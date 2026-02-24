// CareerWiki AI Analyzer - Vectorize Pipeline
// Version: v1.1.0 (Freeze v1.1)
//
// ============================================
// 🚨 [불변 원칙] Vectorize 역할 경계 (절대 변경 금지)
// ============================================
// 1. Vectorize score는 추천 점수에 직접 사용 금지
//    - 유사도 점수는 후보 풀 필터용일 뿐, 랭킹에 영향 없음
//
// 2. 용도 제한: 질문 설계 / 후보 풀 생성 / 설명 보조
//    - Interview Mode: QSP 생성 (직업명 비노출)
//    - Recommendation Mode: 후보 풀 TopK=800
//
// 3. 랭킹 결정: LLM Judge만 담당
//    - 최종 추천 순위는 Fit/Desire/Feasibility 점수로 결정
//    - "500개만 보면 충분"이라는 유혹에 넘어가지 말 것
// ============================================
//
// ⚠️ 설계 원칙
// ============================================
// 1. 후보군 확장: 80개 → 500-1000개
// 2. 태깅 대신 의미 기반 검색으로 커버리지 확보
// 3. Evidence Generator와 통합
// ============================================

import type { D1Database, VectorizeIndex, Ai } from '@cloudflare/workers-types'
import { preFilterByHardConstraints, type PreFilterResult } from './tag-filter'
import type { UserConstraints } from './types'
import type { MiniModuleResult } from './mini-module-questions'
import { TOKEN_TO_ENGLISH } from './mini-module-questions'
import { generateOpenAIEmbedding, OPENAI_EMBEDDING_DIMENSIONS } from './openai-client'
import { calculatePersonalizedBaseScores } from './personalized-scoring'
import { calculateMajorPersonalizedBaseScores } from './personalized-scoring-major'
import type { ScoredMajor, MajorAttributes } from './types'
import { 
  JOB_PROFILE_COMPACT_VERSION, 
  getFullEmbeddingVersion 
} from '../../constants/embedding-versions'

// ============================================
// Vectorize ID 유틸리티 (64바이트 제한 대응)
// ============================================
// Vectorize ID는 UTF-8 64바이트 이내여야 함
// 한글 major ID(예: "major:축산계열축산전공-낙농한우전공-양돈양계전공")가 초과할 수 있음
// prefix:를 유지하면서 ID를 잘라 64바이트에 맞춤
// 검색 시 metadata.original_id로 원본 DB ID 복구
function toVectorizeId(prefix: string, id: string | number): string {
  const full = `${prefix}:${id}`
  const encoder = new TextEncoder()
  if (encoder.encode(full).length <= 64) return full
  // prefix: 부분은 유지하면서 id를 뒤에서부터 자름
  const prefixPart = `${prefix}:`
  let truncated = String(id)
  while (encoder.encode(prefixPart + truncated).length > 64) {
    truncated = truncated.slice(0, -1)
  }
  return prefixPart + truncated
}

// ============================================
// 타입 정의
// ============================================

export interface VectorizeJobData {
  job_id: string
  job_name: string
  description: string
  category?: string
  tags?: string[]
}

export interface VectorSearchResult {
  job_id: string
  job_name: string
  score: number
  metadata?: Record<string, any>
}

export interface CandidateExpansionResult {
  candidates: VectorSearchResult[]
  total_searched: number
  search_duration_ms: number
  fallback_used: boolean
}

// ============================================
// 임베딩 모델 설정 (OpenAI text-embedding-3-small)
// ============================================
// 기존: '@cf/baai/bge-base-en-v1.5' (768차원, 영어 기반)
// 변경: OpenAI 'text-embedding-3-small' (1536차원, 다국어 지원)
const VECTOR_DIMENSIONS = OPENAI_EMBEDDING_DIMENSIONS  // 1536

// ============================================
// 미니모듈 기반 검색 쿼리 생성 (영어 키워드 매핑)
// ============================================
export function buildSearchQueryFromMiniModule(
  miniModule: MiniModuleResult
): string {
  const parts: string[] = []
  
  // 흥미 토큰 → 영어 키워드
  if (miniModule.interest_top.length > 0) {
    const interestKeywords = miniModule.interest_top
      .map(token => TOKEN_TO_ENGLISH[token] || token)
      .join(' ')
    parts.push(`interest: ${interestKeywords}`)
  }
  
  // 가치 토큰 → 영어 키워드
  if (miniModule.value_top.length > 0) {
    const valueKeywords = miniModule.value_top
      .map(token => TOKEN_TO_ENGLISH[token] || token)
      .join(' ')
    parts.push(`value: ${valueKeywords}`)
  }
  
  // 강점 토큰 → 영어 키워드
  if (miniModule.strength_top.length > 0) {
    const strengthKeywords = miniModule.strength_top
      .map(token => TOKEN_TO_ENGLISH[token] || token)
      .join(' ')
    parts.push(`strength: ${strengthKeywords}`)
  }
  
  // 제약 플래그 → 영어 키워드 (피해야 할 것)
  if (miniModule.constraint_flags.length > 0) {
    const constraintKeywords = miniModule.constraint_flags
      .map(token => TOKEN_TO_ENGLISH[token] || token)
      .join(' ')
    parts.push(`avoid: ${constraintKeywords}`)
  }
  
  // 영어 쿼리 생성 (BGE 모델이 영어 기반)
  if (parts.length === 0) {
    return 'career recommendation job matching'
  }

  return parts.join(' ').substring(0, 500)
}

/**
 * MiniModuleResult → SearchProfile 변환
 * E2E 테스트 및 /v3/recommend에서 벡터 검색 시 사용
 */
export function buildSearchProfileFromMiniModule(
  miniModule: MiniModuleResult
): SearchProfile {
  // 토큰을 한국어로 변환하는 맵 (벡터 검색용)
  const interestKorean: Record<string, string> = {
    data_numbers: '데이터 분석 통계',
    problem_solving: '문제 해결 논리',
    research: '연구 조사 분석',
    tech: '기술 개발 IT',
    creative: '창작 디자인 예술',
    helping: '도움 상담 복지 서비스 돌봄',
    helping_teaching: '도움 가르침 상담 교육 복지',
    organizing: '조직 관리 행정 사무 경영지원',
    routine: '행정 사무 공무원 정형화된 업무',
    design: '디자인 시각 그래픽',
    art: '예술 창작 문화',
  }

  const valueKorean: Record<string, string> = {
    autonomy: '자율성 자유 독립',
    growth: '성장 발전 경력개발',
    expertise: '전문성 숙련 전문가',
    stability: '안정 정규직 공무원 공공기관',
    wlb: '워라밸 균형 정시퇴근',
    income: '소득 연봉 보수',
    creativity: '창의성 창작',
    recognition: '인정 성취',
    meaning: '의미 보람 사회공헌',
  }

  const strengthKorean: Record<string, string> = {
    analytical: '분석력 논리 데이터',
    fast_learning: '빠른 학습 습득',
    persistence: '끈기 인내 꾸준함',
    communication: '소통 대인관계 상담 고객응대',
    creative: '창의성 독창',
    structured_execution: '체계적 실행 업무처리 사무',
    leadership: '리더십 통솔 관리',
    empathy: '공감 이해 돌봄',
    adaptability: '적응력 유연',
    detail_oriented: '꼼꼼함 정밀 검수',
  }

  // desiredThemes: 흥미 + 가치
  const desiredThemes: string[] = [
    ...miniModule.interest_top.map(t => interestKorean[t] || t),
    ...miniModule.value_top.map(t => valueKorean[t] || t),
  ]

  // strengthsHypothesis: 강점
  const strengthsHypothesis: string[] = miniModule.strength_top.map(t => strengthKorean[t] || t)

  // hardConstraints: 제약 플래그
  const hardConstraints: string[] = miniModule.constraint_flags || []

  // keywords: 검색 키워드 (영어 + 한국어 혼합, 가치 한국어 포함)
  const keywords: string[] = [
    ...miniModule.interest_top.map(t => TOKEN_TO_ENGLISH[t] || t),
    ...miniModule.strength_top.map(t => TOKEN_TO_ENGLISH[t] || t),
    ...miniModule.interest_top.map(t => interestKorean[t] || t),
    ...miniModule.value_top.map(t => valueKorean[t] || t),
  ]

  // dislikedThemes: 에너지 소모 플래그에서 추출
  const energyDrainKorean: Record<string, string> = {
    people_drain: '사람 상호작용 많은 일',
    routine_drain: '반복 단순 작업',
    time_pressure_drain: '시간 압박 마감',
    bureaucracy_drain: '관료적 절차',
    conflict_drain: '갈등 충돌',
    multitask_drain: '멀티태스킹',
    uncertainty_drain: '불확실성',
  }
  const dislikedThemes: string[] = (miniModule.energy_drain_flags || []).map(t => energyDrainKorean[t] || t)

  return {
    desiredThemes,
    dislikedThemes,
    strengthsHypothesis,
    environmentPreferences: miniModule.workstyle_top || [],
    hardConstraints,
    riskSignals: [],
    keywords: [...new Set(keywords)],  // 중복 제거
  }
}

// ============================================
// P2: Can/Like 가중 검색 쿼리 시스템
// 검증된 Can에 더 높은 가중치 부여
// ============================================
export interface WeightedSearchQuery {
  primary_keywords: string[]      // 가중치 높은 키워드 (검증된 Can + Like)
  secondary_keywords: string[]    // 일반 키워드
  exclude_keywords: string[]      // 제외 키워드 (Risk)
  boost_weights: Map<string, number>
}

/**
 * Can 검증 결과를 반영한 가중 검색 쿼리 생성
 * - 검증된 강점은 primary_keywords로 우선 처리
 * - 미검증 강점은 secondary_keywords로 처리
 */
export function buildWeightedSearchQuery(
  miniModule: MiniModuleResult,
  canValidationResults?: Record<string, { canBoost: number }>
): WeightedSearchQuery {
  const primary: string[] = []
  const secondary: string[] = []
  const exclude: string[] = []
  const weights = new Map<string, number>()

  // 1. Like 키워드 (interest + value)
  for (const token of miniModule.interest_top || []) {
    const keyword = TOKEN_TO_ENGLISH[token]
    if (keyword) {
      secondary.push(keyword)
      weights.set(keyword, 1.0)
    }
  }

  for (const token of miniModule.value_top || []) {
    const keyword = TOKEN_TO_ENGLISH[token]
    if (keyword) {
      secondary.push(keyword)
      weights.set(keyword, 0.8)  // 가치는 관심보다 약간 낮은 가중치
    }
  }

  // 2. Can 키워드 (검증된 강점 우선)
  for (const token of miniModule.strength_top || []) {
    const keyword = TOKEN_TO_ENGLISH[token]
    if (!keyword) continue

    // Can 검증 결과 확인
    const validationKey = `can_verified_${token}`
    const validation = canValidationResults?.[validationKey]

    if (validation && validation.canBoost >= 15) {
      // 검증된 강점 → primary (높은 가중치)
      primary.push(keyword)
      weights.set(keyword, 1.5)
    } else if (validation && validation.canBoost >= 8) {
      // 부분 검증 → secondary (중간 가중치)
      secondary.push(keyword)
      weights.set(keyword, 1.2)
    } else {
      // 미검증 → secondary (기본 가중치)
      secondary.push(keyword)
      weights.set(keyword, 1.0)
    }
  }

  // 3. Risk 키워드 (제외 대상)
  for (const token of miniModule.constraint_flags || []) {
    const keyword = TOKEN_TO_ENGLISH[token]
    if (keyword) {
      exclude.push(keyword)
    }
  }

  // 에너지 소모 플래그도 제외 키워드로
  for (const token of miniModule.energy_drain_flags || []) {
    const keyword = TOKEN_TO_ENGLISH[token]
    if (keyword) {
      exclude.push(keyword)
    }
  }

  return {
    primary_keywords: primary,
    secondary_keywords: secondary,
    exclude_keywords: exclude,
    boost_weights: weights,
  }
}

/**
 * 가중 쿼리를 문자열로 변환 (검색용)
 */
export function weightedQueryToString(query: WeightedSearchQuery): string {
  const parts: string[] = []

  // Primary 키워드를 2번 포함 (가중치 효과)
  if (query.primary_keywords.length > 0) {
    parts.push(`key skills: ${query.primary_keywords.join(' ')}`)
    parts.push(`strengths: ${query.primary_keywords.join(' ')}`)  // 중복으로 강조
  }

  // Secondary 키워드
  if (query.secondary_keywords.length > 0) {
    parts.push(`interests: ${query.secondary_keywords.join(' ')}`)
  }

  // Exclude 키워드 (NOT 표현)
  if (query.exclude_keywords.length > 0) {
    parts.push(`avoid: ${query.exclude_keywords.join(' ')}`)
  }

  if (parts.length === 0) {
    return 'career recommendation job matching'
  }

  return parts.join(' ').substring(0, 500)
}

// ============================================
// 사용자 쿼리 생성 (facts → 검색 쿼리)
// ============================================
export function buildSearchQuery(
  facts: Array<{ fact_key: string; value_json: string }>,
  miniModule?: MiniModuleResult
): string {
  // 미니모듈 결과가 있으면 우선 사용
  if (miniModule && (miniModule.interest_top.length > 0 || miniModule.value_top.length > 0)) {
    return buildSearchQueryFromMiniModule(miniModule)
  }
  
  const queryParts: string[] = []
  
  for (const fact of facts) {
    try {
      const parsed = JSON.parse(fact.value_json)
      const value = parsed.value || parsed
      
      // 관심사 추출 → 영어 키워드로 변환
      if (fact.fact_key.includes('interest')) {
        if (Array.isArray(value)) {
          // 한국어 관심사를 영어로 매핑
          const interestMap: Record<string, string> = {
            '기술': 'technology engineering development',
            '디자인': 'design creative artistic',
            '비즈니스': 'business management leadership',
            '데이터': 'data analysis quantitative',
            '교육': 'education teaching training',
            '의료': 'healthcare medical health',
            '금융': 'finance banking investment',
            '마케팅': 'marketing sales communication',
          }
          const mapped = value.map((v: string) => interestMap[v] || v).join(' ')
          queryParts.push(`interest: ${mapped}`)
        } else {
          queryParts.push(`interest: ${value}`)
        }
      }
      
      // 우선순위 추출 → 영어로 변환
      if (fact.fact_key.includes('priority')) {
        const priorityMapEn: Record<string, string> = {
          growth: 'career growth learning development',
          income: 'high salary compensation financial',
          wlb: 'work-life balance flexible hours',
          stability: 'job security stable employment',
          meaning: 'meaningful work purpose impact',
        }
        queryParts.push(`value: ${priorityMapEn[value] || value}`)
      }
      
      // 작업 스타일 → 영어로 변환
      if (fact.fact_key.includes('workstyle')) {
        if (value === 'solo') {
          queryParts.push('work style: independent autonomous focused')
        } else if (value === 'team') {
          queryParts.push('work style: collaborative team cooperative')
        }
      }
      
      // Deep intake 내용 (이건 한국어 그대로 - 보조 역할)
      if (fact.fact_key.includes('deep_intake') || fact.fact_key.includes('discovery')) {
        if (typeof value === 'string' && value.length > 5) {
          queryParts.push(value.substring(0, 100))
        }
      }
      
    } catch {
      // 파싱 실패 시 무시
    }
  }
  
  // 기본 쿼리 (영어)
  if (queryParts.length === 0) {
    return 'career recommendation job matching professional work'
  }
  
  return queryParts.join(' ').substring(0, 500)
}

