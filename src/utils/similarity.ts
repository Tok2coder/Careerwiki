/**
 * 유사도 계산 유틸리티
 * 직업/전공 이름 간의 유사도를 계산하여 병합 후보를 찾습니다.
 */

export interface SimilarityResult {
  name1: string
  name2: string
  score: number           // 0.0 ~ 1.0
  matchType: MatchType
  normalizedName1: string
  normalizedName2: string
}

export type MatchType = 
  | 'exact'           // 완전 일치
  | 'normalized'      // 정규화 후 일치 (띄어쓰기/특수문자 제거)
  | 'contains'        // 포함 관계
  | 'levenshtein'     // 레벤슈타인 유사도
  | 'keyword'         // 공통 키워드

/**
 * 이름 정규화: 띄어쓰기, 특수문자 제거
 */
export function normalizeName(name: string): string {
  return name
    .replace(/[\s\-_()（）\[\]【】·・]/g, '')  // 공백, 대시, 괄호 제거
    .toLowerCase()
    .trim()
}

/**
 * 레벤슈타인 거리 계산
 */
export function levenshteinDistance(str1: string, str2: string): number {
  const m = str1.length
  const n = str2.length
  
  // 빈 문자열 처리
  if (m === 0) return n
  if (n === 0) return m
  
  // DP 테이블
  const dp: number[][] = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0))
  
  for (let i = 0; i <= m; i++) dp[i][0] = i
  for (let j = 0; j <= n; j++) dp[0][j] = j
  
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      const cost = str1[i - 1] === str2[j - 1] ? 0 : 1
      dp[i][j] = Math.min(
        dp[i - 1][j] + 1,      // 삭제
        dp[i][j - 1] + 1,      // 삽입
        dp[i - 1][j - 1] + cost // 교체
      )
    }
  }
  
  return dp[m][n]
}

/**
 * 레벤슈타인 기반 유사도 (0.0 ~ 1.0)
 */
export function levenshteinSimilarity(str1: string, str2: string): number {
  const maxLen = Math.max(str1.length, str2.length)
  if (maxLen === 0) return 1.0  // 둘 다 빈 문자열
  
  const distance = levenshteinDistance(str1, str2)
  return 1 - (distance / maxLen)
}

/**
 * 포함 관계 검사 (긴 문자열이 짧은 문자열을 포함하는지)
 * 반환: 포함되는 경우 포함 비율 (0.0 ~ 1.0), 포함되지 않으면 0
 */
export function containsRatio(name1: string, name2: string): number {
  const n1 = normalizeName(name1)
  const n2 = normalizeName(name2)
  
  // 완전 일치는 제외 (normalized로 처리)
  if (n1 === n2) return 0
  
  // 짧은 것이 긴 것에 포함되는지 검사
  const shorter = n1.length <= n2.length ? n1 : n2
  const longer = n1.length > n2.length ? n1 : n2
  
  if (longer.includes(shorter)) {
    // 포함 비율 = 짧은 문자열 길이 / 긴 문자열 길이
    return shorter.length / longer.length
  }
  
  return 0
}

/**
 * 공통 키워드 추출
 */
export function extractKeywords(name: string): string[] {
  // 괄호 안 내용, 띄어쓰기 기준으로 분리
  const keywords: string[] = []
  
  // 괄호 제거 전 메인 이름
  const mainName = name.replace(/[（(][^)）]*[)）]/g, '').trim()
  if (mainName) keywords.push(mainName)
  
  // 괄호 안 내용
  const bracketMatches = name.match(/[（(]([^)）]+)[)）]/g)
  if (bracketMatches) {
    bracketMatches.forEach(match => {
      const content = match.replace(/[（()）]/g, '').trim()
      if (content) keywords.push(content)
    })
  }
  
  // 띄어쓰기 기준 분리
  const spaceSplit = mainName.split(/\s+/).filter(s => s.length > 1)
  keywords.push(...spaceSplit)
  
  return [...new Set(keywords)]
}

/**
 * 공통 키워드 비율 계산
 */
export function keywordSimilarity(name1: string, name2: string): number {
  const kw1 = extractKeywords(name1)
  const kw2 = extractKeywords(name2)
  
  if (kw1.length === 0 || kw2.length === 0) return 0
  
  // 공통 키워드 찾기
  let commonCount = 0
  for (const k1 of kw1) {
    for (const k2 of kw2) {
      const n1 = normalizeName(k1)
      const n2 = normalizeName(k2)
      if (n1 === n2 || n1.includes(n2) || n2.includes(n1)) {
        commonCount++
        break
      }
    }
  }
  
  // Jaccard 유사도와 비슷한 방식
  const totalUnique = new Set([...kw1, ...kw2]).size
  return commonCount / totalUnique
}

