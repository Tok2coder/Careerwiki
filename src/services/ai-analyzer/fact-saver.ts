// src/services/ai-analyzer/fact-saver.ts
// ============================================
// Fact 저장 유틸리티 - 커리어트리 통계의 핵심
// ============================================
// P0-5: value_text + rank_int 컬럼으로 인덱스 완전 적용
// P0-6: constraints 2단 저장 (has + detail)

import type { D1Database } from '@cloudflare/workers-types'
import type { CareerState, ConstraintType, CareerConstraints } from './career-tree-types'

// ============================================
// Fact 데이터 인터페이스
// ============================================
export interface AnalyzerFact {
  session_id: string
  user_id?: number
  draft_id?: number
  request_id?: number
  fact_key: string
  value_json: string
  value_text: string | null // P0-5: 인덱스용
  rank_int: number | null // P0-5: 인덱스용
  source: 'user_input' | 'resume_parsed' | 'inferred' | 'followup'
  confidence_weight: number
}

// 저장 요청 인터페이스
export interface FactSaveParams {
  session_id: string
  user_id?: number
  draft_id?: number
  request_id?: number
  source?: 'user_input' | 'resume_parsed' | 'inferred' | 'followup'
  confidence_weight?: number
}

// ============================================
// 단일값 저장 (state, motivation 등)
// ============================================
export function createScalarFact(
  params: FactSaveParams & {
    fact_key: string
    value: string | number | boolean
  }
): AnalyzerFact {
  return {
    session_id: params.session_id,
    user_id: params.user_id,
    draft_id: params.draft_id,
    request_id: params.request_id,
    fact_key: params.fact_key,
    value_json: JSON.stringify(params.value),
    value_text: String(params.value), // P0-5: 인덱스용
    rank_int: null,
    source: params.source || 'user_input',
    confidence_weight: params.confidence_weight || 1.0,
  }
}

// ============================================
// P0-6: 2단 제약 저장
// ============================================
export function createConstraintFacts(
  params: FactSaveParams & {
    constraint_type: ConstraintType
    has_constraint: boolean
    detail?: string
  }
): AnalyzerFact[] {
  const facts: AnalyzerFact[] = []

  // 1단: has_constraint (항상 저장 - 통계/필터에 필요)
  facts.push({
    session_id: params.session_id,
    user_id: params.user_id,
    draft_id: params.draft_id,
    request_id: params.request_id,
    fact_key: `state.constraint.${params.constraint_type}`,
    value_json: JSON.stringify(params.has_constraint),
    value_text: params.has_constraint ? 'true' : 'false',
    rank_int: null,
    source: params.source || 'user_input',
    confidence_weight: params.confidence_weight || 1.0,
  })

  // 2단: detail (있을 때만 저장)
  if (params.has_constraint && params.detail) {
    facts.push({
      session_id: params.session_id,
      user_id: params.user_id,
      draft_id: params.draft_id,
      request_id: params.request_id,
      fact_key: `state.constraint.${params.constraint_type}_detail`,
      value_json: JSON.stringify(params.detail),
      value_text: params.detail,
      rank_int: null,
      source: params.source || 'user_input',
      confidence_weight: params.confidence_weight || 1.0,
    })
  }

  return facts
}

// ============================================
// P0-5: 우선순위 포함 배열 저장 (인덱스 완전 적용!)
// ============================================
export function createRankedFacts(
  params: FactSaveParams & {
    fact_key: string // 단수형! 'transition.desired_type'
    values: string[] // 선택 순서 = 우선순위
  }
): AnalyzerFact[] {
  return params.values.map((v, idx) => ({
    session_id: params.session_id,
    user_id: params.user_id,
    draft_id: params.draft_id,
    request_id: params.request_id,
    fact_key: params.fact_key,
    value_json: JSON.stringify({ type: v, rank: idx + 1 }),
    value_text: v, // P0-5: 인덱스용 - JSON 추출 불필요!
    rank_int: idx + 1, // P0-5: 인덱스용 - 1순위 집계 초고속!
    source: params.source || 'user_input',
    confidence_weight: params.confidence_weight || 1.0,
  }))
}

// ============================================
// 다중값 저장 (blockers 등, 순위 없음)
// ============================================
export function createMultiFacts(
  params: FactSaveParams & {
    fact_key: string
    values: string[]
  }
): AnalyzerFact[] {
  return params.values.map((v) => ({
    session_id: params.session_id,
    user_id: params.user_id,
    draft_id: params.draft_id,
    request_id: params.request_id,
    fact_key: params.fact_key,
    value_json: JSON.stringify(v),
    value_text: v,
    rank_int: null, // 순위 없음
    source: params.source || 'user_input',
    confidence_weight: params.confidence_weight || 1.0,
  }))
}

