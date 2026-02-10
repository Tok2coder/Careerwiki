// CareerWiki AI Analyzer - Question Generation
// Version: v1.0.3 (Phase 1C Deep Intake)
// 후보군 갈림 포인트 기반 질문 생성 + Narrative/Pattern 질문

import type { JobAttribute } from './fact-score-mapping'
import type { FollowupQuestionType } from './types'

// ============================================
// 타입 정의
// ============================================

export interface FollowupQuestion {
  id: string
  type: FollowupQuestionType  // 'clarification' | 'tradeoff' | 'priority' | 'discovery' | 'narrative' | 'pattern'
  question: string
  context?: string
  options: QuestionOption[]
  fact_key: string
  affects_attributes: JobAttribute[]
  // Phase 1C: 오픈 텍스트 여부
  is_open_text?: boolean
  placeholder?: string
}

export interface QuestionOption {
  value: string
  label: string
  tags?: string[]
}

export interface ScoredJob {
  job_id: string
  job_name: string
  slug?: string           // 커리어위키 URL 슬러그
  image_url?: string      // 직업 썸네일 이미지
  scores: {
    fit: number
    like: number
    can: number
    risk_penalty: number
  }
  attributes: Record<string, string | number>
}

export interface QuestionGenerationInput {
  candidates: ScoredJob[]  // 후보 80개
  topK: ScoredJob[]        // TOP 10개
  existingFacts: Array<{ fact_key: string }>  // 이미 수집된 facts
}

export interface QuestionScore {
  question: FollowupQuestion
  informationGain: number      // 0~1
  expectedRankChange: number   // 0~1
  totalScore: number
}

// ============================================
// Attribute → 질문 매핑
// ============================================

export const ATTRIBUTE_TO_QUESTION_MAP: Record<string, FollowupQuestion> = {
  'wlb': {
    id: 'tradeoff_salary_vs_wlb',
    type: 'tradeoff',
    question: '연봉이 30% 높지만 야근이 가끔 있는 회사 vs 연봉은 낮지만 칼퇴가 보장되는 회사, 어느 쪽이 더 끌리세요?',
    context: '당신에게 맞는 직업을 찾기 위해 워라밸과 연봉 중 우선순위를 확인하고 싶어요.',
    options: [
      { value: 'salary', label: '연봉이 높은 쪽', tags: ['income'] },
      { value: 'wlb', label: '칼퇴가 보장되는 쪽', tags: ['work_life_balance'] },
    ],
    fact_key: 'tradeoff.salary_vs_wlb',
    affects_attributes: ['wlb', 'income'],
  },
  
  'growth': {
    id: 'tradeoff_growth_vs_stability',
    type: 'tradeoff',
    question: '빠르게 성장할 수 있지만 불안정한 환경 vs 느리게 성장하지만 안정적인 환경, 어느 쪽이세요?',
    context: '성장과 안정 중 어떤 가치를 더 중시하는지 알고 싶어요.',
    options: [
      { value: 'growth', label: '빠른 성장', tags: ['growth'] },
      { value: 'stability', label: '안정적인 환경', tags: ['stability'] },
    ],
    fact_key: 'tradeoff.growth_vs_stability',
    affects_attributes: ['growth', 'stability'],
  },
  
  'solo_work': {
    id: 'tradeoff_solo_vs_team',
    type: 'tradeoff',
    question: '혼자 깊게 파고드는 업무 vs 여러 사람과 협업하는 업무, 어느 쪽에서 에너지를 더 받으세요?',
    context: '업무 스타일에 대해 알고 싶어요.',
    options: [
      { value: 'solo', label: '혼자 깊게', tags: ['autonomy'] },
      { value: 'team', label: '협업', tags: ['people'] },
    ],
    fact_key: 'tradeoff.solo_vs_team',
    affects_attributes: ['solo_work', 'people_facing'],
  },
  
  'income': {
    id: 'priority_income_importance',
    type: 'priority',
    question: '직업 선택에서 연봉/수입은 얼마나 중요한가요?',
    context: '수입의 우선순위를 확인하고 싶어요.',
    options: [
      { value: 'very_important', label: '매우 중요 (최우선)', tags: ['income'] },
      { value: 'important', label: '중요하지만 다른 것도 중요', tags: ['income'] },
      { value: 'not_priority', label: '다른 가치가 더 중요', tags: [] },
    ],
    fact_key: 'priority.income_importance',
    affects_attributes: ['income'],
  },
  
  'remote': {
    id: 'clarify_remote_reason',
    type: 'clarification',
    question: '원격/재택근무를 원하신다면, 가장 큰 이유가 뭔가요?',
    context: '원격근무를 원하는 진짜 이유를 알고 싶어요.',
    options: [
      { value: '집중', label: '혼자 집중하고 싶어서', tags: ['autonomy'] },
      { value: '통근', label: '출퇴근 시간이 아까워서', tags: ['work_life_balance'] },
      { value: '가족', label: '가족/육아와 병행하려고', tags: ['family', 'work_life_balance'] },
      { value: '체력', label: '체력적으로 편해서', tags: ['health'] },
    ],
    fact_key: 'motivation.remote_reason',
    affects_attributes: ['remote'],
  },
  
  // 야근 관련 명료화 질문
  'wlb_reason': {
    id: 'clarify_work_hours_reason',
    type: 'clarification',
    question: '야근이나 긴 근무시간이 싫으시다면, 가장 큰 이유가 뭔가요?',
    context: '워라밸이 중요한 진짜 이유를 알고 싶어요.',
    options: [
      { value: '체력', label: '체력적으로 힘들어서', tags: ['health'] },
      { value: '가족', label: '가족과 시간을 보내고 싶어서', tags: ['family', 'work_life_balance'] },
      { value: '공부', label: '퇴근 후 자기계발을 하고 싶어서', tags: ['learning', 'growth'] },
      { value: '스트레스', label: '정신적 스트레스가 커서', tags: ['health', 'work_life_balance'] },
    ],
    fact_key: 'motivation.work_hours_reason',
    affects_attributes: ['wlb'],
  },
}

