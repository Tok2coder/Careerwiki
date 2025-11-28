/**
 * Merge Major Profiles
 * major_sources → majors (merged_profile_json)
 * 
 * 병합 규칙 (2024-11-27 업데이트):
 * - hero-summary: WORK24 우선, 첫 문장만
 * - hero-category: 쉼표 2개 이상이면 미표시
 * - overview-summary: 히어로에서 안 쓴 데이터 사용
 * - overview-aptitude: CAREERNET 우선, 중복 제거
 * - details-mainSubjects: 병합 후 중복 제거
 * - sidebar-relatedJobs: 병합 후 중복 제거
 * - sidebar-licenses: licenses + qualifications 병합
 */

import type { D1Database } from '@cloudflare/workers-types'
import { getNameMappingsForETL } from '../../services/similarNamesService'

interface MergeProgress {
  total: number
  processed: number
  success: number
  failed: number
  errors: Array<{ id: string; error: string }>
  startTime: number
}

function generateSlug(name: string): string {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9가-힣\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .trim()
}

/**
 * 첫 문장만 추출 (마침표, 물음표, 느낌표 기준)
 */
function extractFirstSentence(text: string | null | undefined): string | null {
  if (!text) return null
  const match = text.match(/^(.+?[.?!。])\s*/)
  return match ? match[1].trim() : text.trim()
}

/**
 * 쉼표 개수 확인
 */
function countCommas(text: string | null | undefined): number {
  if (!text) return 0
  return (text.match(/,/g) || []).length
}

/**
 * 문자열 배열에서 중복 제거 (대소문자 무시, 공백 정규화)
 */
function deduplicateStrings(items: any[]): string[] {
  const seen = new Set<string>()
  const result: string[] = []
  
  for (const item of items) {
    const str = typeof item === 'string' ? item : item?.name || item?.toString()
    if (!str) continue
    
    const normalized = str.trim().toLowerCase().replace(/\s+/g, ' ')
    if (!seen.has(normalized)) {
      seen.add(normalized)
      result.push(str.trim())
    }
  }
  
  return result
}

/**
 * 괄호 기반 중복 제거 (heroTags용)
 * - 괄호를 제외한 기본 이름이 같으면 기본 이름으로 합침
 * - 잘못된 파싱 처리 (열린 괄호로 끝나거나, 닫힌 괄호로 시작)
 * - 기본 이름이 다른 것과 중복되지 않으면 원래 태그 유지
 */
function deduplicateTagsWithParentheses(tags: string[]): string[] {
  // 1. 전처리: 잘못된 파싱 수정
  const cleanedTags = tags.map(tag => {
    let cleaned = tag.trim()
    // 열린 괄호로 끝나는 경우 제거: "건축학과(4년제" → "건축학과"
    if (cleaned.includes('(') && !cleaned.includes(')')) {
      cleaned = cleaned.replace(/\([^)]*$/, '').trim()
    }
    // 닫힌 괄호로 시작하는 경우 제거: "5년제)" → ""
    if (cleaned.startsWith(')') || /^[^(]*\)/.test(cleaned) && !cleaned.includes('(')) {
      return '' // 이런 건 무시
    }
    return cleaned
  }).filter(Boolean)
  
  // 2. 괄호 제외한 기본 이름 추출
  const getBaseName = (tag: string): string => {
    return tag.replace(/\([^)]*\)/g, '').trim()
  }
  
  // 3. 기본 이름별로 그룹화
  const groups = new Map<string, string[]>()
  for (const tag of cleanedTags) {
    const baseName = getBaseName(tag).toLowerCase()
    if (!baseName) continue
    
    if (!groups.has(baseName)) {
      groups.set(baseName, [])
    }
    groups.get(baseName)!.push(tag)
  }
  
  // 4. 그룹별로 결과 생성
  const result: string[] = []
  const seen = new Set<string>()
  
  for (const [baseName, tagGroup] of groups) {
    if (tagGroup.length > 1) {
      // 여러 개가 같은 기본 이름이면 기본 이름만 사용
      // 원래 대소문자 유지를 위해 첫 번째 태그에서 기본 이름 추출
      const originalBaseName = getBaseName(tagGroup[0])
      const normalized = originalBaseName.toLowerCase()
      if (!seen.has(normalized)) {
        seen.add(normalized)
        result.push(originalBaseName)
      }
    } else {
      // 하나만 있으면 원래 태그 유지
      const tag = tagGroup[0]
      const normalized = tag.toLowerCase()
      if (!seen.has(normalized)) {
        seen.add(normalized)
        result.push(tag)
      }
    }
  }
  
  return result
}

/**
 * 두 값이 같은지 비교 (정규화 후)
 */
