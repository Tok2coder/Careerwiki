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
  NextQuestionsSection,
  FollowupQuestionV3,
  ProfileInterpretation,
  ProfileItemInterpretation,
  MetaCognitionResult,
  ArsenalItem,
  PreferenceMapItem,
  StressRecoveryItem,
} from './types'
import { buildEvidenceLinks, generateDefaultEvidence, type Fact, type ScoredJobForEvidence } from './evidence-generator'
import type { MiniModuleResult } from './mini-module-questions'
import { TOKEN_TO_KOREAN } from './mini-module-questions'

// ============================================
// 입력 타입
// ============================================
export interface PremiumReportInput {
  session_id: string
  facts: Fact[]
  recommendations: ScoredJobForEvidence[]  // 전체 추천 (상위 100개)
  userInsight?: UserInsight
  followupHistory?: FollowupQuestionV3[]
  stage?: string
  miniModuleResult?: MiniModuleResult  // 미니모듈 결과 (판단 앵커)
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
  const mm = input.miniModuleResult
  const stage = input.stage || '탐색'
  
  // Stage 형식 변환: "경력자 (3년+)" → "(3년+) 경력자"
  const formattedStage = formatStageLabel(stage)
  
  // 핵심 요약 생성 - 실제 인사이트만 포함!
  const takeaways: string[] = []
  
  // 1. 좋아하는 것 (interest)
  if (mm?.interest_top?.length) {
    const interests = mm.interest_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
    takeaways.push(`📌 관심 분야: ${interests}`)
  }
  
  // 2. 중요하게 여기는 것 (value)
  if (mm?.value_top?.length) {
    const values = mm.value_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
    takeaways.push(`💎 중요 가치: ${values}`)
  }
  
  // 3. 잘하는 것 (strength)
  if (mm?.strength_top?.length) {
    const strengths = mm.strength_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
    takeaways.push(`💪 강점: ${strengths}`)
  }
  
  // 4. 피하고 싶은 것 (constraints/energy drain)
  if (mm?.constraint_flags?.length) {
    const constraints = mm.constraint_flags.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
    takeaways.push(`⚠️ 제약/피할 것: ${constraints}`)
  }
  
  // 5. 최상위 추천 직업 (점수 없이!)
  if (topJob) {
    takeaways.push(`🎯 최적 추천: ${topJob.job_name}`)
  }
  
  // userInsight에서 추가 인사이트
  if (input.userInsight?.key_traits) {
    for (const trait of input.userInsight.key_traits.slice(0, 2)) {
      if (!takeaways.some(t => t.includes(trait.trait))) {
        takeaways.push(`✨ ${trait.trait}`)
      }
    }
  }
  
  // 🆕 추천 로직 설명 생성
  const recommendationRationale = generateRecommendationRationale(input, mm)
  
  return {
    _meta: {
      status: takeaways.length >= 3 ? 'success' : 'partial',
      confidence: Math.min(0.9, 0.5 + (input.facts.length * 0.05)),
      generated_by: 'rule_enhanced',
    },
    headline: `당신은 ${getPersonalityKeyword(input)}형 인재입니다. ${getActionableAdviceForType(input, mm)}`,
    top_takeaways: takeaways.slice(0, 5),
    recommended_next_step: topJob 
      ? `${topJob.job_name}에 대해 더 알아보고, 관련 역량을 파악해보세요`
      : '관심 분야와 우선순위를 더 명확히 정리해보세요',
    recommendation_rationale: recommendationRationale,
  }
}

// 🆕 추천 로직 설명 생성 함수
function generateRecommendationRationale(
  input: PremiumReportInput, 
  mm?: MiniModuleResult
): { included_because: string[]; excluded_because: string[] } {
  const included: string[] = []
  const excluded: string[] = []
  
  // 포함 이유 생성
  if (mm?.interest_top?.length) {
    const interests = mm.interest_top.map(t => TOKEN_TO_KOREAN[t] || t)
    included.push(`${interests.join(', ')} 관련 업무가 많은 직업을 우선 추천했습니다.`)
  }
  
  if (mm?.strength_top?.includes('analytical') || mm?.interest_top?.includes('data_numbers')) {
    included.push('데이터 분석과 논리적 문제 해결이 핵심인 직업을 포함했습니다.')
  }
  
  if (mm?.workstyle_top?.includes('solo')) {
    included.push('독립적으로 집중할 수 있는 업무 환경의 직업을 선호도 높게 평가했습니다.')
  }
  
  if (mm?.value_top?.includes('growth')) {
    included.push('성장 가능성이 높은 직업군을 우선 배치했습니다.')
  }
  
  // 제외 이유 생성
  if (mm?.constraint_flags?.includes('physical_constraint')) {
    excluded.push('육체적 노동이 많은 현장직/제조직은 제외했습니다.')
  }
  
  if (mm?.energy_drain_flags?.includes('repetition_drain')) {
    excluded.push('단순 반복 업무 중심의 직업은 제외했습니다.')
  }
  
  if (mm?.energy_drain_flags?.includes('people_drain')) {
    excluded.push('대면 상호작용이 많은 서비스직은 제외했습니다.')
  }
  
  if (mm?.strength_top?.includes('analytical') || mm?.interest_top?.includes('data_numbers')) {
    excluded.push('데이터/분석 요소가 거의 없는 수작업 중심 직업은 제외했습니다.')
  }
  
  if (mm?.constraint_flags?.includes('uncertainty_constraint')) {
    excluded.push('불안정하거나 예측 불가능한 환경의 직업은 제외했습니다.')
  }
  
  // 기본 설명 추가 (아무것도 없을 때)
  if (included.length === 0) {
    included.push('입력하신 관심사와 가치관을 기반으로 적합도가 높은 직업을 추천했습니다.')
  }
  
  if (excluded.length === 0) {
    excluded.push('명시적인 제외 조건이 없어 폭넓게 추천했습니다.')
  }
  
  return { included_because: included, excluded_because: excluded }
}

// Stage 라벨 형식 변환: "경력자 (3년+)" → "(3년+) 경력자"
function formatStageLabel(stage: string): string {
  // 패턴: "XXX (숫자년+)" 또는 "XXX (숫자~숫자년)"
  const match = stage.match(/^(.+?)\s*\(([^)]+)\)$/)
  if (match) {
    return `(${match[2]}) ${match[1]}`
  }
  return stage
}