// ============================================
// Phase 1C: Narrative/Pattern 질문 템플릿
// ============================================

export const NARRATIVE_PATTERN_QUESTIONS: FollowupQuestion[] = [
  // Narrative(서사형): "왜?"를 파는 질문
  {
    id: 'narrative_energy_moment',
    type: 'narrative',
    question: '일할 때 가장 에너지가 났던 순간은 언제였나요? 그때 뭘 하고 있었어요?',
    context: '당신이 어떤 상황에서 활력을 느끼는지 알고 싶어요.',
    options: [],  // 오픈 텍스트
    fact_key: 'discovery.best_moment',
    affects_attributes: ['solo_work', 'people_facing', 'creative', 'analytical'],
    is_open_text: true,
    placeholder: '예: 팀원들과 브레인스토밍할 때, 혼자 데이터 분석에 몰입할 때...',
  },
  {
    id: 'narrative_drain_moment',
    type: 'narrative',
    question: '반대로, 일하면서 가장 힘들었거나 에너지가 빠졌던 순간은요?',
    context: '피하고 싶은 상황을 이해하면 더 맞는 직업을 찾을 수 있어요.',
    options: [],  // 오픈 텍스트
    fact_key: 'discovery.worst_moment',
    affects_attributes: ['wlb', 'solo_work', 'people_facing'],
    is_open_text: true,
    placeholder: '예: 회의가 너무 많아서, 반복 업무만 해서, 상사와 갈등...',
  },
  {
    id: 'narrative_change_goal',
    type: 'narrative',
    question: '지금 커리어에서 가장 바꾸고 싶은 게 있다면 뭘까요?',
    context: '현재 불만족이나 원하는 변화를 알면 방향을 잡기 쉬워요.',
    options: [],  // 오픈 텍스트
    fact_key: 'motivation.change_reason',
    affects_attributes: ['growth', 'income', 'wlb', 'stability'],
    is_open_text: true,
    placeholder: '예: 더 성장하고 싶어요, 워라밸이 필요해요, 연봉을 올리고 싶어요...',
  },
  {
    id: 'narrative_never_again',
    type: 'narrative',
    question: '다시는 반복하고 싶지 않은 업무 경험이 있다면요?',
    context: '이 정보가 추천에서 위험 직업을 걸러내는 데 도움이 돼요.',
    options: [],  // 오픈 텍스트
    fact_key: 'discovery.never_again',
    affects_attributes: ['wlb', 'people_facing', 'stability'],
    is_open_text: true,
    placeholder: '예: 밤샘 야근, 감정 노동, 불안정한 계약직...',
  },
  
  // Pattern(패턴형): 반복되는 성향/에너지/스트레스 트리거
  {
    id: 'pattern_stress_trigger',
    type: 'pattern',
    question: '스트레스를 받을 때, 어떤 상황에서 가장 크게 받으세요?',
    context: '스트레스 요인을 알면 맞지 않는 환경을 피할 수 있어요.',
    options: [
      { value: 'deadline', label: '마감/시간 압박', tags: ['deadline'] },
      { value: 'people', label: '사람 간 갈등/정치', tags: ['people'] },
      { value: 'uncertainty', label: '애매하거나 자주 바뀌는 상황', tags: ['uncertainty'] },
      { value: 'multitask', label: '여러 일을 동시에 해야 할 때', tags: ['multitask'] },
      { value: 'meeting', label: '회의/보고가 너무 많을 때', tags: ['meeting'] },
      { value: 'physical', label: '체력적으로 힘들 때', tags: ['physical'] },
    ],
    fact_key: 'insight.stress_trigger',
    affects_attributes: ['wlb', 'solo_work', 'remote'],
  },
  {
    id: 'pattern_energy_source',
    type: 'pattern',
    question: '퇴근 후나 쉬는 날, 어떻게 에너지를 충전하세요?',
    context: '성향을 파악하면 맞는 업무 환경을 찾는 데 도움이 돼요.',
    options: [
      { value: 'solo', label: '혼자 조용히 시간 보내기', tags: ['solo'] },
      { value: 'people', label: '친구/사람들과 만나기', tags: ['people'] },
      { value: 'learning', label: '새로운 걸 배우거나 공부', tags: ['learning'] },
      { value: 'creating', label: '무언가 만들기 (글, 그림, 코드 등)', tags: ['creating'] },
      { value: 'exploring', label: '새로운 곳 탐험/여행', tags: ['exploring'] },
    ],
    fact_key: 'discovery.energy_source',
    affects_attributes: ['solo_work', 'people_facing', 'creative'],
  },
  {
    id: 'pattern_decision_style',
    type: 'pattern',
    question: '중요한 결정을 내릴 때, 주로 어떻게 하세요?',
    context: '의사결정 스타일을 알면 맞는 업무 유형을 찾을 수 있어요.',
    options: [
      { value: 'data', label: '데이터/논리로 분석해서', tags: ['analytical'] },
      { value: 'intuition', label: '직감과 느낌으로', tags: ['creative'] },
      { value: 'consult', label: '주변 사람들과 상의해서', tags: ['people'] },
      { value: 'research', label: '충분히 조사한 후에', tags: ['analytical'] },
    ],
    fact_key: 'insight.decision_style',
    affects_attributes: ['analytical', 'creative', 'people_facing'],
  },
  {
    id: 'pattern_work_rhythm',
    type: 'pattern',
    question: '어떤 업무 리듬이 더 맞으세요?',
    context: '업무 템포 선호도를 알면 맞는 환경을 추천할 수 있어요.',
    options: [
      { value: 'steady', label: '예측 가능하고 꾸준한 페이스', tags: ['stability', 'routine'] },
      { value: 'varied', label: '매일 다른 새로운 도전', tags: ['variety', 'fast_paced'] },
      { value: 'deep', label: '한 가지를 깊게 파고드는 것', tags: ['solo_deep', 'analytical'] },
      { value: 'mixed', label: '여러 가지를 조금씩 다양하게', tags: ['variety'] },
    ],
    fact_key: 'insight.work_rhythm',
    affects_attributes: ['stability', 'growth', 'solo_work'],
  },
]

