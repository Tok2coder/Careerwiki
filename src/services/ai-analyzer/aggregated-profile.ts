// src/services/ai-analyzer/aggregated-profile.ts
// ============================================
// AggregatedProfile: 단일 누적 데이터 구조
// ============================================
// 핵심 원칙: 이 파일의 aggregated_profile_json은 "Derived Cache"
// Source-of-truth는 Draft 조각들(step1/2_answers_json)
// 언제든 buildAggregatedProfile(draft)로 재생성 가능
// 
// [3단계 구조]
// Step 1: 프로필 (5축 상태 + 통합 질문: 관심/가치/강점/회피)
// Step 2: 심층 질문 (LLM Follow-up)
// Step 3: 결과 (추천 리포트)
// ============================================

import type { MiniModuleResult } from './mini-module-questions'
import type { NarrativeFacts, RoundAnswer } from './types'
import type { CareerState, TransitionSignal } from './career-tree-types'

// ============================================
// Types
// ============================================

// 정규화 키 형식
export type EvidenceSourceKey = 
  | `step2.${string}`           // 예: "step2.high_alive", "step2.lost_moment"
  | `round${1|2|3}.q${number}`  // 예: "round1.q1", "round2.q3"
  | `universal.${string}`       // 예: "universal.priority"
  | `transition.${string}`      // 예: "transition.intent"
  | `anchor.${string}`          // 예: "anchor.interest_top"

// 신뢰도 포함 메모리 항목
export interface MemoryItem {
  text: string
  confidence: number      // 0.0 ~ 1.0
  evidenceKey?: string    // 정규화 키
}

// 감정 강도 트리거
export interface EmotionalTrigger {
  trigger: string         // "결정권이 줄어들 때"
  emotions: string[]      // ["불안", "답답함"]
  intensity: 1|2|3|4|5    // 감정 강도
  evidenceKey: string
}

// 누적 메모리 구조
export interface ProfileMemory {
  stable_drivers: MemoryItem[]
  recurring_fears: MemoryItem[]
  decision_rules: MemoryItem[]
  contradictions: MemoryItem[]
  open_loops: Array<{ text: string; priority: number; evidenceKey?: string }>
  resolved_loops: string[]
  emotional_triggers: EmotionalTrigger[]
}

// 증거 인덱스 항목
export interface EvidenceEntry {
  source: EvidenceSourceKey | string  // 정규화 키
  excerpt: string                      // 최대 200자
}

// AggregatedProfile 전체 타입
export interface AggregatedProfile {
  // 메타 (캐시 버전 관리)
  profile_version: number           // draft 업데이트 시마다 +1
  generated_at: string              // 재생성 시점
  
  // 1) 정량 앵커
  anchors: {
    interest_top: string[]
    value_top: string[]
    strength_top: string[]
    constraint_flags: string[]
    low_confidence_flags?: string[]
    internal_conflict_flags?: string[]
    // Q8-Q15 추가 (2026-01-28)
    sacrifice_flags?: string[]           // Q8. 포기 가능성
    energy_drain_flags?: string[]        // Q9. 에너지 소모원
    achievement_feedback_top?: string[]  // Q10. 성취 피드백
    execution_style?: string             // Q11. 실행 속도
    impact_scope?: string                // Q12. 영향 범위
    failure_response?: string            // Q13. 실패 반응
    persistence_anchor?: string          // Q14. 버팀 앵커
    external_expectation?: string        // Q15. 타인 기대 반응
  }
  
  // 2) 사용자 자기진술(정성)
  narrative: {
    life_story?: string
    high_alive?: string
    lost_moment?: string
    career_background?: string  // 전공/이전 직업 (구조화 입력)
  }
  
  // 3) 단계별 선택형 요약
  universals: {
    priority?: string
    interests?: string[]
    dislikes?: string[]
    strengths?: string[]
    workstyle_social?: string
    energy?: string
    language?: string[]
    special_experience?: string[]
    hidden_skill?: string
  }
  
