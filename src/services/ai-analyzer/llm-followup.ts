// src/services/ai-analyzer/llm-followup.ts
// ============================================
// LLM 기반 팔로업 질문 생성 (OpenAI GPT-4o-mini)
// ============================================
// P0-7: LLM은 question만 수정, JSON 출력 강제
// P0-9: Step4 진입 시 preScore(K=10) 후 followup 생성
// P0.5: identity_anchor 최소 1개 수집 정책

import type { Ai } from '@cloudflare/workers-types'
import type { CareerState, TransitionSignal } from './career-tree-types'
import { IDENTITY_ANCHOR_PATTERNS } from './career-tree-types'
import { generatePurposeBasedFollowups } from './question-generation'
import type { ScoredJob, FollowupQuestionV3 } from './types'
import { callOpenAI, OPENAI_MODEL, type OpenAIMessage } from './openai-client'

// ============================================
// Types
// ============================================
export interface LLMFollowupInput {
  facts: Array<{ fact_key: string; value_json: string }>
  career_state: CareerState
  transition_signal?: TransitionSignal
  top_candidates: ScoredJob[] // P0-9: preScore(K=10) 결과
  user_context?: string // 이력서 요약 등
}

export interface LLMFollowupConfig {
  model: string
  max_questions: number
  temperature: number
}

// ============================================
// Constants
// ============================================
const DEFAULT_CONFIG: LLMFollowupConfig = {
  model: OPENAI_MODEL,  // GPT-4o-mini
  max_questions: 3,
  temperature: 0.7,
}

// P0-7: LLM은 question만 수정, JSON 출력 강제
const SYSTEM_PROMPT_QUESTION_ENHANCEMENT = `당신은 커리어 상담사입니다. 질문 문장만 다듬어주세요.

규칙:
1. 질문은 따뜻하고 공감적인 톤으로 작성
2. 판단하지 않는 중립적인 표현 사용
3. 구체적인 상황이나 감정을 묻는 질문 선호
4. 한국어로 자연스럽게 작성
5. 반드시 JSON 형식으로만 출력: {"question": "..."}
6. question 외에 다른 필드 절대 추가 금지

목적별 가이드:
- contradiction_resolver: "~라고 하셨는데, ~도 중요하시다고 하셨어요. 둘 중 정말 포기할 수 없는 건 어느 쪽인가요?"
- decision_variable: "이 답변에 따라 추천이 크게 달라져요. 솔직하게 ~에 대해 어떻게 생각하세요?"
- reality_constraint: "현실적으로 ~가 가능한지 확인하고 싶어요. ~에 대해 솔직히 말씀해주실 수 있나요?"
- identity_anchor: "당신에게 정말 중요한 것이 뭔지 알고 싶어요. 솔직하게 ~에 대해 생각해보시겠어요?"

출력 형식 (이것만!):
{"question": "다듬어진 질문 문장"}`

// ============================================
// Helper Functions
// ============================================

// P0-7: JSON 파싱 + 안전한 추출
function extractQuestionFromResponse(response: any): string | null {
  try {
    const text = response?.response || response?.generated_text || ''
    // JSON 추출 시도
    const jsonMatch = text.match(/\{[\s\S]*"question"[\s\S]*\}/)
    if (jsonMatch) {
      const parsed = JSON.parse(jsonMatch[0])
      if (parsed.question && typeof parsed.question === 'string') {
        return parsed.question
      }
    }
  } catch (e) {
  }
  return null // fallback: rule-based 원문 사용
}

function buildQuestionEnhancementPrompt(question: FollowupQuestionV3, input: LLMFollowupInput): string {
  const careerState = input.career_state
  const transitionSignal = input.transition_signal

  return `
사용자 상태:
- 역할: ${careerState.role_identity}
- 연차: ${careerState.career_stage_years}
- 전환상태: ${careerState.transition_status}
- 숙련도: ${careerState.skill_level}
${transitionSignal ? `- 동기: ${transitionSignal.motivation.primary}` : ''}
${transitionSignal?.blockers?.length ? `- 걱정: ${transitionSignal.blockers.map((b) => b.type).join(', ')}` : ''}

질문 목적: ${question.type}
원래 질문: ${question.question}
${question.why_asked ? `이 질문이 필요한 이유: ${question.why_asked}` : ''}

위 맥락을 고려해서 더 자연스럽고 공감적인 질문으로 다시 작성해주세요.
질문만 출력하세요.`
}

// ============================================
// Main Function
// ============================================