// ============================================
// 벡터 검색 (Cloudflare Vectorize + OpenAI Embedding)
// ============================================
export async function searchCandidates(
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  query: string,
  topK: number = 500
): Promise<VectorSearchResult[]> {
  // 1. 쿼리 임베딩 생성 (OpenAI - 한국어 직접 처리)
  const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, query)
  const queryEmbedding = embeddings[0]
  
  // 2. 벡터 검색
  // Cloudflare Vectorize 절대 상한: topK = 100
  // metadata는 후속 D1 조회에서 가져오므로 'none'으로 설정
  const clampedTopK = Math.min(topK, 100)
  const searchResult = await vectorize.query(queryEmbedding, {
    topK: clampedTopK,
    returnValues: false,
    returnMetadata: 'none',
  })

  // 3. 결과 변환 (metadata 없이 ID + score만 반환, job_name은 D1에서 조회)
  // major:/howto: prefix ID 제외 (RAG 검색용 엔트리가 AI Analyzer에 혼입되지 않도록)
  return searchResult.matches
    .filter(match => !match.id.includes(':'))
    .map(match => ({
      job_id: match.id,
      job_name: match.id,
      score: match.score,
      metadata: {} as Record<string, any>,
    }))
}

// ============================================
// Multi-Query 벡터 검색 (topK=100 제한 우회)
// 여러 쿼리를 배치 임베딩 + 병렬 검색하여 후보 풀 확장
// ============================================
export async function searchCandidatesMultiQuery(
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  queries: string[],
  topK: number = 100
): Promise<VectorSearchResult[]> {
  // 1. 배치 임베딩 (한 번의 OpenAI 호출로 모든 쿼리 임베딩)
  const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, queries)

  // 2. 병렬 Vectorize 검색 (각 topK=100)
  const clampedTopK = Math.min(topK, 100)
  const searchPromises = embeddings.map(emb =>
    vectorize.query(emb, { topK: clampedTopK, returnValues: false, returnMetadata: 'none' })
  )
  const searchResults = await Promise.all(searchPromises)

  // 3. 중복 제거 (같은 job_id → 최고 score 유지 + 히트카운트 추적)
  // v3.9.5: 여러 쿼리에 등장하는 주류 직업에 히트카운트 보너스
  // major:/howto: prefix ID 제외 (RAG 검색용 엔트리가 AI Analyzer에 혼입되지 않도록)
  const bestScoreMap = new Map<string, number>()
  const hitCountMap = new Map<string, number>()
  let totalMatches = 0
  for (const result of searchResults) {
    for (const match of result.matches) {
      if (match.id.includes(':')) continue  // major:/howto: prefix 제외
      totalMatches++
      const existing = bestScoreMap.get(match.id)
      if (existing === undefined || match.score > existing) {
        bestScoreMap.set(match.id, match.score)
      }
      hitCountMap.set(match.id, (hitCountMap.get(match.id) || 0) + 1)
    }
  }


  // 4. 결과 변환 (score 내림차순)
  // 히트카운트 보너스: 3+개 쿼리에 등장 → 점수 보정 (주류 직업 우선)
  return Array.from(bestScoreMap.entries())
    .map(([id, score]) => {
      const hits = hitCountMap.get(id) || 1
      // 3+개 쿼리 히트 시 score에 보너스 (최대 +0.05)
      const hitBonus = hits >= 3 ? Math.min(0.05, (hits - 2) * 0.015) : 0
      return { id, score: Math.min(1.0, score + hitBonus), hits }
    })
    .sort((a, b) => b.score - a.score)
    .map(({ id, score }) => ({
      job_id: id,
      job_name: id,
      score,
      metadata: {} as Record<string, any>,
    }))
}

// ============================================
// 후보군 확장 (메인 함수) - 벡터 검색 기반
// ============================================
// 2026-01-26: 태깅 의존도 완전 제거
// - 벡터 검색 결과만 사용
// - 모든 직업 검색 가능 (태깅 여부 무관)
// ============================================
export async function expandCandidates(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  openaiApiKey: string | undefined,
  facts: Array<{ fact_key: string; value_json: string }>,
  options: {
    targetSize?: number
  } = {}
): Promise<CandidateExpansionResult> {
  const { targetSize = 500 } = options
  const startTime = Date.now()
  
  // Vectorize 또는 OpenAI API 키가 없으면 fallback
  if (!vectorize || !openaiApiKey) {
    const fallbackResult = await getFallbackCandidates(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }
  
  try {
    // 1. 검색 쿼리 생성 (한국어 직접 사용 가능)
    const query = buildSearchQuery(facts)
    
    // 2. 벡터 검색 (OpenAI Embedding 사용)
    const vectorResults = await searchCandidates(vectorize, openaiApiKey, query, targetSize)
    
    
    return {
      candidates: vectorResults,
      total_searched: vectorResults.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: false,
    }
    
  } catch (error) {
    const fallbackResult = await getFallbackCandidates(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }
}

// ============================================
// Fallback: DB에서 직접 조회 (태깅 무관)
// ============================================
// 2026-01-26: 태깅 의존도 제거
// - 모든 직업을 조회 (tagger_version 조건 제거)
// - 랜덤 샘플링으로 다양한 직업 제공
// ============================================
async function getFallbackCandidates(
  db: D1Database,
  limit: number
): Promise<VectorSearchResult[]> {
  // job_attributes 테이블에서 직접 조회 (태깅 여부 무관)
  const result = await db.prepare(`
    SELECT job_id, job_name
    FROM job_attributes
    ORDER BY RANDOM()
    LIMIT ?
  `).bind(limit).all<{ job_id: string; job_name: string }>()
  
  return (result.results || []).map((row, idx) => ({
    job_id: row.job_id,
    job_name: row.job_name,
    score: 0.5 - (idx * 0.0005), // 순서에 따라 미세하게 점수 감소
    metadata: { source: 'fallback_random' },
  }))
}

// ============================================
// Job Profile Compact: Freeze v1.1 인덱싱 텍스트 생성
// ============================================
// 버전: JOB_PROFILE_COMPACT_V1
// 변경 시 반드시 JOB_PROFILE_COMPACT_VERSION 증가 필요!
// ============================================
export interface JobProfileData {
  name: string
  heroIntro?: string | null
  summary?: string | null
  description?: string | null
  duties?: string | null
  skills?: string[] | null
  workEnvironment?: string | null
  certifications?: string[] | null
  category?: string | null
  // V2: Contextual Embedding용 속성 데이터
  attributes?: {
    income?: number | null
    stability?: number | null
    wlb?: number | null
    growth?: number | null
    analytical?: number | null
    creative?: number | null
    people_facing?: number | null
    solo_deep?: number | null
    teamwork?: number | null
    execution?: number | null
  } | null
  relatedMajors?: string[] | null  // 관련 전공명
}

/**
 * buildJobProfileCompact: 직업 데이터를 인덱싱용 텍스트로 변환
 * 
 * Fallback 규칙:
 * 1. heroIntro → summary → description → category 우선순위
 * 2. 모든 직업이 "직업명 + 핵심 2~3문장"은 반드시 포함
 * 3. 최대 길이 1000자
 * 4. 빈 데이터가 많아도 최소 정보량 보장
 */
export function buildJobProfileCompact(job: JobProfileData): string {
  // 직업명은 항상 필수
  const name = job.name || '미상'

  // V2: 맥락 프리앰블 생성 (카테고리 + 핵심 속성 + 관련 전공)
  const preamble = buildContextPreamble(job)

  // 설명 텍스트 fallback 우선순위 (비문자열 방어)
  const rawDesc = job.heroIntro || job.summary || job.description || ''
  const mainDesc = (typeof rawDesc === 'string' ? rawDesc : '').trim()

  // 선택적 필드들 (있으면 추가)
  const parts: string[] = []

  // 프리앰블이 있으면 맨 앞에 추가
  if (preamble) {
    parts.push(preamble)
    parts.push('---')
  }

  parts.push(name)

  // 메인 설명 (최대 300자)
  if (mainDesc) {
    parts.push(mainDesc.slice(0, 300))
  }

  // 핵심업무 (있으면)
  const dutiesStr = typeof job.duties === 'string' ? job.duties.trim() : ''
  if (dutiesStr) {
    parts.push(`핵심업무: ${dutiesStr.slice(0, 100)}`)
  }

  // 필요역량 (있으면, 최대 5개)
  if (Array.isArray(job.skills) && job.skills.length > 0) {
    const validSkills = job.skills.filter(s => typeof s === 'string' && s.trim())
    if (validSkills.length > 0) {
      parts.push(`필요역량: ${validSkills.slice(0, 5).join(', ')}`)
    }
  }

  // 근무환경 (있으면)
  const envStr = typeof job.workEnvironment === 'string' ? job.workEnvironment.trim() : ''
  if (envStr) {
    parts.push(`환경: ${envStr.slice(0, 50)}`)
  }

  // 자격증 (있으면, 최대 3개)
  if (Array.isArray(job.certifications) && job.certifications.length > 0) {
    const validCerts = job.certifications.filter(c => typeof c === 'string' && c.trim())
    if (validCerts.length > 0) {
      parts.push(`자격: ${validCerts.slice(0, 3).join(', ')}`)
    }
  }

  // 카테고리 (있으면, 프리앰블에 없는 경우만)
  const catStr = typeof job.category === 'string' ? job.category.trim() : ''
  if (!preamble && catStr) {
    parts.push(catStr)
  }

  // 최소 보장: name + category는 반드시 포함
  if (parts.length < 2) {
    parts.push(catStr || '미분류')
  }

  // V2: 최대 길이 1200자 (프리앰블 포함)
  return parts.join(' ').substring(0, 1200)
}

/**
 * V2 맥락 프리앰블 생성: 카테고리 + 핵심 속성 + 관련 전공
 * 50-150자 이내로 압축
 */
function buildContextPreamble(job: JobProfileData): string {
  const fragments: string[] = []

  // 1. 카테고리 컨텍스트
  const catText = typeof job.category === 'string' ? job.category.trim() : ''
  if (catText) {
    fragments.push(`[${catText}]`)
  }

  // 2. 핵심 속성 (70+ 값만 하이라이트)
  if (job.attributes) {
    const attrLabels: { key: string; label: string }[] = [
      { key: 'analytical', label: '분석' },
      { key: 'creative', label: '창의' },
      { key: 'execution', label: '실행' },
      { key: 'people_facing', label: '대인' },
      { key: 'solo_deep', label: '독립' },
      { key: 'teamwork', label: '협업' },
      { key: 'income', label: '고소득' },
      { key: 'stability', label: '안정' },
      { key: 'growth', label: '성장' },
      { key: 'wlb', label: 'WLB' },
    ]
    const highlights: string[] = []
    for (const { key, label } of attrLabels) {
      const val = (job.attributes as any)[key] as number | null | undefined
      if (val !== null && val !== undefined && val >= 70) {
        highlights.push(label)
      }
    }
    if (highlights.length > 0) {
      fragments.push(`특성: ${highlights.slice(0, 4).join(', ')}`)
    }
  }

  // 3. 관련 전공
  if (job.relatedMajors && job.relatedMajors.length > 0) {
    fragments.push(`관련전공: ${job.relatedMajors.slice(0, 3).join(', ')}`)
  }

  return fragments.join(' ')
}

/**
 * parseJobProfileFromMergedJson: merged_profile_json에서 JobProfileData 추출
 */
export function parseJobProfileFromMergedJson(
  jobId: string,
  jobName: string,
  mergedProfileJson: string | null,
  category?: string | null
): JobProfileData {
  let heroIntro: string | undefined
  let summary: string | undefined
  let description: string | undefined
  let duties: string | undefined
  let skills: string[] | undefined
  let workEnvironment: string | undefined
  let certifications: string[] | undefined

  if (mergedProfileJson) {
    try {
      const profile = JSON.parse(mergedProfileJson)
      
      // 다양한 필드명 지원 (데이터 소스에 따라 다를 수 있음)
      heroIntro = profile.heroIntro || profile.hero_intro || profile.intro
      summary = profile.summary || profile.brief
      description = profile.description || profile.overview || profile.what || profile.업무내용
      duties = profile.duties || profile.responsibilities || profile.tasks || 
               (profile.what && typeof profile.what === 'string' ? profile.what : undefined)
      
      // skills 배열 처리
      if (profile.skills) {
        skills = Array.isArray(profile.skills) ? profile.skills : [profile.skills]
      } else if (profile.required_skills) {
        skills = Array.isArray(profile.required_skills) ? profile.required_skills : [profile.required_skills]
      }
      
      workEnvironment = profile.workEnvironment || profile.work_environment || profile.environment
      
      // certifications 배열 처리
      if (profile.certifications) {
        certifications = Array.isArray(profile.certifications) ? profile.certifications : [profile.certifications]
      } else if (profile.licenses) {
        certifications = Array.isArray(profile.licenses) ? profile.licenses : [profile.licenses]
      }
      
    } catch (e) {
    }
  }

  return {
    name: jobName,
    heroIntro,
    summary,
    description,
    duties,
    skills,
    workEnvironment,
    certifications,
    category,
  }
}

// ============================================
// 직업 데이터 인덱싱 (배치 처리용 - OpenAI Embedding)
// ============================================
// Version: JOB_PROFILE_COMPACT_V1
// ============================================
export async function indexJobsToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  batchSize: number = 50  // OpenAI API rate limit 고려하여 줄임
): Promise<{ indexed: number; errors: number; version: string }> {
  let indexed = 0
  let errors = 0
  let offset = 0
  const version = getFullEmbeddingVersion()
  
  
  while (true) {
    // jobs + job_attributes LEFT JOIN 조회 (V2: 맥락 프리앰블용)
    const jobs = await db.prepare(`
      SELECT
        j.id as job_id,
        j.name as job_name,
        j.merged_profile_json,
        ja.income, ja.stability, ja.wlb, ja.growth,
        ja.analytical, ja.creative, ja.people_facing, ja.solo_deep,
        ja.teamwork, ja.execution
      FROM jobs j
      LEFT JOIN job_attributes ja ON j.id = ja.job_id
      WHERE j.is_active = 1
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      job_id: string
      job_name: string
      merged_profile_json: string | null
      income: number | null
      stability: number | null
      wlb: number | null
      growth: number | null
      analytical: number | null
      creative: number | null
      people_facing: number | null
      solo_deep: number | null
      teamwork: number | null
      execution: number | null
    }>()

    if (!jobs.results || jobs.results.length === 0) break

    // buildJobProfileCompact로 인덱싱 텍스트 생성 (V2: 속성 데이터 포함)
    const textsForEmbedding = jobs.results.map(job => {
      // category는 merged_profile_json에서 추출
      let category: string | null = null
      if (job.merged_profile_json) {
        try {
          const p = JSON.parse(job.merged_profile_json)
          category = p.category || p.heroCategory || p.분류 || null
        } catch {}
      }
      const profileData = parseJobProfileFromMergedJson(
        job.job_id,
        job.job_name,
        job.merged_profile_json,
        category
      )
      // V2: 속성 데이터 + 관련 전공 추가
      profileData.attributes = {
        income: job.income,
        stability: job.stability,
        wlb: job.wlb,
        growth: job.growth,
        analytical: job.analytical,
        creative: job.creative,
        people_facing: job.people_facing,
        solo_deep: job.solo_deep,
        teamwork: job.teamwork,
        execution: job.execution,
      }
      // 관련 전공은 merged_profile_json에서 추출
      if (job.merged_profile_json) {
        try {
          const profile = JSON.parse(job.merged_profile_json)
          const majors = profile.relatedMajors || profile.related_majors || profile.관련학과 || []
          if (Array.isArray(majors)) {
            profileData.relatedMajors = majors
              .slice(0, 3)
              .map((m: any) => typeof m === 'string' ? m : m.name || '')
              .filter(Boolean)
          }
        } catch {}
      }
      return buildJobProfileCompact(profileData)
    })

    try {
      // 배치로 임베딩 생성
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      // Vectorize에 배치 저장 (확장된 metadata 포함)
      const vectors = jobs.results.map((job, idx) => {
        // merged_profile_json에서 추가 metadata 추출
        let category = ''
        let kscoMajor: string | undefined
        let kscoMid: string | undefined
        let educationLevel: string | undefined

        if (job.merged_profile_json) {
          try {
            const profile = JSON.parse(job.merged_profile_json)
            category = profile.category || profile.heroCategory || profile.분류 || ''
            kscoMajor = profile.ksco_major || profile.kscoMajor
            kscoMid = profile.ksco_mid || profile.kscoMid
            educationLevel = profile.education_level || profile.educationLevel || profile.학력
          } catch {}
        }

        return {
          id: job.job_id,
          values: embeddings[idx],
          metadata: {
            job_name: job.job_name,
            category,
            // QSP 품질 강화용 metadata
            ksco_major: kscoMajor || '',
            ksco_mid: kscoMid || '',
            education_level: educationLevel || '',
            // 버전 추적
            embedding_version: JOB_PROFILE_COMPACT_VERSION,
          },
        }
      })
      
      await vectorize.upsert(vectors)
      indexed += jobs.results.length
      
    } catch (error) {
      errors += jobs.results.length
    }
    
    offset += batchSize
    
    // OpenAI rate limit 방지 (1초 대기)
    await new Promise(resolve => setTimeout(resolve, 1000))
  }
  
  
  return { indexed, errors, version }
}

// ============================================
// 전공 데이터 인덱싱 (배치 처리용 - OpenAI Embedding)
// ============================================
// Vectorize ID: major:{id}
// ============================================

/**
 * buildMajorProfileCompact: 전공 데이터를 인덱싱용 텍스트로 변환
 * 최대 1000자
 */
export function buildMajorProfileCompact(major: {
  name: string
  merged_profile_json: string | null
}): string {
  const name = major.name || '미상'
  const parts: string[] = [name]

  if (major.merged_profile_json) {
    try {
      const profile = JSON.parse(major.merged_profile_json)
      const summary = profile.heroIntro || profile.summary || profile.description || profile.overview || ''
      if (summary) parts.push(summary.trim().slice(0, 300))

      // 관련 직업 (검색 연관성 향상)
      const relatedJobs = profile.relatedJobs || profile.related_jobs || profile.관련직업 || []
      if (Array.isArray(relatedJobs) && relatedJobs.length > 0) {
        const jobNames = relatedJobs.slice(0, 8).map((j: any) => typeof j === 'string' ? j : j.name || j.job_name || '').filter(Boolean)
        if (jobNames.length > 0) parts.push(`관련직업: ${jobNames.join(', ')}`)
      }

      // 학과 분류
      const category = profile.category || profile.분류 || profile.field || ''
      if (category) parts.push(category)

      // 핵심 교과목
      const courses = profile.courses || profile.주요교과목 || profile.curriculum || []
      if (Array.isArray(courses) && courses.length > 0) {
        parts.push(`교과목: ${courses.slice(0, 5).join(', ')}`)
      }
    } catch {}
  }

  return parts.join(' ').substring(0, 1000)
}

export async function indexMajorsToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  batchSize: number = 50
): Promise<{ indexed: number; errors: number }> {
  let indexed = 0
  let errors = 0
  let offset = 0


  while (true) {
    const majors = await db.prepare(`
      SELECT id, name, merged_profile_json
      FROM majors
      WHERE is_active = 1
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      id: string
      name: string
      merged_profile_json: string | null
    }>()

    if (!majors.results || majors.results.length === 0) break

    const textsForEmbedding = majors.results.map(m =>
      buildMajorProfileCompact({ name: m.name, merged_profile_json: m.merged_profile_json })
    )

    try {
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      const vectors = majors.results.map((m, idx) => ({
        id: toVectorizeId('major', m.id),
        values: embeddings[idx],
        metadata: {
          type: 'major',
          name: m.name,
          original_id: m.id,
        },
      }))

      await vectorize.upsert(vectors)
      indexed += majors.results.length

      // indexed_at 업데이트
      const ids = majors.results.map(m => m.id)
      const placeholders = ids.map(() => '?').join(',')
      await db.prepare(`UPDATE majors SET indexed_at = datetime('now'), embedding_version = 'MPC_V1' WHERE id IN (${placeholders})`).bind(...ids).run()
    } catch (error) {
      errors += majors.results.length
    }

    offset += batchSize
    await new Promise(resolve => setTimeout(resolve, 1000))
  }

  return { indexed, errors }
}

// ============================================
// 전공 증분 인덱싱 (신규 또는 버전 불일치만)
// ============================================
export async function incrementalUpsertMajorsToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  options: { batchSize?: number; maxItems?: number } = {}
): Promise<{ upserted: number; errors: number; lastError?: string }> {
  const { batchSize = 50, maxItems = 200 } = options
  const CURRENT_VERSION = 'MPC_V1'
  let upserted = 0
  let errors = 0
  let lastError: string | undefined
  let offset = 0

  while (upserted < maxItems) {
    const majors = await db.prepare(`
      SELECT id, name, merged_profile_json
      FROM majors
      WHERE is_active = 1
        AND (indexed_at IS NULL OR embedding_version != ?)
      ORDER BY id
      LIMIT ? OFFSET ?
    `).bind(CURRENT_VERSION, batchSize, offset).all<{
      id: string
      name: string
      merged_profile_json: string | null
    }>()

    if (!majors.results || majors.results.length === 0) break

    const textsForEmbedding = majors.results.map(m =>
      buildMajorProfileCompact({ name: m.name, merged_profile_json: m.merged_profile_json })
    )

    try {
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      const vectors = majors.results.map((m, idx) => ({
        id: toVectorizeId('major', m.id),
        values: embeddings[idx],
        metadata: { type: 'major', name: m.name, original_id: m.id },
      }))

      await vectorize.upsert(vectors)

      for (const m of majors.results) {
        await db.prepare(`
          UPDATE majors SET indexed_at = datetime('now'), embedding_version = ?
          WHERE id = ?
        `).bind(CURRENT_VERSION, m.id).run()
      }

      upserted += majors.results.length
    } catch (e) {
      lastError = e instanceof Error ? e.message : String(e)
      errors += majors.results.length
    }

    offset += batchSize
    await new Promise(resolve => setTimeout(resolve, 1000))
  }

  return { upserted, errors, lastError }
}