  transition: {
    intent?: string
    timeline?: string
    reasons?: string[]
    industries?: string[]
    role_change?: string
    priorities?: string[]
  }
  
  // 4) 라운드 누적 (원문 유지 + 태그)
  rounds: Array<{
    round: 1|2|3
    questions: Array<{ id: string; text: string; purposeTag: string }>
    answers: Array<{ question_id: string; answer: string }>
  }>
  
  // 5) 누적 메모리 (신뢰도 포함!)
  memory: ProfileMemory
  
  // 6) 증거 인덱스 (정규화 키!)
  evidence_index: {
    [key: string]: EvidenceEntry
  }
}

// Draft 데이터 구조 (DB에서 가져온 원본)
export interface DraftData {
  id: number
  user_id: number
  session_id: string
  analysis_type: 'job' | 'major'
  current_step: number
  career_state_json: string | null
  step1_answers_json: string | null
  step2_answers_json: string | null
  step3_answers_json: string | null
  step4_answers_json: string | null
  mini_module_result_json?: string | null
  aggregated_profile_json?: string | null
  memory_json?: string | null
  profile_version?: number
  created_at: string
  updated_at: string
}

// Gate 검증 결과
export interface GateResult {
  passed: boolean
  missing: string[]
  fallback_questions?: FallbackQuestion[]
}

// 폴백 질문 구조
export interface FallbackQuestion {
  id: string
  questionText: string
  target_field: string
  minLengthGuidance: number
}

// ============================================
// Step 1 제약조건 → 미니모듈 토큰 변환
// ============================================
// Step 1의 constraints 객체에서 has_constraint=true인 항목을
// 미니모듈 constraint_flags 토큰으로 변환
const STEP1_TO_MINIMODULE_CONSTRAINT_MAP: Record<string, string> = {
  'time': 'time_constraint',           // 시간 제약
  'money': 'income_constraint',        // 경제적 제약
  'location': 'location_constraint',   // 장소 제약
  'family': 'time_constraint',         // 가족 상황 → 시간 제약으로 매핑
  'health': 'physical_constraint',     // 건강/컨디션 제약
  'qualification': 'qualification_constraint', // 자격/학력 제약
}

interface ConstraintItem {
  has_constraint?: boolean
  details?: string[]
}

function extractConstraintFlagsFromCareerState(
  constraints: Record<string, ConstraintItem>
): string[] {
  const flags: string[] = []
  
  for (const [type, constraint] of Object.entries(constraints)) {
    if (constraint?.has_constraint) {
      const mappedToken = STEP1_TO_MINIMODULE_CONSTRAINT_MAP[type]
      if (mappedToken && !flags.includes(mappedToken)) {
        flags.push(mappedToken)
      }
    }
  }
  
  return flags
}

// ============================================
// 빈 프로필 생성
// ============================================
export function createEmptyProfile(version: number = 0): AggregatedProfile {
  return {
    profile_version: version,
    generated_at: new Date().toISOString(),
    anchors: {
      interest_top: [],
      value_top: [],
      strength_top: [],
      constraint_flags: [],
    },
    narrative: {},
    universals: {},
    transition: {},
    rounds: [],
    memory: {
      stable_drivers: [],
      recurring_fears: [],
      decision_rules: [],
      contradictions: [],
      open_loops: [],
      resolved_loops: [],
      emotional_triggers: [],
    },
    evidence_index: {},
  }
}