function areValuesEqual(a: any, b: any): boolean {
  if (a === b) return true
  if (!a || !b) return false
  
  const strA = typeof a === 'string' ? a : JSON.stringify(a)
  const strB = typeof b === 'string' ? b : JSON.stringify(b)
  
  return strA.trim().toLowerCase() === strB.trim().toLowerCase()
}

/**
 * 더 긴 콘텐츠 선택
 */
function selectLongerContent(a: any, b: any): any {
  const lenA = typeof a === 'string' ? a.length : JSON.stringify(a || '').length
  const lenB = typeof b === 'string' ? b.length : JSON.stringify(b || '').length
  return lenA >= lenB ? a : b
}

// ========== 이색학과 (majorGb=2) 데이터 파싱 함수들 ==========

/**
 * HTML 태그 제거
 */
function stripHtmlTags(text: string): string {
  return text
    .replace(/<[^>]+>/g, '') // HTML 태그 제거
    .replace(/&nbsp;/g, ' ') // &nbsp; → 공백
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&amp;/g, '&')
    .replace(/&quot;/g, '"')
    .replace(/\s+/g, ' ')    // 연속 공백 제거
    .trim()
}

interface ParsedWhatStudy {
  summary: string | null           // □ 입문과목 이전 텍스트 → 전공 개요
  basicSubjects: string[]          // □ 입문과목 → 기초/입문 과목
  advancedSubjects: string[]       // □ 심화과목 → 심화 과목
}

/**
 * 이색학과 whatStudy 필드 파싱
 * 형식: "설명 텍스트 □ 입문과목 과목1, 과목2, ... □ 심화과목 과목1, 과목2, ..."
 */
function parseWhatStudy(text: string | null | undefined): ParsedWhatStudy {
  const result: ParsedWhatStudy = {
    summary: null,
    basicSubjects: [],
    advancedSubjects: []
  }
  
  if (!text) return result
  
  // HTML 태그 제거 및 □ 내용 제거
  const cleanText = stripHtmlTags(text).replace(/□\s*내용\s*/g, '')
  
  // □ 입문과목, □ 심화과목 위치 찾기
  const basicIdx = cleanText.indexOf('□ 입문과목')
  const advancedIdx = cleanText.indexOf('□ 심화과목')
  
  // 1. summary: □ 입문과목 이전 텍스트
  if (basicIdx > 0) {
    result.summary = cleanText.substring(0, basicIdx).trim()
  } else if (advancedIdx > 0) {
    result.summary = cleanText.substring(0, advancedIdx).trim()
  } else {
    // □가 없으면 전체가 summary
    result.summary = cleanText.trim()
  }
  
  // 2. basicSubjects: □ 입문과목 ~ □ 심화과목 사이
  if (basicIdx >= 0) {
    const startIdx = basicIdx + '□ 입문과목'.length
    const endIdx = advancedIdx > basicIdx ? advancedIdx : cleanText.length
    const basicText = cleanText.substring(startIdx, endIdx).trim()
    
    // 과목 추출: 쉼표로 구분, "등" 제거
    result.basicSubjects = basicText
      .split(/[,、]\s*/)
      .map(s => s.trim())
      .filter(s => s && s !== '등' && s.length > 1)
  }
  
  // 3. advancedSubjects: □ 심화과목 이후
  if (advancedIdx >= 0) {
    const startIdx = advancedIdx + '□ 심화과목'.length
    const advancedText = cleanText.substring(startIdx).trim()
    
    result.advancedSubjects = advancedText
      .split(/[,、]\s*/)
      .map(s => s.trim())
      .filter(s => s && s !== '등' && s.length > 1)
  }
  
  return result
}

interface ParsedHowPrepare {
  prepareText: string | null       // □ 이전 텍스트 → 준비 방법
  universities: string[]           // □ 개설대학 → 대학 목록
  aptitude: string | null          // □ 적성과 흥미 → 적성/흥미
  licenses: string[]               // □ 취득자격 → 자격증 목록
}

/**
 * 이색학과 howPrepare 필드 파싱
 * 형식: "텍스트 □ 개설대학 ... □ 적성과 흥미 ... □ 취득자격 ..."
 */