// ============================================
// HowTo(가이드) 데이터 인덱싱 (배치 처리용 - OpenAI Embedding)
// ============================================
// Vectorize ID: howto:{id}
// pages 테이블의 page_type='guide' 대상
// ============================================

/**
 * buildHowtoProfileCompact: 가이드 데이터를 인덱싱용 텍스트로 변환
 * 최대 1000자
 */
export function buildHowtoProfileCompact(page: {
  title: string
  summary: string | null
  content: string | null
}): string {
  const parts: string[] = [page.title || '미상']

  if (page.summary) {
    parts.push(page.summary.trim().slice(0, 200))
  }

  if (page.content) {
    // HTML 태그 제거 후 앞부분만 사용
    const plainText = page.content.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim()
    if (plainText.length > 0) {
      parts.push(plainText.slice(0, 500))
    }
  }

  return parts.join(' ').substring(0, 1000)
}

export async function indexHowtosToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  batchSize: number = 50
): Promise<{ indexed: number; errors: number }> {
  let indexed = 0
  let errors = 0
  let offset = 0


  while (true) {
    const pages = await db.prepare(`
      SELECT id, slug, title, summary, content
      FROM pages
      WHERE page_type IN ('guide', 'howto')
        AND status = 'published'
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      id: number
      slug: string
      title: string
      summary: string | null
      content: string | null
    }>()

    if (!pages.results || pages.results.length === 0) break

    const textsForEmbedding = pages.results.map(p =>
      buildHowtoProfileCompact({ title: p.title, summary: p.summary, content: p.content })
    )

    try {
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      const vectors = pages.results.map((p, idx) => ({
        id: `howto:${p.id}`,
        values: embeddings[idx],
        metadata: {
          type: 'howto',
          title: p.title,
          slug: p.slug,
        },
      }))

      await vectorize.upsert(vectors)
      indexed += pages.results.length

      // indexed_at 업데이트
      const ids = pages.results.map(p => p.id)
      const placeholders = ids.map(() => '?').join(',')
      await db.prepare(`UPDATE pages SET indexed_at = datetime('now'), embedding_version = 'HPC_V1' WHERE id IN (${placeholders})`).bind(...ids).run()
    } catch (error) {
      errors += pages.results.length
    }

    offset += batchSize
    await new Promise(resolve => setTimeout(resolve, 1000))
  }

  return { indexed, errors }
}

// ============================================
// HowTo 증분 인덱싱 (신규 또는 버전 불일치만)
// ============================================
export async function incrementalUpsertHowtosToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  options: { batchSize?: number; maxItems?: number } = {}
): Promise<{ upserted: number; errors: number }> {
  const { batchSize = 50, maxItems = 200 } = options
  const CURRENT_VERSION = 'HPC_V1'
  let upserted = 0
  let errors = 0
  let offset = 0

  while (upserted < maxItems) {
    const pages = await db.prepare(`
      SELECT id, slug, title, summary, content
      FROM pages
      WHERE page_type IN ('guide', 'howto')
        AND status = 'published'
        AND (indexed_at IS NULL OR embedding_version != ?)
      ORDER BY id
      LIMIT ? OFFSET ?
    `).bind(CURRENT_VERSION, batchSize, offset).all<{
      id: number
      slug: string
      title: string
      summary: string | null
      content: string | null
    }>()

    if (!pages.results || pages.results.length === 0) break

    const textsForEmbedding = pages.results.map(p =>
      buildHowtoProfileCompact({ title: p.title, summary: p.summary, content: p.content })
    )

    try {
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      const vectors = pages.results.map((p, idx) => ({
        id: `howto:${p.id}`,
        values: embeddings[idx],
        metadata: { type: 'howto', title: p.title, slug: p.slug },
      }))

      await vectorize.upsert(vectors)

      for (const p of pages.results) {
        await db.prepare(`
          UPDATE pages SET indexed_at = datetime('now'), embedding_version = ?
          WHERE id = ?
        `).bind(CURRENT_VERSION, p.id).run()
      }

      upserted += pages.results.length
    } catch {
      errors += pages.results.length
    }

    offset += batchSize
    await new Promise(resolve => setTimeout(resolve, 1000))
  }

  return { upserted, errors }
}

// ============================================
// 단일 항목 인덱싱 (생성/발행 시 백그라운드 호출용)
// ============================================

export async function indexSingleJob(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  jobId: string
): Promise<boolean> {
  try {
    const job = await db.prepare(`
      SELECT
        j.id as job_id, j.name as job_name, j.merged_profile_json,
        ja.income, ja.stability, ja.wlb, ja.growth,
        ja.analytical, ja.creative, ja.people_facing, ja.solo_deep,
        ja.teamwork, ja.execution
      FROM jobs j
      LEFT JOIN job_attributes ja ON j.id = ja.job_id
      WHERE j.id = ? AND j.is_active = 1
    `).bind(jobId).first<{
      job_id: string; job_name: string; merged_profile_json: string | null
      income: number | null; stability: number | null; wlb: number | null; growth: number | null
      analytical: number | null; creative: number | null; people_facing: number | null
      solo_deep: number | null; teamwork: number | null; execution: number | null
    }>()

    if (!job) return false

    // category는 merged_profile_json에서 추출
    let category: string | null = null
    let kscoMajor = '', kscoMid = '', educationLevel = ''
    if (job.merged_profile_json) {
      try {
        const p = JSON.parse(job.merged_profile_json)
        category = p.category || p.heroCategory || p.분류 || null
        kscoMajor = p.ksco_major || p.kscoMajor || ''
        kscoMid = p.ksco_mid || p.kscoMid || ''
        educationLevel = p.education_level || p.educationLevel || p.학력 || ''
      } catch {}
    }

    const profileData = parseJobProfileFromMergedJson(job.job_id, job.job_name, job.merged_profile_json, category)
    profileData.attributes = {
      income: job.income, stability: job.stability, wlb: job.wlb, growth: job.growth,
      analytical: job.analytical, creative: job.creative, people_facing: job.people_facing,
      solo_deep: job.solo_deep, teamwork: job.teamwork, execution: job.execution,
    }
    if (job.merged_profile_json) {
      try {
        const profile = JSON.parse(job.merged_profile_json)
        const majors = profile.relatedMajors || profile.related_majors || profile.관련학과 || []
        if (Array.isArray(majors)) {
          profileData.relatedMajors = majors.slice(0, 3).map((m: any) => typeof m === 'string' ? m : m.name || '').filter(Boolean)
        }
      } catch {}
    }

    const text = buildJobProfileCompact(profileData)
    const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, text)

    await vectorize.upsert([{
      id: job.job_id,
      values: embeddings[0],
      metadata: {
        job_name: job.job_name,
        category: category || '',
        ksco_major: kscoMajor,
        ksco_mid: kscoMid,
        education_level: educationLevel,
        embedding_version: JOB_PROFILE_COMPACT_VERSION,
      },
    }])

    const version = getFullEmbeddingVersion()
    await db.prepare(`UPDATE jobs SET indexed_at = datetime('now'), embedding_version = ? WHERE id = ?`).bind(version, jobId).run()
    return true
  } catch {
    return false
  }
}

export async function indexSingleMajor(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  majorId: string
): Promise<boolean> {
  try {
    const major = await db.prepare(`
      SELECT id, name, merged_profile_json
      FROM majors WHERE id = ? AND is_active = 1
    `).bind(majorId).first<{ id: string; name: string; merged_profile_json: string | null }>()

    if (!major) return false

    const text = buildMajorProfileCompact({ name: major.name, merged_profile_json: major.merged_profile_json })
    const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, text)

    await vectorize.upsert([{
      id: toVectorizeId('major', major.id),
      values: embeddings[0],
      metadata: { type: 'major', name: major.name, original_id: major.id },
    }])

    await db.prepare(`UPDATE majors SET indexed_at = datetime('now'), embedding_version = 'MPC_V1' WHERE id = ?`).bind(majorId).run()
    return true
  } catch {
    return false
  }
}

export async function indexSingleHowto(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  pageId: number
): Promise<boolean> {
  try {
    const page = await db.prepare(`
      SELECT id, slug, title, summary, content
      FROM pages WHERE id = ? AND page_type IN ('guide', 'howto') AND status = 'published'
    `).bind(pageId).first<{ id: number; slug: string; title: string; summary: string | null; content: string | null }>()

    if (!page) return false

    const text = buildHowtoProfileCompact({ title: page.title, summary: page.summary, content: page.content })
    const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, text)

    await vectorize.upsert([{
      id: `howto:${page.id}`,
      values: embeddings[0],
      metadata: { type: 'howto', title: page.title, slug: page.slug },
    }])

    await db.prepare(`UPDATE pages SET indexed_at = datetime('now'), embedding_version = 'HPC_V1' WHERE id = ?`).bind(pageId).run()
    return true
  } catch {
    return false
  }
}

// ============================================
// 직업 설명 추출 헬퍼 함수
// ============================================
export function extractJobDescription(apiDataJson: string | null, mergedProfileJson?: string | null, jobName?: string, aiDataJson?: string | null): string | undefined {
  // 1. merged_profile_json에서 먼저 시도 (heroIntro 등 실제 필드명)
  if (mergedProfileJson) {
    try {
      const data = JSON.parse(mergedProfileJson)
      const description =
        data.heroIntro ||                     // 메인 설명 필드
        data.overviewWork?.main ||            // 업무 개요
        data.description ||
        data.job_overview ||
        data.summary ||
        data.job_summary ||
        data.overview ||
        data.직무개요 ||
        data.직업개요 ||
        undefined
      if (description) {
        // 문자열이 아닌 경우 처리
        const text = typeof description === 'string' ? description : JSON.stringify(description)
        return text.substring(0, 200)
      }
    } catch {
      // continue to api_data_json
    }
  }

  // 2. api_data_json에서 시도
  if (apiDataJson) {
    try {
      const data = JSON.parse(apiDataJson)
      // merged → careernet → goyong24 순으로 시도
      const description =
        data.merged?.heroIntro ||
        data.merged?.description ||
        data.merged?.job_overview ||
        data.careernet?.summary ||
        data.careernet?.job_overview ||
        data.careernet?.description ||
        data.goyong24?.summary?.jobSum ||
        data.goyong24?.duty?.jobSum ||
        data.goyong24?.description ||
        data.goyong24?.job_overview ||
        undefined
      if (description) {
        const text = typeof description === 'string' ? description : JSON.stringify(description)
        return text.substring(0, 200)
      }
    } catch {
      // continue to ai_data_json
    }
  }

  // 3. ai_data_json에서 시도
  if (aiDataJson) {
    try {
      const data = JSON.parse(aiDataJson)
      const description =
        data.description ||
        data.summary ||
        data.heroIntro ||
        data.job_description ||
        undefined
      if (description) {
        const text = typeof description === 'string' ? description : JSON.stringify(description)
        return text.substring(0, 200)
      }
    } catch {
      // continue to fallback
    }
  }

  // 4. 설명이 없으면 직업명 기반 기본 설명 생성
  if (jobName) {
    return `${jobName}은(는) 전문적인 지식과 기술이 필요한 직업입니다.`
  }
  return undefined
}

// ============================================
// 벡터 검색 결과를 ScoredJob 형태로 변환
// ============================================
export async function vectorResultsToScoredJobs(
  db: D1Database,
  vectorResults: VectorSearchResult[],
  miniModule?: any
): Promise<Array<{
  job_id: string
  job_name: string
  slug?: string
  image_url?: string
  job_description?: string
  base_like: number
  base_can: number
  base_risk: number
  like_score?: number
  can_score?: number
  risk_penalty?: number
  final_score?: number
  attributes: Record<string, number | string>
}>> {
  if (vectorResults.length === 0) return []

  // 벡터 결과의 job_id로 job_attributes + jobs 조인 조회
  // D1/SQLite는 최대 999개 변수만 허용하므로 batch 처리
  const BATCH_SIZE = 100  // D1 안정성을 위해 100개씩
  const jobIds = vectorResults.map(v => v.job_id)

  // v3.10.6: batch 병렬 조회 (순차 → Promise.all로 최적화)
  const batches: string[][] = []
  for (let i = 0; i < jobIds.length; i += BATCH_SIZE) {
    batches.push(jobIds.slice(i, i + BATCH_SIZE))
  }

  const batchPromises = batches.map(batchIds => {
    const placeholders = batchIds.map(() => '?').join(',')
    return db.prepare(`
      SELECT
        ja.job_id, ja.job_name,
        j.slug, j.image_url, j.api_data_json, j.merged_profile_json,
        ja.wlb, ja.growth, ja.stability, ja.income,
        ja.teamwork, ja.solo_deep, ja.analytical, ja.creative, ja.execution, ja.people_facing,
        ja.work_hours, ja.shift_work, ja.travel, ja.remote_possible,
        ja.degree_required, ja.license_required
      FROM job_attributes ja
      LEFT JOIN jobs j ON ja.job_id = j.id
      WHERE ja.job_id IN (${placeholders})
    `).bind(...batchIds).all<{
    job_id: string
    job_name: string
    slug: string | null
    image_url: string | null
    api_data_json: string | null
    merged_profile_json: string | null
    wlb: number
    growth: number
    stability: number
    income: number
    teamwork: number
    solo_deep: number
    analytical: number
    creative: number
    execution: number
    people_facing: number
    work_hours: string
    shift_work: string
    travel: string
    remote_possible: string
    degree_required: string
    license_required: string
  }>()
  })

  const batchResults = await Promise.all(batchPromises)
  const allAttributeResults: any[] = []
  for (const batchResult of batchResults) {
    if (batchResult.results) {
      allAttributeResults.push(...batchResult.results)
    }
  }

  const attributesMap = new Map(
    allAttributeResults.map(row => [row.job_id, row])
  )

  // job_attributes에 없는 job_id들을 찾아서 jobs 테이블에서 직접 조회
  const missingJobIds = jobIds.filter(id => !attributesMap.has(id))
  if (missingJobIds.length > 0) {

    // v3.10.6: fallback도 병렬 조회
    const missingBatches: string[][] = []
    for (let i = 0; i < missingJobIds.length; i += BATCH_SIZE) {
      missingBatches.push(missingJobIds.slice(i, i + BATCH_SIZE))
    }

    const fallbackPromises = missingBatches.map(batchIds => {
      const placeholders = batchIds.map(() => '?').join(',')
      return db.prepare(`
        SELECT id as job_id, name as job_name, slug, image_url, api_data_json, merged_profile_json
        FROM jobs
        WHERE id IN (${placeholders})
      `).bind(...batchIds).all<{
        job_id: string
        job_name: string
        slug: string | null
        image_url: string | null
        api_data_json: string | null
        merged_profile_json: string | null
      }>()
    })

    const fallbackResults = await Promise.all(fallbackPromises)
    for (const fallbackResult of fallbackResults) {
      if (fallbackResult.results) {
        for (const row of fallbackResult.results) {
          attributesMap.set(row.job_id, {
            ...row,
            wlb: 50, growth: 50, stability: 50, income: 50,
            teamwork: 50, solo_deep: 50, analytical: 50, creative: 50, execution: 50, people_facing: 50,
            work_hours: 'regular', shift_work: 'none', travel: 'some', remote_possible: 'partial',
            degree_required: 'none', license_required: 'none', experience_required: 'none',
            _from_jobs_fallback: true,
          })
        }
      }
    }
  }

  // 벡터 점수 맵 (score로 정렬 유지)
  const vectorScoreMap = new Map(
    vectorResults.map(vr => [vr.job_id, vr.score])
  )
  
  // 벡터 점수를 기반으로 ScoredJob 생성
  return vectorResults.map(vr => {
    const attrs = attributesMap.get(vr.job_id) as any
    const vectorScore = vectorScoreMap.get(vr.job_id) || 0
    
    if (attrs) {
      const personalized = calculatePersonalizedBaseScores(attrs, miniModule)
      // v3.9.5: 벡터 유사도 보너스 축소 (이중 적용 버그 수정)
      // 기존: vectorScore*15 + final에 vectorScore*20 = 최대 35점 이중 적용
      // 수정: vectorScore*10만 base에 반영, final에는 추가 보너스 없음
      const vectorBonus = Math.round(vectorScore * 10)
      const baseLike = Math.min(100, personalized.like + vectorBonus)
      const baseCan = Math.min(100, personalized.can + Math.round(vectorBonus * 0.5))
      const baseRisk = 10

      // 미태깅 직업 페널티: job_attributes 없이 기본값 50으로 채워진 직업은 순위 하락
      const isUntagged = !!(attrs as any)?._from_jobs_fallback
      const untaggedPenalty = isUntagged ? -25 : 0

      // ksco_major 추출 (카테고리 다양성 보장용)
      let kscoMajor = ''
      if (attrs.merged_profile_json) {
        try {
          const profile = JSON.parse(attrs.merged_profile_json)
          kscoMajor = profile.ksco_major || profile.kscoMajor || ''
        } catch {}
      }

      return {
        job_id: attrs.job_id,
        job_name: attrs.job_name,
        slug: attrs.slug || undefined,
        image_url: attrs.image_url || undefined,
        job_description: extractJobDescription(attrs.api_data_json, attrs.merged_profile_json, attrs.job_name),
        base_like: baseLike,
        base_can: baseCan,
        base_risk: baseRisk,
        like_score: baseLike,
        can_score: baseCan,
        risk_penalty: baseRisk,
        // v3.9.5: vectorScore*20 이중 적용 제거 — 벡터 보너스는 baseLike/baseCan에만 반영
        final_score: Math.round(0.55 * baseLike + 0.45 * baseCan - baseRisk) + untaggedPenalty,
        ksco_major: kscoMajor,
        attributes: {
          wlb: attrs.wlb,
          growth: attrs.growth,
          stability: attrs.stability,
          income: attrs.income,
          remote: attrs.remote_possible === 'full' ? 100 : attrs.remote_possible === 'partial' ? 50 : 0,
          solo_work: attrs.solo_deep,
          solo_deep: attrs.solo_deep,
          people_facing: attrs.people_facing,
          analytical: attrs.analytical,
          creative: attrs.creative,
          execution: attrs.execution,
          teamwork: attrs.teamwork,
          work_hours: attrs.work_hours,
          shift_work: attrs.shift_work,
          degree_required: attrs.degree_required,
          license_required: attrs.license_required,
          ksco_major: kscoMajor,
        },
      }
    }
    
    // 속성 정보가 없는 경우 기본값
    const baseLike = Math.round(50 + vr.score * 20)
    return {
      job_id: vr.job_id,
      job_name: vr.job_name,
      slug: undefined,
      image_url: undefined,
      base_like: baseLike,
      base_can: 50,
      base_risk: 15,
      like_score: baseLike,
      can_score: 50,
      risk_penalty: 15,
      final_score: Math.round(baseLike + 50 - 15),
      attributes: {
        wlb: 50,
        growth: 50,
        stability: 50,
        income: 50,
        remote: 50,
        solo_work: 50,
        solo_deep: 50,
        people_facing: 50,
        analytical: 50,
        creative: 50,
        execution: 50,
        teamwork: 50,
        work_hours: 'regular',
        shift_work: 'none',
        degree_required: 'none',
        license_required: 'none',
        ksco_major: '',
      },
    }
  })
}

// ============================================
// V3: SearchProfile 기반 검색 (2026-01 리팩토링)
// ============================================
import type { SearchProfile, NarrativeFacts, RoundAnswer } from './types'

export interface SearchProfileInput {
  narrativeFacts?: NarrativeFacts
  roundAnswers?: RoundAnswer[]
  universalAnswers?: Record<string, string | string[]>
  careerState?: {
    role_identity: string
    career_stage_years: string
    transition_status: string
  }
}

// V3: SearchProfile 생성 (rule-based, LLM 없이)
export function buildSearchProfile(input: SearchProfileInput): SearchProfile {
  const { narrativeFacts, roundAnswers, universalAnswers, careerState } = input
  
  const desiredThemes: string[] = []
  const dislikedThemes: string[] = []
  const strengthsHypothesis: string[] = []
  const environmentPreferences: string[] = []
  const hardConstraints: string[] = []
  const riskSignals: string[] = []
  const keywords: string[] = []
  
  // 1. Universal Answers에서 추출
  if (universalAnswers) {
    // 관심사
    const interest = universalAnswers['univ_interest']
    if (interest) {
      const arr = Array.isArray(interest) ? interest : [interest]
      desiredThemes.push(...arr)
      keywords.push(...arr)
    }
    
    // 싫어하는 것
    const dislike = universalAnswers['univ_dislike']
    if (dislike) {
      const arr = Array.isArray(dislike) ? dislike : [dislike]
      dislikedThemes.push(...arr)
    }
    
    // 강점
    const strength = universalAnswers['univ_strength']
    if (strength) {
      const arr = Array.isArray(strength) ? strength : [strength]
      strengthsHypothesis.push(...arr)
      keywords.push(...arr)
    }
    
    // 환경 선호
    const environment = universalAnswers['univ_environment']
    if (environment) {
      environmentPreferences.push(environment as string)
    }
    
    // 제약조건
    const constraintTime = universalAnswers['univ_constraint_time']
    if (constraintTime) {
      const arr = Array.isArray(constraintTime) ? constraintTime : [constraintTime]
      hardConstraints.push(...arr)
    }
    
    const constraintLocation = universalAnswers['univ_constraint_location']
    if (constraintLocation) {
      const arr = Array.isArray(constraintLocation) ? constraintLocation : [constraintLocation]
      hardConstraints.push(...arr)
    }
    
    // 우선순위
    const priority = universalAnswers['univ_priority']
    if (priority) {
      desiredThemes.push(priority as string)
    }
  }
  
  // 2. 서술형 답변에서 키워드 추출 (간단한 rule-based)
  if (narrativeFacts) {
    const extractKeywords = (text: string): string[] => {
      // 간단한 키워드 추출 (한국어 명사 패턴)
      const patterns = [
        '성장', '배움', '자율', '안정', '도전', '창의', '분석', '협업', '소통',
        '기술', 'IT', '개발', '디자인', '마케팅', '영업', '관리', '연구',
        '사람', '혼자', '팀', '자유', '규칙', '루틴', '변화',
        '인정', '성취', '의미', '보람', '돈', '여유', '건강'
      ]
      return patterns.filter(p => text.includes(p))
    }
    
    if (narrativeFacts.highAliveMoment) {
      const kw = extractKeywords(narrativeFacts.highAliveMoment)
      desiredThemes.push(...kw)
      keywords.push(...kw)
    }
    
    if (narrativeFacts.lostMoment) {
      const kw = extractKeywords(narrativeFacts.lostMoment)
      dislikedThemes.push(...kw)
      riskSignals.push(...kw)
    }
  }
  
  // 3. 라운드 답변에서 추출
  if (roundAnswers && roundAnswers.length > 0) {
    for (const ans of roundAnswers) {
      const text = ans.answer || ''
      
      // Round 1 (ENGINE) - 원하는 것
      if (ans.roundNumber === 1) {
        const kw = text.split(/[,\s]+/).filter(w => w.length > 1).slice(0, 5)
        keywords.push(...kw)
      }
      
      // Round 2 (AVOIDANCE) - 피하고 싶은 것
      if (ans.roundNumber === 2) {
        const kw = text.split(/[,\s]+/).filter(w => w.length > 1).slice(0, 3)
        riskSignals.push(...kw)
      }
    }
  }
  
  // 4. 커리어 상태에서 키워드 추가
  if (careerState) {
    if (careerState.transition_status === 'changer' || careerState.transition_status === 'returner') {
      keywords.push('전환', '새로운')
    }
    if (careerState.career_stage_years === 'student') {
      keywords.push('신입', '초보', '입문')
    }
  }
  
  // 중복 제거
  return {
    desiredThemes: [...new Set(desiredThemes)],
    dislikedThemes: [...new Set(dislikedThemes)],
    strengthsHypothesis: [...new Set(strengthsHypothesis)],
    environmentPreferences: [...new Set(environmentPreferences)],
    hardConstraints: [...new Set(hardConstraints)],
    riskSignals: [...new Set(riskSignals)],
    keywords: [...new Set(keywords)],
  }
}

// ============================================
// LLM 기반 벡터 검색 쿼리 동적 생성
// ============================================
// 정적 토큰→키워드 매핑 대신 GPT-4o-mini가 유저 프로파일을 보고
// 적합한 직업 카테고리/직업명을 자동 추론합니다.
// 비용: ~$0.001/call, 시간: ~1-2초
// ============================================

const LLM_SEARCH_QUERY_PROMPT = `당신은 한국 직업 전문가입니다. 사용자의 프로파일을 보고, 이 사람에게 적합할 수 있는 한국 직업 카테고리와 구체적 직업명을 나열해주세요.

규칙:
1. 직업 카테고리 5~8개, 구체적 직업명 25~30개를 나열
2. 한국어로 작성 (예: 공무원, 행정사무원, 데이터분석가)
3. 사용자의 흥미, 가치관, 강점, 제약조건을 모두 고려
4. ★★★ 반드시 누구나 아는 주류 직업 위주로 출력하세요!
   - 주류 직업 = 취업포털에서 쉽게 검색되는 직업 (예: UX디자이너, 서비스기획자, 소프트웨어개발자, 경영컨설턴트, 연구원, 마케터, 교사, 간호사 등)
   - 최소 20개는 주류 직업이어야 합니다
   - 숨겨진 틈새 직업은 5개 이하로 제한
5. ❌ 금지: 특정 소재/재료 기반 세부 직종 (예: 고무제품개발자, 바이오화학제품○○자, 석유화학○○자, 단청기술자 등)
   → 사용자가 해당 분야를 명시적으로 언급하지 않았다면 절대 포함 금지
6. 제약조건이 있으면 그에 맞는 현실적인 직업 위주로
7. 쉼표로 구분하여 한 줄로 출력
8. 설명이나 번호 없이 직업명/카테고리만 나열`

export async function buildLLMSearchQuery(
  miniModule: MiniModuleResult,
  openaiApiKey: string
): Promise<string> {
  // 유저 프로파일을 자연어로 변환
  const profileParts: string[] = []

  if (miniModule.interest_top?.length) {
    profileParts.push(`흥미: ${miniModule.interest_top.join(', ')}`)
  }
  if (miniModule.value_top?.length) {
    profileParts.push(`가치관: ${miniModule.value_top.join(', ')}`)
  }
  if (miniModule.strength_top?.length) {
    profileParts.push(`강점: ${miniModule.strength_top.join(', ')}`)
  }
  if (miniModule.workstyle_top?.length) {
    profileParts.push(`업무스타일: ${miniModule.workstyle_top.join(', ')}`)
  }
  if (miniModule.constraint_flags?.length) {
    profileParts.push(`제약조건: ${miniModule.constraint_flags.join(', ')}`)
  }
  if (miniModule.energy_drain_flags?.length) {
    profileParts.push(`에너지소모: ${miniModule.energy_drain_flags.join(', ')}`)
  }
  if (miniModule.sacrifice_flags?.length) {
    profileParts.push(`감수가능: ${miniModule.sacrifice_flags.join(', ')}`)
  }
  if (miniModule.background_flags?.length) {
    profileParts.push(`배경: ${miniModule.background_flags.join(', ')}`)
  }
  if (miniModule.persistence_anchor) {
    profileParts.push(`지속동기: ${miniModule.persistence_anchor}`)
  }
  if (miniModule.failure_response) {
    profileParts.push(`실패반응: ${miniModule.failure_response}`)
  }

  if (profileParts.length === 0) {
    throw new Error('[LLM Search Query] miniModule에 프로파일 데이터가 없습니다')
  }

  const userMessage = `사용자 프로파일:\n${profileParts.join('\n')}`

  const response = await fetch('https://gateway.ai.cloudflare.com/v1/3587865378649966bfb0a814fce73c77/careerwiki/openai/chat/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${openaiApiKey}`,
    },
    body: JSON.stringify({
      model: 'gpt-4o-mini',
      messages: [
        { role: 'system', content: LLM_SEARCH_QUERY_PROMPT },
        { role: 'user', content: userMessage },
      ],
      temperature: 0.3,
      max_tokens: 300,
    }),
  })

  if (!response.ok) {
    const body = await response.text().catch(() => '')
    throw new Error(`[LLM Search Query] API error ${response.status}: ${body.substring(0, 200)}`)
  }

  const data = await response.json() as any
  const content = data.choices?.[0]?.message?.content?.trim()

  if (!content) {
    throw new Error('[LLM Search Query] LLM 응답이 비어있습니다')
  }

  const llmQuery = `적합 직업: ${content}`.substring(0, 500)


  return llmQuery
}