// 모든 질문 통합
export function getAllQuestionsIncludingNarrativePattern(): FollowupQuestion[] {
  return [
    ...Object.values(ATTRIBUTE_TO_QUESTION_MAP),
    ...NARRATIVE_PATTERN_QUESTIONS,
  ]
}

// ============================================
// 분별력(Discrimination) 계산
// ============================================

interface AttributeDiscrimination {
  attribute: JobAttribute
  variance: number
  splitGain: number
}

function calculateVariance(values: number[]): number {
  if (values.length === 0) return 0
  const mean = values.reduce((a, b) => a + b, 0) / values.length
  const squaredDiffs = values.map(v => Math.pow(v - mean, 2))
  return squaredDiffs.reduce((a, b) => a + b, 0) / values.length
}

function calculateSplitGain(jobs: ScoredJob[], attribute: JobAttribute): number {
  // 해당 attribute로 직업들을 나눴을 때 정보 이득 계산
  // 간단 버전: attribute 값이 다양할수록 gain 높음
  const values = jobs.map(j => j.attributes[attribute]).filter(v => v !== undefined)
  const uniqueValues = new Set(values)
  
  // 다양성 점수 (0~1)
  const diversity = uniqueValues.size / Math.max(values.length, 1)
  
  // 점수 분산 (해당 attribute로 점수가 갈리는지)
  const fitScores = jobs.map(j => j.scores.fit)
  const variance = calculateVariance(fitScores)
  
  // gain = diversity * variance (정규화)
  return diversity * (variance / 1000)  // 1000으로 나눠서 0~1 범위로
}

