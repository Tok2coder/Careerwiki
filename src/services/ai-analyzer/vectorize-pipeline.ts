// CareerWiki AI Analyzer - Vectorize Pipeline
// Version: v1.0.0
//
// ⚠️ 설계 원칙
// ============================================
// 1. 후보군 확장: 80개 → 500-1000개
// 2. 태깅 대신 의미 기반 검색으로 커버리지 확보
// 3. Evidence Generator와 통합
// ============================================

import type { D1Database, VectorizeIndex, Ai } from '@cloudflare/workers-types'

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
// 임베딩 모델 설정
// ============================================
const EMBEDDING_MODEL = '@cf/baai/bge-base-en-v1.5'
const VECTOR_DIMENSIONS = 768

// ============================================
// 사용자 쿼리 생성 (facts → 검색 쿼리)
// ============================================
export function buildSearchQuery(
  facts: Array<{ fact_key: string; value_json: string }>
): string {
  const queryParts: string[] = []
  
  for (const fact of facts) {
    try {
      const parsed = JSON.parse(fact.value_json)
      const value = parsed.value || parsed
      
      // 관심사 추출
      if (fact.fact_key.includes('interest')) {
        if (Array.isArray(value)) {
          queryParts.push(`관심분야: ${value.join(', ')}`)
        } else {
          queryParts.push(`관심분야: ${value}`)
        }
      }
      
      // 우선순위 추출
      if (fact.fact_key.includes('priority')) {
        const priorityMap: Record<string, string> = {
          growth: '성장과 발전',
          income: '높은 수입',
          wlb: '워라밸',
          stability: '안정성',
          meaning: '의미있는 일',
        }
        queryParts.push(`중요시하는 것: ${priorityMap[value] || value}`)
      }
      
      // 작업 스타일
      if (fact.fact_key.includes('workstyle')) {
        if (value === 'solo') {
          queryParts.push('혼자 집중해서 일하는')
        } else if (value === 'team') {
          queryParts.push('팀으로 협업하는')
        }
      }
      
      // Deep intake 내용
      if (fact.fact_key.includes('deep_intake') || fact.fact_key.includes('discovery')) {
        if (typeof value === 'string' && value.length > 5) {
          queryParts.push(value.substring(0, 100))
        }
      }
      
    } catch {
      // 파싱 실패 시 무시
    }
  }
  
  // 기본 쿼리
  if (queryParts.length === 0) {
    return '직업 추천 적합한 일자리'
  }
  
  return queryParts.join(' ').substring(0, 500)
}

// ============================================
// 벡터 검색 (Cloudflare Vectorize)
// ============================================
export async function searchCandidates(
  vectorize: VectorizeIndex,
  ai: Ai,
  query: string,
  topK: number = 500
): Promise<VectorSearchResult[]> {
  // 1. 쿼리 임베딩 생성
  const embeddingResult = await ai.run(EMBEDDING_MODEL, {
    text: [query],
  }) as { data: number[][] }
  
  const queryEmbedding = embeddingResult.data[0]
  
  // 2. 벡터 검색
  const searchResult = await vectorize.query(queryEmbedding, {
    topK,
    returnValues: false,
    returnMetadata: 'all',
  })
  
  // 3. 결과 변환
  return searchResult.matches.map(match => ({
    job_id: match.id,
    job_name: (match.metadata?.job_name as string) || match.id,
    score: match.score,
    metadata: match.metadata as Record<string, any>,
  }))
}