// ============================================
// v3.9.5: 커리어 아키타입 쿼리 빌더
// 흥미+가치 조합에서 주류 직업군 쿼리를 생성하여
// 벡터 검색에서 누구나 아는 직업이 후보에 포함되도록 보장
// ============================================
function buildArchetypeQueries(miniModule: MiniModuleResult): string[] {
  const interests = miniModule.interest_top || []
  const values = miniModule.value_top || []

  // 흥미×가치 조합 → 주류 직업 쿼리 맵
  // 각 조합은 한국 취업시장에서 실제 존재하는 대표 직업 4-6개
  const ARCHETYPE_MAP: Record<string, Record<string, string>> = {
    creating: {
      autonomy: 'UX디자이너 서비스기획자 콘텐츠기획자 브랜드디자이너 영상편집자',
      growth: 'UX디자이너 프로덕트디자이너 게임기획자 광고기획자 콘텐츠전략가',
      stability: 'UX디자이너 인테리어디자이너 편집디자이너 공간디자이너 웹디자이너',
      wlb: 'UX디자이너 웹디자이너 편집디자이너 콘텐츠기획자 그래픽디자이너',
      income: '광고감독 크리에이티브디렉터 브랜드매니저 UX디렉터 아트디렉터',
      meaning: '교육콘텐츠기획자 문화기획자 공공디자이너 사회혁신디자이너',
      recognition: 'UX디렉터 크리에이티브디렉터 아트디렉터 프로덕트디자이너',
    },
    problem_solving: {
      autonomy: '경영컨설턴트 UX리서처 데이터분석가 전략기획자 프리랜서컨설턴트',
      growth: '경영컨설턴트 전략기획자 데이터사이언티스트 사업개발매니저 투자분석가',
      stability: '공공정책분석가 연구원 품질관리전문가 시스템분석가 감사관',
      wlb: '연구원 품질관리전문가 공공정책분석가 데이터분석가 시스템분석가',
      income: '경영컨설턴트 투자분석가 전략기획임원 데이터사이언티스트 기술컨설턴트',
      meaning: '정책연구원 사회문제해결전문가 비영리컨설턴트 교육혁신가',
      recognition: '경영컨설턴트 전략기획자 연구원 기술자문위원',
    },
    data_numbers: {
      autonomy: '데이터분석가 통계컨설턴트 퀀트분석가 BI분석가 리서치애널리스트',
      growth: '데이터사이언티스트 AI엔지니어 머신러닝엔지니어 데이터엔지니어',
      stability: '통계분석전문가 보험계리사 재무분석가 공공데이터분석가',
      wlb: '통계분석전문가 재무분석가 공공데이터분석가 경리사무원 회계사무원',
      income: '퀀트분석가 데이터사이언티스트 AI엔지니어 금융공학전문가',
      meaning: '보건통계분석가 사회조사분석사 공공데이터분석가 교육평가연구원',
      recognition: '데이터사이언티스트 AI연구원 통계학자 데이터아키텍트',
    },
    helping_teaching: {
      autonomy: '상담심리사 코치 교육컨설턴트 사회복지사 진로상담사',
      growth: '교육기획자 HRD전문가 조직개발컨설턴트 상담심리사',
      stability: '교사 공무원 사회복지사 간호사 상담교사',
      wlb: '교사 사회복지사 상담교사 보건교사 사서 학교상담사',
      income: '임상심리전문가 조직개발컨설턴트 HRD매니저 의사',
      meaning: '사회복지사 상담심리사 NGO활동가 교육혁신가 청소년지도사',
      recognition: '임상심리전문가 교수 교육전문가 상담심리사',
    },
    organizing: {
      autonomy: '프로젝트매니저 경영기획자 전략기획자 사업개발매니저',
      growth: '경영기획자 사업개발매니저 프로덕트매니저 전략기획자',
      stability: '행정관리자 공무원 총무관리자 인사담당자 경영지원',
      wlb: '행정사무원 총무관리자 인사담당자 경리사무원 공무원 사무관리자',
      income: '경영기획임원 사업개발이사 프로그램디렉터 경영관리자',
      meaning: '비영리경영자 공공기관관리자 사회적기업매니저 협동조합운영자',
      recognition: '경영기획자 프로젝트디렉터 전략기획임원',
    },
    influencing: {
      autonomy: '마케터 브랜드매니저 홍보전문가 콘텐츠마케터 퍼포먼스마케터',
      growth: '마케팅전략가 브랜드매니저 디지털마케터 그로스해커',
      stability: '홍보담당자 마케팅관리자 광고대행사기획자 사내커뮤니케이션',
      wlb: '홍보담당자 마케팅관리자 사내커뮤니케이션 콘텐츠마케터',
      income: 'CMO 마케팅이사 브랜드디렉터 세일즈디렉터',
      meaning: '사회마케팅전문가 공익캠페인기획자 비영리홍보전문가',
      recognition: '브랜드디렉터 마케팅전략가 PR전문가 광고크리에이터',
    },
    tech: {
      autonomy: '소프트웨어개발자 풀스택개발자 프리랜서개발자 DevOps엔지니어',
      growth: '소프트웨어엔지니어 백엔드개발자 AI엔지니어 클라우드아키텍트',
      stability: '시스템엔지니어 IT인프라관리자 정보보안전문가 DBA',
      wlb: '시스템엔지니어 IT인프라관리자 DBA 정보보안전문가 웹개발자',
      income: 'CTO 시니어개발자 AI엔지니어 클라우드아키텍트 보안컨설턴트',
      meaning: '에듀테크개발자 헬스테크개발자 오픈소스개발자 접근성전문가',
      recognition: 'CTO 테크리드 소프트웨어아키텍트 AI연구원',
    },
    routine: {
      autonomy: '사무관리자 재무회계사 세무사 행정사',
      growth: '회계사 세무사 법무사 노무사 감정평가사',
      stability: '공무원 은행원 회계사 행정직 사무관리자',
      wlb: '공무원 은행원 행정사무원 경리사무원 사무관리자 총무',
      income: '회계사 세무사 변리사 감정평가사 법무사',
      meaning: '공공행정가 시민서비스전문가 법률구조사',
      recognition: '공인회계사 세무사 행정전문가',
    },
  }

  const queries: string[] = []
  const seen = new Set<string>()

  // v3.9.9: 상위 흥미 3개 × 상위 가치 3개 조합 (2×2→3×3 확장)
  for (const interest of interests.slice(0, 3)) {
    for (const value of values.slice(0, 3)) {
      const query = ARCHETYPE_MAP[interest]?.[value]
      if (query && !seen.has(query)) {
        seen.add(query)
        queries.push(query)
      }
    }
  }

  // v3.9.9: 최대 5개로 확장 (3→5, 주류 직업 커버리지 향상)
  return queries.slice(0, 5)
}