/**
 * 두 이름 간의 종합 유사도 계산
 */
export function calculateSimilarity(name1: string, name2: string): SimilarityResult {
  const normalized1 = normalizeName(name1)
  const normalized2 = normalizeName(name2)
  
  // 1. 완전 일치
  if (name1 === name2) {
    return {
      name1, name2, score: 1.0, matchType: 'exact',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  // 2. 정규화 후 일치
  if (normalized1 === normalized2) {
    return {
      name1, name2, score: 0.98, matchType: 'normalized',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  // 3. 포함 관계
  const containsScore = containsRatio(name1, name2)
  if (containsScore >= 0.5) {  // 50% 이상 포함
    return {
      name1, name2, score: 0.9 * containsScore + 0.05, matchType: 'contains',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  // 4. 레벤슈타인 유사도
  const levSim = levenshteinSimilarity(normalized1, normalized2)
  
  // 5. 키워드 유사도
  const kwSim = keywordSimilarity(name1, name2)
  
  // 최고 점수 선택
  if (levSim >= kwSim && levSim >= 0.7) {
    return {
      name1, name2, score: levSim, matchType: 'levenshtein',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  if (kwSim >= levSim && kwSim >= 0.5) {
    return {
      name1, name2, score: kwSim, matchType: 'keyword',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  // 포함 관계가 있지만 50% 미만인 경우
  if (containsScore > 0) {
    return {
      name1, name2, score: containsScore * 0.8, matchType: 'contains',
      normalizedName1: normalized1, normalizedName2: normalized2
    }
  }
  
  // 유사하지 않음 - 더 높은 점수 반환
  const finalScore = Math.max(levSim, kwSim)
  return {
    name1, name2, score: finalScore,
    matchType: levSim >= kwSim ? 'levenshtein' : 'keyword',
    normalizedName1: normalized1, normalizedName2: normalized2
  }
}

/**
 * 이름 목록에서 유사한 쌍 찾기
 * @param names 이름 목록
 * @param minScore 최소 유사도 점수 (기본 0.7)
 * @returns 유사한 쌍 목록 (점수 내림차순)
 */
export function findSimilarPairs(
  names: string[],
  minScore: number = 0.7
): SimilarityResult[] {
  const results: SimilarityResult[] = []
  const normalizedMap = new Map<string, string[]>()  // 정규화된 이름 → 원본 이름들
  
  // 정규화된 이름으로 그룹화 (완전 일치 제외용)
  for (const name of names) {
    const normalized = normalizeName(name)
    if (!normalizedMap.has(normalized)) {
      normalizedMap.set(normalized, [])
    }
    normalizedMap.get(normalized)!.push(name)
  }
  
  // 정규화 후 같은 이름들은 이미 병합되므로 제외
  // 서로 다른 정규화된 이름들 간의 유사도만 계산
  const uniqueNormalized = [...normalizedMap.keys()]
  
  for (let i = 0; i < uniqueNormalized.length; i++) {
    for (let j = i + 1; j < uniqueNormalized.length; j++) {
      const names1 = normalizedMap.get(uniqueNormalized[i])!
      const names2 = normalizedMap.get(uniqueNormalized[j])!
      
      // 대표 이름으로 비교
      const name1 = names1[0]
      const name2 = names2[0]
      
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
 * 정규화 후 동일한 이름 그룹 찾기
 * (기존 ETL에서 이미 병합되었어야 하지만 놓친 경우)
 */
export function findNormalizedDuplicates(names: string[]): Map<string, string[]> {
  const normalizedMap = new Map<string, string[]>()
  
  for (const name of names) {
    const normalized = normalizeName(name)
    if (!normalizedMap.has(normalized)) {
      normalizedMap.set(normalized, [])
    }
    normalizedMap.get(normalized)!.push(name)
  }
  
  // 2개 이상인 그룹만 반환
  const duplicates = new Map<string, string[]>()
  normalizedMap.forEach((originals, normalized) => {
    if (originals.length > 1) {
      duplicates.set(normalized, originals)
    }
  })
  
  return duplicates
}