// ============================================
// CareerState → Facts 변환 (P0-2: 2단 저장 반영)
// ============================================
export function careerStateToFacts(
  state: CareerState,
  params: FactSaveParams
): AnalyzerFact[] {
  const facts: AnalyzerFact[] = []

  // 5축 상태 좌표 (단일값)
  facts.push(
    createScalarFact({
      ...params,
      fact_key: 'state.role_identity',
      value: state.role_identity,
    })
  )

  // P0.5: 세분화 탈출구 (있을 때만)
  if (state.role_identity_subtype) {
    facts.push(
      createScalarFact({
        ...params,
        fact_key: 'state.role_identity_subtype',
        value: state.role_identity_subtype,
      })
    )
  }

  facts.push(
    createScalarFact({
      ...params,
      fact_key: 'state.career_stage_years',
      value: state.career_stage_years,
    })
  )

  facts.push(
    createScalarFact({
      ...params,
      fact_key: 'state.transition_status',
      value: state.transition_status,
    })
  )

  facts.push(
    createScalarFact({
      ...params,
      fact_key: 'state.skill_level',
      value: state.skill_level,
    })
  )

  // P0-2: 제약 조건 2단 저장 (has + detail 분리)
  for (const [key, val] of Object.entries(state.constraints)) {
    const constraintFacts = createConstraintFacts({
      ...params,
      constraint_type: key as ConstraintType,
      has_constraint: val.has_constraint,
      detail: val.details,
    })
    facts.push(...constraintFacts)
  }

  return facts
}

// ============================================
// DB 저장 함수 (D1)
// ============================================
export async function saveFactsToDb(
  db: D1Database,
  facts: AnalyzerFact[]
): Promise<{ saved: number; errors: number }> {
  let saved = 0
  let errors = 0

  for (const fact of facts) {
    try {
      await db
        .prepare(
          `
        INSERT INTO analyzer_facts (
          session_id, user_id, draft_id, request_id,
          fact_key, value_json, value_text, rank_int,
          source, confidence_weight
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `
        )
        .bind(
          fact.session_id,
          fact.user_id || null,
          fact.draft_id || null,
          fact.request_id || null,
          fact.fact_key,
          fact.value_json,
          fact.value_text,
          fact.rank_int,
          fact.source,
          fact.confidence_weight
        )
        .run()
      saved++
    } catch (error) {
      errors++
    }
  }

  return { saved, errors }
}

// ============================================
// Step별 Facts 삭제 후 재저장 (중복 방지)
// ============================================
export async function replaceFactsForStep(
  db: D1Database,
  params: {
    session_id: string
    draft_id?: number
    fact_key_prefix: string // 예: 'state.' 또는 'transition.'
  },
  newFacts: AnalyzerFact[]
): Promise<{ deleted: number; saved: number; errors: number }> {
  // 기존 facts 삭제
  const deleteResult = await db
    .prepare(
      `
      DELETE FROM analyzer_facts 
      WHERE session_id = ? 
        AND (draft_id = ? OR (draft_id IS NULL AND ? IS NULL))
        AND fact_key LIKE ?
    `
    )
    .bind(
      params.session_id,
      params.draft_id || null,
      params.draft_id || null,
      `${params.fact_key_prefix}%`
    )
    .run()

  const deleted = deleteResult.meta?.changes || 0

  // 새 facts 저장
  const { saved, errors } = await saveFactsToDb(db, newFacts)

  return { deleted, saved, errors }
}

// ============================================
// Facts 조회 함수
// ============================================
export async function getFactsForSession(
  db: D1Database,
  session_id: string,
  options?: {
    draft_id?: number
    request_id?: number
    fact_key_prefix?: string
  }
): Promise<AnalyzerFact[]> {
  let query = `SELECT * FROM analyzer_facts WHERE session_id = ?`
  const bindings: (string | number | null)[] = [session_id]

  if (options?.draft_id) {
    query += ` AND draft_id = ?`
    bindings.push(options.draft_id)
  }

  if (options?.request_id) {
    query += ` AND request_id = ?`
    bindings.push(options.request_id)
  }

  if (options?.fact_key_prefix) {
    query += ` AND fact_key LIKE ?`
    bindings.push(`${options.fact_key_prefix}%`)
  }

  query += ` ORDER BY created_at ASC`

  const stmt = db.prepare(query)
  const result = await stmt.bind(...bindings).all<AnalyzerFact>()

  return result.results || []
}

// ============================================
// 통계용 집계 함수
// ============================================
export async function getTopFactValues(
  db: D1Database,
  fact_key: string,
  options?: {
    rank_int?: number // 특정 순위만 (예: 1 = 1순위만)
    limit?: number
  }
): Promise<Array<{ value_text: string; count: number }>> {
  let query = `
    SELECT value_text, COUNT(*) as count 
    FROM analyzer_facts 
    WHERE fact_key = ?
  `
  const bindings: (string | number)[] = [fact_key]

  if (options?.rank_int !== undefined) {
    query += ` AND rank_int = ?`
    bindings.push(options.rank_int)
  }

  query += ` GROUP BY value_text ORDER BY count DESC`

  if (options?.limit) {
    query += ` LIMIT ?`
    bindings.push(options.limit)
  }

  const stmt = db.prepare(query)
  const result = await stmt.bind(...bindings).all<{ value_text: string; count: number }>()

  return result.results || []
}