// ============================================
// Multi-Search 쿼리 생성 (LLM 쿼리 분할 + 차원별 키워드)
// 10-12개 쿼리로 벡터 공간의 다양한 영역 탐색
// ============================================
export async function buildMultiSearchQueries(
  miniModule: MiniModuleResult,
  openaiApiKey: string
): Promise<string[]> {
  // 1. 기존 LLM 쿼리 (종합 직업명 리스트)
  const llmQuery = await buildLLMSearchQuery(miniModule, openaiApiKey)

  // 2. LLM 출력을 3-5개씩 분할하여 서브쿼리 생성
  // "적합 직업: A, B, C, D, E, ..." → ["A, B, C", "D, E, F", ...]
  const rawContent = llmQuery.replace(/^적합 직업:\s*/, '')
  const jobNames = rawContent.split(/[,，、]/).map(s => s.trim()).filter(Boolean)
  const chunkSize = Math.max(3, Math.ceil(jobNames.length / 5))
  const subQueries: string[] = []
  for (let i = 0; i < jobNames.length; i += chunkSize) {
    subQueries.push(jobNames.slice(i, i + chunkSize).join(', '))
  }

  // 3. 차원별 키워드 쿼리 추가 (한국어 변환 + 규칙 기반)
  // v3.9.5: 영어 토큰 → 한국어 라벨 변환 (벡터 매칭 정확도 향상)
  const INTEREST_KR: Record<string, string> = {
    creating: '창작 예술 디자인 기획', problem_solving: '문제해결 분석 컨설팅',
    data_numbers: '데이터분석 통계', helping_teaching: '교육 상담 복지',
    organizing: '기획 관리 행정', influencing: '마케팅 영업 홍보',
    tech: '기술 IT 프로그래밍 개발', routine: '사무 행정 정규업무',
  }
  const STRENGTH_KR: Record<string, string> = {
    analytical: '분석력 논리적사고', creative: '창의성 아이디어',
    communication: '소통 커뮤니케이션', structured_execution: '실행력 체계적',
    persistence: '끈기 지속력', fast_learning: '학습능력 빠른습득',
  }
  const VALUE_KR: Record<string, string> = {
    growth: '성장 발전 커리어성장', stability: '안정 정규직 정시퇴근',
    income: '높은연봉 수입', autonomy: '자율 독립 재량',
    meaning: '보람 사회기여', recognition: '인정 전문성',
  }

  const dimensionQueries: string[] = []
  if (miniModule.interest_top?.length) {
    const krInterests = miniModule.interest_top.map((t: string) => INTEREST_KR[t] || t).join(' ')
    dimensionQueries.push(`${krInterests} 관련 직업`)
  }
  if (miniModule.strength_top?.length) {
    const krStrengths = miniModule.strength_top.map((t: string) => STRENGTH_KR[t] || t).join(' ')
    dimensionQueries.push(`${krStrengths} 역량이 필요한 직업`)
  }
  if (miniModule.value_top?.length) {
    const krValues = miniModule.value_top.map((t: string) => VALUE_KR[t] || t).join(' ')
    dimensionQueries.push(`${krValues} 환경의 직업`)
  }

  // 4. 커리어 아키타입 쿼리 (흥미+가치 조합 → 주류 직업군 보장)
  const archetypeQueries = buildArchetypeQueries(miniModule)

  // 5. 모든 쿼리 결합 (종합 + 서브쿼리 + 차원별 + 아키타입)
  const allQueries = [
    llmQuery,            // 종합 (가장 중요)
    ...subQueries,       // LLM 출력 분할 (5-8개)
    ...dimensionQueries, // 흥미/강점/가치 한국어 차원 (2-3개)
    ...archetypeQueries, // 주류 커리어 패스 보장 (1-3개)
  ]


  return allQueries
}

