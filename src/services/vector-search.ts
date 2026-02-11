/**
 * vector-search.ts
 * 
 * Part 2.4: Vectorize 검색 서비스
 * AI 분석기 후보 생성(Recall)에 사용
 * 
 * Usage in routes.ts:
 *   import { searchSimilarJobs, generateQueryEmbedding } from './vector-search'
 *   const candidates = await searchSimilarJobs(c.env, userQuery, 200)
 */

import type { VectorizeIndex, Ai } from '@cloudflare/workers-types'

// ============================================
// Types
// ============================================

export interface VectorSearchResult {
  id: string
  score: number
  metadata: {
    type: 'job' | 'major' | 'howto'
    entity_id: string
    slug: string
    title: string
    section: string
    chunk_index: number
    status?: string  // 'tagged' | 'stubbed' | 'pending'
  }
}

export interface VectorSearchOptions {
  topK?: number
  namespace?: string
  filter?: Record<string, string | number>
  minScore?: number
}

export interface Bindings {
  VECTORIZE?: VectorizeIndex
  AI?: Ai
  [key: string]: unknown
}

// ============================================
// Embedding Generation
// ============================================

/**
 * Generate embedding for a query using Workers AI
 * Model: @cf/baai/bge-m3 (multilingual, good for Korean)
 */
export async function generateQueryEmbedding(
  ai: Ai | undefined,
  query: string
): Promise<number[] | null> {
  if (!ai) {
    console.warn('AI binding not available, skipping embedding generation')
    return null
  }
  
  try {
    // Use BGE-M3 for multilingual support (Korean)
    const response = await ai.run('@cf/baai/bge-m3', {
      text: [query],
    }) as { data: number[][] }
    
    if (response?.data?.[0]) {
      return response.data[0]
    }
    return null
  } catch (error) {
    console.error('Failed to generate embedding:', error)
    return null
  }
}

// ============================================
// Vector Search
// ============================================

/**
 * Search for similar content using Vectorize
 */
export async function searchSimilar(
  vectorize: VectorizeIndex | undefined,
  queryVector: number[],
  options: VectorSearchOptions = {}
): Promise<VectorSearchResult[]> {
  if (!vectorize) {
    console.warn('Vectorize binding not available')
    return []
  }
  
  const {
    topK = 80,
    namespace = 'job-content',
    filter,
    minScore = 0.5,
  } = options
  
  try {
    // Cloudflare Vectorize limits: returnMetadata='indexed' → max topK=100
    const clampedTopK = Math.min(topK, 100)
    const results = await vectorize.query(queryVector, {
      topK: clampedTopK,
      namespace,
      filter,
      returnValues: false,
      returnMetadata: 'indexed',
    })
    
    // Filter by minimum score and map to our result type
    return (results.matches || [])
      .filter(match => match.score >= minScore)
      .map(match => ({
        id: match.id,
        score: match.score,
        metadata: match.metadata as VectorSearchResult['metadata'],
      }))
  } catch (error) {
    console.error('Vectorize search failed:', error)
    return []
  }
}

/**
 * Search for similar jobs by text query
 * Combines embedding generation + vector search
 */
export async function searchSimilarJobs(
  env: Bindings,
  query: string,
  topK: number = 200
): Promise<VectorSearchResult[]> {
  // 1. Generate query embedding
  const queryVector = await generateQueryEmbedding(env.AI, query)
  
  if (!queryVector) {
    // Fallback: return empty (caller should use DB-based candidate generation)
    return []
  }
  
  // 2. Search Vectorize
  const results = await searchSimilar(env.VECTORIZE, queryVector, {
    topK,
    namespace: 'job-content',
    minScore: 0.4,  // Lower threshold for recall
  })
  
  return results
}

// ============================================
// Hybrid Search (Vector + Filtering)
// ============================================

/**
 * Hybrid candidate generation:
 * 1. Vector search for initial candidates (topK=200)
 * 2. Filter by tagged status
 * 3. Fill with stubbed if needed
 */
export async function getHybridCandidates(
  env: Bindings,
  query: string,
  targetCount: number = 80
): Promise<{
  candidates: VectorSearchResult[]
  debug: {
    vectorSource: boolean
    vectorCount: number
    taggedCount: number
    stubbedRatio: number
  }
}> {
  // 1. Try vector search first
  const vectorResults = await searchSimilarJobs(env, query, 200)
  
  if (vectorResults.length === 0) {
    // Fallback to non-vector candidate generation
    return {
      candidates: [],
      debug: {
        vectorSource: false,
        vectorCount: 0,
        taggedCount: 0,
        stubbedRatio: 0,
      }
    }
  }
  
  // 2. Prioritize tagged jobs
  const tagged = vectorResults.filter(r => r.metadata.status === 'tagged')
  const stubbed = vectorResults.filter(r => r.metadata.status === 'stubbed' || !r.metadata.status)
  
  // 3. Fill candidates (prefer tagged)
  let candidates = tagged.slice(0, targetCount)
  
  if (candidates.length < targetCount) {
    const remaining = targetCount - candidates.length
    candidates = [...candidates, ...stubbed.slice(0, remaining)]
  }
  
  const stubbedInCandidates = candidates.filter(c => c.metadata.status !== 'tagged').length
  
  return {
    candidates,
    debug: {
      vectorSource: true,
      vectorCount: vectorResults.length,
      taggedCount: tagged.length,
      stubbedRatio: candidates.length > 0 ? stubbedInCandidates / candidates.length : 0,
    }
  }
}

// ============================================
// Admin/Debug Endpoints
// ============================================

/**
 * Debug endpoint: test vector search with a query
 * Returns raw results for debugging
 */
export async function debugVectorSearch(
  env: Bindings,
  query: string,
  topK: number = 10
): Promise<{
  query: string
  embedding_generated: boolean
  results: VectorSearchResult[]
  error?: string
}> {
  try {
    const queryVector = await generateQueryEmbedding(env.AI, query)
    
    if (!queryVector) {
      return {
        query,
        embedding_generated: false,
        results: [],
        error: 'AI binding not available or embedding generation failed',
      }
    }
    
    const results = await searchSimilar(env.VECTORIZE, queryVector, {
      topK,
      namespace: 'job-content',
      minScore: 0.3,
    })
    
    return {
      query,
      embedding_generated: true,
      results,
    }
  } catch (error: any) {
    return {
      query,
      embedding_generated: false,
      results: [],
      error: error.message,
    }
  }
}