export function calculateDiscriminatingAttributes(
  topK: ScoredJob[]
): AttributeDiscrimination[] {
  const attributes: JobAttribute[] = [
    'wlb', 'growth', 'stability', 'income', 'remote', 'solo_work', 'people_facing'
  ]
  
  return attributes.map(attr => {
    const values = topK
      .map(job => {
        const val = job.attributes[attr]
        return typeof val === 'number' ? val : (val ? 1 : 0)
      })
    
    const variance = calculateVariance(values)
    const splitGain = calculateSplitGain(topK, attr)
    
    return { attribute: attr, variance, splitGain }
  }).sort((a, b) => b.splitGain - a.splitGain)
}

// ============================================
// 질문 점수 계산
// ============================================

function calculateInformationGain(
  question: FollowupQuestion,
  existingFacts: Array<{ fact_key: string }>
): number {
  // 이미 수집된 fact면 gain = 0
  const alreadyCollected = existingFacts.some(f => f.fact_key === question.fact_key)
  if (alreadyCollected) return 0
  
  // 관련 fact가 있으면 gain 감소
  const relatedFacts = existingFacts.filter(f => 
    question.affects_attributes.some(attr => f.fact_key.includes(attr))
  )
  
  if (relatedFacts.length > 0) return 0.5  // 부분적으로 알고 있음
  
  return 1.0  // 완전히 모름
}

function simulateRankChange(
  question: FollowupQuestion,
  candidates: ScoredJob[]
): number {
  // 간단 버전: 질문이 영향을 주는 attribute가 후보들 간에 다양할수록 높음
  const affectedJobs = candidates.filter(job => 
    question.affects_attributes.some(attr => job.attributes[attr] !== undefined)
  )
  
  // 영향받는 직업 비율 (0~1)
  const affectedRatio = affectedJobs.length / Math.max(candidates.length, 1)
  
  // 해당 attribute들의 분산
  let totalVariance = 0
  for (const attr of question.affects_attributes) {
    const values = candidates
      .map(j => j.attributes[attr])
      .filter(v => v !== undefined)
      .map(v => typeof v === 'number' ? v : 1)
    
    totalVariance += calculateVariance(values)
  }
  
  // 정규화
  return Math.min(1, affectedRatio * (totalVariance / 100))
}