// ============================================
// buildAggregatedProfile: Draft 조각에서 프로필 재생성
// ============================================
export function buildAggregatedProfile(
  draft: DraftData,
  existingMemory?: ProfileMemory
): AggregatedProfile {
  const newVersion = (draft.profile_version || 0) + 1
  const profile = createEmptyProfile(newVersion)
  
  // 1) 미니모듈 결과 → anchors
  if (draft.mini_module_result_json) {
    try {
      const mm: MiniModuleResult = JSON.parse(draft.mini_module_result_json)
      profile.anchors = {
        interest_top: mm.interest_top || [],
        value_top: mm.value_top || [],
        strength_top: mm.strength_top || [],
        constraint_flags: mm.constraint_flags || [],
        low_confidence_flags: mm.low_confidence_flags,
        internal_conflict_flags: mm.internal_conflict_flags,
        // Q8-Q15 추가
        sacrifice_flags: mm.sacrifice_flags,
        energy_drain_flags: mm.energy_drain_flags,
        achievement_feedback_top: mm.achievement_feedback_top,
        execution_style: mm.execution_style,
        impact_scope: mm.impact_scope,
        failure_response: mm.failure_response,
        persistence_anchor: mm.persistence_anchor,
        external_expectation: mm.external_expectation,
      }
      
      // evidence 추가
      if (mm.interest_top?.length) {
        profile.evidence_index['anchor.interest_top'] = {
          source: 'anchor.interest_top',
          excerpt: `흥미 Top: ${mm.interest_top.join(', ')}`.substring(0, 200),
        }
      }
      if (mm.value_top?.length) {
        profile.evidence_index['anchor.value_top'] = {
          source: 'anchor.value_top',
          excerpt: `가치 Top: ${mm.value_top.join(', ')}`.substring(0, 200),
        }
      }
      // Q8-Q9 evidence (Hard Bias)
      if (mm.sacrifice_flags?.length) {
        profile.evidence_index['anchor.sacrifice_flags'] = {
          source: 'anchor.sacrifice_flags',
          excerpt: `포기 가능: ${mm.sacrifice_flags.join(', ')}`.substring(0, 200),
        }
      }
      if (mm.energy_drain_flags?.length) {
        profile.evidence_index['anchor.energy_drain_flags'] = {
          source: 'anchor.energy_drain_flags',
          excerpt: `에너지 소모: ${mm.energy_drain_flags.join(', ')}`.substring(0, 200),
        }
      }
    } catch (e) {
      console.error('[buildAggregatedProfile] mini_module_result parse error:', e)
    }
  }
  
  // 2) Step1 (Career State) → career_state + constraints 병합
  if (draft.career_state_json) {
    try {
      const cs: CareerState = JSON.parse(draft.career_state_json)
      
      // Step 1의 제약조건을 미니모듈 토큰으로 변환하여 병합
      if (cs.constraints) {
        const step1ConstraintFlags = extractConstraintFlagsFromCareerState(cs.constraints)
        
        // 기존 constraint_flags와 병합 (중복 제거)
        const existingFlags = new Set(profile.anchors.constraint_flags)
        step1ConstraintFlags.forEach(flag => existingFlags.add(flag))
        profile.anchors.constraint_flags = Array.from(existingFlags)
        
        // evidence 추가
        if (step1ConstraintFlags.length > 0) {
          profile.evidence_index['step1.constraints'] = {
            source: 'step1.constraints',
            excerpt: `상태 단계 제약: ${step1ConstraintFlags.join(', ')}`.substring(0, 200),
          }
        }
      }
    } catch (e) {
      console.error('[buildAggregatedProfile] career_state parse error:', e)
    }
  }
  
  // 3) Step1/Step2 (통합 질문) → universals + narrative
  // 3단계 구조에서는 통합 질문이 Step 1에 포함되어 step2_answers_json에 저장됨
  if (draft.step2_answers_json) {
    try {
      const step2 = JSON.parse(draft.step2_answers_json)
      
      // universals (통합 질문 데이터 + anchors fallback)
      // 3단계 구조: 통합 질문에서 관심/가치/강점/회피를 한 번에 수집
      profile.universals = {
        // 가치: 배열이면 첫 번째, 문자열이면 그대로
        priority: Array.isArray(step2.univ_priority) 
          ? step2.univ_priority[0] 
          : (step2.univ_priority || profile.anchors.value_top?.[0] || undefined),
        // 관심사: 통합 질문 결과 또는 anchors fallback
        interests: step2.univ_interest?.length > 0 
          ? step2.univ_interest 
          : (profile.anchors.interest_top?.length > 0 ? profile.anchors.interest_top : undefined),
        // 회피 항목
        dislikes: step2.univ_dislike,
        // 강점: 통합 질문 결과 또는 anchors fallback
        strengths: step2.univ_strength?.length > 0 
          ? step2.univ_strength 
          : (profile.anchors.strength_top?.length > 0 ? profile.anchors.strength_top : undefined),
        workstyle_social: step2.univ_workstyle_social,
        energy: step2.univ_energy,
        language: step2.univ_language,
        special_experience: step2.univ_special_experience,
        hidden_skill: step2.univ_hidden_skill,
      }
      
      // ============================================
      // Q8-Q15 답변을 anchors에 병합 (step2_answers에서 수집)
      // 프론트엔드에서 mm_sacrifice, mm_energy_drain 등으로 저장됨
      // ============================================
      if (step2.mm_sacrifice?.length) {
        profile.anchors.sacrifice_flags = step2.mm_sacrifice
      }
      if (step2.mm_energy_drain?.length) {
        profile.anchors.energy_drain_flags = step2.mm_energy_drain
      }
      if (step2.mm_achievement?.length) {
        profile.anchors.achievement_feedback_top = step2.mm_achievement
      }
      if (step2.mm_execution) {
        profile.anchors.execution_style = step2.mm_execution
      }
      if (step2.mm_impact) {
        profile.anchors.impact_scope = step2.mm_impact
      }
      if (step2.mm_failure) {
        profile.anchors.failure_response = step2.mm_failure
      }
      if (step2.mm_anchor) {
        profile.anchors.persistence_anchor = step2.mm_anchor
      }
      if (step2.mm_expectation) {
        profile.anchors.external_expectation = step2.mm_expectation
      }
      
      // evidence 추가
      if (profile.universals.priority) {
        profile.evidence_index['universal.priority'] = {
          source: 'universal.priority',
          excerpt: `우선순위: ${profile.universals.priority}`.substring(0, 200),
        }
      }
      
      // narrative facts (step2에 저장된 경우)
      if (step2.narrative_facts) {
        profile.narrative = {
          life_story: step2.narrative_facts.life_story || step2.narrative_facts.storyAnswer,
          high_alive: step2.narrative_facts.highAliveMoment,
          lost_moment: step2.narrative_facts.lostMoment,
          career_background: step2.narrative_facts.career_background,
        }
        
        // evidence 추가
        if (profile.narrative.high_alive) {
          profile.evidence_index['step2.high_alive'] = {
            source: 'step2.high_alive',
            excerpt: profile.narrative.high_alive.substring(0, 200),
          }
        }
        if (profile.narrative.lost_moment) {
          profile.evidence_index['step2.lost_moment'] = {
            source: 'step2.lost_moment',
            excerpt: profile.narrative.lost_moment.substring(0, 200),
          }
        }
        if (profile.narrative.life_story) {
          profile.evidence_index['step2.life_story'] = {
            source: 'step2.life_story',
            excerpt: profile.narrative.life_story.substring(0, 200),
          }
        }
        if (profile.narrative.career_background) {
          profile.evidence_index['step2.career_background'] = {
            source: 'step2.career_background',
            excerpt: profile.narrative.career_background.substring(0, 200),
          }
        }
      }
    } catch (e) {
      console.error('[buildAggregatedProfile] step2 parse error:', e)
    }
  }
  
  // 4) Step3 (Transition Signal) → transition
  // [3단계 구조] 전이 신호는 Step 1의 5축에 통합됨. 레거시 데이터 호환용으로 유지
  if (draft.step3_answers_json) {
    try {
      const step3: TransitionSignal = JSON.parse(draft.step3_answers_json)
      profile.transition = {
        intent: step3.trans_intent,
        timeline: step3.trans_timeline,
        reasons: step3.trans_reason,
        industries: step3.trans_industry,
        role_change: step3.trans_role_change,
        priorities: step3.trans_priority,
      }
      
      // evidence 추가
      if (step3.trans_intent) {
        profile.evidence_index['transition.intent'] = {
          source: 'transition.intent',
          excerpt: `이직 의향: ${step3.trans_intent}`.substring(0, 200),
        }
      }
    } catch (e) {
      console.error('[buildAggregatedProfile] step3 parse error:', e)
    }
  }
  
  // 5) Step4 (Round Questions/Answers) → rounds + narrative
  if (draft.step4_answers_json) {
    try {
      const step4 = JSON.parse(draft.step4_answers_json)
      
      // narrative facts (step4에 저장된 경우도 처리)
      if (step4.narrative_facts && !profile.narrative.high_alive) {
        profile.narrative = {
          life_story: step4.narrative_facts.life_story || step4.narrative_facts.storyAnswer || profile.narrative.life_story,
          high_alive: step4.narrative_facts.highAliveMoment || profile.narrative.high_alive,
          lost_moment: step4.narrative_facts.lostMoment || profile.narrative.lost_moment,
          career_background: step4.narrative_facts.career_background || profile.narrative.career_background,
        }
        
        // evidence 추가
        if (profile.narrative.high_alive && !profile.evidence_index['step2.high_alive']) {
          profile.evidence_index['step2.high_alive'] = {
            source: 'step2.high_alive',
            excerpt: profile.narrative.high_alive.substring(0, 200),
          }
        }
        if (profile.narrative.career_background && !profile.evidence_index['step2.career_background']) {
          profile.evidence_index['step2.career_background'] = {
            source: 'step2.career_background',
            excerpt: profile.narrative.career_background.substring(0, 200),
          }
        }
      }
      
      // round questions & answers
      if (step4.round_questions) {
        for (const rq of step4.round_questions) {
          const roundNum = rq.round || rq.roundNumber
          if (!roundNum) continue
          
          let roundEntry = profile.rounds.find(r => r.round === roundNum)
          if (!roundEntry) {
            roundEntry = { round: roundNum, questions: [], answers: [] }
            profile.rounds.push(roundEntry)
          }
          
          if (rq.questions) {
            for (const q of rq.questions) {
              roundEntry.questions.push({
                id: q.id,
                text: q.questionText || q.text,
                purposeTag: q.purposeTag || 'ENGINE',
              })
            }
          }
        }
      }
      
      if (step4.round_answers) {
        for (const ra of step4.round_answers) {
          const roundNum = ra.roundNumber || ra.round_number
          if (!roundNum) continue
          
          let roundEntry = profile.rounds.find(r => r.round === roundNum)
          if (!roundEntry) {
            roundEntry = { round: roundNum, questions: [], answers: [] }
            profile.rounds.push(roundEntry)
          }
          
          roundEntry.answers.push({
            question_id: ra.questionId || ra.question_id,
            answer: ra.answer,
          })
          
          // evidence 추가
          const qIndex = roundEntry.answers.length
          const evidenceKey = `round${roundNum}.q${qIndex}` as EvidenceSourceKey
          profile.evidence_index[evidenceKey] = {
            source: evidenceKey,
            excerpt: ra.answer.substring(0, 200),
          }
        }
      }
    } catch (e) {
      console.error('[buildAggregatedProfile] step4 parse error:', e)
    }
  }
  
  // 6) 기존 메모리 유지 (있으면)
  if (existingMemory) {
    profile.memory = existingMemory
  } else if (draft.memory_json) {
    try {
      profile.memory = JSON.parse(draft.memory_json)
    } catch (e) {
      console.error('[buildAggregatedProfile] memory parse error:', e)
    }
  }
  
  // 정렬: rounds를 round 번호 순으로
  profile.rounds.sort((a, b) => a.round - b.round)
  
  return profile
}

