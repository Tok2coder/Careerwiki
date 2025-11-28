/**
 * 유사 이름 병합 서비스
 * 직업/전공 데이터에서 유사한 이름 쌍을 찾고 매핑을 관리합니다.
 */

import type { D1Database } from '@cloudflare/workers-types'
import { calculateSimilarity, normalizeName, type SimilarityResult } from '../utils/similarity'

export interface NameMapping {
  id: number
  type: 'job' | 'major'
  sourceName: string
  targetName: string
  similarityScore: number | null
  matchReason: string | null
  createdBy: string | null
  createdAt: number
  updatedAt: number | null
  isActive: boolean
}

export interface SimilarNameCandidate {
  name1: string
  name2: string
  score: number
  matchType: string
  sourceCount1?: number  // name1이 몇 개의 소스를 가지고 있는지
  sourceCount2?: number  // name2가 몇 개의 소스를 가지고 있는지
  sources1?: string[]    // name1의 소스 시스템 목록
  sources2?: string[]    // name2의 소스 시스템 목록
  alreadyMapped?: boolean  // 이미 매핑이 존재하는지
}

export interface SimilarNamesResponse {
  type: 'job' | 'major'
  totalNames: number
  similarPairs: SimilarNameCandidate[]
  normalizedDuplicates: Array<{
    normalized: string
    originals: string[]
  }>
  existingMappings: NameMapping[]
}

interface NameWithSource {
  name: string
  sources: Set<string>  // CAREERNET, WORK24_JOB, WORK24_DJOB 등
}

/**
 * 직업 이름 목록 조회 (소스 정보 포함)
 */
async function getJobNamesWithSources(db: D1Database): Promise<Map<string, Set<string>>> {
  const result = await db.prepare(`
    SELECT 
      COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) as name,
      source_system
    FROM job_sources
    WHERE COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) IS NOT NULL
      AND COALESCE(
        JSON_EXTRACT(normalized_payload, '$.name'),
        JSON_EXTRACT(raw_payload, '$.dJobNm'),
        JSON_EXTRACT(raw_payload, '$.jobNm')
      ) != ''
    ORDER BY name
  `).all<{ name: string; source_system: string }>()
  
  const nameToSources = new Map<string, Set<string>>()
  for (const r of result.results ?? []) {
    if (!nameToSources.has(r.name)) {
      nameToSources.set(r.name, new Set())
    }
    nameToSources.get(r.name)!.add(r.source_system)
  }
  
  return nameToSources
}

/**
 * 전공 이름 목록 조회 (소스 정보 포함)
 */
async function getMajorNamesWithSources(db: D1Database): Promise<Map<string, Set<string>>> {
  const result = await db.prepare(`
    SELECT 
      JSON_EXTRACT(normalized_payload, '$.name') as name,
      source_system
    FROM major_sources
    WHERE JSON_EXTRACT(normalized_payload, '$.name') IS NOT NULL
      AND JSON_EXTRACT(normalized_payload, '$.name') != ''
    ORDER BY name
  `).all<{ name: string; source_system: string }>()
  
  const nameToSources = new Map<string, Set<string>>()
  for (const r of result.results ?? []) {
    if (!nameToSources.has(r.name)) {
      nameToSources.set(r.name, new Set())
    }
    nameToSources.get(r.name)!.add(r.source_system)
  }
  
  return nameToSources
}

/**
 * 두 소스 집합이 서로 다른 소스를 포함하는지 확인
 * (같은 소스끼리만 있으면 false, 다른 소스가 있으면 true)
 */
function hasDifferentSources(sources1: Set<string>, sources2: Set<string>): boolean {
  // sources1에 있는 것 중 sources2에 없는 것이 있거나
  // sources2에 있는 것 중 sources1에 없는 것이 있으면 true
  for (const s of sources1) {
    if (!sources2.has(s)) return true
  }
  for (const s of sources2) {
    if (!sources1.has(s)) return true
  }
  return false
}

/**
 * 다른 소스 간의 유사 쌍 찾기
 * 같은 소스끼리는 비교하지 않음
 */
function findSimilarPairsCrossSource(
  names: string[],
  nameToSources: Map<string, Set<string>>,
  minScore: number = 0.7
): SimilarityResult[] {
  const results: SimilarityResult[] = []
  
  for (let i = 0; i < names.length; i++) {
    for (let j = i + 1; j < names.length; j++) {
      const name1 = names[i]
      const name2 = names[j]
      
      const sources1 = nameToSources.get(name1) ?? new Set()
      const sources2 = nameToSources.get(name2) ?? new Set()
      
      // 다른 소스 간의 이름만 비교
      if (!hasDifferentSources(sources1, sources2)) continue
      
      const similarity = calculateSimilarity(name1, name2)
      
      if (similarity.score >= minScore && similarity.matchType !== 'exact') {
        results.push(similarity)
      }
    }
  }
  
  // 점수 내림차순 정렬
  return results.sort((a, b) => b.score - a.score)
}

