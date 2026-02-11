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
import { 
  JOB_PROFILE_COMPACT_VERSION, 
  getFullEmbeddingVersion 
} from '../../constants/embedding-versions'

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
  return searchResult.matches.map(match => ({
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
  console.log(`[Multi-Query] Batch embedding done: ${queries.length} queries → ${embeddings.length} embeddings`)

  // 2. 병렬 Vectorize 검색 (각 topK=100)
  const clampedTopK = Math.min(topK, 100)
  const searchPromises = embeddings.map(emb =>
    vectorize.query(emb, { topK: clampedTopK, returnValues: false, returnMetadata: 'none' })
  )
  const searchResults = await Promise.all(searchPromises)

  // 3. 중복 제거 (같은 job_id → 최고 score 유지)
  const bestScoreMap = new Map<string, number>()
  let totalMatches = 0
  for (const result of searchResults) {
    for (const match of result.matches) {
      totalMatches++
      const existing = bestScoreMap.get(match.id)
      if (existing === undefined || match.score > existing) {
        bestScoreMap.set(match.id, match.score)
      }
    }
  }

  console.log(`[Multi-Query] Total matches: ${totalMatches}, Unique jobs: ${bestScoreMap.size}`)

  // 4. 결과 변환 (score 내림차순)
  return Array.from(bestScoreMap.entries())
    .sort((a, b) => b[1] - a[1])
    .map(([id, score]) => ({
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
    console.log('[Vectorize] Vectorize/OpenAI not available, using DB fallback')
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
    console.log(`[Vectorize] Search query: ${query.substring(0, 100)}...`)
    
    // 2. 벡터 검색 (OpenAI Embedding 사용)
    const vectorResults = await searchCandidates(vectorize, openaiApiKey, query, targetSize)
    
    console.log(`[Vectorize] Found ${vectorResults.length} candidates via vector search`)
    
    return {
      candidates: vectorResults,
      total_searched: vectorResults.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: false,
    }
    
  } catch (error) {
    console.error('[Vectorize] Search failed, using fallback:', error)
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
  
  // 설명 텍스트 fallback 우선순위
  const mainDesc = (
    job.heroIntro || 
    job.summary || 
    job.description || 
    ''
  ).trim()
  
  // 선택적 필드들 (있으면 추가)
  const parts: string[] = [name]
  
  // 메인 설명 (최대 300자)
  if (mainDesc) {
    parts.push(mainDesc.slice(0, 300))
  }
  
  // 핵심업무 (있으면)
  if (job.duties && job.duties.trim()) {
    parts.push(`핵심업무: ${job.duties.slice(0, 100)}`)
  }
  
  // 필요역량 (있으면, 최대 5개)
  if (job.skills && job.skills.length > 0) {
    const validSkills = job.skills.filter(s => s && s.trim())
    if (validSkills.length > 0) {
      parts.push(`필요역량: ${validSkills.slice(0, 5).join(', ')}`)
    }
  }
  
  // 근무환경 (있으면)
  if (job.workEnvironment && job.workEnvironment.trim()) {
    parts.push(`환경: ${job.workEnvironment.slice(0, 50)}`)
  }
  
  // 자격증 (있으면, 최대 3개)
  if (job.certifications && job.certifications.length > 0) {
    const validCerts = job.certifications.filter(c => c && c.trim())
    if (validCerts.length > 0) {
      parts.push(`자격: ${validCerts.slice(0, 3).join(', ')}`)
    }
  }
  
  // 카테고리 (있으면)
  if (job.category && job.category.trim()) {
    parts.push(job.category)
  }
  
  // 최소 보장: name + category는 반드시 포함
  if (parts.length < 2) {
    parts.push(job.category || '미분류')
  }
  
  return parts.join(' ').substring(0, 1000)
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
      console.warn(`[parseJobProfile] Failed to parse merged_profile_json for ${jobId}:`, e)
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
  
  console.log(`[Vectorize] Starting indexing with version: ${version}`)
  
  while (true) {
    // jobs 테이블에서 직접 조회 (6,945개 전체)
    const jobs = await db.prepare(`
      SELECT 
        id as job_id,
        name as job_name,
        merged_profile_json,
        category
      FROM jobs
      WHERE is_active = 1
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      job_id: string
      job_name: string
      merged_profile_json: string | null
      category: string | null
    }>()
    
    if (!jobs.results || jobs.results.length === 0) break
    
    // buildJobProfileCompact로 인덱싱 텍스트 생성
    const textsForEmbedding = jobs.results.map(job => {
      const profileData = parseJobProfileFromMergedJson(
        job.job_id,
        job.job_name,
        job.merged_profile_json,
        job.category
      )
      return buildJobProfileCompact(profileData)
    })
    
    try {
      // 배치로 임베딩 생성
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)
      
      // Vectorize에 배치 저장 (확장된 metadata 포함)
      const vectors = jobs.results.map((job, idx) => {
        // merged_profile_json에서 추가 metadata 추출
        let kscoMajor: string | undefined
        let kscoMid: string | undefined
        let educationLevel: string | undefined
        
        if (job.merged_profile_json) {
          try {
            const profile = JSON.parse(job.merged_profile_json)
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
            category: job.category || '',
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
      console.error(`[Vectorize] Batch indexing failed at offset ${offset}:`, error)
      errors += jobs.results.length
    }
    
    offset += batchSize
    console.log(`[Vectorize] Indexed ${indexed} jobs so far...`)
    
    // OpenAI rate limit 방지 (1초 대기)
    await new Promise(resolve => setTimeout(resolve, 1000))
  }
  
  console.log(`[Vectorize] Indexing complete. Total: ${indexed}, Errors: ${errors}, Version: ${version}`)
  
  return { indexed, errors, version }
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

  // batch로 나눠서 조회
  const allAttributeResults: any[] = []
  for (let i = 0; i < jobIds.length; i += BATCH_SIZE) {
    const batchIds = jobIds.slice(i, i + BATCH_SIZE)
    const placeholders = batchIds.map(() => '?').join(',')

    const batchResult = await db.prepare(`
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
    console.log(`[vectorResultsToScoredJobs] ${missingJobIds.length}개 직업이 job_attributes에 없음, jobs 테이블에서 직접 조회`)

    for (let i = 0; i < missingJobIds.length; i += BATCH_SIZE) {
      const batchIds = missingJobIds.slice(i, i + BATCH_SIZE)
      const placeholders = batchIds.map(() => '?').join(',')

      const fallbackResult = await db.prepare(`
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

      if (fallbackResult.results) {
        for (const row of fallbackResult.results) {
          // job_attributes 데이터 없이 jobs 테이블 데이터만으로 기본값 생성
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
      // 벡터 유사도 보너스: 의미적으로 가까운 직업에 Like/Can 보너스
      // vectorScore 범위 0~1, 보너스 0~15점
      const vectorBonus = Math.round(vectorScore * 15)
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
        final_score: Math.round(0.55 * baseLike + 0.45 * baseCan - baseRisk + (vectorScore * 20)) + untaggedPenalty,
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
        people_facing: 50,
        analytical: 50,
        creative: 50,
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
1. 직업 카테고리 5~8개, 구체적 직업명 15~25개를 나열
2. 한국어로 작성 (예: 공무원, 행정사무원, 데이터분석가)
3. 사용자의 흥미, 가치관, 강점, 제약조건을 모두 고려
4. 너무 뻔한 것만 나열하지 말고, 숨겨진 적합 직업도 포함
5. 제약조건이 있으면 그에 맞는 현실적인 직업 위주로
6. 쉼표로 구분하여 한 줄로 출력
7. 설명이나 번호 없이 직업명/카테고리만 나열`

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

  const response = await fetch('https://api.openai.com/v1/chat/completions', {
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

  console.log(`[LLM Search Query] Generated: ${llmQuery.substring(0, 150)}...`)
  console.log(`[LLM Search Query] Tokens: ${data.usage?.total_tokens || 'unknown'}`)

  return llmQuery
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

  // 3. 차원별 키워드 쿼리 추가 (LLM 호출 없이 규칙 기반)
  const dimensionQueries: string[] = []
  if (miniModule.interest_top?.length) {
    dimensionQueries.push(`${miniModule.interest_top.join(' ')} 관련 직업`)
  }
  if (miniModule.strength_top?.length) {
    dimensionQueries.push(`${miniModule.strength_top.join(' ')} 역량이 필요한 직업`)
  }
  if (miniModule.value_top?.length) {
    dimensionQueries.push(`${miniModule.value_top.join(' ')} 가치를 충족하는 직업`)
  }

  // 4. 모든 쿼리 결합 (종합 + 서브쿼리 + 차원별)
  const allQueries = [
    llmQuery,          // 종합 (가장 중요)
    ...subQueries,     // LLM 출력 분할 (5-8개)
    ...dimensionQueries, // 흥미/강점/가치 차원 (2-3개)
  ]

  console.log(`[Multi-Search] Generated ${allQueries.length} queries: 1 main + ${subQueries.length} sub + ${dimensionQueries.length} dimension`)

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
    console.log('[V3 Vectorize] Vectorize/OpenAI not available, using DB fallback')
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
  console.log(`[V3 Vectorize] Multi-query search: ${queries.length} queries`)

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
      console.warn(`[V3 Vectorize] Vectorize 로컬 실행 불가 → DB fallback: ${vecError.message}`)
      console.log(`[V3 Vectorize] LLM 쿼리는 성공: ${queries[0]?.substring(0, 80)}...`)
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
    console.warn('[P1-2] SearchProfile cache read failed:', error)
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
    
    console.log('[P1-2] SearchProfile cached:', { sessionId, answersHash: answersHash.substring(0, 8) })
  } catch (error) {
    // 캐시 저장 실패는 치명적이지 않음
    console.warn('[P1-2] SearchProfile cache write failed:', error)
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
  
  console.log(`[Vectorize Incremental] Starting upsert, target version: ${CURRENT_VERSION}`)
  
  let upserted = 0
  let errors = 0
  let skipped = 0
  let offset = 0
  
  while (upserted + skipped < maxJobs) {
    // 신규 또는 버전 불일치 직업 조회
    const jobs = await db.prepare(`
      SELECT id, name, merged_profile_json, category
      FROM jobs
      WHERE is_active = 1 
        AND (indexed_at IS NULL OR embedding_version != ?)
      ORDER BY id
      LIMIT ? OFFSET ?
    `).bind(CURRENT_VERSION, batchSize, offset).all<{
      id: string
      name: string
      merged_profile_json: string | null
      category: string | null
    }>()
    
    if (!jobs.results || jobs.results.length === 0) {
      console.log('[Vectorize Incremental] No more jobs to upsert')
      break
    }
    
    // 인덱싱 텍스트 생성
    const textsForEmbedding = jobs.results.map(job => {
      const profileData = parseJobProfileFromMergedJson(
        job.id,
        job.name,
        job.merged_profile_json,
        job.category
      )
      return buildJobProfileCompact(profileData)
    })
    
    try {
      // OpenAI Embedding 생성
      const { embeddings } = await generateOpenAIEmbedding(openaiApiKey, textsForEmbedding)
      
      // Vectorize에 upsert
      const vectors = jobs.results.map((job, idx) => {
        let kscoMajor: string | undefined
        let kscoMid: string | undefined
        let educationLevel: string | undefined
        
        if (job.merged_profile_json) {
          try {
            const profile = JSON.parse(job.merged_profile_json)
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
            category: job.category || '',
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
      console.log(`[Vectorize Incremental] Upserted ${upserted} jobs`)
      
    } catch (error) {
      console.error(`[Vectorize Incremental] Batch failed at offset ${offset}:`, error)
      errors += jobs.results.length
    }
    
    offset += batchSize
    
    // Rate limit
    await new Promise(resolve => setTimeout(resolve, 1000))
  }
  
  console.log(`[Vectorize Incremental] Complete. Upserted: ${upserted}, Errors: ${errors}, Skipped: ${skipped}`)
  
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
      console.log('[P1-2] SearchProfile cache hit:', { sessionId, answersHash: answersHash.substring(0, 8) })
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
    
    console.log(`[TAG Pre-Filter] Excluded ${preFilterResult.stats.excluded} jobs before RAG`, {
      totalTagged: preFilterResult.stats.totalTagged,
      remaining: preFilterResult.stats.remainingTagged,
    })
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
    console.log('[V3 Vectorize] Vectorize/OpenAI not available, using DB fallback')
    let fallbackResult = await getFallbackCandidatesV3(db, targetSize)

    // Pre-Filter 적용
    if (excludedJobIds && excludedJobIds.size > 0) {
      fallbackResult = fallbackResult.filter(c => !excludedJobIds.has(c.job_id))
      console.log(`[V3 Fallback] After pre-filter: ${fallbackResult.length} candidates`)
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
      console.log(`[V3 Vectorize] Multi-query search: ${queries.length} queries`)

      // 2. Multi-Query 병렬 벡터 검색 (각 topK=100, 중복 제거)
      vectorResults = await searchCandidatesMultiQuery(vectorize, openaiApiKey!, queries)
      console.log(`[V3 Vectorize] Multi-query results: ${vectorResults.length} unique jobs`)
    } else {
      const query = searchProfileToQuery(searchProfile)
      console.log(`[V3 Vectorize] Search query (static - interview mode): ${query.substring(0, 100)}...`)

      // 2. 단일 쿼리 벡터 검색 (인터뷰 모드 fallback)
      vectorResults = await searchCandidates(vectorize, openaiApiKey!, query, 100)
      console.log(`[V3 Vectorize] Single-query results: ${vectorResults.length}`)
    }

    // 3. Pre-Filter 적용 (제외 대상 제거)
    if (excludedJobIds && excludedJobIds.size > 0) {
      const beforeCount = vectorResults.length
      vectorResults = vectorResults.filter(r => !excludedJobIds.has(r.job_id))
      console.log(`[V3 Vectorize] After pre-filter: ${vectorResults.length} (removed ${beforeCount - vectorResults.length})`)
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
      console.warn(`[V3 Vectorize] Vectorize 로컬 실행 불가 → DB fallback: ${vecError.message}`)
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