function parseHowPrepare(text: string | null | undefined): ParsedHowPrepare {
  const result: ParsedHowPrepare = {
    prepareText: null,
    universities: [],
    aptitude: null,
    licenses: []
  }
  
  if (!text) return result
  
  // HTML 태그 제거
  const cleanText = stripHtmlTags(text)
  
  // 섹션 위치 찾기
  const uniIdx = cleanText.indexOf('□ 개설대학')
  const aptIdx = cleanText.indexOf('□ 적성과 흥미')
  const licIdx = cleanText.indexOf('□ 취득자격')
  
  // 모든 □ 섹션 위치를 배열로 정리
  const sections = [
    { name: 'uni', idx: uniIdx },
    { name: 'apt', idx: aptIdx },
    { name: 'lic', idx: licIdx }
  ].filter(s => s.idx >= 0).sort((a, b) => a.idx - b.idx)
  
  // 1. prepareText: 첫 □ 이전
  const firstSectionIdx = sections.length > 0 ? sections[0].idx : cleanText.length
  if (firstSectionIdx > 0) {
    result.prepareText = cleanText.substring(0, firstSectionIdx).trim()
  }
  
  // 2. 각 섹션 파싱
  for (let i = 0; i < sections.length; i++) {
    const section = sections[i]
    const nextIdx = i + 1 < sections.length ? sections[i + 1].idx : cleanText.length
    
    if (section.name === 'uni') {
      // □ 개설대학 파싱
      const content = cleanText.substring(section.idx + '□ 개설대학'.length, nextIdx).trim()
      // "cf) 유사학과" 부분 제거
      const mainContent = content.split(/cf\)|유사학과/)[0].trim()
      // 대학 이름 추출 (쉼표 또는 줄바꿈으로 구분)
      result.universities = mainContent
        .split(/[,\n]\s*/)
        .map(s => s.replace(/-[^\s,]+/g, '').trim()) // "두원공과대학-안성" → "두원공과대학"
        .filter(s => s && s.length > 1)
    } else if (section.name === 'apt') {
      // □ 적성과 흥미 파싱
      result.aptitude = cleanText.substring(section.idx + '□ 적성과 흥미'.length, nextIdx).trim()
    } else if (section.name === 'lic') {
      // □ 취득자격 파싱
      const content = cleanText.substring(section.idx + '□ 취득자격'.length, nextIdx).trim()
      // "· 국가자격 : 자격1, 자격2" 또는 "· 민간자격 : 자격" 형식 파싱
      const licenses: string[] = []
      
      // 콜론(:) 뒤의 자격증들 추출
      const matches = content.matchAll(/[:：]\s*([^·\n]+)/g)
      for (const match of matches) {
        const items = match[1].split(/[,、]\s*/).map(s => s.trim()).filter(Boolean)
        licenses.push(...items)
      }
      
      result.licenses = licenses.filter(s => s && s.length > 1)
    }
  }
  
  return result
}

interface ParsedJobProspect {
  careerFields: string | null      // □ 진출분야 → 진출 분야 설명
  relatedJobs: string[]            // □ 진출직업 → 관련 직업 목록
}

/**
 * 이색학과 jobProspect 필드 파싱
 * 형식: "□ 진출분야 ... □ 진출직업 직업1, 직업2"
 */
function parseJobProspect(text: string | null | undefined): ParsedJobProspect {
  const result: ParsedJobProspect = {
    careerFields: null,
    relatedJobs: []
  }
  
  if (!text) return result
  
  // HTML 태그 제거
  const cleanText = stripHtmlTags(text)
  
  const fieldIdx = cleanText.indexOf('□ 진출분야')
  const jobIdx = cleanText.indexOf('□ 진출직업')
  
  // 1. careerFields: □ 진출분야 ~ □ 진출직업 사이
  if (fieldIdx >= 0) {
    const startIdx = fieldIdx + '□ 진출분야'.length
    const endIdx = jobIdx > fieldIdx ? jobIdx : cleanText.length
    result.careerFields = cleanText.substring(startIdx, endIdx).trim()
  }
  
  // 2. relatedJobs: □ 진출직업 이후
  if (jobIdx >= 0) {
    const content = cleanText.substring(jobIdx + '□ 진출직업'.length).trim()
    result.relatedJobs = content
      .split(/[,、]\s*/)
      .map(s => s.trim())
      .filter(s => s && s.length > 1)
  }
  
  return result
}