export function scoreQuestion(
  question: FollowupQuestion,
  candidates: ScoredJob[],
  existingFacts: Array<{ fact_key: string }>
): QuestionScore {
  const informationGain = calculateInformationGain(question, existingFacts)
  const expectedRankChange = simulateRankChange(question, candidates)
  
  // v1.0.2 공식: 0.4 * informationGain + 0.6 * expectedRankChange
  const totalScore = 0.4 * informationGain + 0.6 * expectedRankChange
  
  return { question, informationGain, expectedRankChange, totalScore }
}

// ============================================
// 질문 생성 메인 함수
// ============================================

export interface QuestionGenerationInputV2 extends QuestionGenerationInput {
  hasDeepIntake?: boolean  // Deep Intake 입력 여부
}

export function generateFollowupQuestions(
  input: QuestionGenerationInputV2,
  maxQuestions: number = 3
): FollowupQuestion[] {
  const { candidates, topK, existingFacts, hasDeepIntake = false } = input
  
  // 1. 후보군에서 분별력 높은 attribute 추출
  const discriminatingAttrs = calculateDiscriminatingAttributes(topK)
  
  // 2. 해당 attribute에 대한 질문 찾기
  const candidateQuestions: FollowupQuestion[] = []
  
  for (const attrInfo of discriminatingAttrs) {
    const question = ATTRIBUTE_TO_QUESTION_MAP[attrInfo.attribute]
    if (question) {
      candidateQuestions.push(question)
    }
  }
  
  // 추가: 명료화 질문도 후보에 포함 (wlb_reason 등)
  const clarificationQuestions = Object.values(ATTRIBUTE_TO_QUESTION_MAP)
    .filter(q => q.type === 'clarification')
  candidateQuestions.push(...clarificationQuestions)
  
  // Phase 1C: Narrative/Pattern 질문 추가
  candidateQuestions.push(...NARRATIVE_PATTERN_QUESTIONS)
  
  // 3. 질문 점수 계산 및 정렬
  const scoredQuestions = candidateQuestions.map(q => {
    const score = scoreQuestion(q, candidates, existingFacts)
    
    // Phase 1C: Deep Intake 없으면 Narrative/Pattern 질문 우선순위 가산
    if (!hasDeepIntake && (q.type === 'narrative' || q.type === 'pattern')) {
      // Narrative/Pattern에 가산점 (0.2)
      score.totalScore += 0.2
    }
    
    return score
  })
  
  scoredQuestions.sort((a, b) => b.totalScore - a.totalScore)
  
  // 4. 최소 정보이득 임계값 체크 (0.2 미만이면 제외)
  // Narrative/Pattern은 예외 (항상 중요)
  const filtered = scoredQuestions.filter(sq => {
    if (sq.question.type === 'narrative' || sq.question.type === 'pattern') {
      return sq.informationGain >= 0.1  // 더 낮은 임계값
    }
    return sq.informationGain >= 0.2
  })
  
  // 5. 상위 N개 선택 (중복 fact_key 제거)
  const selected: FollowupQuestion[] = []
  const usedFactKeys = new Set<string>()
  
  for (const sq of filtered) {
    if (selected.length >= maxQuestions) break
    if (usedFactKeys.has(sq.question.fact_key)) continue
    
    selected.push(sq.question)
    usedFactKeys.add(sq.question.fact_key)
  }
  
  return selected
}

// 질문 타입별 필터링
export function getQuestionsByType(type: FollowupQuestion['type']): FollowupQuestion[] {
  return [
    ...Object.values(ATTRIBUTE_TO_QUESTION_MAP),
    ...NARRATIVE_PATTERN_QUESTIONS,
  ].filter(q => q.type === type)
}

// ============================================
// 유틸리티
// ============================================

export function getQuestionById(questionId: string): FollowupQuestion | undefined {
  return Object.values(ATTRIBUTE_TO_QUESTION_MAP).find(q => q.id === questionId)
}

export function getAllQuestions(): FollowupQuestion[] {
  return Object.values(ATTRIBUTE_TO_QUESTION_MAP)
}

// ============================================
// Premium V3: 목적 기반 3종 분류 Follow-up 생성
// ============================================
// ⚠️ LLM vs Rule 역할 경계
// - type, why_asked, affected_dimensions: Rule 기반으로 고정
// - question 문장만 LLM 생성 가능 (선택적)
// ============================================