/**
 * 정규화 후 중복 찾기 (다른 소스 간만)
 */
function findNormalizedDuplicatesCrossSource(
  names: string[],
  nameToSources: Map<string, Set<string>>
): Array<{ normalized: string; originals: string[] }> {
  const normalizedMap = new Map<string, string[]>()
  
  for (const name of names) {
    const normalized = normalizeName(name)
    if (!normalizedMap.has(normalized)) {
      normalizedMap.set(normalized, [])
    }
    normalizedMap.get(normalized)!.push(name)
  }
  
  // 2개 이상이고, 다른 소스에서 온 것들만 필터링
  const duplicates: Array<{ normalized: string; originals: string[] }> = []
  
  normalizedMap.forEach((originals, normalized) => {
    if (originals.length <= 1) return
    
    // 다른 소스가 있는지 확인
    const allSources = new Set<string>()
    for (const name of originals) {
      const sources = nameToSources.get(name) ?? new Set()
      sources.forEach(s => allSources.add(s))
    }
    
    // 소스가 2개 이상이면 다른 소스에서 온 중복이 있음
    if (allSources.size > 1) {
      duplicates.push({ normalized, originals })
    }
  })
  
  return duplicates
}

/**
 * 특정 이름의 소스 개수 조회
 */
async function getSourceCounts(
  db: D1Database, 
  type: 'job' | 'major', 
  names: string[]
): Promise<Map<string, number>> {
  const counts = new Map<string, number>()
  
  if (names.length === 0) return counts
  
  if (type === 'job') {
    for (const name of names) {
      const result = await db.prepare(`
        SELECT COUNT(*) as cnt
        FROM job_sources
        WHERE COALESCE(
          JSON_EXTRACT(normalized_payload, '$.name'),
          JSON_EXTRACT(raw_payload, '$.dJobNm'),
          JSON_EXTRACT(raw_payload, '$.jobNm')
        ) = ?
      `).bind(name).first<{ cnt: number }>()
      counts.set(name, result?.cnt ?? 0)
    }
  } else {
    for (const name of names) {
      const result = await db.prepare(`
        SELECT COUNT(*) as cnt
        FROM major_sources
        WHERE JSON_EXTRACT(normalized_payload, '$.name') = ?
      `).bind(name).first<{ cnt: number }>()
      counts.set(name, result?.cnt ?? 0)
    }
  }
  
  return counts
}

/**
 * 기존 매핑 조회
 */
export async function getExistingMappings(
  db: D1Database, 
  type: 'job' | 'major'
): Promise<NameMapping[]> {
  const result = await db.prepare(`
    SELECT 
      id,
      type,
      source_name as sourceName,
      target_name as targetName,
      similarity_score as similarityScore,
      match_reason as matchReason,
      created_by as createdBy,
      created_at as createdAt,
      updated_at as updatedAt,
      is_active as isActive
    FROM name_mappings
    WHERE type = ? AND is_active = 1
    ORDER BY source_name
  `).bind(type).all<{
    id: number
    type: 'job' | 'major'
    sourceName: string
    targetName: string
    similarityScore: number | null
    matchReason: string | null
    createdBy: string | null
    createdAt: number
    updatedAt: number | null
    isActive: number
  }>()
  
  return result.results?.map(r => ({
    ...r,
    isActive: r.isActive === 1
  })) ?? []
}

/**
 * 유사 이름 후보 조회 (다른 소스 간의 유사도만 비교)
 */