// V3: SearchProfile → 검색 쿼리 변환 (정적 키워드 기반 - fallback용)
export function searchProfileToQuery(profile: SearchProfile): string {
  const parts: string[] = []
  
  if (profile.desiredThemes.length > 0) {
    parts.push(`원하는 것: ${profile.desiredThemes.join(', ')}`)
  }
  
  if (profile.strengthsHypothesis.length > 0) {
    parts.push(`강점: ${profile.strengthsHypothesis.join(', ')}`)
  }
  
  if (profile.keywords.length > 0) {
    parts.push(profile.keywords.join(' '))
  }
  
  if (profile.environmentPreferences.length > 0) {
    parts.push(`환경: ${profile.environmentPreferences.join(', ')}`)
  }
  
  if (parts.length === 0) {
    return '직업 추천 적합한 일자리'
  }
  
  return parts.join(' ').substring(0, 500)
}

// ============================================
// V3: SearchProfile 기반 후보군 확장 (OpenAI Embedding)
// ============================================
// 2026-01-26: 태깅 의존도 완전 제거
// - 벡터 검색 결과만 사용
// - minTaggedJobs 옵션 제거
// ============================================
export async function expandCandidatesV3(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  openaiApiKey: string | undefined,
  searchProfile: SearchProfile,
  options: {
    targetSize?: number
    miniModule?: MiniModuleResult
  } = {}
): Promise<CandidateExpansionResult> {
  const { targetSize = 500, miniModule } = options
  const startTime = Date.now()

  // Vectorize 또는 OpenAI API 키가 없으면 fallback
  if (!vectorize || !openaiApiKey) {
    const fallbackResult = await getFallbackCandidatesV3(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }

  // 1. LLM 기반 검색 쿼리 생성 (필수 - 실패 시 에러)
  if (!miniModule) {
    throw new Error('[V3 Vectorize] miniModule이 필수입니다 - LLM 검색 쿼리 생성에 필요')
  }

  const queries = await buildMultiSearchQueries(miniModule, openaiApiKey)

  // 2. 벡터 검색 (Multi-Query 병렬 검색, OpenAI Embedding)
  // Vectorize 로컬 실행 불가 시 DB fallback (wrangler pages dev 한계)
  try {
    const vectorResults = await searchCandidatesMultiQuery(vectorize, openaiApiKey, queries)

    const candidates = vectorResults.map(vr => ({
      ...vr,
      metadata: { ...vr.metadata, source: 'vector_search', query_source: 'llm' },
    }))

    return {
      candidates,
      total_searched: vectorResults.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: false,
    }
  } catch (vecError: any) {
    // Vectorize 로컬 바인딩 에러 → DB fallback (production에서는 발생하지 않음)
    if (vecError?.message?.includes('remotely') || vecError?.message?.includes('Vectorize')) {
      const fallbackResult = await getFallbackCandidatesV3(db, targetSize)
      return {
        candidates: fallbackResult,
        total_searched: fallbackResult.length,
        search_duration_ms: Date.now() - startTime,
        fallback_used: true,
      }
    }
    throw vecError  // 다른 에러는 그대로 전파
  }
}

// V3: Fallback - jobs 테이블에서 직접 조회 (태깅 무관)
async function getFallbackCandidatesV3(
  db: D1Database,
  limit: number
): Promise<VectorSearchResult[]> {
  const result = await db.prepare(`
    SELECT id, name
    FROM jobs
    WHERE is_active = 1 AND merged_profile_json IS NOT NULL
    ORDER BY RANDOM()
    LIMIT ?
  `).bind(limit).all<{ id: string; name: string }>()
  
  return (result.results || []).map((row, idx) => ({
    job_id: row.id,
    job_name: row.name,
    score: 0.5 - (idx * 0.0001), // 랜덤 순서 유지
    metadata: { source: 'fallback_v3' },
  }))
}

// ============================================
// P1-2: SearchProfile 캐시 버전화 (answers_hash)
// ============================================

/**
 * P1-2: 사용자 답변을 기반으로 해시 생성
 * 답변이 변경되면 다른 해시가 생성되어 캐시가 무효화됨
 */
export function computeAnswersHash(
  narrativeFacts?: NarrativeFacts,
  roundAnswers?: RoundAnswer[],
  universalAnswers?: Record<string, string | string[]>
): string {
  const content = JSON.stringify({
    n: narrativeFacts || null,
    r: (roundAnswers || []).map(a => ({ r: a.roundNumber, q: a.questionId, a: a.answer })),
    u: universalAnswers || {},
  })
  
  // 간단한 해시 함수 (DJB2 알고리즘)
  let hash = 5381
  for (let i = 0; i < content.length; i++) {
    hash = ((hash << 5) + hash) + content.charCodeAt(i)
    hash = hash & hash // 32bit 정수로 변환
  }
  
  return Math.abs(hash).toString(36)
}

/**
 * P1-2: SearchProfile 캐시 조회 (버전화된 키 사용)
 */
export async function getCachedSearchProfile(
  db: D1Database,
  sessionId: string,
  answersHash: string
): Promise<SearchProfile | null> {
  try {
    const cached = await db.prepare(`
      SELECT profile_json FROM search_profile_cache 
      WHERE session_id = ? AND answers_hash = ?
    `).bind(sessionId, answersHash).first<{ profile_json: string }>()
    
    if (cached?.profile_json) {
      return JSON.parse(cached.profile_json)
    }
  } catch (error) {
  }
  
  return null
}

/**
 * P1-2: SearchProfile 캐시 저장 (버전화된 키 사용)
 */
export async function cacheSearchProfile(
  db: D1Database,
  sessionId: string,
  answersHash: string,
  profile: SearchProfile
): Promise<void> {
  try {
    await db.prepare(`
      INSERT INTO search_profile_cache (session_id, answers_hash, profile_json)
      VALUES (?, ?, ?)
      ON CONFLICT(session_id, answers_hash) DO UPDATE SET 
        profile_json = excluded.profile_json,
        created_at = datetime('now')
    `).bind(sessionId, answersHash, JSON.stringify(profile)).run()
    
  } catch (error) {
    // 캐시 저장 실패는 치명적이지 않음
  }
}

// ============================================
// Freeze v1.1: 증분 업서트 시스템
// ============================================
// 신규/변경 직업만 Vectorize에 반영
// indexed_at/embedding_version 컬럼 기반
// ============================================

/**
 * 증분 업서트: 신규 또는 버전 불일치 직업만 인덱싱
 */
export async function incrementalUpsertToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  options: {
    batchSize?: number
    maxJobs?: number
  } = {}
): Promise<{ upserted: number; errors: number; skipped: number }> {
  const { batchSize = 50, maxJobs = 500 } = options
  const CURRENT_VERSION = `JPC_${JOB_PROFILE_COMPACT_VERSION}`
  
  
  let upserted = 0
  let errors = 0
  let skipped = 0
  let offset = 0
  
  while (upserted + skipped < maxJobs) {
    // 신규 또는 버전 불일치 직업 조회
    const jobs = await db.prepare(`
      SELECT id, name, merged_profile_json
      FROM jobs
      WHERE is_active = 1
        AND (indexed_at IS NULL OR embedding_version != ?)
      ORDER BY id
      LIMIT ? OFFSET ?
    `).bind(CURRENT_VERSION, batchSize, offset).all<{
      id: string
      name: string
      merged_profile_json: string | null
    }>()

    if (!jobs.results || jobs.results.length === 0) {
      break
    }

    // 인덱싱 텍스트 생성 (category는 merged_profile_json에서 추출)
    const textsForEmbedding = jobs.results.map(job => {
      let category: string | null = null
      if (job.merged_profile_json) {
        try {
          const p = JSON.parse(job.merged_profile_json)
          category = p.category || p.heroCategory || p.분류 || null
        } catch {}
      }
      const profileData = parseJobProfileFromMergedJson(
        job.id,
        job.name,
        job.merged_profile_json,
        category
      )
      return buildJobProfileCompact(profileData)
    })

    try {
      // OpenAI Embedding 생성
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)

      // Vectorize에 upsert
      const vectors = jobs.results.map((job, idx) => {
        let category = ''
        let kscoMajor: string | undefined
        let kscoMid: string | undefined
        let educationLevel: string | undefined

        if (job.merged_profile_json) {
          try {
            const profile = JSON.parse(job.merged_profile_json)
            category = profile.category || profile.heroCategory || profile.분류 || ''
            kscoMajor = profile.ksco_major || profile.kscoMajor
            kscoMid = profile.ksco_mid || profile.kscoMid
            educationLevel = profile.education_level || profile.educationLevel
          } catch {}
        }

        return {
          id: job.id,
          values: embeddings[idx],
          metadata: {
            job_name: job.name,
            category,
            ksco_major: kscoMajor || '',
            ksco_mid: kscoMid || '',
            education_level: educationLevel || '',
            embedding_version: JOB_PROFILE_COMPACT_VERSION,
          },
        }
      })
      
      await vectorize.upsert(vectors)
      
      // D1에 인덱싱 상태 업데이트
      for (const job of jobs.results) {
        await db.prepare(`
          UPDATE jobs 
          SET indexed_at = datetime('now'), embedding_version = ?
          WHERE id = ?
        `).bind(CURRENT_VERSION, job.id).run()
      }
      
      upserted += jobs.results.length
      
    } catch (error) {
      errors += jobs.results.length
    }
    
    offset += batchSize
    
    // Rate limit
    await new Promise(resolve => setTimeout(resolve, 1000))
  }
  
  
  return { upserted, errors, skipped }
}

/**
 * 인덱싱이 필요한 직업 수 확인
 */
export async function countJobsNeedingIndexing(
  db: D1Database
): Promise<{ total: number; needsIndexing: number; upToDate: number }> {
  const CURRENT_VERSION = `JPC_${JOB_PROFILE_COMPACT_VERSION}`
  
  const totalResult = await db.prepare(`
    SELECT COUNT(*) as count FROM jobs WHERE is_active = 1
  `).first<{ count: number }>()
  
  const needsResult = await db.prepare(`
    SELECT COUNT(*) as count FROM jobs 
    WHERE is_active = 1 
      AND (indexed_at IS NULL OR embedding_version != ?)
  `).bind(CURRENT_VERSION).first<{ count: number }>()
  
  const total = totalResult?.count || 0
  const needsIndexing = needsResult?.count || 0
  const upToDate = total - needsIndexing
  
  return { total, needsIndexing, upToDate }
}

/**
 * P1-2: SearchProfile 기반 후보군 확장 (캐시 사용)
 * V3 Enhancement: TAG Pre-Filter 지원 추가
 * OpenAI Embedding 사용
 * 
 * 2026-01-26: 태깅 의존도 완전 제거 (minTaggedJobs 옵션 제거)
 */