import type { FollowupPurpose, FollowupQuestionV3 } from './types'

// 모순 패턴 정의
interface ContradictionPattern {
  fact_a: string | RegExp
  fact_b: string | RegExp
  conflict_reason: string
  resolution_question: string
  affected_dimensions: string[]
}

const CONTRADICTION_PATTERNS: ContradictionPattern[] = [
  {
    fact_a: 'priority.top1',
    fact_b: 'profile.dislike.keywords',
    conflict_reason: '성장/수입을 우선시하면서 야근을 피하고 싶다고 하셨어요',
    resolution_question: '성장 기회가 많지만 가끔 야근이 있는 환경과, 안정적이지만 성장이 느린 환경 중 어느 쪽이 더 낫나요?',
    affected_dimensions: ['growth', 'wlb', 'income'],
  },
  {
    fact_a: /^profile\.workstyle\.social$/,
    fact_b: /^profile\.interest\.keywords$/,
    conflict_reason: '혼자 일하는 걸 선호하시면서 사람 관련 분야에 관심 있다고 하셨어요',
    resolution_question: '사람들과 직접 소통하는 역할과, 사람을 위한 결과물을 혼자 만드는 역할 중 어느 쪽인가요?',
    affected_dimensions: ['solo_deep', 'people_facing', 'teamwork'],
  },
  {
    fact_a: 'priority.top1',
    fact_b: 'profile.constraints.qualification',
    conflict_reason: '전문성 성장을 원하시면서 학력/자격 취득이 어렵다고 하셨어요',
    resolution_question: '자격증 없이도 실력으로 인정받을 수 있는 분야와, 자격증이 있어야 진입할 수 있는 분야 중 어느 쪽을 원하시나요?',
    affected_dimensions: ['growth', 'degree_required', 'license_required'],
  },
]

// 결정 분기점 정의
interface DecisionSplitPoint {
  attribute: string
  split_threshold: number
  high_group_label: string
  low_group_label: string
  question: string
  why_asked: string
}

const DECISION_SPLIT_POINTS: DecisionSplitPoint[] = [
  {
    attribute: 'wlb',
    split_threshold: 60,
    high_group_label: '워라밸 좋은 직업군',
    low_group_label: '야근 많지만 성장 빠른 직업군',
    question: '주 50시간 이상 일하는 건 절대 안 되나요, 아니면 보상이 좋으면 괜찮나요?',
    why_asked: '이 답변에 따라 추천 직업군이 크게 달라집니다. 야근이 잦은 고성장 직업 vs 안정적 워라밸 직업',
  },
  {
    attribute: 'income',
    split_threshold: 60,
    high_group_label: '고수입 직업군',
    low_group_label: '안정적 중간 수입 직업군',
    question: '연봉이 낮더라도 의미있는 일을 할 수 있으면 괜찮나요, 아니면 수입이 최우선인가요?',
    why_asked: '수입 우선순위에 따라 추천 방향이 달라집니다. 고수입 경쟁 직업 vs 안정적 보람 직업',
  },
  {
    attribute: 'remote_possible',
    split_threshold: 50,
    high_group_label: '원격근무 가능 직업군',
    low_group_label: '현장 근무 직업군',
    question: '매일 사무실에 출근하는 건 괜찮나요, 아니면 재택/원격이 필수인가요?',
    why_asked: '근무 형태 선호에 따라 추천 가능한 직업 범위가 달라집니다',
  },
  {
    attribute: 'people_facing',
    split_threshold: 60,
    high_group_label: '대인 업무 직업군',
    low_group_label: '비대면 업무 직업군',
    question: '매일 새로운 사람을 만나는 일은 어떤가요? 에너지가 나나요, 빠지나요?',
    why_asked: '대인 업무 선호도에 따라 영업/서비스직 vs 개발/분석직 방향이 갈립니다',
  },
]

// 미확인 제약 체크
interface UnconfirmedConstraint {
  constraint_key: string
  question: string
  why_asked: string
  affected_dimensions: string[]
}