export async function findSimilarNames(
  db: D1Database,
  type: 'job' | 'major',
  minScore: number = 0.7
): Promise<SimilarNamesResponse> {
  // 1. 이름 목록 조회 (소스 정보 포함)
  const nameToSources = type === 'job' 
    ? await getJobNamesWithSources(db) 
    : await getMajorNamesWithSources(db)
  
  const names = [...nameToSources.keys()]
  
  // 2. 유사 쌍 찾기 (다른 소스 간의 이름만 비교)
  const similarPairs = findSimilarPairsCrossSource(names, nameToSources, minScore)
  
  // 3. 정규화 후 중복 찾기 (다른 소스 간만)
  const normalizedDuplicates = findNormalizedDuplicatesCrossSource(names, nameToSources)
  
  // 4. 기존 매핑 조회
  const existingMappings = await getExistingMappings(db, type)
  const mappedNames = new Set<string>()
  existingMappings.forEach(m => {
    mappedNames.add(m.sourceName)
    mappedNames.add(m.targetName)
  })
  
  // 5. 소스 개수 조회 (전체)
  const namesToCheck = new Set<string>()
  similarPairs.forEach(p => {
    namesToCheck.add(p.name1)
    namesToCheck.add(p.name2)
  })
  
  const sourceCounts = await getSourceCounts(db, type, [...namesToCheck])
  
  // 6. 결과 구성 (소스 정보 추가)
  const candidates: SimilarNameCandidate[] = similarPairs.map(pair => ({
    name1: pair.name1,
    name2: pair.name2,
    score: pair.score,
    matchType: pair.matchType,
    sourceCount1: sourceCounts.get(pair.name1) ?? 0,
    sourceCount2: sourceCounts.get(pair.name2) ?? 0,
    sources1: [...(nameToSources.get(pair.name1) ?? [])],
    sources2: [...(nameToSources.get(pair.name2) ?? [])],
    alreadyMapped: mappedNames.has(pair.name1) || mappedNames.has(pair.name2)
  }))
  
  return {
    type,
    totalNames: names.length,
    similarPairs: candidates,
    normalizedDuplicates,
    existingMappings
  }
}

/**
 * 매핑 저장
 */
export async function saveNameMapping(
  db: D1Database,
  type: 'job' | 'major',
  sourceName: string,
  targetName: string,
  options: {
    similarityScore?: number
    matchReason?: string
    createdBy?: string
  } = {}
): Promise<{ success: boolean; id?: number; error?: string }> {
  const now = Date.now()
  
  try {
    // 이미 존재하는 매핑 확인
    const existing = await db.prepare(`
      SELECT id FROM name_mappings 
      WHERE type = ? AND source_name = ?
    `).bind(type, sourceName).first<{ id: number }>()
    
    if (existing) {
      // 업데이트
      await db.prepare(`
        UPDATE name_mappings
        SET target_name = ?, similarity_score = ?, match_reason = ?, 
            updated_at = ?, is_active = 1
        WHERE id = ?
      `).bind(
        targetName, 
        options.similarityScore ?? null, 
        options.matchReason ?? null,
        now,
        existing.id
      ).run()
      
      return { success: true, id: existing.id }
    }
    
    // 새로 삽입
    const result = await db.prepare(`
      INSERT INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active)
      VALUES (?, ?, ?, ?, ?, ?, ?, 1)
    `).bind(
      type,
      sourceName,
      targetName,
      options.similarityScore ?? null,
      options.matchReason ?? null,
      options.createdBy ?? null,
      now
    ).run()
    
    return { success: true, id: result.meta.last_row_id }
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    return { success: false, error: message }
  }
}

/**
 * 매핑 일괄 저장
 */
export async function saveNameMappings(
  db: D1Database,
  mappings: Array<{
    type: 'job' | 'major'
    sourceName: string
    targetName: string
    similarityScore?: number
    matchReason?: string
  }>,
  createdBy?: string
): Promise<{ success: number; failed: number; errors: string[] }> {
  const results = { success: 0, failed: 0, errors: [] as string[] }
  
  for (const mapping of mappings) {
    const result = await saveNameMapping(db, mapping.type, mapping.sourceName, mapping.targetName, {
      similarityScore: mapping.similarityScore,
      matchReason: mapping.matchReason,
      createdBy
    })
    
    if (result.success) {
      results.success++
    } else {
      results.failed++
      results.errors.push(`${mapping.sourceName}: ${result.error}`)
    }
  }
  
  return results
}

/**
 * 매핑 삭제 (비활성화)
 */
export async function deleteNameMapping(
  db: D1Database,
  id: number
): Promise<{ success: boolean; error?: string }> {
  try {
    await db.prepare(`
      UPDATE name_mappings SET is_active = 0, updated_at = ? WHERE id = ?
    `).bind(Date.now(), id).run()
    
    return { success: true }
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unknown error'
    return { success: false, error: message }
  }
}

/**
 * ETL용: 이름 매핑 조회 (source_name → target_name)
 */
export async function getNameMappingsForETL(
  db: D1Database,
  type: 'job' | 'major'
): Promise<Map<string, string>> {
  const result = await db.prepare(`
    SELECT source_name, target_name
    FROM name_mappings
    WHERE type = ? AND is_active = 1
  `).bind(type).all<{ source_name: string; target_name: string }>()
  
  const mappings = new Map<string, string>()
  result.results?.forEach(r => {
    mappings.set(r.source_name, r.target_name)
  })
  
  return mappings
}