// ============================================
// LLM Gate: 호출 전 데이터 준비 검증
// ============================================
export type GatePhase = 'round1' | 'round2' | 'round3' | 'analyze'

const FALLBACK_QUESTIONS_MAP: Record<string, FallbackQuestion> = {
  'narrative.high_alive': {
    id: 'fix_high_alive',
    questionText: "최근 1년 안에 '내가 잘 살고 있다'고 느낀 순간이 있었다면, 어떤 상황이었나요?",
    target_field: 'narrative.high_alive',
    minLengthGuidance: 50,
  },
  'narrative.lost_moment': {
    id: 'fix_lost_moment',
    questionText: '현재 위치에서 아쉬운 점이나 부족하다고 느끼는 부분이 있다면 무엇인가요?',
    target_field: 'narrative.lost_moment',
    minLengthGuidance: 50,
  },
  'narrative.life_story': {
    id: 'fix_life_story',
    questionText: '간략하게 지금까지의 커리어 이야기를 들려주세요.',
    target_field: 'narrative.life_story',
    minLengthGuidance: 100,
  },
  'anchors.interest_top': {
    id: 'fix_interest',
    questionText: '어떤 일을 할 때 시간 가는 줄 모르고 몰입하시나요? (예: 문제 해결, 창작, 분석 등)',
    target_field: 'anchors.interest_top',
    minLengthGuidance: 30,
  },
  'anchors.value_top': {
    id: 'fix_value',
    questionText: '일할 때 가장 중요하게 여기는 가치는 무엇인가요? (예: 자율, 성장, 안정 등)',
    target_field: 'anchors.value_top',
    minLengthGuidance: 30,
  },
  'anchors.strength_top': {
    id: 'fix_strength',
    questionText: '주변에서 인정받는 당신의 강점은 무엇인가요? (예: 분석력, 소통력, 실행력 등)',
    target_field: 'anchors.strength_top',
    minLengthGuidance: 30,
  },
  'anchors.constraint_flags': {
    id: 'fix_constraint',
    questionText: '커리어 선택에서 반드시 피하고 싶은 제약이 있나요? (예: 야근, 출장, 특정 환경 등)',
    target_field: 'anchors.constraint_flags',
    minLengthGuidance: 30,
  },
  'rounds.round1_answers': {
    id: 'fix_round1_answers',
    questionText: '앞서 드린 질문에 조금 더 자세히 답해주시면 더 정확한 추천이 가능합니다.',
    target_field: 'rounds.round1_answers',
    minLengthGuidance: 50,
  },
}