const UNCONFIRMED_CONSTRAINTS: UnconfirmedConstraint[] = [
  {
    constraint_key: 'profile.constraints.qualification',
    question: '새로운 자격증이나 학위 취득에 1년 이상 투자할 수 있나요?',
    why_asked: '자격 요구 직업을 추천 범위에 포함할지 결정합니다',
    affected_dimensions: ['degree_required', 'license_required'],
  },
  {
    constraint_key: 'profile.constraints.location',
    question: '수도권 외 지역이나 잦은 출장이 있는 직업도 괜찮나요?',
    why_asked: '지역 제한이 있으면 추천 가능한 직업이 제한됩니다',
    affected_dimensions: ['travel', 'remote_possible'],
  },
  {
    constraint_key: 'profile.constraints.time',
    question: '주말 근무나 야간 근무가 있는 직업도 고려할 수 있나요?',
    why_asked: '시간 제약이 있으면 교대근무 직업이 제외됩니다',
    affected_dimensions: ['shift_work', 'work_hours', 'wlb'],
  },
  {
    constraint_key: 'profile.life_constraint',
    question: '가족 돌봄이나 건강 상 특별히 피해야 할 근무 환경이 있나요?',
    why_asked: '생활 제약을 반영해서 현실적으로 가능한 직업만 추천합니다',
    affected_dimensions: ['wlb', 'work_hours', 'remote_possible'],
  },
]

// ============================================
// 모순 감지
// ============================================
function detectContradictions(
  facts: Array<{ fact_key: string; value_json: string }>
): { pattern: ContradictionPattern; fact_a_value: string; fact_b_value: string }[] {
  const contradictions: { pattern: ContradictionPattern; fact_a_value: string; fact_b_value: string }[] = []
  
  for (const pattern of CONTRADICTION_PATTERNS) {
    const fact_a = facts.find(f => {
      if (typeof pattern.fact_a === 'string') return f.fact_key === pattern.fact_a
      return pattern.fact_a.test(f.fact_key)
    })
    const fact_b = facts.find(f => {
      if (typeof pattern.fact_b === 'string') return f.fact_key === pattern.fact_b
      return pattern.fact_b.test(f.fact_key)
    })
    
    if (fact_a && fact_b) {
      // 실제 모순인지 검사 (간단 버전: 둘 다 존재하면 잠재적 모순)
      let a_value = ''
      let b_value = ''
      try {
        const a_parsed = JSON.parse(fact_a.value_json)
        const b_parsed = JSON.parse(fact_b.value_json)
        a_value = a_parsed.value || a_parsed
        b_value = b_parsed.value || b_parsed
      } catch {
        a_value = fact_a.value_json
        b_value = fact_b.value_json
      }
      
      // 특정 조합만 모순으로 판정
      // 예: priority.top1 = growth + dislike = overtime
      if (pattern.fact_a === 'priority.top1' && 
          (a_value === 'growth' || a_value === 'income') &&
          (Array.isArray(b_value) ? b_value.includes('overtime') : String(b_value).includes('overtime'))) {
        contradictions.push({ pattern, fact_a_value: String(a_value), fact_b_value: String(b_value) })
      }
    }
  }
  
  return contradictions
}

// ============================================
// 결정 분기점 탐지
// ============================================
function findDecisionSplitPoints(
  candidates: ScoredJob[],
  topK: ScoredJob[]
): DecisionSplitPoint[] {
  const splitPoints: DecisionSplitPoint[] = []
  
  for (const split of DECISION_SPLIT_POINTS) {
    // topK 내에서 해당 attribute의 분산 확인
    const values = topK.map(j => {
      const val = j.attributes[split.attribute]
      return typeof val === 'number' ? val : 50
    })
    
    const variance = calculateVariance(values)
    
    // 분산이 크면 (속성값이 다양하면) 이 분기점이 중요
    if (variance > 200) {  // threshold
      splitPoints.push(split)
    }
  }
  
  return splitPoints
}