export async function expandCandidatesV3WithCache(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  openaiApiKey: string | undefined,
  profileInput: SearchProfileInput,
  options: {
    sessionId?: string
    targetSize?: number
    userConstraints?: UserConstraints  // Hard Constraint 필터용
    enableTagPreFilter?: boolean       // Pre-Filter 활성화 플래그
    miniModule?: MiniModuleResult      // LLM 검색 쿼리 생성용
  } = {}
): Promise<CandidateExpansionResult & {
  searchProfile: SearchProfile
  cacheHit: boolean
  preFilterResult?: PreFilterResult
}> {
  const { sessionId, targetSize = 500, userConstraints, enableTagPreFilter = false, miniModule } = options
  
  // P1-2: 답변 해시 계산
  const answersHash = computeAnswersHash(
    profileInput.narrativeFacts,
    profileInput.roundAnswers,
    profileInput.universalAnswers
  )
  
  // P1-2: 캐시된 SearchProfile 확인
  let searchProfile: SearchProfile | null = null
  let cacheHit = false
  
  if (sessionId) {
    searchProfile = await getCachedSearchProfile(db, sessionId, answersHash)
    if (searchProfile) {
      cacheHit = true
    }
  }
  
  // 캐시 미스 시 새로 생성
  if (!searchProfile) {
    searchProfile = buildSearchProfile(profileInput)
    
    // P1-2: 캐시 저장
    if (sessionId) {
      await cacheSearchProfile(db, sessionId, answersHash, searchProfile)
    }
  }
  
  // ============================================
  // V3 Enhancement: TAG Pre-Filter (RAG 전 적용)
  // ============================================
  let preFilterResult: PreFilterResult | undefined
  let excludedJobIds: Set<string> | undefined
  
  if (enableTagPreFilter && userConstraints) {
    preFilterResult = await preFilterByHardConstraints(db, userConstraints)
    excludedJobIds = preFilterResult.excludedJobIds
    
  }
  
  // 후보군 확장 (Pre-Filter 결과를 적용, OpenAI Embedding 사용)
  const result = await expandCandidatesV3WithPreFilter(
    db,
    vectorize,
    openaiApiKey,
    searchProfile,
    { targetSize, excludedJobIds, miniModule }
  )
  
  return {
    ...result,
    searchProfile,
    cacheHit,
    preFilterResult,
  }
}

/**
 * V3 Enhancement: Pre-Filter가 적용된 후보군 확장
 * excludedJobIds가 있으면 RAG 결과에서 제외
 * OpenAI Embedding 사용
 * 
 * 2026-01-26: 태깅 의존도 완전 제거 (minTaggedJobs 옵션 제거)
 */
async function expandCandidatesV3WithPreFilter(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  openaiApiKey: string | undefined,
  searchProfile: SearchProfile,
  options: {
    targetSize?: number
    excludedJobIds?: Set<string>
    miniModule?: MiniModuleResult
  } = {}
): Promise<CandidateExpansionResult> {
  const { targetSize = 500, excludedJobIds, miniModule } = options
  const startTime = Date.now()

  // Vectorize 또는 OpenAI API 키가 없으면 fallback
  if (!vectorize || !openaiApiKey) {
    let fallbackResult = await getFallbackCandidatesV3(db, targetSize)

    // Pre-Filter 적용
    if (excludedJobIds && excludedJobIds.size > 0) {
      fallbackResult = fallbackResult.filter(c => !excludedJobIds.has(c.job_id))
    }

    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }

  // 1. 검색 쿼리 생성: miniModule 있으면 Multi-Query (LLM+분할+차원별), 없으면 단일 정적 쿼리
  try {
    let vectorResults: VectorSearchResult[]

    if (miniModule) {
      const queries = await buildMultiSearchQueries(miniModule, openaiApiKey!)

      // 2. Multi-Query 병렬 벡터 검색 (각 topK=100, 중복 제거)
      vectorResults = await searchCandidatesMultiQuery(vectorize, openaiApiKey!, queries)
    } else {
      const query = searchProfileToQuery(searchProfile)

      // 2. 단일 쿼리 벡터 검색 (인터뷰 모드 fallback)
      vectorResults = await searchCandidates(vectorize, openaiApiKey!, query, 100)
    }

    // 3. Pre-Filter 적용 (제외 대상 제거)
    if (excludedJobIds && excludedJobIds.size > 0) {
      const beforeCount = vectorResults.length
      vectorResults = vectorResults.filter(r => !excludedJobIds.has(r.job_id))
    }

    // 4. targetSize로 제한
    const candidates = vectorResults.slice(0, targetSize)

    return {
      candidates,
      total_searched: vectorResults.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: false,
    }
  } catch (vecError: any) {
    if (vecError?.message?.includes('remotely') || vecError?.message?.includes('Vectorize')) {
      let fallbackResult = await getFallbackCandidatesV3(db, targetSize)
      if (excludedJobIds && excludedJobIds.size > 0) {
        fallbackResult = fallbackResult.filter(c => !excludedJobIds.has(c.job_id))
      }
      return {
        candidates: fallbackResult,
        total_searched: fallbackResult.length,
        search_duration_ms: Date.now() - startTime,
        fallback_used: true,
      }
    }
    throw vecError
  }
}

// ============================================
// 전공 추천 전용 벡터 파이프라인
// ============================================
// 기존 직업 추천 함수를 수정하지 않고, 전공 전용 함수만 정의
// major: prefix 벡터만 필터, major_attributes JOIN, 전공 스코어링
// ============================================

// 전공 벡터 검색 결과 타입
export interface MajorVectorSearchResult {
  major_id: string
  major_name: string
  score: number
  metadata?: Record<string, any>
}

export interface MajorCandidateExpansionResult {
  candidates: MajorVectorSearchResult[]
  total_searched: number
  search_duration_ms: number
  fallback_used: boolean
}

// ============================================
// 전공 벡터 검색 (Multi-Query) — major: prefix만 포함
// ============================================
export async function searchMajorCandidatesMultiQuery(
  vectorize: VectorizeIndex,
  openaiApiKey: string,
  queries: string[],
  topK: number = 100
): Promise<MajorVectorSearchResult[]> {
  // 1. 배치 임베딩
  const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, queries)

  // 2. 병렬 Vectorize 검색
  const clampedTopK = Math.min(topK, 100)
  const searchPromises = embeddings.map(emb =>
    vectorize.query(emb, { topK: clampedTopK, returnValues: false, returnMetadata: 'none' })
  )
  const searchResults = await Promise.all(searchPromises)

  // 3. 중복 제거 — major: prefix만 포함 (직업 검색과 정반대)
  const bestScoreMap = new Map<string, number>()
  const hitCountMap = new Map<string, number>()
  for (const result of searchResults) {
    for (const match of result.matches) {
      if (!match.id.startsWith('major:')) continue  // major: prefix만 포함
      const majorId = match.id.replace('major:', '')  // prefix 제거
      const existing = bestScoreMap.get(majorId)
      if (existing === undefined || match.score > existing) {
        bestScoreMap.set(majorId, match.score)
      }
      hitCountMap.set(majorId, (hitCountMap.get(majorId) || 0) + 1)
    }
  }

  // 4. 결과 변환 (히트카운트 보너스 포함)
  return Array.from(bestScoreMap.entries())
    .map(([id, score]) => {
      const hits = hitCountMap.get(id) || 1
      const hitBonus = hits >= 3 ? Math.min(0.05, (hits - 2) * 0.015) : 0
      return { id, score: Math.min(1.0, score + hitBonus), hits }
    })
    .sort((a, b) => b.score - a.score)
    .map(({ id, score }) => ({
      major_id: id,
      major_name: id,  // 실제 이름은 DB 조인에서 채움
      score,
      metadata: {} as Record<string, any>,
    }))
}

// ============================================
// 전공 LLM 검색 쿼리 생성
// ============================================
const LLM_MAJOR_SEARCH_QUERY_PROMPT = `당신은 한국 대학 전공/학과 전문가입니다. 사용자의 프로파일을 보고, 이 사람에게 적합할 수 있는 한국 대학 전공(학과)을 나열해주세요.

규칙:
1. 전공 카테고리 5~8개, 구체적 전공/학과명 25~30개를 나열
2. 한국어로 작성 (예: 컴퓨터공학과, 경영학과, 심리학과)
3. 사용자의 흥미, 가치관, 강점, 제약조건을 모두 고려
4. ★★★ 반드시 실제 한국 대학에 개설된 주류 전공 위주로 출력하세요!
   - 주류 전공 = 대부분 대학에 개설된 일반적 학과 (예: 컴퓨터공학, 경영학, 심리학, 간호학, 디자인학, 영문학, 화학공학 등)
   - 최소 20개는 주류 전공이어야 합니다
   - 특수/희소 전공은 5개 이하로 제한
5. ❌ 금지: 대학원 전용 세부 전공이나 존재하지 않는 학과명
6. 제약조건이 있으면 그에 맞는 현실적인 전공 위주로
7. 쉼표로 구분하여 한 줄로 출력
8. 설명이나 번호 없이 전공명만 나열`

export async function buildLLMMajorSearchQuery(
  miniModule: MiniModuleResult,
  openaiApiKey: string
): Promise<string> {
  const profileParts: string[] = []

  if (miniModule.interest_top?.length) {
    profileParts.push(`흥미: ${miniModule.interest_top.join(', ')}`)
  }
  if (miniModule.value_top?.length) {
    profileParts.push(`가치관: ${miniModule.value_top.join(', ')}`)
  }
  if (miniModule.strength_top?.length) {
    profileParts.push(`강점: ${miniModule.strength_top.join(', ')}`)
  }
  if (miniModule.workstyle_top?.length) {
    profileParts.push(`학습스타일: ${miniModule.workstyle_top.join(', ')}`)
  }
  if (miniModule.constraint_flags?.length) {
    profileParts.push(`제약조건: ${miniModule.constraint_flags.join(', ')}`)
  }
  if (miniModule.energy_drain_flags?.length) {
    profileParts.push(`에너지소모: ${miniModule.energy_drain_flags.join(', ')}`)
  }
  if (miniModule.sacrifice_flags?.length) {
    profileParts.push(`감수가능: ${miniModule.sacrifice_flags.join(', ')}`)
  }
  if (miniModule.persistence_anchor) {
    profileParts.push(`지속동기: ${miniModule.persistence_anchor}`)
  }

  if (profileParts.length === 0) {
    throw new Error('[LLM Major Search Query] miniModule에 프로파일 데이터가 없습니다')
  }

  const userMessage = `사용자 프로파일:\n${profileParts.join('\n')}`

  let response: Response | null = null
  for (let attempt = 0; attempt < 3; attempt++) {
    try {
      response = await fetch('https://gateway.ai.cloudflare.com/v1/3587865378649966bfb0a814fce73c77/careerwiki/openai/chat/completions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${openaiApiKey}`,
        },
        body: JSON.stringify({
          model: 'gpt-4o-mini',
          messages: [
            { role: 'system', content: LLM_MAJOR_SEARCH_QUERY_PROMPT },
            { role: 'user', content: userMessage },
          ],
          temperature: 0.3,
          max_tokens: 300,
        }),
      })
      if (response.ok) break
      if (response.status < 500) break // 4xx는 재시도하지 않음
    } catch (fetchError) {
      if (attempt === 2) throw fetchError
    }
    if (attempt < 2) await new Promise(r => setTimeout(r, 1000 * (attempt + 1)))
  }

  if (!response || !response.ok) {
    const body = response ? await response.text().catch(() => '') : 'no response'
    throw new Error(`[LLM Major Search Query] API error ${response?.status}: ${body.substring(0, 200)}`)
  }

  const data = await response.json() as any
  const content = data.choices?.[0]?.message?.content?.trim()

  if (!content) {
    throw new Error('[LLM Major Search Query] LLM 응답이 비어있습니다')
  }

  return `적합 전공: ${content}`.substring(0, 500)
}

// ============================================
// 전공 아키타입 쿼리 빌더
// 흥미+가치 조합에서 주류 전공 쿼리를 생성
// ============================================
function buildMajorArchetypeQueries(miniModule: MiniModuleResult): string[] {
  const interests = miniModule.interest_top || []
  const values = miniModule.value_top || []

  const MAJOR_ARCHETYPE_MAP: Record<string, Record<string, string>> = {
    creating: {
      autonomy: '시각디자인학과 산업디자인학과 건축학과 미디어학과 영상학과',
      growth: '산업디자인학과 디지털미디어학과 게임학과 콘텐츠학과',
      stability: '건축학과 실내디자인학과 패션디자인학과 시각디자인학과',
      income: '건축학과 산업디자인학과 영상학과',
      meaning: '문화콘텐츠학과 교육공학과 미디어커뮤니케이션학과',
    },
    problem_solving: {
      autonomy: '철학과 경영학과 컴퓨터공학과 수학과 물리학과',
      growth: '컴퓨터공학과 산업공학과 경영학과 데이터사이언스학과',
      stability: '법학과 행정학과 회계학과 통계학과',
      income: '의학과 법학과 경영학과 컴퓨터공학과 금융학과',
      meaning: '사회학과 정치학과 국제학과 환경공학과 교육학과',
    },
    data_numbers: {
      autonomy: '수학과 통계학과 물리학과 경제학과 컴퓨터공학과',
      growth: '데이터사이언스학과 컴퓨터공학과 산업공학과 통계학과',
      stability: '회계학과 통계학과 컴퓨터공학과 경제학과',
      income: '컴퓨터공학과 금융공학과 경제학과 통계학과 의학과',
      meaning: '환경공학과 수학교육과 통계학과 보건학과',
    },
    helping_teaching: {
      autonomy: '심리학과 상담학과 교육학과 사회복지학과',
      growth: '교육학과 심리학과 간호학과 언어치료학과',
      stability: '간호학과 사회복지학과 유아교육과 초등교육과 특수교육과',
      income: '의학과 치의학과 약학과 간호학과 물리치료학과',
      meaning: '사회복지학과 교육학과 상담학과 신학과 간호학과',
    },
    tech: {
      autonomy: '컴퓨터공학과 소프트웨어학과 전자공학과 정보보안학과',
      growth: '컴퓨터공학과 소프트웨어학과 데이터사이언스학과 로봇공학과',
      stability: '전기공학과 전자공학과 컴퓨터공학과 기계공학과 토목공학과',
      income: '컴퓨터공학과 전자공학과 화학공학과 의공학과',
      meaning: '환경공학과 바이오공학과 의공학과 에너지공학과',
    },
    research: {
      autonomy: '물리학과 화학과 생명과학과 수학과 천문학과',
      growth: '생명공학과 신소재공학과 뇌과학과',
      stability: '약학과 화학과 생명과학과 수학과',
      income: '의학과 약학과 치의학과 한의학과',
      meaning: '생명과학과 환경과학과 해양학과 천문학과',
    },
    organizing: {
      autonomy: '경영학과 행정학과 국제학과 정치외교학과',
      growth: '경영학과 국제통상학과 미디어학과 산업공학과',
      stability: '행정학과 경영학과 회계학과 법학과 세무학과',
      income: '경영학과 금융학과 법학과 회계학과',
      meaning: '행정학과 사회학과 국제학과 도시계획학과',
    },
    influencing: {
      autonomy: '광고홍보학과 미디어학과 경영학과 커뮤니케이션학과',
      growth: '경영학과 미디어학과 광고홍보학과',
      stability: '경영학과 행정학과 법학과 무역학과',
      income: '경영학과 법학과 금융학과 의학과',
      meaning: '사회학과 국제학과 정치외교학과 신문방송학과',
    },
  }

  const queries: string[] = []
  for (const interest of interests) {
    const valueMap = MAJOR_ARCHETYPE_MAP[interest]
    if (!valueMap) continue
    for (const value of values) {
      const query = valueMap[value]
      if (query && !queries.includes(query)) {
        queries.push(query)
      }
    }
  }

  return queries.slice(0, 3)
}