// ============================================
// Section 2: Personal Analysis (개선된 버전)
// ============================================
function generatePersonalAnalysis(input: PremiumReportInput): PersonalAnalysisSection {
  const insights = input.userInsight
  const mm = input.miniModuleResult
  const facts = input.facts || []
  
  // ============================================
  // 1. 성격 요약 (미니모듈 + 인사이트 기반 - 확장됨)
  // ============================================
  let personalitySummary = ''
  
  if (insights?.summary) {
    personalitySummary = insights.summary
  } else if (mm) {
    const interestKorean = mm.interest_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '다양한 분야'
    const valueKorean = mm.value_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '안정'
    const strengthKorean = mm.strength_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '성실함'
    
    // 기본 요약
    let summary = `당신은 ${interestKorean}에 흥미를 느끼며, ${valueKorean}을(를) 중요하게 여기는 분입니다. ` +
      `${strengthKorean}이(가) 당신의 강점으로 보이며, 이를 활용할 수 있는 환경에서 가장 빛날 것입니다.`
    
    // 작업 스타일 추가 (Q5)
    if (mm.workstyle_top?.length) {
      const workstyleKorean = mm.workstyle_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
      summary += ` ${workstyleKorean} 방식의 업무 환경을 선호합니다.`
    }
    
    // 실패 반응 추가 (Q13 - Hard Bias급)
    if (mm.failure_response) {
      const failureResponseMap: Record<string, string> = {
        'persist_on_failure': '실패해도 끈기 있게 도전하는 타입',
        'pivot_on_failure': '상황에 맞게 빠르게 전략을 수정하는 타입',
        'pause_on_failure': '실패 후 충분히 성찰하고 다시 시작하는 타입',
        'emotionally_affected': '실패에 민감하여 안정적인 환경이 필요한 타입',
      }
      const failureDesc = failureResponseMap[mm.failure_response]
      if (failureDesc) {
        summary += ` ${failureDesc}입니다.`
      }
    }
    
    personalitySummary = summary
  } else {
    personalitySummary = `당신은 ${getPersonalityKeyword(input)}적인 성향을 가진 분입니다.`
  }
  
  // ============================================
  // 2. 업무 스타일 인사이트 (미니모듈 기반 확장 - Q5~Q15 전체 활용)
  // ============================================
  const workStyleInsights: string[] = []
  
  // 기존 인사이트 추가
  if (insights?.key_traits) {
    for (const trait of insights.key_traits) {
      workStyleInsights.push(`${trait.trait} - ${trait.evidence}`)
    }
  }
  
  // 미니모듈 기반 인사이트 추가
  if (mm) {
    // 흥미 기반 (Q1)
    if (mm.interest_top?.includes('problem_solving')) {
      workStyleInsights.push('복잡한 문제를 분석하고 해결하는 과정에서 몰입과 성취감을 느끼는 타입입니다.')
    }
    if (mm.interest_top?.includes('creating')) {
      workStyleInsights.push('새로운 아이디어를 구상하고 창작하는 활동에서 에너지를 얻습니다.')
    }
    if (mm.interest_top?.includes('helping_teaching')) {
      workStyleInsights.push('다른 사람을 돕고 그들의 성장을 지원하는 일에서 의미를 찾습니다.')
    }
    if (mm.interest_top?.includes('data_numbers')) {
      workStyleInsights.push('데이터를 분석하고 패턴을 발견하는 작업에서 집중력이 높아집니다')
    }
    if (mm.interest_top?.includes('organizing')) {
      workStyleInsights.push('복잡한 것을 체계적으로 정리하고 관리하는 일에서 성취감을 느낍니다')
    }
    if (mm.interest_top?.includes('influencing')) {
      workStyleInsights.push('사람들에게 영향력을 발휘하고 설득하는 일에 능합니다.')
    }
    
    // 가치 기반 (Q2)
    if (mm.value_top?.includes('autonomy')) {
      workStyleInsights.push('자율적으로 결정하고 실행할 수 있는 환경에서 최고의 성과를 냅니다')
    }
    if (mm.value_top?.includes('stability')) {
      workStyleInsights.push('예측 가능하고 안정적인 환경에서 안정감을 느끼며 일합니다.')
    }
    if (mm.value_top?.includes('growth')) {
      workStyleInsights.push('지속적으로 배우고 성장할 수 있는 기회를 중요하게 생각합니다.')
    }
    if (mm.value_top?.includes('income')) {
      workStyleInsights.push('적절한 보상과 경제적 안정이 동기부여의 중요한 요소입니다.')
    }
    if (mm.value_top?.includes('meaning')) {
      workStyleInsights.push('사회에 기여하고 의미 있는 일을 하는 것을 중시합니다.')
    }
    if (mm.value_top?.includes('recognition')) {
      workStyleInsights.push('자신의 노력과 성과가 인정받는 환경에서 동기부여됩니다')
    }
    
    // 작업 스타일 (Q5)
    if (mm.workstyle_top?.includes('solo')) {
      workStyleInsights.push('혼자 집중해서 깊이 파고드는 시간이 필요한 타입입니다.')
    }
    if (mm.workstyle_top?.includes('team')) {
      workStyleInsights.push('팀과 함께 협업하며 시너지를 내는 것을 즐깁니다')
    }
    if (mm.workstyle_top?.includes('structured')) {
      workStyleInsights.push('규칙과 절차가 명확한 환경에서 안정감을 느끼고 잘 수행합니다.')
    }
    if (mm.workstyle_top?.includes('flexible')) {
      workStyleInsights.push('유연하고 자유로운 환경에서 창의성을 발휘합니다.')
    }
    
    // 성취 피드백 타입 (Q10)
    if (mm.achievement_feedback_top?.length) {
      const feedbackMap: Record<string, string> = {
        'metric_feedback': '구체적인 수치와 지표로 성과를 확인할 때 동기부여됩니다',
        'helping_feedback': '다른 사람에게 직접적인 도움이 되었다는 피드백이 가장 큰 보람입니다',
        'problem_solved_feedback': '복잡한 문제를 해결했을 때 최고의 성취감을 느낍니다',
        'tangible_output_feedback': '눈에 보이는 결과물을 만들어냈을 때 만족합니다',
        'growth_feedback': '어제보다 나아졌다는 성장의 증거가 동기부여의 원천입니다',
      }
      for (const fb of mm.achievement_feedback_top) {
        const desc = feedbackMap[fb]
        if (desc) workStyleInsights.push(desc)
      }
    }
    
    // 실행 스타일 (Q11)
    if (mm.execution_style) {
      const execMap: Record<string, string> = {
        'fast_mover': '빠르게 결정하고 실행에 옮기는 것을 선호합니다',
        'balanced_pace': '적절한 속도로 신중하게 진행하는 것을 좋아합니다',
        'thorough_planner': '충분한 계획과 준비 후에 확실하게 실행합니다',
      }
      const execDesc = execMap[mm.execution_style]
      if (execDesc) workStyleInsights.push(execDesc)
    }
    
    // 영향 범위 (Q12)
    if (mm.impact_scope) {
      const scopeMap: Record<string, string> = {
        'individual_impact': '개인의 성장과 발전에 집중하는 것을 선호합니다',
        'team_impact': '팀 단위의 성과와 협업에서 보람을 느낍니다',
        'org_impact': '조직 전체에 영향을 미치는 일에 관심이 있습니다',
        'society_impact': '사회적으로 의미 있는 변화를 만들고 싶어합니다',
      }
      const scopeDesc = scopeMap[mm.impact_scope]
      if (scopeDesc) workStyleInsights.push(scopeDesc)
    }
    
    // 버팀 앵커 (Q14)
    if (mm.persistence_anchor) {
      const anchorMap: Record<string, string> = {
        'reward_anchor': '적절한 보상과 인센티브가 버티는 힘의 원천입니다',
        'growth_anchor': '배움과 성장의 기회가 있다면 어려움도 견딜 수 있습니다',
        'people_anchor': '함께하는 사람들이 힘이 될 때 오래 버틸 수 있습니다',
        'meaning_anchor': '일의 의미와 목적이 명확하면 어떤 고난도 감수할 수 있습니다',
        'stability_anchor': '안정감과 예측 가능성이 지속 동기의 핵심입니다',
      }
      const anchorDesc = anchorMap[mm.persistence_anchor]
      if (anchorDesc) workStyleInsights.push(anchorDesc)
    }
    
    // 외부 기대 반응 (Q15)
    if (mm.external_expectation) {
      const expectMap: Record<string, string> = {
        'external_structure_ok': '명확한 기대와 가이드라인이 있으면 오히려 편안해집니다',
        'neutral_to_expectation': '외부 기대에 크게 좌우되지 않고 자신의 기준으로 움직입니다',
        'expectation_pressure': '타인의 기대가 부담으로 다가올 수 있어 자율성이 중요합니다',
      }
      const expectDesc = expectMap[mm.external_expectation]
      if (expectDesc) workStyleInsights.push(expectDesc)
    }
  }
  
  // 기본 인사이트 제거 - 사용자 데이터 기반으로만 생성
  // workStyleInsights가 비어있으면 비어있는 상태로 둠 (generic 문구 삭제)
  
  // ============================================
  // 3. 가치관/우선순위 (미니모듈 통합)
  // ============================================
  let valuePriorities = extractValuePriorities(facts, mm)
  
  // 미니모듈 가치가 이미 extractValuePriorities에서 처리됨
  
  // ============================================
  // 4. 잠재적 도전 (미니모듈 기반 동적 생성 - 확장)
  // ============================================
  const challenges: string[] = []
  
  if (mm) {
    // 가치 충돌 기반 도전
    if (mm.internal_conflict_flags?.includes('autonomy_vs_stability')) {
      challenges.push('자율성과 안정성 사이에서 균형을 찾는 것이 중요합니다. 두 가치 중 현재 시점에서 더 우선순위가 높은 것을 명확히 해보세요.')
    }
    if (mm.internal_conflict_flags?.includes('growth_vs_income')) {
      challenges.push('성장 기회와 당장의 수입 사이에서 갈등할 수 있습니다. 장기적 관점에서 무엇이 더 중요한지 정리해보세요.')
    }
    
    // 제약 조건 기반 도전 (Q4)
    if (mm.constraint_flags?.includes('time_constraint')) {
      challenges.push('시간적 제약이 있어 효율적인 시간 관리가 필요합니다. 우선순위를 명확히 하고 선택과 집중이 필요합니다.')
    }
    if (mm.constraint_flags?.includes('income_constraint')) {
      challenges.push('경제적 조건을 고려해야 하므로, 이상적인 선택과 현실적인 선택 사이에서 균형을 찾아야 합니다.')
    }
    if (mm.constraint_flags?.includes('uncertainty_constraint')) {
      challenges.push('불확실한 환경에 대한 불안이 있을 수 있습니다. 작은 실험부터 시작해 점진적으로 적응하는 전략을 고려해보세요.')
    }
    if (mm.constraint_flags?.includes('location_constraint')) {
      challenges.push('지역적 제약이 있어 선택 범위가 좁아질 수 있습니다. 원격 근무 가능한 옵션도 함께 탐색해보세요.')
    }
    if (mm.constraint_flags?.includes('health_constraint')) {
      challenges.push('건강을 고려해야 하므로, 무리하지 않는 범위에서 지속 가능한 선택이 중요합니다.')
    }
    
    // 포기 가능성 기반 도전 (Q8)
    if (mm.sacrifice_flags?.includes('no_sacrifice')) {
      challenges.push('현재 상태에서 크게 포기할 수 있는 것이 없다고 하셨습니다. 이 경우 현실적인 선택지 내에서 최선을 찾는 것이 중요합니다.')
    }
    if (mm.sacrifice_flags?.includes('sacrifice_income')) {
      challenges.push('수입을 일시적으로 낮출 수 있다고 하셨지만, 경제적 버퍼가 얼마나 있는지 구체적으로 점검해보세요.')
    }
    if (mm.sacrifice_flags?.includes('sacrifice_wlb')) {
      challenges.push('워라밸을 희생할 수 있다고 하셨지만, 장기적으로 지속 가능한지, 언제까지인지 기한을 정해두는 것이 좋습니다.')
    }
    
    // 에너지 소모원 기반 도전 (Q9)
    if (mm.energy_drain_flags?.includes('people_drain')) {
      challenges.push('대인 상호작용이 에너지를 소모한다고 하셨습니다. 사람과의 접점이 많은 직업은 회피하되, 완전히 혼자 일하는 것도 외로울 수 있으니 균형을 찾아보세요.')
    }
    if (mm.energy_drain_flags?.includes('time_pressure_drain')) {
      challenges.push('시간 압박이 에너지를 소모한다고 하셨습니다. 마감이 잦은 환경보다는 자기 페이스로 일할 수 있는 곳을 찾아보세요.')
    }
    if (mm.energy_drain_flags?.includes('cognitive_drain')) {
      challenges.push('인지적 부하가 크면 지친다고 하셨습니다. 고강도 분석 업무보다는 적절한 난이도의 일이 지속 가능할 수 있습니다.')
    }
    if (mm.energy_drain_flags?.includes('repetition_drain')) {
      challenges.push('반복 업무가 에너지를 소모한다고 하셨습니다. 다양성과 변화가 있는 역할을 찾아보세요.')
    }
    if (mm.energy_drain_flags?.includes('unpredictability_drain')) {
      challenges.push('예측 불가능한 상황이 스트레스라고 하셨습니다. 체계적이고 예측 가능한 환경이 맞을 수 있습니다.')
    }
    if (mm.energy_drain_flags?.includes('responsibility_drain')) {
      challenges.push('책임이 무거우면 부담을 느낀다고 하셨습니다. 리더 역할보다는 전문가/기여자 역할이 더 맞을 수 있습니다.')
    }
    
    // 실패 반응 기반 도전 (Q13)
    if (mm.failure_response === 'emotionally_affected') {
      challenges.push('실패에 민감하게 반응하시는 편입니다. 실패 가능성이 낮고 안정적인 환경에서 시작하는 것이 좋을 수 있습니다.')
    }
  }
  
  // 기본 도전 제거 - 사용자 데이터 기반으로만 생성
  // 데이터가 부족하면 빈 상태로 두고, UI에서 "분석을 위해 더 많은 정보가 필요합니다" 표시
  
  // ============================================
  // 5. 맹점 (미니모듈 기반 동적 생성 - 확장)
  // ============================================
  const blindSpots: string[] = []
  
  if (mm) {
    // 강점 관련 맹점 (Q3)
    if (mm.strength_top?.includes('analytical')) {
      blindSpots.push('분석력이 뛰어나지만, 때로는 과도한 분석이 결정을 지연시킬 수 있습니다. 적당한 시점에 실행으로 옮기는 연습도 필요합니다.')
    }
    if (mm.strength_top?.includes('structured_execution')) {
      blindSpots.push('체계적인 실행 능력이 강점이지만, 급변하는 상황에서 유연성이 부족할 수 있습니다.')
    }
    if (mm.strength_top?.includes('communication')) {
      blindSpots.push('소통 능력이 좋지만, 혼자 깊이 집중해야 하는 업무에서는 에너지가 고갈될 수 있습니다.')
    }
    if (mm.strength_top?.includes('creative')) {
      blindSpots.push('창의력이 뛰어나지만, 실행과 완성까지 이어가는 데 어려움을 느낄 수 있습니다.')
    }
    if (mm.strength_top?.includes('persistence')) {
      blindSpots.push('끈기가 강점이지만, 때로는 손절해야 할 때도 있습니다. 포기해야 할 때를 아는 것도 중요합니다.')
    }
    if (mm.strength_top?.includes('fast_learning')) {
      blindSpots.push('빠르게 배우는 능력이 있지만, 깊이보다 넓이에 치중할 수 있습니다. 한 분야에 깊이 파고드는 것도 필요합니다.')
    }
    
    // 가치 관련 맹점 (Q2)
    if (mm.value_top?.includes('stability')) {
      blindSpots.push('안정을 추구하는 경향이 때로는 새로운 기회를 놓치게 할 수 있습니다.')
    }
    if (mm.value_top?.includes('recognition')) {
      blindSpots.push('인정받고 싶은 욕구가 강해 외부 평가에 지나치게 의존할 수 있습니다. 내적 기준도 중요합니다.')
    }
    if (mm.value_top?.includes('autonomy')) {
      blindSpots.push('자율성을 중시하다 보니 팀 협업이나 조직의 방향성을 따르는 데 어려움을 느낄 수 있습니다.')
    }
    if (mm.value_top?.includes('growth')) {
      blindSpots.push('성장에 대한 욕구가 강해 현재에 만족하지 못하고 항상 부족함을 느낄 수 있습니다.')
    }
    if (mm.value_top?.includes('income')) {
      blindSpots.push('수입을 중시하다 보니 다른 중요한 가치(일의 의미, 워라밸 등)를 놓칠 수 있습니다.')
    }
    
    // 작업 스타일 관련 맹점 (Q5)
    if (mm.workstyle_top?.includes('solo')) {
      blindSpots.push('혼자 일하는 것을 선호하지만, 협업이 필수인 프로젝트에서 어려움을 느낄 수 있습니다.')
    }
    if (mm.workstyle_top?.includes('structured')) {
      blindSpots.push('구조화된 환경을 선호하지만, 스타트업이나 빠르게 변하는 환경에서 적응이 어려울 수 있습니다.')
    }
    
    // 실행 스타일 관련 맹점 (Q11)
    if (mm.execution_style === 'fast_mover') {
      blindSpots.push('빠르게 실행하는 것이 강점이지만, 충분한 검토 없이 진행해 실수할 수 있습니다.')
    }
    if (mm.execution_style === 'thorough_planner') {
      blindSpots.push('철저한 계획이 강점이지만, 과도한 준비로 시작 타이밍을 놓칠 수 있습니다.')
    }
    
    // 버팀 앵커 관련 맹점 (Q14)
    if (mm.persistence_anchor === 'reward_anchor') {
      blindSpots.push('보상이 동기부여의 핵심이라면, 보상이 불확실한 초기 단계에서 동기 유지가 어려울 수 있습니다.')
    }
    if (mm.persistence_anchor === 'people_anchor') {
      blindSpots.push('사람이 버팀의 핵심이라면, 좋은 팀원이 없을 때 쉽게 지칠 수 있습니다.')
    }
  }
  
  // 기본 맹점 제거 - 사용자 데이터 기반으로만 생성
  
  const hasRichData = !!(insights || (mm && (mm.interest_top?.length || mm.value_top?.length)))
  
  return {
    _meta: {
      status: hasRichData ? 'success' : 'partial',
      confidence: hasRichData ? 0.8 : 0.5,
      generated_by: 'rule_enhanced',
    },
    personality_summary: personalitySummary,
    work_style_insights: [...new Set(workStyleInsights)].slice(0, 7),
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
// Section 7: Next Questions (로드맵 섹션 제거됨)
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
  const mm = input.miniModuleResult
  
  // 1. 미니모듈에서 가장 뚜렷한 특성 추출
  if (mm) {
    // 강점 기반 키워드
    if (mm.strength_top?.includes('analytical')) return '분석'
    if (mm.strength_top?.includes('creative')) return '창의'
    if (mm.strength_top?.includes('communication')) return '소통 중심'
    if (mm.strength_top?.includes('structured_execution')) return '체계'
    if (mm.strength_top?.includes('problem_solving')) return '문제 해결 지향'

    // 작업스타일 기반 키워드
    if (mm.workstyle_top?.includes('solo')) return '독립'
    if (mm.workstyle_top?.includes('team')) return '협업 지향'
    if (mm.workstyle_top?.includes('leader')) return '리더십 지향'
    if (mm.workstyle_top?.includes('structured')) return '체계'
    if (mm.workstyle_top?.includes('flexible')) return '유연'

    // 관심사 기반 키워드
    if (mm.interest_top?.includes('data_numbers')) return '데이터 지향'
    if (mm.interest_top?.includes('problem_solving')) return '문제 해결'
    if (mm.interest_top?.includes('creating')) return '창작 지향'
    if (mm.interest_top?.includes('helping_teaching')) return '사람 중심'
  }
  
  // 2. facts에서 성향 키워드 추출
  const workstyleFact = input.facts.find(f => f.fact_key.includes('workstyle'))
  if (workstyleFact) {
    try {
      const parsed = JSON.parse(workstyleFact.value_json)
      const value = parsed.value || parsed
      if (value === 'solo') return '독립'
      if (value === 'team') return '협업 지향'
    } catch { /* ignore */ }
  }
  
  // 3. 기본값 - 추상적 표현 피하기
  // ❌ "균형 잡힌" 같은 추상적 표현 제거
  // ⭕ 구체적이지만 중립적인 표현 사용
  return '탐색'
}

function getPriorityFromFacts(facts: Fact[], mm?: MiniModuleResult): string {
  // 1. 미니모듈 결과 우선 사용
  if (mm?.value_top?.length) {
    const topValue = mm.value_top[0]
    return TOKEN_TO_KOREAN[topValue] || topValue
  }

  // 2. facts에서 추출
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
        recognition: '인정과 영향력',
        autonomy: '자율성',
        risk: '도전과 리스크',
      }
      return map[value] || value
    } catch { /* ignore */ }
  }

  // 기본값은 최소화
  return '방향 탐색'
}