async function createSeedLog(
  db: D1Database,
  seedType: string,
  status: string,
  stats: Partial<MergeProgress>
): Promise<number> {
  const now = Date.now()
  const result = await db.prepare(`
    INSERT INTO seed_logs (
      seed_type, started_at, completed_at, status,
      total_count, success_count, failed_count, skipped_count,
      created_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    seedType,
    stats.startTime || now,
    status === 'running' ? null : now,
    status,
    stats.total || 0,
    stats.success || 0,
    stats.failed || 0,
    0,
    now
  ).run()
  
  return result.meta.last_row_id as number
}

/**
 * 소스 우선순위에 따라 값을 병합
 */
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any }>,
  field: string
): any {
  const priority = ['CAREERNET', 'WORK24_MAJOR']
  
  for (const sourceSystem of priority) {
    const source = sources.find(s => s.system === sourceSystem)
    if (source && source.data[field]) {
      return source.data[field]
    }
  }
  
  return null
}

/**
 * Helper: 우선순위에 따라 첫 번째 유효한 값 선택
 */
function selectBestValue(...values: any[]): any {
  for (const val of values) {
    if (val !== null && val !== undefined && val !== '' && !(Array.isArray(val) && val.length === 0)) {
      return val
    }
  }
  return null
}

/**
 * 배열 필드 병합 (중복 제거)
 */
function mergeArrayFields(
  sources: Array<{ system: string; data: any }>,
  field: string
): any[] {
  const allItems: any[] = []
  const seen = new Set<string>()
  
  for (const source of sources) {
    const items = source.data[field]
    if (Array.isArray(items)) {
      for (const item of items) {
        const key = typeof item === 'string' ? item : (item?.name || item?.id || JSON.stringify(item))
        if (!seen.has(key)) {
          seen.add(key)
          allItems.push(item)
        }
      }
    }
  }
  
  return allItems
}

export async function mergeMajorProfiles(
  db: D1Database,
  options: {
    limit?: number
    majorGb?: '1' | '2'  // 1: 일반학과만, 2: 이색학과만
    majorName?: string   // 특정 전공명만
  } = {}
): Promise<MergeProgress> {
  const filterDesc = options.majorGb === '2' ? ' (이색학과만)' : 
                     options.majorGb === '1' ? ' (일반학과만)' : 
                     options.majorName ? ` (${options.majorName}만)` : ''
  console.log(`🔀 Merging Major Profiles...${filterDesc}`)
  
  const progress: MergeProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'ETL_MERGE_MAJORS', 'running', progress)
  
  try {
    // 0. 이름 매핑 테이블 조회 (유사 이름 병합용)
    console.log('📋 Loading name mappings...')
    const nameMappings = await getNameMappingsForETL(db, 'major')
    console.log(`  ✓ Loaded ${nameMappings.size} name mappings`)
    
    // 매핑 적용 함수: source_name → target_name 변환
    const applyNameMapping = (name: string): string => {
      return nameMappings.get(name) || name
    }
    
    // 1. 이름 기준으로 그룹화 (normalized_payload.name)
    console.log('📊 Grouping majors by name...')
    
    let query = `
      SELECT DISTINCT 
        JSON_EXTRACT(normalized_payload, '$.name') as major_name
      FROM major_sources
      WHERE JSON_EXTRACT(normalized_payload, '$.name') IS NOT NULL
        AND JSON_EXTRACT(normalized_payload, '$.name') != ''
    `
    
    // majorGb 필터 (이색학과/일반학과 구분) - raw_payload에서 확인
    if (options.majorGb) {
      query += ` AND JSON_EXTRACT(raw_payload, '$.majorGb') = '${options.majorGb}'`
    }
    
    // 특정 전공명 필터
    if (options.majorName) {
      query += ` AND JSON_EXTRACT(normalized_payload, '$.name') = '${options.majorName}'`
    }
    
    if (options.limit) {
      query += ` LIMIT ${options.limit}`
    }
    
    const { results: rawResults } = await db.prepare(query).all<{ major_name: string }>()
    
    if (!rawResults || rawResults.length === 0) {
      console.log('ℹ️  No majors to merge')
      await createSeedLog(db, 'ETL_MERGE_MAJORS', 'completed', progress)
      return progress
    }
    
    // 매핑을 적용하여 이름 그룹화 (source_name → target_name)
    const normalizedNames = new Set<string>()
    const nameToOriginals = new Map<string, Set<string>>()  // target_name → original names
    
    for (const row of rawResults) {
      const originalName = row.major_name
      const normalizedName = applyNameMapping(originalName)
      normalizedNames.add(normalizedName)
      
      if (!nameToOriginals.has(normalizedName)) {
        nameToOriginals.set(normalizedName, new Set())
      }
      nameToOriginals.get(normalizedName)!.add(originalName)
    }
    
    const results = [...normalizedNames].map(name => ({ major_name: name }))
    
    progress.total = results.length
    console.log(`📊 Found ${rawResults.length} raw names → ${progress.total} unique majors after mapping`)
    
    for (const row of results) {
      const majorName = row.major_name
      progress.processed++
      
      if (progress.processed % 10 === 0) {
        console.log(`📊 Progress: ${progress.processed}/${progress.total}`)
      }
      
      try {
        // 2. 해당 이름의 모든 소스 가져오기 (매핑된 원본 이름들도 포함)
        const originalNames = nameToOriginals.get(majorName) || new Set([majorName])
        const namePlaceholders = [...originalNames].map(() => '?').join(',')
        
        const { results: sources } = await db.prepare(`
          SELECT 
            id,
            source_system,
            source_key,
            raw_payload,
            normalized_payload,
            major_seq,
            department_cd
          FROM major_sources
          WHERE JSON_EXTRACT(normalized_payload, '$.name') IN (${namePlaceholders})
        `).bind(...originalNames).all<any>()
        
        if (!sources || sources.length === 0) continue
        
        console.log(`  🔀 Merging: ${majorName} (${sources.length} sources)`)
        
        // 3. normalized_payload 파싱 및 중복 소스 제거
        const parsedSourcesMap = new Map<string, any>()
        
        for (const s of sources) {
          const system = s.source_system
          // 같은 시스템의 소스가 여러 개면 첫 번째것만 사용
          if (!parsedSourcesMap.has(system)) {
            try {
              const normalizedData = s.normalized_payload && s.normalized_payload.trim() !== '' 
                ? JSON.parse(s.normalized_payload) 
                : {}
              const rawData = s.raw_payload && s.raw_payload.trim() !== '' 
                ? JSON.parse(s.raw_payload) 
                : {}
              
              // normalized_payload가 비어있으면 스킵
              if (Object.keys(normalizedData).length === 0) {
                console.warn(`  ⚠️ Empty normalized_payload for source ${s.source_key}, skipping`)
                continue
              }
              
              parsedSourcesMap.set(system, {
                id: s.id,
                system: system,
                sourceKey: s.source_key,
                majorSeq: s.major_seq,
                departmentCd: s.department_cd,
                data: normalizedData,
                raw: rawData
              })
            } catch (parseError) {
              console.error(`  ⚠️ Failed to parse payload for source ${s.source_key}:`, parseError)
              continue
            }
          }
        }
        
        const parsedSources = Array.from(parsedSourcesMap.values())
        
        // 파싱된 소스가 없으면 스킵
        if (parsedSources.length === 0) {
          console.warn(`  ⚠️ No valid sources found for ${majorName}, skipping`)
          continue
        }
        
        // 4. 소스별 데이터 추출
        const careernet = parsedSources.find(s => s.system === 'CAREERNET')?.data || {}
        const work24 = parsedSources.find(s => s.system === 'WORK24_MAJOR')?.data || {}
        const work24Raw = parsedSources.find(s => s.system === 'WORK24_MAJOR')?.raw || {}
        
        // ========== 이색학과 (majorGb=2) 데이터 정제 ==========
        let specialMajorData: {
          summary?: string | null
          basicSubjects?: string[]
          advancedSubjects?: string[]
          prepareText?: string | null
          specialUniversities?: string[]
          aptitudeFromSpecial?: string | null
          licensesFromSpecial?: string[]
          careerFields?: string | null
          relatedJobsFromSpecial?: string[]
        } = {}
        
        // majorGb는 raw_payload에 있음 (normalized에 안들어가있음)
        const majorGb = work24Raw.majorGb || work24.majorGb
        
        if (majorGb === '2') {
          console.log(`    🎨 이색학과 데이터 파싱: ${majorName}`)
          
          // whatStudy 파싱
          const parsedWhatStudy = parseWhatStudy(work24.whatStudy)
          if (parsedWhatStudy.summary) {
            specialMajorData.summary = parsedWhatStudy.summary
          }
          if (parsedWhatStudy.basicSubjects.length > 0) {
            specialMajorData.basicSubjects = parsedWhatStudy.basicSubjects
          }
          if (parsedWhatStudy.advancedSubjects.length > 0) {
            specialMajorData.advancedSubjects = parsedWhatStudy.advancedSubjects
          }
          
          // howPrepare 파싱
          const parsedHowPrepare = parseHowPrepare(work24.howPrepare)
          if (parsedHowPrepare.prepareText) {
            specialMajorData.prepareText = parsedHowPrepare.prepareText
          }
          if (parsedHowPrepare.universities.length > 0) {
            specialMajorData.specialUniversities = parsedHowPrepare.universities
          }
          if (parsedHowPrepare.aptitude) {
            specialMajorData.aptitudeFromSpecial = parsedHowPrepare.aptitude
          }
          if (parsedHowPrepare.licenses.length > 0) {
            specialMajorData.licensesFromSpecial = parsedHowPrepare.licenses
          }
          
          // jobProspect 파싱
          const parsedJobProspect = parseJobProspect(work24.jobProspect)
          if (parsedJobProspect.careerFields) {
            specialMajorData.careerFields = parsedJobProspect.careerFields
          }
          if (parsedJobProspect.relatedJobs.length > 0) {
            specialMajorData.relatedJobsFromSpecial = parsedJobProspect.relatedJobs
          }
          
          console.log(`    📊 파싱 결과: 기초과목 ${specialMajorData.basicSubjects?.length || 0}개, 심화과목 ${specialMajorData.advancedSubjects?.length || 0}개, 자격증 ${specialMajorData.licensesFromSpecial?.length || 0}개, 관련직업 ${specialMajorData.relatedJobsFromSpecial?.length || 0}개`)
        }
        
        // ========== 병합 규칙 적용 ==========
        
        // --- hero-category: categoryName 사용, 쉼표 2개 이상이면 미표시 ---
        const rawCategoryName = work24.categoryName || careernet.categoryName || null
        const categoryDisplay = rawCategoryName && countCommas(rawCategoryName) < 2 
          ? rawCategoryName 
          : null
        
        // --- hero-name: 더 긴 것 또는 복잡한 것 사용 ---
        const heroName = selectLongerContent(
          careernet.name || careernet.major,
          work24.name || work24.majorName
        ) || majorName
        
        // --- hero-summary: WORK24 우선, 첫 문장만 ---
        const work24Summary = work24.summary
        const careernetSummary = careernet.summary
        const heroSummary = extractFirstSentence(work24Summary) || extractFirstSentence(careernetSummary)
        
        // --- overview-summary: 히어로에서 안 쓴 데이터 사용, 또는 전체 ---
        let overviewSummary: string | null = null
        if (work24Summary && careernetSummary) {
          // 둘 다 있으면: 히어로에서 WORK24를 썼으니 CAREERNET 전체 사용
          overviewSummary = careernetSummary
        } else {
          // 하나만 있으면 전체 사용
          overviewSummary = work24Summary || careernetSummary || null
        }
        
        // --- hero-tags: CAREERNET.categoryName + WORK24_MAJOR.relatedMajors 병합, 중복 제거 ---
        // CAREERNET.categoryName은 쉼표로 구분된 관련 학과 목록 (예: "간호대학,간호전공,간호학과,...")
        // 이걸 분리해서 태그로 사용
        const categoryTags = careernet.categoryName 
          ? (typeof careernet.categoryName === 'string' 
              ? careernet.categoryName.split(',').map((s: string) => s.trim()).filter(Boolean)
              : [])
          : []
        
        // 괄호 기반 중복 제거: "건축학과", "건축학과(5년제)", "건축학과(건축공학전공)" → "건축학과"
        const heroTags = deduplicateTagsWithParentheses(
          deduplicateStrings([
            ...categoryTags,  // CAREERNET.categoryName (분리됨)
            ...(Array.isArray(work24.relatedMajors) ? work24.relatedMajors : [])
          ].filter(Boolean))
        )
        
        // --- overview-aptitude: CAREERNET 우선, interest와 같으면 하나만, 이색학과 aptitude도 고려 ---
        let aptitude = careernet.aptitude || work24.aptitude || specialMajorData.aptitudeFromSpecial || null
        const interest = careernet.interest
        if (aptitude && interest && areValuesEqual(aptitude, interest)) {
          // 같으면 aptitude만 사용
        } else if (aptitude && interest) {
          // 다르면 더 긴 쪽 사용
          aptitude = selectLongerContent(aptitude, interest)
        } else if (!aptitude && interest) {
          aptitude = interest
        }
        
        // --- overview-metrics: 중복 값 제거 ---
        const salary = careernet.salary || null
        const salaryAfterGraduation = careernet.salaryAfterGraduation || null
        const employment = careernet.employment || null
        const employmentRate = careernet.employmentRate || null
        
        // salary와 salaryAfterGraduation이 같으면 하나만
        const effectiveSalary = salary
        const effectiveSalaryAfterGrad = areValuesEqual(salary, salaryAfterGraduation) ? null : salaryAfterGraduation
        
        // employment와 employmentRate가 같으면 하나만
        const effectiveEmployment = employment
        const effectiveEmploymentRate = areValuesEqual(employment, employmentRate) ? null : employmentRate
        
        // --- details-mainSubjects: mainSubjects + mainSubject + relateSubject 병합 ---
        // CAREERNET의 mainSubject/relateSubject는 객체 배열 ({SBJECT_NM, SBJECT_SUMRY})일 수 있음
        const extractSubjectNames = (subjects: any): string[] => {
          if (!subjects) return []
          if (typeof subjects === 'string') return [subjects]
          if (Array.isArray(subjects)) {
            return subjects.map((s: any) => {
              if (typeof s === 'string') return s
              if (s && typeof s === 'object' && s.SBJECT_NM) return s.SBJECT_NM
              return null
            }).filter(Boolean) as string[]
          }
          return []
        }
        
        const mainSubjectsArray = deduplicateStrings([
          ...(Array.isArray(work24.mainSubjects) ? work24.mainSubjects : []),
          ...extractSubjectNames(careernet.mainSubject),
          ...extractSubjectNames(careernet.relateSubject),
          ...extractSubjectNames(careernet.main_subject),
          ...extractSubjectNames(careernet.relate_subject)
        ].filter(Boolean))
        
        // --- sidebar-relatedJobs: 병합 후 중복 제거 (이색학과 진출직업 포함) ---
        const relatedJobsArray = deduplicateStrings([
          ...(Array.isArray(work24.relatedJobs) ? work24.relatedJobs : []),
          ...(Array.isArray(careernet.relatedJobs) ? careernet.relatedJobs : []),
          ...(Array.isArray(careernet.relatedJob) ? careernet.relatedJob : []),
          ...(Array.isArray(careernet.job) ? careernet.job : []),
          ...(specialMajorData.relatedJobsFromSpecial || [])
        ].filter(Boolean))
        
        // --- sidebar-licenses: licenses + qualifications 병합 (이색학과 취득자격 포함) ---
        const licensesArray = deduplicateStrings([
          ...(Array.isArray(work24.licenses) ? work24.licenses : []),
          ...(Array.isArray(careernet.qualifications) ? careernet.qualifications : []),
          ...(Array.isArray(careernet.licenses) ? careernet.licenses : []),
          ...(specialMajorData.licensesFromSpecial || [])
        ].filter(Boolean))
        
        // --- universities: WORK24_MAJOR.universities 우선, 없으면 CAREERNET.universityList, 이색학과 개설대학 포함 ---
        const work24Unis = Array.isArray(work24.universities) ? work24.universities : []
        const careernetUnis = Array.isArray(careernet.universityList) ? careernet.universityList : 
                              Array.isArray(careernet.universities) ? careernet.universities : []
        const specialUnis = specialMajorData.specialUniversities || []
        const universitiesArray = work24Unis.length > 0 ? work24Unis : 
                                  careernetUnis.length > 0 ? careernetUnis : specialUnis
        
        // ========== 최종 병합 객체 생성 ==========
        // 이색학과인 경우 summary를 파싱된 데이터로 대체
        const finalSummary = specialMajorData.summary || overviewSummary
        
        const merged: any = {
          // 기본 정보
          name: heroName,
          categoryId: work24.categoryId || null,
          categoryName: rawCategoryName,
          categoryDisplay, // 쉼표 2개 이상이면 null
          majorGb: majorGb || null, // 이색학과 구분 (1: 일반, 2: 이색)
          
          // 히어로 섹션
          heroSummary: specialMajorData.summary ? extractFirstSentence(specialMajorData.summary) : heroSummary, // 이색학과면 파싱된 summary에서 첫 문장
          heroTags,
          
          // 개요 탭
          summary: finalSummary, // 이색학과면 파싱된 summary 사용
          property: careernet.property || null,
          aptitude, // CAREERNET 우선, 중복 제거됨, 이색학과 포함
          enterField: careernet.enterField || careernet.enter_field || null,
          prepareText: specialMajorData.prepareText || null, // 이색학과 준비 방법
          careerFields: specialMajorData.careerFields || null, // 이색학과 진출 분야
          
          // 통계 (중복 제거됨)
          salary: effectiveSalary,
          salaryAfterGraduation: effectiveSalaryAfterGrad,
          employment: effectiveEmployment,
          employmentRate: effectiveEmploymentRate,
          
          // 상세정보 탭
          whatStudy: majorGb === '2' ? null : work24.whatStudy, // 이색학과면 파싱된 데이터 사용하므로 원본은 null
          howPrepare: majorGb === '2' ? null : work24.howPrepare, // 이색학과면 파싱된 데이터 사용
          careerAct: careernet.careerAct || careernet.career_act || null,
          jobProspect: majorGb === '2' ? null : work24.jobProspect, // 이색학과면 파싱된 데이터 사용
          mainSubjects: mainSubjectsArray.length > 0 ? mainSubjectsArray : null,
          mainSubject: careernet.mainSubject || careernet.main_subject || null,
          relateSubject: careernet.relateSubject || careernet.relate_subject || null,
          
          // 이색학과 전용 교과목 필드 (기초/심화 분리)
          basicSubjects: specialMajorData.basicSubjects?.length ? specialMajorData.basicSubjects : null,
          advancedSubjects: specialMajorData.advancedSubjects?.length ? specialMajorData.advancedSubjects : null,
          
          // 대학정보 탭
          universities: universitiesArray.length > 0 ? universitiesArray : null,
          recruitmentStatus: work24.recruitmentStatus || null,
          chartData: careernet.chartData || null,
          
          // 사이드바
          relatedJobs: relatedJobsArray.length > 0 ? relatedJobsArray : null,
          licenses: licensesArray.length > 0 ? licensesArray : null,
          relatedMajors: heroTags.length > 0 ? heroTags : null, // heroTags와 동일
          
          // 기타 필드 (기존 호환성)
          goals: careernet.goals || work24.goals || null,
          curriculum: careernet.curriculum || work24.curriculum || null,
          careers: careernet.careers || work24.careers || null,
          skills: careernet.skills || work24.skills || null,
          interests: careernet.interests || work24.interests || null,
          values: careernet.values || work24.values || null,
          admission: careernet.admission || work24.admission || null,
          degreeLevel: careernet.degreeLevel || work24.degreeLevel || null,
          track: careernet.track || work24.track || null,
          department: careernet.department || work24.department || null,
          
          // 소스 정보
          sources: Array.from(new Set(parsedSources.map(s => s.system))),
          sourceIds: {
            careernet: parsedSources.find(s => s.system === 'CAREERNET')?.sourceKey?.split(':')[1] || null,
            work24: parsedSources.find(s => s.system === 'WORK24_MAJOR')?.sourceKey?.split(':')[1] || null
          }
        }
        
        // null/undefined/빈 배열/빈 객체 제거
        Object.keys(merged).forEach(key => {
          const value = merged[key]
          if (value === null || value === undefined || 
              (Array.isArray(value) && value.length === 0) ||
              (typeof value === 'object' && value !== null && !Array.isArray(value) && Object.keys(value).length === 0)) {
            delete merged[key]
          }
        })
        
        // 필수 필드 검증
        if (!merged.name || merged.name.trim() === '') {
          throw new Error('Merged profile has no name')
        }
        
        // sources 배열이 비어있으면 에러
        if (!merged.sources || merged.sources.length === 0) {
          throw new Error('Merged profile has no sources')
        }
        
        // 최소한의 데이터 검증: summary 또는 curriculum이 있어야 함
        if (!merged.summary && !merged.curriculum) {
          console.warn(`  ⚠️ ${majorName}: No summary or curriculum, but proceeding`)
        }
        
        // 5. Primary source 결정
        let primarySource = 'CAREERNET'
        if (parsedSources.every(s => s.system !== 'CAREERNET')) {
          primarySource = 'WORK24_MAJOR'
        }
        
        // 6. Slug 생성 및 기존 레코드 확인
        const slug = generateSlug(merged.name)
        
        // 먼저 slug로 기존 레코드 조회
        const existingMajor = await db.prepare(`
          SELECT id FROM majors WHERE slug = ? LIMIT 1
        `).bind(slug).first<{ id: string }>()
        
        const majorId = existingMajor?.id || `major:${slug}`
        
        // 7. majors 테이블 삽입/업데이트
        // ⚠️ careernet_id, work24_id는 NULL로 설정 (FOREIGN KEY 제약 조건 회피)
        // sourceIds는 merged_profile_json 안에 저장되어 있음
        if (existingMajor) {
          // 기존 레코드 업데이트
          await db.prepare(`
            UPDATE majors
            SET name = ?,
                primary_source = ?,
                merged_profile_json = ?
            WHERE id = ?
          `).bind(
            merged.name,
            primarySource,
            JSON.stringify(merged),
            majorId
          ).run()
        } else {
          // 새 레코드 삽입
          await db.prepare(`
            INSERT INTO majors (
              id, name, slug, primary_source, merged_profile_json,
              created_at, is_active
            ) VALUES (?, ?, ?, ?, ?, ?, 1)
          `).bind(
            majorId,
            merged.name,
            slug,
            primarySource,
            JSON.stringify(merged),
            Date.now()
          ).run()
        }
        
        // 8. major_sources의 major_id 업데이트 (역참조)
        for (const source of sources) {
          await db.prepare(`
            UPDATE major_sources
            SET major_id = ?
            WHERE id = ?
          `).bind(majorId, source.id).run()
        }
        
        progress.success++
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${majorName}: ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: majorName,
          error: errorMessage
        })
      }
    }
    
    await createSeedLog(db, 'ETL_MERGE_MAJORS', 'completed', progress)
    
    console.log('\n✅ Major Profile Merging Complete')
    console.log(`   Total: ${progress.total}`)
    console.log(`   Success: ${progress.success}`)
    console.log(`   Failed: ${progress.failed}`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during merging:', error)
    await createSeedLog(db, 'ETL_MERGE_MAJORS', 'failed', progress)
    throw error
  }
}