// ============================================
// Multi-Search 쿼리 생성 (전공용)
// ============================================
export async function buildMultiSearchQueriesForMajor(
  miniModule: MiniModuleResult,
  openaiApiKey: string
): Promise<string[]> {
  // 1. LLM 쿼리 (종합 전공명 리스트)
  const llmQuery = await buildLLMMajorSearchQuery(miniModule, openaiApiKey)

  // 2. LLM 출력을 3-5개씩 분할
  const rawContent = llmQuery.replace(/^적합 전공:\s*/, '')
  const majorNames = rawContent.split(/[,，、]/).map(s => s.trim()).filter(Boolean)
  const chunkSize = Math.max(3, Math.ceil(majorNames.length / 5))
  const subQueries: string[] = []
  for (let i = 0; i < majorNames.length; i += chunkSize) {
    subQueries.push(majorNames.slice(i, i + chunkSize).join(', '))
  }

  // 3. 차원별 키워드 쿼리 (전공 도메인)
  const INTEREST_MAJOR_KR: Record<string, string> = {
    creating: '디자인 미술 건축 영상 창작',
    problem_solving: '공학 과학 분석 연구 컨설팅',
    data_numbers: '수학 통계 데이터 경제 회계',
    helping_teaching: '교육 심리 복지 상담 간호',
    organizing: '경영 행정 기획 관리',
    influencing: '광고 홍보 마케팅 미디어 커뮤니케이션',
    tech: 'IT 컴퓨터 전자 기계 소프트웨어',
    routine: '행정 사무 회계 세무',
    research: '연구 과학 물리 화학 생명',
    design: '디자인 시각 산업 건축 패션',
    art: '미술 음악 영화 연극 무용',
  }
  const STRENGTH_MAJOR_KR: Record<string, string> = {
    analytical: '분석 논리 수학 과학 연구',
    creative: '창의 디자인 예술 기획',
    communication: '소통 발표 토론 언어',
    structured_execution: '실험 실습 제작 구현',
    persistence: '연구 심화 전문',
    fast_learning: '다학제 융합 복수전공',
  }
  const VALUE_MAJOR_KR: Record<string, string> = {
    growth: '성장산업 신기술 미래유망',
    stability: '안정 취업률 공무원 전문직',
    income: '고소득 전문직 금융 의학',
    autonomy: '자유 연구 자기주도',
    meaning: '사회공헌 교육 복지 환경',
    recognition: '전문성 명성 학술',
  }

  const dimensionQueries: string[] = []
  if (miniModule.interest_top?.length) {
    const kr = miniModule.interest_top.map((t: string) => INTEREST_MAJOR_KR[t] || t).join(' ')
    dimensionQueries.push(`${kr} 관련 전공 학과`)
  }
  if (miniModule.strength_top?.length) {
    const kr = miniModule.strength_top.map((t: string) => STRENGTH_MAJOR_KR[t] || t).join(' ')
    dimensionQueries.push(`${kr} 역량이 필요한 전공 학과`)
  }
  if (miniModule.value_top?.length) {
    const kr = miniModule.value_top.map((t: string) => VALUE_MAJOR_KR[t] || t).join(' ')
    dimensionQueries.push(`${kr} 전공 학과`)
  }

  // 4. 아키타입 쿼리 (흥미+가치 조합 → 주류 전공)
  const archetypeQueries = buildMajorArchetypeQueries(miniModule)

  // 5. 결합
  return [
    llmQuery,
    ...subQueries,
    ...dimensionQueries,
    ...archetypeQueries,
  ]
}

// ============================================
// 전공 벡터 결과 → ScoredMajor 변환
// major_attributes + majors 테이블 JOIN
// ============================================
export async function vectorResultsToScoredMajors(
  db: D1Database,
  vectorResults: MajorVectorSearchResult[],
  miniModule?: any
): Promise<ScoredMajor[]> {
  if (vectorResults.length === 0) return []

  const BATCH_SIZE = 100
  const majorIds = vectorResults.map(v => v.major_id)

  // 1. major_attributes + majors 조인 조회 (배치 병렬)
  const batches: string[][] = []
  for (let i = 0; i < majorIds.length; i += BATCH_SIZE) {
    batches.push(majorIds.slice(i, i + BATCH_SIZE))
  }

  const batchPromises = batches.map(batchIds => {
    const placeholders = batchIds.map(() => '?').join(',')
    return db.prepare(`
      SELECT
        ma.major_id, ma.major_name,
        m.slug, m.image_url, m.merged_profile_json,
        ma.academic_rigor, ma.math_intensity, ma.creativity, ma.social_interaction,
        ma.lab_practical, ma.reading_writing,
        ma.career_breadth, ma.career_income_potential, ma.employment_rate,
        ma.competition_level, ma.growth_outlook, ma.stability, ma.autonomy, ma.teamwork,
        ma.field_category, ma.degree_level,
        ma.prerequisite_subjects, ma.related_careers, ma.key_skills, ma.description
      FROM major_attributes ma
      LEFT JOIN majors m ON ma.major_id = m.id
      WHERE ma.major_id IN (${placeholders})
    `).bind(...batchIds).all<{
      major_id: number
      major_name: string
      slug: string | null
      image_url: string | null
      merged_profile_json: string | null
      academic_rigor: number
      math_intensity: number
      creativity: number
      social_interaction: number
      lab_practical: number
      reading_writing: number
      career_breadth: number
      career_income_potential: number
      employment_rate: number
      competition_level: number
      growth_outlook: number
      stability: number
      autonomy: number
      teamwork: number
      field_category: string
      degree_level: string
      prerequisite_subjects: string
      related_careers: string
      key_skills: string
      description: string | null
    }>()
  })

  const batchResults = await Promise.all(batchPromises)
  const allAttributeResults: any[] = []
  for (const batchResult of batchResults) {
    if (batchResult.results) {
      allAttributeResults.push(...batchResult.results)
    }
  }

  const attributesMap = new Map(
    allAttributeResults.map(row => [String(row.major_id), row])
  )

  // 2. major_attributes에 없는 전공 → majors 테이블에서 직접 조회 (fallback)
  const missingMajorIds = majorIds.filter(id => !attributesMap.has(id))
  if (missingMajorIds.length > 0) {
    const missingBatches: string[][] = []
    for (let i = 0; i < missingMajorIds.length; i += BATCH_SIZE) {
      missingBatches.push(missingMajorIds.slice(i, i + BATCH_SIZE))
    }

    const fallbackPromises = missingBatches.map(batchIds => {
      const placeholders = batchIds.map(() => '?').join(',')
      return db.prepare(`
        SELECT id as major_id, name as major_name, slug, image_url, merged_profile_json
        FROM majors
        WHERE id IN (${placeholders})
      `).bind(...batchIds).all<{
        major_id: number
        major_name: string
        slug: string | null
        image_url: string | null
        merged_profile_json: string | null
      }>()
    })

    const fallbackResults = await Promise.all(fallbackPromises)
    for (const fallbackResult of fallbackResults) {
      if (fallbackResult.results) {
        for (const row of fallbackResult.results) {
          attributesMap.set(String(row.major_id), {
            ...row,
            academic_rigor: 50, math_intensity: 50, creativity: 50, social_interaction: 50,
            lab_practical: 50, reading_writing: 50,
            career_breadth: 50, career_income_potential: 50, employment_rate: 50,
            competition_level: 50, growth_outlook: 50, stability: 50, autonomy: 50, teamwork: 50,
            field_category: 'general', degree_level: 'bachelor',
            prerequisite_subjects: '[]', related_careers: '[]', key_skills: '[]',
            description: null,
            _from_majors_fallback: true,
          })
        }
      }
    }
  }

  // 3. ScoredMajor 생성
  const vectorScoreMap = new Map(
    vectorResults.map(vr => [vr.major_id, vr.score])
  )

  return vectorResults.map(vr => {
    const attrs = attributesMap.get(vr.major_id) as any
    const vectorScore = vectorScoreMap.get(vr.major_id) || 0

    if (attrs) {
      const personalized = calculateMajorPersonalizedBaseScores(attrs, miniModule)
      const vectorBonus = Math.round(vectorScore * 10)
      const baseLike = Math.min(100, personalized.like + vectorBonus)
      const baseCan = Math.min(100, personalized.can + Math.round(vectorBonus * 0.5))
      const baseRisk = 10

      // 미태깅 전공 페널티
      const isUntagged = !!(attrs as any)?._from_majors_fallback
      const untaggedPenalty = isUntagged ? -25 : 0

      // 전공 설명 추출
      let majorDescription: string | undefined
      if (attrs.description) {
        majorDescription = attrs.description
      } else if (attrs.merged_profile_json) {
        try {
          const profile = JSON.parse(attrs.merged_profile_json)
          majorDescription = (
            profile.overview?.summary || profile.summary || profile.요약 || profile.description || ''
          ).substring(0, 200) || undefined
        } catch {}
      }

      return {
        entity_type: 'major' as const,
        major_id: String(attrs.major_id),
        major_name: attrs.major_name,
        slug: attrs.slug || undefined,
        image_url: attrs.image_url || undefined,
        major_description: majorDescription,
        base_like: baseLike,
        base_can: baseCan,
        base_risk: baseRisk,
        like_score: baseLike,
        can_score: baseCan,
        risk_penalty: baseRisk,
        final_score: Math.round(0.55 * baseLike + 0.45 * baseCan - baseRisk) + untaggedPenalty,
        field_category: attrs.field_category || 'general',
        tag_source: (isUntagged ? 'untagged' : 'tagged') as 'tagged' | 'untagged',
        attributes: {
          academic_rigor: attrs.academic_rigor,
          math_intensity: attrs.math_intensity,
          creativity: attrs.creativity,
          social_interaction: attrs.social_interaction,
          lab_practical: attrs.lab_practical,
          reading_writing: attrs.reading_writing,
          career_breadth: attrs.career_breadth,
          career_income_potential: attrs.career_income_potential,
          employment_rate: attrs.employment_rate,
          competition_level: attrs.competition_level,
          growth_outlook: attrs.growth_outlook,
          stability: attrs.stability,
          autonomy: attrs.autonomy,
          teamwork: attrs.teamwork,
          field_category: attrs.field_category,
          degree_level: attrs.degree_level,
        } as MajorAttributes,
      } satisfies ScoredMajor
    }

    // 속성 정보가 없는 경우 기본값
    const baseLike = Math.round(50 + vr.score * 20)
    return {
      entity_type: 'major' as const,
      major_id: vr.major_id,
      major_name: vr.major_name,
      slug: undefined,
      image_url: undefined,
      major_description: undefined,
      base_like: baseLike,
      base_can: 50,
      base_risk: 15,
      like_score: baseLike,
      can_score: 50,
      risk_penalty: 15,
      final_score: Math.round(baseLike + 50 - 15),
      field_category: 'general',
      tag_source: 'untagged' as const,
      attributes: {
        academic_rigor: 50, math_intensity: 50, creativity: 50, social_interaction: 50,
        lab_practical: 50, reading_writing: 50,
        career_breadth: 50, career_income_potential: 50, employment_rate: 50,
        competition_level: 50, growth_outlook: 50, stability: 50, autonomy: 50, teamwork: 50,
        field_category: 'general', degree_level: 'bachelor',
      } as MajorAttributes,
    } satisfies ScoredMajor
  })
}

// ============================================
// V3: Fallback — majors 테이블에서 직접 조회 (태깅 무관)
// ============================================
async function getFallbackMajorCandidatesV3(
  db: D1Database,
  limit: number
): Promise<MajorVectorSearchResult[]> {
  const result = await db.prepare(`
    SELECT id, name
    FROM majors
    WHERE name IS NOT NULL AND merged_profile_json IS NOT NULL
    ORDER BY RANDOM()
    LIMIT ?
  `).bind(limit).all<{ id: string; name: string }>()

  return (result.results || []).map((row, idx) => ({
    major_id: String(row.id),
    major_name: row.name,
    score: 0.5 - (idx * 0.0001),
    metadata: { source: 'fallback_v3' },
  }))
}

// ============================================
// V3: SearchProfile 기반 전공 후보군 확장
// ============================================
export async function expandCandidatesV3ForMajors(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  openaiApiKey: string | undefined,
  searchProfile: SearchProfile,
  options: {
    targetSize?: number
    miniModule?: MiniModuleResult
  } = {}
): Promise<MajorCandidateExpansionResult> {
  const { targetSize = 500, miniModule } = options
  const startTime = Date.now()

  // Vectorize 또는 OpenAI API 키가 없으면 fallback
  if (!vectorize || !openaiApiKey) {
    const fallbackResult = await getFallbackMajorCandidatesV3(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }

  // miniModule 필수
  if (!miniModule) {
    throw new Error('[V3 Major Vectorize] miniModule이 필수입니다 - LLM 검색 쿼리 생성에 필요')
  }

  try {
    const queries = await buildMultiSearchQueriesForMajor(miniModule, openaiApiKey)
    const vectorResults = await searchMajorCandidatesMultiQuery(vectorize, openaiApiKey, queries)

    const candidates = vectorResults.map(vr => ({
      ...vr,
      metadata: { ...vr.metadata, source: 'vector_search', query_source: 'llm' },
    }))

    return {
      candidates,
      total_searched: vectorResults.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: false,
    }
  } catch (vecError: any) {
    // LLM/Vectorize 검색 실패 시 DB fallback
    console.error('[V3 Major Vectorize] 검색 실패, DB fallback 사용:', vecError?.message)
    const fallbackResult = await getFallbackMajorCandidatesV3(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }
}