// 성격 타입에 맞는 행동 가이드 생성
function getActionableAdviceForType(input: PremiumReportInput, mm?: MiniModuleResult): string {
  const personalityType = getPersonalityKeyword(input)
  const topJob = input.recommendations[0]

  // 성격 타입별 맞춤 조언
  const adviceByType: Record<string, string> = {
    '분석': '데이터와 논리를 기반으로 체계적인 커리어 로드맵을 설계해보세요.',
    '창의': '새로운 아이디어를 실험하고 자신만의 차별화된 포트폴리오를 만들어보세요.',
    '소통 중심': '네트워킹과 관계 구축에 집중하며 협업 기회를 탐색해보세요.',
    '체계': '명확한 목표와 단계별 계획을 세워 꾸준히 실행해보세요.',
    '문제 해결 지향': '실제 문제를 해결하는 프로젝트에 참여하며 역량을 증명해보세요.',
    '독립': '자율성이 보장되는 환경에서 깊이 있는 전문성을 키워보세요.',
    '협업 지향': '팀 프로젝트에 적극 참여하며 시너지를 만들어보세요.',
    '리더십 지향': '작은 팀이라도 이끌어보며 리더십 경험을 쌓아보세요.',
    '유연': '다양한 경험을 쌓으며 자신에게 맞는 방향을 찾아보세요.',
    '데이터 지향': '데이터 분석 역량을 키우고 실제 인사이트를 도출해보세요.',
    '문제 해결': '복잡한 문제에 도전하며 해결 능력을 증명해보세요.',
    '창작 지향': '자신만의 작품이나 결과물을 만들어 포트폴리오를 구축해보세요.',
    '사람 중심': '사람들과의 상호작용에서 보람을 찾는 역할을 탐색해보세요.',
    '탐색': '다양한 경험을 통해 자신의 강점과 관심사를 발견해보세요.',
  }

  // 기본 조언 + 추천 직업 연계
  const baseAdvice = adviceByType[personalityType] || adviceByType['탐색']

  if (topJob?.job_name) {
    // "~해보세요." → "~하고," / "~어보세요." → "~고," 등 자연스러운 연결형으로 변환
    const connected = baseAdvice
      .replace(/해보세요\.$/, '하고')
      .replace(/워보세요\.$/, '우고')
      .replace(/어보세요\.$/, '고')
      .replace(/아보세요\.$/, '고')
    return `${connected}, ${topJob.job_name} 같은 분야를 시작점으로 고려해보세요.`
  }

  return baseAdvice
}