/**
 * P0.5 정책: identity_anchor 최소 1개 수집 원칙
 *
 * "identity_anchor는 분석 1회당 최소 1개는 반드시 수집한다"
 *
 * 이유:
 * 1. 이 질문이 '이 서비스가 다른 추천기와 다른 이유'
 * 2. 이 fact들이 쌓이면:
 *    - "성장형 인간들의 커리어트리"
 *    - "워라밸 앵커를 가진 mid-career의 분기점"
 *    같은 진짜 보물 데이터가 됨
 */
export async function generateLLMFollowups(
  ai: Ai | null,
  input: LLMFollowupInput,
  config: LLMFollowupConfig = DEFAULT_CONFIG,
  openaiApiKey?: string  // OpenAI API 키 추가
): Promise<FollowupQuestionV3[]> {
  // 1. Rule-based로 질문 유형/목적 결정 (기존 3종)
  const ruleBasedQuestions = generatePurposeBasedFollowups({
    candidates: input.top_candidates || [],
    topK: input.top_candidates?.slice(0, 10) || [],
    facts: input.facts,
    maxQuestions: config.max_questions - 1, // identity_anchor용 1개 확보!
  })

  // 2. P0.5 정책: identity_anchor 최소 1개 "반드시" 추가
  const askedFactKeys = new Set(input.facts.map((f) => f.fact_key))
  const unaskedAnchor = IDENTITY_ANCHOR_PATTERNS.find((p) => !askedFactKeys.has(p.fact_key))

  // 안 물어본 anchor가 있으면 반드시 추가 (최우선)
  if (unaskedAnchor) {
    ruleBasedQuestions.push({
      id: unaskedAnchor.id,
      type: 'identity_anchor',
      question: unaskedAnchor.question,
      why_asked: unaskedAnchor.why_asked,
      affected_dimensions: unaskedAnchor.affected_dimensions,
      options: unaskedAnchor.options,
      fact_key: unaskedAnchor.fact_key,
      uncertainty_reduction: 0.85, // 높은 중요도
    } as FollowupQuestionV3)
  }

  if (ruleBasedQuestions.length === 0) {
    return []
  }

  // 3. OpenAI API 키가 없으면 rule-based 그대로 반환
  if (!openaiApiKey) {
    return ruleBasedQuestions.slice(0, config.max_questions)
  }


  // 4. OpenAI로 질문 문장 재구성
  const enhancedQuestions = await Promise.all(
    ruleBasedQuestions.map(async (q) => {
      const prompt = buildQuestionEnhancementPrompt(q, input)

      try {
        const messages: OpenAIMessage[] = [
          { role: 'system', content: SYSTEM_PROMPT_QUESTION_ENHANCEMENT },
          { role: 'user', content: prompt },
        ]
        
        const { response: text } = await callOpenAI(openaiApiKey, messages, {
          model: config.model,
          temperature: config.temperature,
          max_tokens: 200,
        })

        const enhancedText = extractQuestionFromResponse({ response: text })

        return {
          ...q,
          question: enhancedText || q.question, // fallback to rule-based
        }
      } catch (error) {
        return q // fallback to rule-based
      }
    })
  )

  return enhancedQuestions.slice(0, config.max_questions)
}

// ============================================
// preScore 함수 (Step4용 간이 스코어링)
// ============================================
// P0-9: Step4 진입 직전에 경량 pre-score를 돌려서 top_candidates(K=10) 생성
// 이건 "최종 결과 생성"이 아니라 "질문을 고르는 힌트" 용도

export interface PreScoreInput {
  facts: Array<{ fact_key: string; value_json: string }>
  career_state: CareerState
  candidates: ScoredJob[]
}

export async function preScoreForFollowup(
  input: PreScoreInput,
  topK: number = 10
): Promise<ScoredJob[]> {
  // 간단한 스코어링: 기존 점수에 facts 기반 가중치 적용
  // 실제로는 fact-score-mapping.ts의 calculateFactBoosts 사용 가능

  const scoredCandidates = input.candidates.map((job) => {
    let adjustedScore = job.final_score || 0

    // Career state 기반 간단한 조정
    if (input.career_state.transition_status === 'changer') {
      // 전환자는 entry-level 직업 선호
      if (job.entry_level_friendly) {
        adjustedScore += 5
      }
    }

    if (input.career_state.skill_level <= 1) {
      // 초급자는 학습 기회 많은 직업 선호
      adjustedScore += 2
    }

    return {
      ...job,
      final_score: adjustedScore,
    }
  })

  // 상위 K개 반환
  return scoredCandidates.sort((a, b) => (b.final_score || 0) - (a.final_score || 0)).slice(0, topK)
}