export function assertReadyForLLM(
  profile: AggregatedProfile,
  phase: GatePhase
): GateResult {
  const missing: string[] = []
  
  switch (phase) {
    case 'round1':
      // anchors 최소 1개 + narrative 최소 1개
      const hasAnchor = 
        profile.anchors.interest_top.length > 0 ||
        profile.anchors.value_top.length > 0 ||
        profile.anchors.strength_top.length > 0
      
      const hasNarrative =
        !!profile.narrative.life_story ||
        !!profile.narrative.high_alive ||
        !!profile.narrative.lost_moment
      
      if (!hasAnchor) {
        missing.push('anchors.interest_top')
        missing.push('anchors.value_top')
      }
      if (!hasNarrative) {
        missing.push('narrative.high_alive')
      }
      break
      
    case 'round2':
      // Round 1 answers 최소 2개
      const round1 = profile.rounds.find(r => r.round === 1)
      if (!round1 || round1.answers.length < 2) {
        missing.push('rounds.round1_answers')
      }
      break
      
    case 'round3':
      // constraint_flags 최소 1개 또는 Step1 constraints 존재
      if (profile.anchors.constraint_flags.length === 0) {
        missing.push('anchors.constraint_flags')
      }
      break
      
    case 'analyze':
      // anchors 완비 + narrative 2개 + round answers 6개 이상
      if (profile.anchors.interest_top.length === 0) {
        missing.push('anchors.interest_top')
      }
      if (profile.anchors.value_top.length === 0) {
        missing.push('anchors.value_top')
      }
      if (profile.anchors.strength_top.length === 0) {
        missing.push('anchors.strength_top')
      }
      
      const narrativeCount = [
        profile.narrative.life_story,
        profile.narrative.high_alive,
        profile.narrative.lost_moment,
      ].filter(Boolean).length
      
      if (narrativeCount < 2) {
        if (!profile.narrative.high_alive) missing.push('narrative.high_alive')
        if (!profile.narrative.lost_moment) missing.push('narrative.lost_moment')
      }
      
      const totalAnswers = profile.rounds.reduce(
        (sum, r) => sum + r.answers.length,
        0
      )
      if (totalAnswers < 6) {
        missing.push('rounds.round1_answers')
      }
      break
  }
  
  if (missing.length === 0) {
    return { passed: true, missing: [] }
  }
  
  // 폴백 질문 생성 (중복 제거)
  const uniqueMissing = [...new Set(missing)]
  const fallback_questions = uniqueMissing
    .map(field => FALLBACK_QUESTIONS_MAP[field])
    .filter(Boolean)
  
  return {
    passed: false,
    missing: uniqueMissing,
    fallback_questions,
  }
}