function extractValuePriorities(facts: Fact[], mm?: MiniModuleResult): string[] {
  const priorities: string[] = []
  const valueMap: Record<string, string> = {
    growth: '성장 가능성을 중요하게 생각합니다',
    income: '적절한 보상/수입을 중요하게 생각합니다',
    wlb: '일과 삶의 균형을 중요하게 생각합니다',
    stability: '안정성을 중요하게 생각합니다',
    meaning: '의미있는 일을 중요하게 생각합니다',
    recognition: '인정받고 영향력을 발휘하는 것을 중요하게 생각합니다',
    autonomy: '자율적으로 일하는 것을 중요하게 생각합니다',
    risk: '도전적인 기회를 추구합니다',
  }
  
  // 1. 미니모듈 결과 우선 사용 (valueMap의 자연스러운 설명 활용)
  if (mm?.value_top?.length) {
    for (const v of mm.value_top) {
      if (valueMap[v]) {
        priorities.push(valueMap[v])
      } else {
        const korean = TOKEN_TO_KOREAN[v] || v
        priorities.push(`${korean}을(를) 중요하게 생각합니다`)
      }
    }
  }
  
  // 2. facts에서 추가 추출
  for (const fact of facts) {
    if (fact.fact_key.includes('priority') || fact.fact_key.includes('value')) {
      try {
        const parsed = JSON.parse(fact.value_json)
        const value = parsed.value || parsed
        if (typeof value === 'string' && valueMap[value]) {
          const mapped = valueMap[value]
          if (!priorities.includes(mapped)) {
            priorities.push(mapped)
          }
        }
      } catch { /* ignore */ }
    }
  }
  
  // 기본값 제거 - 데이터가 없으면 빈 배열 반환
  // 사용자 입력을 기반으로만 표시
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
    return `${job.job_name}은(는) 당신의 성향과 잘 맞는 직업입니다.`
  }
  
  return `${job.job_name}은(는) ${reasons.slice(0, 2).join(', ')} 직업입니다.`
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
  
  if ((attrs.wlb as number) < 40) risks.push('야근이 많을 수 있습니다.')
  if ((attrs.stability as number) < 40) risks.push('고용 안정성이 낮을 수 있습니다.')
  if ((attrs.income as number) < 40) risks.push('초기 수입이 낮을 수 있습니다.')
  
  if (risks.length === 0) {
    risks.push('새로운 분야 적응에 시간이 필요할 수 있습니다.')
    risks.push('경쟁이 있을 수 있습니다.')
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
  
  // 신뢰도 계산 (팩트 수 기반)
  const factsCount = input.facts.length
  const confidence = Math.min(0.95, 0.5 + (factsCount * 0.05))
  
  // ★★★ LLM Reporter 호환 필드 생성 (프론트엔드가 이 필드들을 먼저 확인함!) ★★★
  const mm = input.miniModuleResult

  // executiveSummary 생성
  const executiveSummary = summaryResult.result.headline ||
    `당신은 ${getPersonalityKeyword(input)}형 인재입니다. ${mm?.value_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '다양한 가치'}를 중요하게 여기며, ${mm?.strength_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ') || '여러 강점'}을 가지고 있습니다.`

  // workStyleNarrative 생성 (심리 분석 핵심 텍스트)
  const workStyleNarrative = generateWorkStyleNarrative(input)

  // workStyleMap 생성 (5축 분석)
  const workStyleMap = generateWorkStyleMapFromMiniModule(mm)

  // innerConflictAnalysis 생성
  const innerConflictAnalysis = generateInnerConflictAnalysis(input)

  // conflictPatterns 생성
  const conflictPatterns = generateConflictPatterns(input)

  // growthCurveType & description 생성
  const { growthCurveType, growthCurveDescription } = generateGrowthCurveInfo(input)

  // stressTriggers 생성
  const stressTriggers = generateStressTriggers(input)

  // lifeVersionStatement 생성
  const lifeVersionStatement = {
    oneLiner: executiveSummary,
    expanded: summaryResult.result.top_takeaways || [],
  }

  // expertGuidance 생성 - 미니모듈 기반 구체적 조언
  const strengthLabelsForGuidance = (mm?.strength_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const interestLabelsForGuidance = (mm?.interest_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const valueLabelsForGuidance = (mm?.value_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const constraintLabelsForGuidance = (mm?.constraint_flags || []).map(t => TOKEN_TO_KOREAN[t] || t)

  const doNowItems: string[] = []
  const learnNextItems: string[] = []
  const avoidItems: string[] = []

  // 강점 기반 조언
  if (strengthLabelsForGuidance.length > 0) {
    doNowItems.push(`당신의 ${strengthLabelsForGuidance[0]} 강점을 활용할 수 있는 프로젝트나 업무를 찾아보세요.`)
    learnNextItems.push(`${strengthLabelsForGuidance[0]}을(를) 더욱 발전시킬 수 있는 심화 학습 자료를 찾아보세요.`)
  }

  // 흥미 기반 조언
  if (interestLabelsForGuidance.length > 0) {
    doNowItems.push(`${interestLabelsForGuidance[0]} 관련 커뮤니티나 네트워크에 참여해보세요.`)
    learnNextItems.push(`${interestLabelsForGuidance[0]} 분야의 트렌드와 최신 동향을 파악하세요.`)
  }

  // 가치 기반 조언
  if (valueLabelsForGuidance.length > 0) {
    doNowItems.push(`${valueLabelsForGuidance[0]}이(가) 보장되는 환경인지 현재 직장/목표 직업을 점검해보세요.`)
  }

  // 제약 기반 조언
  if (constraintLabelsForGuidance.length > 0) {
    constraintLabelsForGuidance.forEach(c => {
      avoidItems.push(`${c} 관련 조건이 맞지 않는 포지션 지원은 당분간 피하세요.`)
    })
  }

  // 기본 조언 추가
  if (doNowItems.length === 0) {
    doNowItems.push('관심 분야를 더 구체적으로 탐색해보세요.')
  }
  if (learnNextItems.length === 0) {
    learnNextItems.push('관련 직업 정보와 요구 역량을 조사하세요.')
  }

  const expertGuidance = {
    doNow: doNowItems.slice(0, 3),
    learnNext: learnNextItems.slice(0, 3),
    avoidFor3Months: avoidItems.slice(0, 2),
    stopDoing: mm?.energy_drain_flags?.length ? [`${TOKEN_TO_KOREAN[mm.energy_drain_flags[0]] || mm.energy_drain_flags[0]}을(를) 유발하는 상황에 자신을 계속 노출하는 것.`] : [],
  }

  return {
    report_id: `report-${input.session_id}-${Date.now()}`,
    generated_at: new Date().toISOString(),
    session_id: input.session_id,
    engine_version: 'v3-rule',  // 규칙 기반임을 표시
    overall_status: overallStatus,
    sections_completed: sectionsCompleted,
    sections_total: sectionsTotal,

    // 분석 상세 메타데이터 (UI에서 사용)
    _confidence: confidence,
    _factsCount: factsCount,
    _answeredQuestions: factsCount,
    _candidatesScored: input.recommendations.length,
    _appliedRules: Math.min(factsCount * 2, 20),

    // ★★★ LLM Reporter 호환 필드 (프론트엔드 우선 사용) ★★★
    executiveSummary,
    workStyleNarrative,
    workStyleMap,
    innerConflictAnalysis,
    conflictPatterns,
    growthCurveType,
    growthCurveDescription,
    stressTriggers,
    lifeVersionStatement,
    expertGuidance,

    // 프로필 해석 (나의 커리어 프로필 카드)
    profileInterpretation: generateProfileInterpretation(mm),

    // 메타인지 (자기 이해 중심 분석)
    metaCognition: generateMetaCognition(mm),

    // 기존 섹션 (하위 호환)
    summary_one_page: summaryResult.result,
    personal_analysis: personalResult.result,
    key_hypotheses: hypothesesResult.result,
    recommendations_top: topRecsResult.result,
    recommendations_hold: holdRecsResult.result,
    plan_b_paths: planBResult.result,
    next_questions: questionsResult.result,
  }
}

// ============================================
// LLM Reporter 호환 필드 생성 함수들
// ============================================

function generateWorkStyleNarrative(input: PremiumReportInput): string {
  const mm = input.miniModuleResult
  if (!mm) return '작업 스타일 분석을 위해 더 많은 정보가 필요합니다.'

  const parts: string[] = []

  // 1. 흥미/관심 기반
  const interests = mm.interest_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
  const values = mm.value_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
  const strengths = mm.strength_top?.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')

  parts.push(`당신은 ${interests || '다양한 분야'}에 관심을 가지고 있으며 ${values || '여러 가치'}를 중요하게 여기는 ${strengths || '다양한 강점'}에서 강점을 보이는 분입니다.`)

  // 2. 작업 스타일 기반
  if (mm.workstyle_top?.length) {
    const workstyles = mm.workstyle_top.map(t => TOKEN_TO_KOREAN[t] || t).join(', ')
    parts.push(`${workstyles} 환경에서 가장 효과적으로 일합니다.`)
  }

  // 3. 실행 스타일 기반
  if (mm.execution_style) {
    const execMap: Record<string, string> = {
      'action_first': '빠르게 실행하며 배우는 스타일로, 먼저 시도하고 조정하는 것을 선호합니다.',
      'plan_first': '체계적으로 계획을 세운 뒤 실행하는 스타일로, 준비가 충분해야 시작합니다.',
      'flexible_execution': '상황에 맞게 유연하게 대응하는 스타일로, 계획과 실행 사이의 균형을 잡습니다.',
      'planner': '꼼꼼하게 계획하고 단계별로 진행하는 것을 선호합니다.',
      'explorer': '새로운 것을 탐색하며 유연하게 방향을 수정하는 것을 좋아합니다.',
      'balanced': '계획과 즉흥 사이에서 균형을 잡는 스타일입니다.',
    }
    if (execMap[mm.execution_style]) {
      parts.push(execMap[mm.execution_style])
    }
  }

  // 4. 영향력 범위 기반
  if (mm.impact_scope) {
    const impactMap: Record<string, string> = {
      'specialist': '특정 분야에서 깊이 있는 전문성을 쌓는 것을 선호합니다.',
      'wide_impact': '넓은 영역에 영향을 미치는 일에서 보람을 느낍니다.',
      'team_org': '팀이나 조직 내에서 협력하며 성과를 내는 것을 중시합니다.',
    }
    if (impactMap[mm.impact_scope]) {
      parts.push(impactMap[mm.impact_scope])
    }
  }

  return parts.join(' ')
}

function generateWorkStyleMapFromMiniModule(mm?: MiniModuleResult): {
  analytical_vs_creative: number
  solo_vs_team: number
  structured_vs_flexible: number
  depth_vs_breadth: number
  guided_vs_autonomous: number
} {
  if (!mm) {
    return {
      analytical_vs_creative: 0,
      solo_vs_team: 0,
      structured_vs_flexible: 0,
      depth_vs_breadth: 0,
      guided_vs_autonomous: 0,
    }
  }

  let analytical_vs_creative = 0
  let solo_vs_team = 0
  let structured_vs_flexible = 0
  let depth_vs_breadth = 0
  let guided_vs_autonomous = 0

  // 흥미 기반
  if (mm.interest_top?.includes('data_numbers') || mm.interest_top?.includes('research')) {
    analytical_vs_creative -= 30
  }
  if (mm.interest_top?.includes('creative') || mm.interest_top?.includes('design') || mm.interest_top?.includes('art')) {
    analytical_vs_creative += 30
  }

  // 강점 기반
  if (mm.strength_top?.includes('analytical')) analytical_vs_creative -= 20
  if (mm.strength_top?.includes('creative')) analytical_vs_creative += 20

  // 작업 스타일 기반
  if (mm.workstyle_top?.includes('solo') || mm.workstyle_top?.includes('solo_deep')) {
    solo_vs_team -= 40
  }
  if (mm.workstyle_top?.includes('team') || mm.workstyle_top?.includes('team_harmony')) {
    solo_vs_team += 40
  }
  if (mm.workstyle_top?.includes('structured')) {
    structured_vs_flexible -= 40
  }
  if (mm.workstyle_top?.includes('flexible')) {
    structured_vs_flexible += 40
  }

  // 가치 기반
  if (mm.value_top?.includes('autonomy')) {
    guided_vs_autonomous += 30
  }
  if (mm.value_top?.includes('stability')) {
    structured_vs_flexible -= 20
  }

  // 실행 스타일 기반
  if (mm.execution_style === 'planner' || mm.execution_style === 'plan_first') {
    structured_vs_flexible -= 20
  }
  if (mm.execution_style === 'explorer' || mm.execution_style === 'flexible_execution') {
    structured_vs_flexible += 20
  }

  // 영향 범위 기반
  if (mm.impact_scope === 'specialist') {
    depth_vs_breadth -= 30
  }
  if (mm.impact_scope === 'wide_impact') {
    depth_vs_breadth += 30
  }

  // 범위 제한 (-100 ~ +100)
  const clamp = (v: number) => Math.max(-100, Math.min(100, v))

  return {
    analytical_vs_creative: clamp(analytical_vs_creative),
    solo_vs_team: clamp(solo_vs_team),
    structured_vs_flexible: clamp(structured_vs_flexible),
    depth_vs_breadth: clamp(depth_vs_breadth),
    guided_vs_autonomous: clamp(guided_vs_autonomous),
  }
}

function generateInnerConflictAnalysis(input: PremiumReportInput): string {
  const mm = input.miniModuleResult
  if (!mm) return ''

  const conflicts: string[] = []

  // 가치 충돌 검사
  if (mm.value_top?.includes('autonomy') && mm.value_top?.includes('stability')) {
    conflicts.push('자율성과 안정성 사이에서 갈등하는 모습이 보입니다. 자유롭게 일하고 싶지만 안정적인 환경도 중요하게 여기는 것 같습니다.')
  }
  if (mm.value_top?.includes('growth') && mm.sacrifice_flags?.includes('no_sacrifice')) {
    conflicts.push('성장을 원하지만 현재 상황에서 큰 희생은 어려운 것 같습니다. 단계적인 성장 전략이 필요할 수 있습니다.')
  }
  if (mm.value_top?.includes('income') && mm.value_top?.includes('meaning')) {
    conflicts.push('경제적 보상과 의미 있는 일 사이에서 균형을 찾고 있습니다.')
  }

  // 작업 스타일 충돌
  if (mm.workstyle_top?.includes('solo_deep') && mm.workstyle_top?.includes('team_harmony')) {
    conflicts.push('혼자 집중하는 것과 팀과 조화롭게 일하는 것 모두 가치 있게 여기며, 상황에 따라 유연하게 전환하는 것을 선호합니다.')
  }

  if (conflicts.length === 0) {
    return '현재 답변에서 뚜렷한 내면 갈등은 발견되지 않았습니다. 가치관과 목표가 비교적 일관된 것으로 보입니다.'
  }

  return conflicts.join(' ')
}

function generateConflictPatterns(input: PremiumReportInput): string[] {
  const mm = input.miniModuleResult
  const patterns: string[] = []

  if (!mm) return patterns

  if (mm.value_top?.includes('autonomy') && mm.value_top?.includes('stability')) {
    patterns.push('자율성 vs 안정성')
  }
  if (mm.value_top?.includes('growth') && mm.sacrifice_flags?.includes('no_sacrifice')) {
    patterns.push('성장 욕구 vs 현실 제약')
  }
  if (mm.interest_top?.includes('creative') && mm.workstyle_top?.includes('structured')) {
    patterns.push('창의성 vs 체계성')
  }

  return patterns
}

function generateGrowthCurveInfo(input: PremiumReportInput): { growthCurveType: string; growthCurveDescription: string } {
  const mm = input.miniModuleResult

  if (!mm) {
    return { growthCurveType: '분석 중', growthCurveDescription: '성장 곡선 분석을 위해 더 많은 정보가 필요합니다.' }
  }

  // 안정 지향
  if (mm.value_top?.includes('stability') || mm.persistence_anchor === 'stability_anchor') {
    return {
      growthCurveType: '안정 성장형',
      growthCurveDescription: '꾸준하고 안정적인 성장을 선호합니다. 급격한 변화보다 점진적 발전이 맞습니다.',
    }
  }

  // 성장 지향
  if (mm.value_top?.includes('growth') || mm.persistence_anchor === 'growth_anchor') {
    return {
      growthCurveType: '도전 성장형',
      growthCurveDescription: '빠른 성장과 도전을 선호합니다. 학습 곡선이 가파른 환경에서 동기부여됩니다.',
    }
  }

  // 균형형
  return {
    growthCurveType: '균형 성장형',
    growthCurveDescription: '안정과 성장 사이에서 균형을 추구합니다. 상황에 따라 유연하게 대응합니다.',
  }
}

function generateStressTriggers(input: PremiumReportInput): string[] {
  const mm = input.miniModuleResult
  const triggers: string[] = []

  if (!mm?.energy_drain_flags) return triggers

  const drainMap: Record<string, string> = {
    'people_drain': '많은 사람과의 상호작용이 지속될 때 에너지가 소모됩니다',
    'cognitive_drain': '복잡한 인지 작업이 장시간 지속될 때 피로를 느낍니다',
    'time_pressure_drain': '촉박한 마감과 시간 압박이 스트레스가 됩니다',
    'responsibility_drain': '과도한 책임감이 부담이 될 수 있습니다',
    'repetition_drain': '반복적인 업무가 지속될 때 지루함을 느낍니다',
    'unpredictability_drain': '예측 불가능한 상황이 불안을 유발합니다',
    'routine_drain': '정해진 루틴이 반복될 때 답답함을 느낍니다',
    'bureaucracy_drain': '불필요한 절차와 관료주의가 스트레스가 됩니다',
    'uncertainty_drain': '불확실한 상황에서 불안을 느낍니다',
  }

  for (const flag of mm.energy_drain_flags) {
    if (drainMap[flag]) {
      triggers.push(drainMap[flag])
    }
  }

  return triggers.slice(0, 3)  // 최대 3개
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

function createFallbackNextQuestions(): NextQuestionsSection {
  return {
    _meta: { status: 'fallback', generated_by: 'rule' },
    questions: ['어떤 일을 할 때 가장 즐거우신가요?'],
    expected_improvements: ['더 정확한 분석'],
  }
}

// ============================================
// 메타인지 생성 함수 (자기 이해 중심 분석)
// ============================================
function generateMetaCognition(mm?: MiniModuleResult): MetaCognitionResult {
  // 기본 빈 구조
  const defaultResult: MetaCognitionResult = {
    myArsenal: {
      strengths: [],
      weaknesses: [],
    },
    preferenceMap: {
      likes: [],
      fits: [],
      dislikes: [],
    },
    innerExploration: {
      valueAnalysis: '가치관 분석을 위해 더 많은 정보가 필요합니다.',
      identityInsight: '자기 이해를 위해 더 많은 질문에 답변해주세요.',
      innerConflicts: '',
    },
    stressRecovery: {
      stressFactors: [],
      recoveryMethods: [],
    },
    growthPotential: {
      direction: '성장 방향을 분석 중입니다.',
      leveragePoints: [],
      counselorNote: '더 많은 정보가 모이면 맞춤형 조언을 드릴 수 있습니다.',
    },
    _meta: {
      generated_by: 'rule',
    },
  }

  if (!mm) {
    return defaultResult
  }

  // 강점 해석 - 더 풍부한 설명
  const strengthMeanings: Record<string, string> = {
    analytical: '복잡한 문제를 체계적으로 분해해서 해결하는 능력이 뛰어납니다. 이는 논리적 사고를 즐기고, 패턴을 찾아내는 것에서 에너지를 얻기 때문입니다. 데이터나 정보를 다룰 때 남들보다 빠르게 핵심을 파악하고, "왜?"라는 질문을 멈추지 않는 당신의 성향이 이 강점을 만들어냅니다.',
    creative: '기존 틀을 벗어나 새로운 방식을 제안하고 연결고리를 찾아내는 능력이 있습니다. 다른 사람들이 보지 못하는 것을 볼 수 있습니다. 당신의 머릿속에서는 항상 "다르게 할 순 없을까?"라는 생각이 자연스럽게 떠오르며, 이 창의적 충동이 혁신의 씨앗이 됩니다.',
    communication: '상대방의 관점을 이해하고 자신의 생각을 명확히 전달할 수 있습니다. 팀워크와 협업에서 윤활유 역할을 합니다. 당신은 말과 글로 사람의 마음을 움직이는 법을 본능적으로 알고 있으며, 복잡한 개념도 쉽게 풀어 설명할 수 있습니다.',
    structured_execution: '계획을 세우고 체계적으로 실행하는 능력이 뛰어납니다. 복잡한 프로젝트도 단계별로 관리할 수 있습니다. 당신에게 "계획"은 단순한 문서가 아니라 실현 가능한 로드맵이며, 이 체계성이 주변 사람들에게 신뢰감을 줍니다.',
    persistence: '끈기 있게 끝까지 해내는 힘을 가졌습니다. 어려운 상황에서도 포기하지 않는 강점이 있습니다. 많은 사람들이 중간에 그만두는 곳에서 당신은 계속 나아가며, 이 인내심이 결국 탁월한 결과로 이어집니다.',
    fast_learning: '새로운 것을 빠르게 배우고 적응하는 능력이 있습니다. 변화하는 환경에서도 유연하게 대처할 수 있습니다. 당신은 낯선 분야에서도 빠르게 핵심을 파악하고, 필요한 것을 흡수하여 자기 것으로 만드는 데 탁월합니다.',
    // 추가 강점 토큰
    leadership: '사람들을 이끌고 동기부여하는 능력이 있습니다. 비전을 제시하고 팀을 하나로 모으는 데 자연스러운 재능을 가지고 있으며, 어려운 상황에서도 방향을 제시할 수 있습니다.',
    empathy: '다른 사람의 감정과 상황을 깊이 이해하는 능력이 있습니다. 이 공감 능력은 대인관계에서 신뢰를 쌓는 기반이 되며, 팀 내 갈등을 해결하는 데 큰 도움이 됩니다.',
    detail_oriented: '세부사항에 주의를 기울이는 능력이 뛰어납니다. 다른 사람들이 놓치기 쉬운 부분을 발견하고, 완성도 높은 결과물을 만들어내는 데 기여합니다.',
    adaptability: '변화에 유연하게 적응하는 능력이 있습니다. 예상치 못한 상황에서도 당황하지 않고 새로운 방법을 찾아내며, 이 유연성이 불확실한 환경에서 큰 강점이 됩니다.',
  }

  const strengths: ArsenalItem[] = (mm.strength_top || []).map(token => ({
    trait: TOKEN_TO_KOREAN[token] || token,
    meaning: strengthMeanings[token] || `${TOKEN_TO_KOREAN[token] || token}이(가) 강점입니다.`,
  }))

  // 좋아하는 것 (흥미) - 더 풍부한 설명
  const interestWhys: Record<string, string> = {
    problem_solving: '해결했을 때의 성취감과 복잡한 것이 단순해지는 쾌감을 즐기기 때문입니다. 도전적인 문제 앞에서 오히려 에너지가 충전되며, "이걸 어떻게 풀지?"라는 질문이 당신을 설레게 만듭니다. 퍼즐이 맞춰지는 순간의 쾌감이 당신을 움직이는 원동력입니다.',
    creating: '무에서 유를 만드는 과정에서 살아있음을 느끼기 때문입니다. 결과물보다 창작 과정 자체에서 만족을 얻으며, 백지 상태에서 무언가를 만들어낼 때 가장 몰입합니다. 당신의 손에서 탄생하는 결과물은 당신의 정체성 일부입니다.',
    helping_teaching: '다른 사람이 성장하는 모습에서 보람을 느끼기 때문입니다. 나눔을 통해 자신도 성장하며, 누군가의 "아하!" 순간을 이끌어낼 때 가장 큰 기쁨을 느낍니다. 당신의 지식과 경험을 나누는 것이 곧 의미 있는 삶입니다.',
    data_numbers: '패턴을 발견하고 논리적 근거를 찾는 것에서 만족을 얻기 때문입니다. 숫자와 데이터 속에서 이야기를 읽어내는 능력이 있으며, 직관보다 증거를 신뢰합니다. 복잡한 데이터가 명확한 인사이트로 바뀌는 순간이 당신에게 보람입니다.',
    organizing: '체계적으로 정리된 상태에서 안정감을 느끼기 때문입니다. 혼란 속에서 질서를 만들어내는 것을 즐기며, 정돈된 시스템을 구축할 때 성취감을 느낍니다. 당신이 만든 구조 덕분에 다른 사람들도 효율적으로 일할 수 있습니다.',
    influencing: '다른 사람에게 영향을 미치고 변화를 이끌어내는 것에서 에너지를 얻기 때문입니다. 당신의 말과 행동이 누군가에게 영향을 주고, 세상이 조금이라도 바뀌는 것을 보면 큰 보람을 느낍니다.',
    // 추가 흥미 토큰
    researching: '깊이 파고들어 탐구하는 과정 자체에서 즐거움을 느끼기 때문입니다. 하나의 주제에 대해 철저히 알아가는 과정이 당신에게는 지루함이 아니라 발견의 여정입니다. 새로운 지식을 쌓아가는 것이 곧 성장입니다.',
    leading: '앞에서 이끌고 방향을 제시하는 역할에서 에너지를 얻기 때문입니다. 팀이 하나의 목표를 향해 움직일 때, 그 중심에서 조율하는 것이 당신의 자연스러운 역할입니다.',
    building: '처음부터 무언가를 구축해 나가는 과정을 즐기기 때문입니다. 아이디어가 실체를 갖추어 가는 과정에서 성취감을 느끼며, 완성된 결과물을 보면 뿌듯함을 느낍니다.',
  }

  const likes: PreferenceMapItem[] = (mm.interest_top || []).map(token => ({
    item: TOKEN_TO_KOREAN[token] || token,
    why: interestWhys[token] || `${TOKEN_TO_KOREAN[token] || token}에서 에너지를 얻습니다.`,
  }))

  // 안 맞는 것 (제약) - 더 풍부한 설명
  const constraintWhys: Record<string, string> = {
    time_constraint: '업무와 개인 시간의 경계가 무너지는 것을 꺼리는 타입입니다. 정해진 시간 안에 집중해서 효율적으로 일하고, 퇴근 후에는 온전히 자신의 시간을 갖고 싶어합니다. 이는 게으름이 아니라 삶의 균형을 중시하는 건강한 가치관입니다.',
    income_constraint: '경제적 안정이 중요한 가치이기 때문입니다. 불안정한 수입 구조는 일에 대한 불안감으로 이어지며, 재정적 걱정이 없을 때 더 창의적이고 과감한 시도를 할 수 있습니다. 안정된 수입은 당신이 더 좋은 일을 하기 위한 기반입니다.',
    physical_constraint: '체력적 소모가 큰 일보다 정신적 활동을 선호하기 때문입니다. 몸이 지치면 생각의 질도 떨어지고, 당신이 가진 분석력이나 창의력을 제대로 발휘하기 어렵습니다. 지적 활동에 에너지를 집중하는 것이 당신에게 맞습니다.',
    uncertainty_constraint: '예측 가능한 환경에서 더 안정감을 느끼기 때문입니다. 불확실성은 불필요한 불안을 유발하고, 당신의 계획적인 성향과 충돌합니다. 명확한 방향성이 있을 때 더 좋은 성과를 낼 수 있습니다.',
    qualification_constraint: '현재 상황에서 새로운 자격을 취득하는 데 시간이나 자원을 투자하기 어렵습니다. 이미 가진 역량을 활용할 수 있는 기회를 찾는 것이 더 현실적인 선택입니다.',
    location_constraint: '거주지 이동이 어렵거나 특정 지역에서만 근무가 가능한 상황입니다. 이는 가족, 네트워크, 또는 개인적 사정과 연결된 중요한 조건입니다.',
    // 추가 제약 토큰
    work_hours_strict: '불규칙한 근무시간은 생활 리듬을 깨뜨리고 개인 시간을 예측 불가능하게 만들기 때문입니다. 규칙적인 일과가 당신의 생산성과 삶의 질에 중요합니다.',
    no_travel: '잦은 출장은 체력적, 정신적 소모가 크고 일상의 안정성을 해치기 때문입니다. 한 곳에서 집중해서 일할 때 더 좋은 성과를 낼 수 있습니다.',
    no_overtime: '야근이 일상화된 환경은 개인 시간을 침해하고 번아웃 위험을 높이기 때문입니다. 정해진 시간 내에 효율적으로 일하는 문화를 선호합니다.',
    remote_only: '출퇴근에 소요되는 시간과 에너지를 절약하고, 자신만의 공간에서 집중해서 일하는 것을 선호하기 때문입니다.',
    no_shift: '교대근무는 생체리듬을 교란시키고 규칙적인 생활을 어렵게 만들기 때문입니다. 일정한 근무 시간이 당신의 건강과 성과에 중요합니다.',
    no_physical: '육체적으로 힘든 일보다 지적 활동에서 더 강점을 발휘할 수 있기 때문입니다.',
    no_outdoor: '야외 환경보다 실내에서 일할 때 더 집중이 잘 되고 편안함을 느끼기 때문입니다.',
    health_constraint: '건강 상태를 고려해야 하는 상황이므로, 무리가 가지 않는 환경에서 일하는 것이 중요합니다.',
  }

  const dislikes: PreferenceMapItem[] = (mm.constraint_flags || []).map(token => ({
    item: TOKEN_TO_KOREAN[token] || token,
    why: constraintWhys[token] || `${TOKEN_TO_KOREAN[token] || token}을(를) 피하고 싶어합니다.`,
  }))

  // 스트레스 요인 (에너지 소모) - 더 풍부한 설명
  const stressWhys: Record<string, string> = {
    people_drain: '지속적인 사회적 상호작용이 내적 에너지를 소모하기 때문입니다. 이는 당신이 내향적이거나 나쁜 사람이라는 뜻이 아닙니다. 당신은 내면의 세계가 풍부해서 혼자만의 시간에 충전되는 타입이며, 깊은 대화는 좋아하지만 피상적인 네트워킹은 피곤하게 느껴질 수 있습니다.',
    cognitive_drain: '계속 깊이 생각해야 할 때 정신적 피로가 쌓이기 때문입니다. 당신의 뇌는 열심히 일하고 있고, 그만큼 적절한 휴식과 회복 시간이 필요합니다. 생각을 비우는 시간을 의도적으로 만들어 두는 것이 중요합니다.',
    time_pressure_drain: '촉박한 마감과 시간 압박이 스트레스가 됩니다. 당신은 충분히 숙고하고 최선의 결정을 내리고 싶어하는 사람이며, 급하게 처리해야 할 때 불안함을 느낍니다. 여유 있는 계획 수립이 당신의 성과를 높입니다.',
    responsibility_drain: '큰 결정에 대한 책임감이 무겁게 느껴지기 때문입니다. 이는 당신이 일을 가볍게 여기지 않고 진지하게 임한다는 증거이기도 합니다. 책임을 분담하거나 의사결정 과정을 공유할 수 있는 환경이 좋습니다.',
    repetition_drain: '정해진 루틴이 반복될 때 답답함을 느낍니다. 새로운 자극과 도전이 없으면 의미를 찾기 어렵고, 당신의 창의성이나 학습 욕구가 충족되지 않습니다. 일상에 변화와 다양성을 더하는 것이 필요합니다.',
    unpredictability_drain: '예측할 수 없는 상황과 갑작스러운 변화가 불안감을 유발합니다. 당신은 계획적이고 체계적인 환경에서 안정감을 느끼며, 명확한 방향성이 있을 때 더 좋은 성과를 낼 수 있습니다.',
    // 추가 스트레스 토큰
    conflict_drain: '대인 갈등이나 불화가 에너지를 크게 소모합니다. 조화롭고 협력적인 환경에서 일할 때 더 좋은 결과를 낼 수 있습니다.',
    multitask_drain: '여러 일을 동시에 처리해야 할 때 집중력이 분산되고 스트레스를 받습니다. 한 번에 하나의 일에 깊이 집중하는 것이 당신에게 맞습니다.',
    uncertainty_drain: '불확실한 상황이 지속되면 에너지가 빠르게 소진됩니다. 명확한 정보와 방향이 있을 때 더 안정적으로 일할 수 있습니다.',
  }

  const stressFactors: StressRecoveryItem[] = (mm.energy_drain_flags || []).map(token => ({
    factor: TOKEN_TO_KOREAN[token] || token,
    why: stressWhys[token] || `스트레스 요인입니다.`,
  }))

  // 내적 충돌 - 더 공감적이고 구체적인 설명
  let innerConflicts = ''
  if (mm.internal_conflict_flags?.length) {
    const conflictMessages: Record<string, string> = {
      autonomy_vs_stability: '자율성과 안정성 사이에서 갈등을 느끼고 계시네요. 이는 매우 자연스러운 것입니다. 자유롭게 일하고 싶은 마음과 동시에 예측 가능하고 안정적인 환경에서 안심하고 싶은 마음, 두 가지 모두 당신의 진짜 욕구입니다. 이 둘을 양자택일이 아닌 "어느 정도의 자율성을 유지하면서 안정감도 확보할 수 있는 환경"으로 재정의해 보세요.',
      growth_vs_income: '성장과 수입 사이에서 고민하고 계시네요. 배우고 발전하고 싶지만 경제적 안정도 포기할 수 없는 현실적 조건입니다. 좋은 소식은 이 두 가치가 반드시 상충하는 것은 아니라는 점입니다. 성장의 방향을 수입과 연결할 수 있는 영역으로 설정하거나, 안정된 수입 기반 위에서 장기적 성장을 도모하는 전략을 고려해 보세요.',
      meaning_vs_income: '의미 있는 일과 수입 사이에서 갈등을 느끼고 계시네요. 이는 많은 분들이 겪는 고민입니다. "이 일이 정말 가치 있는가?"라는 질문과 "생활은 어떻게 하지?"라는 현실이 충돌합니다. 의미와 수입이 완벽히 일치하는 일은 드물지만, 의미 있는 요소를 점진적으로 늘려가는 방식으로 접근할 수 있습니다.',
      autonomy_vs_recognition: '자율성과 인정 사이에서 갈등이 있습니다. 스스로 결정하고 자유롭게 일하고 싶지만, 동시에 노력을 인정받고 싶은 마음도 있습니다. 이 두 가지 욕구는 모두 정당합니다. 자율적으로 일하면서도 성과를 가시화할 수 있는 방법을 찾아보세요.',
      stability_vs_excitement: '안정과 도전 사이에서 고민하고 계시네요. 안전하고 예측 가능한 것을 원하면서도, 동시에 새로운 자극과 도전이 필요합니다. 현재 환경에서 작은 도전을 시도해보거나, 안정적 기반 위에서 측면 프로젝트를 진행하는 방법도 있습니다.',
    }
    innerConflicts = mm.internal_conflict_flags
      .map(flag => conflictMessages[flag] || `${flag} 관련 내적 갈등이 감지됩니다. 이러한 갈등은 자연스러운 것이며, 두 가지 가치 모두 당신에게 중요하다는 의미입니다.`)
      .join(' ')
  }

  // 가치관 분석 - 더 구체적인 인사이트
  const valueLabels = (mm.value_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const valueAnalysis = valueLabels.length
    ? `당신에게 ${valueLabels.join('과(와) ')}은(는) 중요한 가치입니다. 이 가치들이 충족되는 환경에서 더 만족스럽게 일할 수 있으며, 이 가치들이 무시되거나 침해받는 상황에서는 불편함을 느끼게 됩니다. 커리어 선택의 기로에 섰을 때, 이 가치들을 기준으로 판단하면 후회가 적을 것입니다. 조건이 좋아 보여도 당신의 핵심 가치와 맞지 않는 환경은 결국 지속하기 어렵습니다.`
    : '가치관 분석을 위해 더 많은 정보가 필요합니다.'

  // 정체성 인사이트 - 더 완성도 있는 문장
  const strengthLabels = (mm.strength_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const interestLabels = (mm.interest_top || []).map(t => TOKEN_TO_KOREAN[t] || t)
  const workStyleLabels = (mm.work_style_flags || []).map(t => TOKEN_TO_KOREAN[t] || t)

  let identityInsight = '자기 이해를 위해 더 많은 질문에 답변해주세요.'
  if (strengthLabels.length && interestLabels.length && valueLabels.length) {
    // 자연스러운 서술형으로 생성 (선택지 나열 대신 의미 중심)
    const strengthStr = strengthLabels[0]
    const interestStr = interestLabels[0]
    const valueStr = valueLabels[0]
    identityInsight = `${interestStr}에 대한 열정과 ${strengthStr}을 갖춘 당신은, ${valueStr}을 중심으로 커리어를 설계할 때 가장 큰 만족감을 느낄 수 있습니다.`
    if (strengthLabels.length > 1) {
      identityInsight += ` ${strengthLabels.slice(1).join(', ')}도 함께 활용하면 독보적인 경쟁력이 됩니다.`
    }
  } else if (strengthLabels.length && interestLabels.length) {
    identityInsight = `${interestLabels[0]}에 대한 관심과 ${strengthLabels[0]}이라는 강점을 결합하면 강력한 시너지를 낼 수 있습니다.`
  } else if (strengthLabels.length) {
    identityInsight = `${strengthLabels.join('과(와) ')}에서 뛰어난 능력을 발휘하는 분입니다. 이 강점을 활용할 수 있는 환경을 찾아보세요.`
  }

  // 성장 방향 - 더 구체적인 가이드
  let direction = '성장 방향을 분석 중입니다.'
  if (strengthLabels.length && interestLabels.length) {
    direction = `당신의 ${strengthLabels.join(', ')} 강점을 ${interestLabels.join(', ')} 분야에 적용하면 독보적인 전문성을 쌓을 수 있습니다. 이 조합은 당신만의 경쟁력이 됩니다.`
  } else if (strengthLabels.length) {
    direction = `${strengthLabels.join(', ')}을(를) 더욱 발전시키고, 이를 실제 성과로 연결할 수 있는 기회를 찾아보세요.`
  }

  // 상담사 노트 - 더 개인화된 조언
  let counselorNote = '더 상세한 답변을 통해 맞춤형 성장 조언을 받아보세요.'
  if (strengthLabels.length && valueLabels.length && interestLabels.length) {
    counselorNote = `당신의 ${strengthLabels[0]}과(와) ${interestLabels[0]}에 대한 관심을 결합하면 큰 시너지를 낼 수 있습니다. 다만 ${valueLabels[0]}이(가) 보장되는 환경을 선택하세요. 조건이 좋아 보여도 핵심 가치가 충족되지 않으면 오래 버티기 어렵습니다.`
  } else if (strengthLabels.length && valueLabels.length) {
    counselorNote = `당신의 ${strengthLabels[0]}을(를) 발휘하면서 ${valueLabels[0]}이(가) 존중받는 환경을 찾으세요. 이 두 조건이 맞아떨어질 때 가장 좋은 성과를 낼 수 있습니다.`
  }

  // 섹션별 상담사 노트 생성
  let arsenalCounselorNote = ''
  if (strengthLabels.length >= 2) {
    arsenalCounselorNote = `${strengthLabels[0]}과(와) ${strengthLabels[1]}의 조합은 흔하지 않은 강점입니다. 이 두 가지를 동시에 발휘할 수 있는 역할을 찾으면 대체 불가능한 인재가 될 수 있습니다.`
  } else if (strengthLabels.length === 1) {
    arsenalCounselorNote = `${strengthLabels[0]}은(는) 많은 직업에서 핵심 역량으로 꼽히는 강점입니다. 이를 의식적으로 발전시키면 커리어에서 큰 차별화 요소가 됩니다.`
  }

  let preferenceCounselorNote = ''
  if (interestLabels.length && (mm.constraint_flags || []).length) {
    const constraintLabel = (mm.constraint_flags || []).map(t => TOKEN_TO_KOREAN[t] || t)[0]
    preferenceCounselorNote = `${interestLabels[0]}에 대한 열정을 유지하면서도 ${constraintLabel || '제약 조건'}을 피할 수 있는 환경을 찾는 것이 핵심입니다. 좋아하는 것을 포기하지 마세요.`
  } else if (interestLabels.length) {
    preferenceCounselorNote = `${interestLabels[0]}에 대한 관심은 단순한 취미가 아니라 커리어 방향의 나침반입니다. 이 관심사가 살아있는 환경에서 일할 때 가장 높은 몰입을 경험할 수 있습니다.`
  }

  let stressCounselorNote = ''
  if (stressFactors.length) {
    stressCounselorNote = `스트레스 요인을 인지하고 있다는 것 자체가 자기관리의 첫걸음입니다. 이 요인들이 최소화된 환경을 선택하면 번아웃 없이 오래 성장할 수 있습니다.`
  }

  return {
    myArsenal: {
      strengths,
      weaknesses: [],  // rule 기반에서는 약점 분석 제한
      counselorNote: arsenalCounselorNote,
    },
    preferenceMap: {
      likes,
      fits: [],  // rule 기반에서는 fits 생략
      dislikes,
      counselorNote: preferenceCounselorNote,
    },
    innerExploration: {
      valueAnalysis,
      identityInsight,
      innerConflicts,
    },
    stressRecovery: {
      stressFactors,
      recoveryMethods: [],  // rule 기반에서는 회복 방법 생략
      counselorNote: stressCounselorNote,
    },
    growthPotential: {
      direction,
      leveragePoints: strengthLabels,
      counselorNote,
    },
    _meta: {
      generated_by: 'rule',
    },
  }
}

// ============================================
// 프로필 해석 생성 함수 (나의 커리어 프로필 카드)
// ============================================
function generateProfileInterpretation(mm?: MiniModuleResult): ProfileInterpretation {
  // miniModuleResult가 없어도 빈 기본 구조 반환
  if (!mm) {
    return {
      interests: [],
      interests_summary: '',
      strengths: [],
      strengths_summary: '',
      values: [],
      values_summary: '',
      constraints: [],
      constraints_summary: '',
      overall_profile: '프로필 분석을 위해 더 많은 정보가 필요합니다.'
    }
  }

  // 흥미 해석
  const interests: ProfileItemInterpretation[] = (mm.interest_top || []).map(token => ({
    token,
    label: TOKEN_TO_KOREAN[token] || token,
    meaning: getInterestMeaning(token)
  }))

  // 강점 해석
  const strengths: ProfileItemInterpretation[] = (mm.strength_top || []).map(token => ({
    token,
    label: TOKEN_TO_KOREAN[token] || token,
    meaning: getStrengthMeaning(token)
  }))

  // 가치 해석
  const values: ProfileItemInterpretation[] = (mm.value_top || []).map(token => ({
    token,
    label: TOKEN_TO_KOREAN[token] || token,
    meaning: getValueMeaning(token)
  }))

  // 제약 해석
  const constraints: ProfileItemInterpretation[] = (mm.constraint_flags || []).map(token => ({
    token,
    label: TOKEN_TO_KOREAN[token] || token,
    meaning: getConstraintMeaning(token)
  }))

  // 종합 프로필 문장 생성
  const overallParts: string[] = []
  if (interests.length) {
    overallParts.push(`${interests.map(i => i.label).join('과 ')}에 관심을 가진`)
  }
  if (strengths.length) {
    overallParts.push(`${strengths.map(s => s.label).join(', ')}에 강점을 가진`)
  }
  if (values.length) {
    overallParts.push(`${values.map(v => v.label).join(', ')}을(를) 중요하게 여기는`)
  }
  const overallProfile = overallParts.length > 0
    ? `당신은 ${overallParts.join(', ')} 사람입니다.`
    : '프로필 분석을 위해 더 많은 정보가 필요합니다.'

  return {
    interests,
    interests_summary: interests.length
      ? `당신은 ${interests.map(i => i.label).join(', ')}에 관심이 있습니다.`
      : '',
    strengths,
    strengths_summary: strengths.length
      ? `당신은 ${strengths.map(s => s.label).join(', ')}에 강점을 가지고 있습니다.`
      : '',
    values,
    values_summary: values.length
      ? `당신에게 ${values.map(v => v.label).join(', ')}는 중요한 가치입니다.`
      : '',
    constraints,
    constraints_summary: constraints.length
      ? `당신은 ${constraints.map(c => c.label).join(', ')}을(를) 피하고 싶어합니다.`
      : '',
    overall_profile: overallProfile
  }
}

// 흥미 토큰별 의미 해석
function getInterestMeaning(token: string): string {
  const meanings: Record<string, string> = {
    'problem_solving': '복잡한 문제를 분석하고 해결책을 찾는 것에서 에너지를 얻는 타입입니다.',
    'data_numbers': '데이터와 숫자를 다루며 패턴을 발견하는 것을 좋아합니다.',
    'creating': '새로운 것을 만들어내는 창작 활동에서 보람을 느낍니다.',
    'influencing': '다른 사람에게 영향을 주고 설득하는 것을 즐깁니다.',
    'helping_teaching': '다른 사람을 돕고 가르치는 것에서 의미를 찾습니다.',
    'organizing': '체계적으로 정리하고 관리하는 것을 좋아합니다.',
  }
  return meanings[token] || `${TOKEN_TO_KOREAN[token] || token}에 관심이 있습니다.`
}

// 강점 토큰별 의미 해석
function getStrengthMeaning(token: string): string {
  const meanings: Record<string, string> = {
    'analytical': '정보를 체계적으로 정리하고, 핵심을 빠르게 파악하는 능력을 가졌습니다.',
    'fast_learning': '새로운 것을 빠르게 습득하고 적용할 수 있습니다.',
    'creative': '창의적인 아이디어를 내고 새로운 방식을 시도하는 것을 잘합니다.',
    'communication': '생각을 명확하게 전달하고 다른 사람과 소통하는 것을 잘합니다.',
    'persistence': '어려움이 있어도 포기하지 않고 끝까지 해내는 끈기가 있습니다.',
    'leadership': '팀을 이끌고 방향을 제시하는 리더십을 가지고 있습니다.',
  }
  return meanings[token] || `${TOKEN_TO_KOREAN[token] || token}이(가) 강점입니다.`
}

// 가치 토큰별 의미 해석
function getValueMeaning(token: string): string {
  const meanings: Record<string, string> = {
    'growth': '지속적인 성장과 발전을 중요하게 여깁니다. 배움을 멈추지 않는 것이 중요합니다.',
    'stability': '예측 가능한 환경에서 안정감을 느끼는 타입입니다. 불확실성보다는 체계적인 계획을 선호합니다.',
    'autonomy': '스스로 판단하고 결정하는 것을 중요하게 여깁니다. 세세한 지시나 감시를 받으면 답답함을 느낄 수 있습니다.',
    'recognition': '노력에 대한 인정과 성과에 대한 보상을 중요하게 생각합니다.',
    'meaning': '단순히 돈을 버는 것이 아닌, 의미 있는 일을 하고 싶어합니다.',
    'work_life_balance': '일과 삶의 균형을 중요하게 여깁니다. 장기적으로 지속 가능한 커리어를 추구합니다.',
  }
  return meanings[token] || `${TOKEN_TO_KOREAN[token] || token}을(를) 중요하게 생각합니다.`
}

// 제약 토큰별 의미 해석
function getConstraintMeaning(token: string): string {
  const meanings: Record<string, string> = {
    'no_overtime': '업무와 개인 시간의 경계가 무너지는 것을 꺼리는 타입입니다. 효율적으로 일하고, 정해진 시간 안에 마무리하는 것을 중요하게 생각합니다.',
    'no_repetitive': '같은 일을 반복하면 빠르게 지루함을 느끼는 타입입니다. 새로운 자극과 변화가 있어야 동기부여가 됩니다.',
    'no_social_stress': '사람들과의 갈등이나 불필요한 사회적 에너지 소비를 꺼리는 타입입니다.',
    'no_relocation': '이사나 잦은 출장이 어려운 상황입니다.',
    'no_physical': '체력적으로 부담되는 업무를 피하고 싶어합니다.',
    'remote_preferred': '가능하면 재택근무 환경에서 일하고 싶어하는 타입입니다. 출퇴근 부담을 줄이고 집중할 수 있는 환경을 선호합니다.',
    'prefer_remote': '가능하면 재택근무 환경에서 일하고 싶어하는 타입입니다. 출퇴근 부담을 줄이고 집중할 수 있는 환경을 선호합니다.',
    'remote_only': '재택근무가 필수인 상황입니다. 사무실 출근이 어렵거나 원격 환경에서 최고의 성과를 냅니다.',
    'work_hours_strict': '불규칙한 근무시간이 힘든 타입입니다. 예측 가능한 생활 패턴과 워라밸을 중요하게 생각합니다.',
    'no_travel': '잦은 출장이 어려운 상황입니다. 한 곳에서 안정적으로 근무하는 것을 선호합니다.',
    'no_shift': '교대근무가 어려운 타입입니다. 규칙적인 생활 리듬이 중요합니다.',
    'shift_work_no': '교대근무가 어려운 타입입니다. 규칙적인 생활 리듬이 중요합니다.',
    'no_outdoor': '야외 근무보다는 실내 환경에서 일하는 것을 선호합니다.',
    'no_weekend': '주말에는 충분한 휴식과 개인 시간이 필요한 타입입니다.',
    'degree_impossible': '학위 취득이 현실적으로 어려운 상황입니다. 실무 경험이나 자격증으로 대체할 수 있는 분야를 선호합니다.',
    'license_impossible': '자격증 취득이 현실적으로 어려운 상황입니다.',
    'travel_impossible': '출장이 불가능한 상황입니다.',
    'prefer_low_overtime': '야근을 최소화하고 싶은 타입입니다. 업무 효율을 높여 정시 퇴근을 추구합니다.',
  }
  return meanings[token] || `${TOKEN_TO_KOREAN[token] || token}을(를) 피하고 싶어합니다.`
}