// ============================================
// 후보군 확장 (메인 함수)
// ============================================
export async function expandCandidates(
  db: D1Database,
  vectorize: VectorizeIndex | undefined,
  ai: Ai | undefined,
  facts: Array<{ fact_key: string; value_json: string }>,
  options: {
    targetSize?: number
    minTaggedJobs?: number
  } = {}
): Promise<CandidateExpansionResult> {
  const { targetSize = 500, minTaggedJobs = 80 } = options
  const startTime = Date.now()
  
  // Vectorize가 없으면 fallback
  if (!vectorize || !ai) {
    console.log('[Vectorize] Vectorize/AI not available, using DB fallback')
    const fallbackResult = await getFallbackCandidates(db, targetSize)
    return {
      candidates: fallbackResult,
      total_searched: fallbackResult.length,
      search_duration_ms: Date.now() - startTime,
      fallback_used: true,
    }
  }
  
  try {
    // 1. 검색 쿼리 생성
    const query = buildSearchQuery(facts)
    console.log(`[Vectorize] Search query: ${query.substring(0, 100)}...`)
    
    // 2. 벡터 검색
    const vectorResults = await searchCandidates(vectorize, ai, query, targetSize)
    
    // 3. 태깅된 직업 우선 포함 (최소 minTaggedJobs개)
    const taggedJobs = await getTaggedJobs(db, minTaggedJobs)
    const taggedJobIds = new Set(taggedJobs.map(j => j.job_id))
    
    // 4. 결과 병합 (태깅된 직업 우선, 그 다음 벡터 검색 결과)
    const mergedCandidates: VectorSearchResult[] = []
    
    // 태깅된 직업 먼저 추가
    for (const job of taggedJobs) {
      const vectorMatch = vectorResults.find(v => v.job_id === job.job_id)
      mergedCandidates.push({
        job_id: job.job_id,
        job_name: job.job_name,
        score: vectorMatch?.score || 0.5, // 벡터 매칭 없으면 기본 점수
        metadata: { source: 'tagged', ...vectorMatch?.metadata },
      })
    }
    
    // 벡터 검색 결과 추가 (태깅된 직업 제외)
    for (const result of vectorResults) {
      if (!taggedJobIds.has(result.job_id)) {
        mergedCandidates.push({
          ...result,
          metadata: { ...result.metadata, source: 'vector_search' },
        })
      }
      if (mergedCandidates.length >= targetSize) break
    }
    
    return {
      candidates: mergedCandidates,
      total_searched: vectorResults.length + taggedJobs.length,
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
// 태깅된 직업 조회 (기존 데이터 활용)
// ============================================
async function getTaggedJobs(
  db: D1Database,
  limit: number
): Promise<VectorSearchResult[]> {
  const result = await db.prepare(`
    SELECT job_id, job_name
    FROM job_attributes
    WHERE tagger_version IS NOT NULL
    LIMIT ?
  `).bind(limit).all<{ job_id: string; job_name: string }>()
  
  return (result.results || []).map(row => ({
    job_id: row.job_id,
    job_name: row.job_name,
    score: 0.7, // 태깅된 직업 기본 점수
    metadata: { source: 'tagged' },
  }))
}

// ============================================
// Fallback: DB에서 직접 조회
// ============================================
async function getFallbackCandidates(
  db: D1Database,
  limit: number
): Promise<VectorSearchResult[]> {
  // job_attributes 테이블에서 직접 조회
  const result = await db.prepare(`
    SELECT job_id, job_name
    FROM job_attributes
    WHERE tagger_version = 'tagger-v1.0.0'
    ORDER BY 
      CASE WHEN growth > 60 THEN 1 ELSE 2 END,
      CASE WHEN wlb > 60 THEN 1 ELSE 2 END
    LIMIT ?
  `).bind(limit).all<{ job_id: string; job_name: string }>()
  
  return (result.results || []).map((row, idx) => ({
    job_id: row.job_id,
    job_name: row.job_name,
    score: 0.6 - (idx * 0.001), // 순서에 따라 점수 감소
    metadata: { source: 'fallback' },
  }))
}

// ============================================
// 직업 데이터 인덱싱 (배치 처리용)
// ============================================
export async function indexJobsToVectorize(
  db: D1Database,
  vectorize: VectorizeIndex,
  ai: Ai,
  batchSize: number = 100
): Promise<{ indexed: number; errors: number }> {
  let indexed = 0
  let errors = 0
  let offset = 0
  
  while (true) {
    // 직업 데이터 조회
    const jobs = await db.prepare(`
      SELECT 
        ja.job_id,
        ja.job_name,
        COALESCE(jd.description, '') as description,
        COALESCE(jd.category, '') as category
      FROM job_attributes ja
      LEFT JOIN job_details jd ON ja.job_id = jd.job_id
      LIMIT ? OFFSET ?
    `).bind(batchSize, offset).all<{
      job_id: string
      job_name: string
      description: string
      category: string
    }>()
    
    if (!jobs.results || jobs.results.length === 0) break
    
    // 배치 처리
    for (const job of jobs.results) {
      try {
        // 텍스트 생성 (직업명 + 설명)
        const textForEmbedding = `${job.job_name} ${job.description} ${job.category}`.trim()
        
        // 임베딩 생성
        const embeddingResult = await ai.run(EMBEDDING_MODEL, {
          text: [textForEmbedding],
        }) as { data: number[][] }
        
        // Vectorize에 저장
        await vectorize.upsert([{
          id: job.job_id,
          values: embeddingResult.data[0],
          metadata: {
            job_name: job.job_name,
            category: job.category,
          },
        }])
        
        indexed++
      } catch (error) {
        console.error(`[Vectorize] Failed to index job ${job.job_id}:`, error)
        errors++
      }
    }
    
    offset += batchSize
    console.log(`[Vectorize] Indexed ${indexed} jobs so far...`)
  }
  
  return { indexed, errors }
}

// ============================================
// 벡터 검색 결과를 ScoredJob 형태로 변환
// ============================================
export async function vectorResultsToScoredJobs(
  db: D1Database,
  vectorResults: VectorSearchResult[]
): Promise<Array<{
  job_id: string
  job_name: string
  base_like: number
  base_can: number
  base_risk: number
  attributes: Record<string, number | string>
}>> {
  if (vectorResults.length === 0) return []
  
  // 벡터 결과의 job_id로 job_attributes 조회
  const jobIds = vectorResults.map(v => v.job_id)
  const placeholders = jobIds.map(() => '?').join(',')
  
  const attributesResult = await db.prepare(`
    SELECT 
      job_id, job_name,
      wlb, growth, stability, income,
      teamwork, solo_deep, analytical, creative, execution, people_facing,
      work_hours, shift_work, travel, remote_possible,
      degree_required, license_required
    FROM job_attributes
    WHERE job_id IN (${placeholders})
  `).bind(...jobIds).all<{
    job_id: string
    job_name: string
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
  
  const attributesMap = new Map(
    (attributesResult.results || []).map(row => [row.job_id, row])
  )
  
  // 벡터 점수를 기반으로 ScoredJob 생성
  return vectorResults.map(vr => {
    const attrs = attributesMap.get(vr.job_id)
    
    if (attrs) {
      return {
        job_id: attrs.job_id,
        job_name: attrs.job_name,
        base_like: Math.round((attrs.wlb + attrs.growth + attrs.stability + attrs.income) / 4),
        base_can: Math.round((attrs.teamwork + (attrs.analytical * 0.7) + attrs.creative) / 3),
        base_risk: 10,
        attributes: {
          wlb: attrs.wlb,
          growth: attrs.growth,
          stability: attrs.stability,
          income: attrs.income,
          remote: attrs.remote_possible === 'full' ? 100 : attrs.remote_possible === 'partial' ? 50 : 0,
          solo_work: attrs.solo_deep,
          people_facing: attrs.people_facing,
          analytical: attrs.analytical,
          creative: attrs.creative,
        },
      }
    }
    
    // 속성 정보가 없는 경우 기본값
    return {
      job_id: vr.job_id,
      job_name: vr.job_name,
      base_like: Math.round(50 + vr.score * 20), // 벡터 점수 반영
      base_can: 50,
      base_risk: 15,
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