// ============================================
// 미확인 제약 찾기
// ============================================
function findUncheckedConstraints(
  facts: Array<{ fact_key: string }>
): UnconfirmedConstraint[] {
  const existingKeys = new Set(facts.map(f => f.fact_key))
  
  return UNCONFIRMED_CONSTRAINTS.filter(constraint => {
    // 해당 제약이 아직 확인되지 않았으면 반환
    return !existingKeys.has(constraint.constraint_key)
  })
}

// ============================================
// 메인 함수: generatePurposeBasedFollowups
// ============================================
export interface PurposeBasedFollowupInput {
  candidates: ScoredJob[]
  topK: ScoredJob[]
  facts: Array<{ fact_key: string; value_json: string }>
  maxQuestions?: number
}

export function generatePurposeBasedFollowups(
  input: PurposeBasedFollowupInput
): FollowupQuestionV3[] {
  const { candidates, topK, facts, maxQuestions = 3 } = input
  const questions: FollowupQuestionV3[] = []
  const usedTypes = new Set<FollowupPurpose>()
  
  // 1. contradiction_resolver: 모순 해결형
  const contradictions = detectContradictions(facts)
  if (contradictions.length > 0 && !usedTypes.has('contradiction_resolver')) {
    const c = contradictions[0]
    questions.push({
      id: `contradiction_${Date.now()}`,
      type: 'contradiction_resolver',
      why_asked: c.pattern.conflict_reason,
      affected_dimensions: c.pattern.affected_dimensions,
      question: c.pattern.resolution_question,
      fact_key: 'resolution.contradiction',
      uncertainty_reduction: 0.8,
    })
    usedTypes.add('contradiction_resolver')
  }
  
  // 2. decision_variable: 결정변수 확인형
  const splitPoints = findDecisionSplitPoints(candidates, topK)
  if (splitPoints.length > 0 && !usedTypes.has('decision_variable')) {
    const sp = splitPoints[0]
    questions.push({
      id: `decision_${sp.attribute}_${Date.now()}`,
      type: 'decision_variable',
      why_asked: sp.why_asked,
      affected_dimensions: [sp.attribute],
      question: sp.question,
      fact_key: `decision.${sp.attribute}`,
      split_impact: {
        option_a: [sp.high_group_label],
        option_b: [sp.low_group_label],
      },
      uncertainty_reduction: 0.7,
    })
    usedTypes.add('decision_variable')
  }
  
  // 3. reality_constraint: 현실 제약 확인형
  const factKeys = facts.map(f => ({ fact_key: f.fact_key }))
  const uncheckedConstraints = findUncheckedConstraints(factKeys)
  if (uncheckedConstraints.length > 0 && !usedTypes.has('reality_constraint')) {
    const uc = uncheckedConstraints[0]
    questions.push({
      id: `constraint_${uc.constraint_key.replace(/\./g, '_')}_${Date.now()}`,
      type: 'reality_constraint',
      why_asked: uc.why_asked,
      affected_dimensions: uc.affected_dimensions,
      question: uc.question,
      fact_key: uc.constraint_key,
      uncertainty_reduction: 0.9,
    })
    usedTypes.add('reality_constraint')
  }
  
  // 질문이 부족하면 추가 decision_variable 생성
  if (questions.length < maxQuestions && splitPoints.length > 1) {
    for (let i = 1; i < splitPoints.length && questions.length < maxQuestions; i++) {
      const sp = splitPoints[i]
      // 이미 같은 속성에 대한 질문이 있으면 스킵
      if (questions.some(q => q.affected_dimensions.includes(sp.attribute))) continue
      
      questions.push({
        id: `decision_${sp.attribute}_${Date.now()}_${i}`,
        type: 'decision_variable',
        why_asked: sp.why_asked,
        affected_dimensions: [sp.attribute],
        question: sp.question,
        fact_key: `decision.${sp.attribute}`,
        uncertainty_reduction: 0.6,
      })
    }
  }
  
  // 정렬: uncertainty_reduction 높은 순
  questions.sort((a, b) => (b.uncertainty_reduction || 0) - (a.uncertainty_reduction || 0))
  
  return questions.slice(0, maxQuestions)
}