// ============================================
// Hard Dislike 감지 및 저장
// ============================================

// 강한 부정 표현 패턴
const HARD_DISLIKE_PATTERNS = [
  /죽어도/,
  /절대.*싫/,
  /절대.*안.*해/,
  /절대.*못.*해/,
  /정말.*싫/,
  /진짜.*싫/,
  /다시는.*안/,
  /두번.*다시/,
  /아무리.*해도.*못/,
  /도저히.*못/,
  /그건.*안.*돼/,
  /그건.*절대/,
]

// 서술형 텍스트에서 hard_dislike 키워드 추출
export function extractHardDislikesFromText(text: string): string[] {
  const hardDislikes: string[] = []
  
  // 강한 부정 패턴이 있는지 확인
  const hasStrongNegation = HARD_DISLIKE_PATTERNS.some(pattern => pattern.test(text))
  
  if (!hasStrongNegation) return []
  
  // 직업/업무 관련 키워드와 강한 부정이 함께 나타나면 추출
  const jobKeywords = [
    { pattern: /목공|목수|나무/, value: 'woodwork' },
    { pattern: /영업|판매|세일즈/, value: 'sales' },
    { pattern: /야근|초과 근무|밤늦게/, value: 'overtime' },
    { pattern: /발표|프레젠|앞에 서/, value: 'public_speaking' },
    { pattern: /회의|미팅/, value: 'meetings' },
    { pattern: /출장|이동/, value: 'travel' },
    { pattern: /단순.*반복|반복.*작업|루틴/, value: 'routine' },
    { pattern: /갈등|싸움|대립/, value: 'conflict' },
    { pattern: /육체.*노동|힘든 일|몸 쓰는/, value: 'physical' },
    { pattern: /콜센터|전화/, value: 'call_center' },
    { pattern: /현장|공사|건설/, value: 'construction' },
    { pattern: /교대|야간|밤샘/, value: 'shift_work' },
  ]
  
  for (const { pattern, value } of jobKeywords) {
    if (pattern.test(text)) {
      hardDislikes.push(value)
    }
  }
  
  return [...new Set(hardDislikes)]
}

// hard_dislike facts 생성
export function createHardDislikeFacts(
  params: FactSaveParams & {
    dislikes: string[] // UI에서 선택한 일반 dislike
    hardDislikes?: string[] // 강조 표시하거나 서술형에서 추출한 것
    narrativeText?: string // 서술형 답변 (자동 추출용)
  }
): AnalyzerFact[] {
  const facts: AnalyzerFact[] = []
  
  // 1. UI에서 선택한 일반 dislike 저장
  for (const dislike of params.dislikes) {
    facts.push({
      session_id: params.session_id,
      user_id: params.user_id,
      draft_id: params.draft_id,
      request_id: params.request_id,
      fact_key: 'profile.dislike',
      value_json: JSON.stringify({ type: dislike, intensity: 'mild' }),
      value_text: dislike,
      rank_int: null,
      source: params.source || 'user_input',
      confidence_weight: params.confidence_weight || 0.7,
    })
  }
  
  // 2. 명시적 hard_dislike 저장
  const explicitHard = params.hardDislikes || []
  for (const hardDislike of explicitHard) {
    facts.push({
      session_id: params.session_id,
      user_id: params.user_id,
      draft_id: params.draft_id,
      request_id: params.request_id,
      fact_key: 'profile.hard_dislike',
      value_json: JSON.stringify({ type: hardDislike, intensity: 'hard', source: 'explicit' }),
      value_text: hardDislike,
      rank_int: null,
      source: params.source || 'user_input',
      confidence_weight: 1.0, // hard_dislike는 최대 가중치
    })
  }
  
  // 3. 서술형에서 자동 추출한 hard_dislike 저장
  if (params.narrativeText) {
    const extracted = extractHardDislikesFromText(params.narrativeText)
    for (const hardDislike of extracted) {
      // 이미 명시적으로 있으면 스킵
      if (explicitHard.includes(hardDislike)) continue
      
      facts.push({
        session_id: params.session_id,
        user_id: params.user_id,
        draft_id: params.draft_id,
        request_id: params.request_id,
        fact_key: 'profile.hard_dislike',
        value_json: JSON.stringify({ type: hardDislike, intensity: 'hard', source: 'narrative_extracted' }),
        value_text: hardDislike,
        rank_int: null,
        source: 'inferred',
        confidence_weight: 0.9, // 추출은 약간 낮은 가중치
      })
    }
  }
  
  return facts
}