// ============================================
// NEXT_TARGETS 우선순위 큐 생성
// ============================================
export interface NextTarget {
  text: string
  type: 'contradiction' | 'fear' | 'decision_rule' | 'low_confidence' | 'open_loop'
  priority: number
  evidenceKey?: string
}

export function buildNextTargets(
  memory: ProfileMemory,
  maxTargets: number = 3
): NextTarget[] {
  const targets: NextTarget[] = []
  
  // 1. contradictions (가치 충돌) - 최우선
  for (const item of memory.contradictions) {
    targets.push({
      text: item.text,
      type: 'contradiction',
      priority: 100 - (item.confidence * 10), // confidence 낮을수록 높은 우선순위
      evidenceKey: item.evidenceKey,
    })
  }
  
  // 2. recurring_fears (반복 두려움) - 다음
  for (const item of memory.recurring_fears) {
    targets.push({
      text: item.text,
      type: 'fear',
      priority: 80 - (item.confidence * 10),
      evidenceKey: item.evidenceKey,
    })
  }
  
  // 3. low confidence items - 확인 필요
  const allItems = [
    ...memory.stable_drivers.map(i => ({ ...i, type: 'low_confidence' as const })),
    ...memory.decision_rules.map(i => ({ ...i, type: 'decision_rule' as const })),
  ]
  
  for (const item of allItems) {
    if (item.confidence < 0.6) {
      targets.push({
        text: `확인 필요: ${item.text}`,
        type: item.type === 'low_confidence' ? 'low_confidence' : 'decision_rule',
        priority: 60 + ((0.6 - item.confidence) * 100), // confidence 낮을수록 높은 우선순위
        evidenceKey: item.evidenceKey,
      })
    }
  }
  
  // 4. open_loops (미해결 질문) - 마지막
  for (const loop of memory.open_loops) {
    // resolved_loops에 있으면 스킵
    if (memory.resolved_loops.includes(loop.text)) continue
    
    targets.push({
      text: loop.text,
      type: 'open_loop',
      priority: loop.priority || 40,
      evidenceKey: loop.evidenceKey,
    })
  }
  
  // 우선순위 내림차순 정렬 후 Top N
  targets.sort((a, b) => b.priority - a.priority)
  
  return targets.slice(0, maxTargets)
}

// ============================================
// 고강도 감정 트리거 추출
// ============================================
export function getHighIntensityTriggers(
  memory: ProfileMemory,
  minIntensity: number = 4
): EmotionalTrigger[] {
  return memory.emotional_triggers.filter(t => t.intensity >= minIntensity)
}
