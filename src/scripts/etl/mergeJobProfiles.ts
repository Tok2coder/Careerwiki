/**
 * Merge Job Profiles
 * job_sources → jobs (merged_profile_json)
 * 
 * 계층적 구조로 병합:
 * Type A: 동일 데이터 → 병합
 * Type B: 유사 데이터 → 우선순위 선택
 * Type C: 보완 데이터 → 계층적 활용 (simple/detailed)
 * Type D: 독립 데이터 → 각자 유지
 */

import type { D1Database } from '@cloudflare/workers-types'
import { normalizeGoyong24JobDetail } from '../../api/goyong24API'
import type { Goyong24JobDetailAggregated } from '../../api/goyong24API'
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
 * normalized_payload 우선, 비어있거나 null이면 raw_payload 확인
 */
function mergeFieldByPriority(
  sources: Array<{ system: string; data: any; raw?: any }>,
  field: string
): any {
  const priority = ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']
  
  for (const sourceSystem of priority) {
    const source = sources.find(s => s.system === sourceSystem)
    if (!source) continue
    
    // 1. normalized_payload 확인 (null이 아닌 값만)
    if (source.data && source.data[field] !== null && source.data[field] !== undefined && source.data[field] !== '') {
      return source.data[field]
    }
    
    // 2. raw_payload 확인 (필요한 경우에만)
    if (source.raw) {
      const rawValue = extractFieldFromRawPayload(source.raw, field, sourceSystem)
      if (rawValue !== null && rawValue !== undefined && rawValue !== '') {
        return rawValue
      }
    }
  }
  
  return null
}

/**
 * 대괄호 제거 헬퍼 함수
 * 예: "[J602]텔레비전 방송업" → "텔레비전 방송업"
 */
function removeBrackets(value: any): any {
  if (typeof value !== 'string') return value
  return value.replace(/^\s*\[[^\]]*\]\s*/, '').trim() || null
}

/**
 * raw_payload에서 필드 추출 (필요한 경우에만 사용)
 */
function extractFieldFromRawPayload(
  raw: any,
  field: string,
  system: string
): any {
  if (!raw || typeof raw !== 'object') return null
  
  // WORK24_JOB 필드 매핑
  if (system === 'WORK24_JOB') {
    const mapping: Record<string, string> = {
      'summary': 'summary.jobSum',
      'duties': 'duty.execJob',
      'salary': 'summary.sal',
      'prospect': 'summary.jobProspect',
      'status': 'summary.jobStatus',
      'abilities': 'summary.jobAbil',
      'knowledge': 'ablKnwEnv.Knwldg',
      'environment': 'ablKnwEnv.jobsEnv',
      'personality': 'summary.jobChr',
      'interests': 'summary.jobIntrst',
      'values': 'summary.jobVals'
    }
    
    const path = mapping[field]
    if (path) {
      const parts = path.split('.')
      let value = raw
      for (const part of parts) {
        if (value && typeof value === 'object') {
          value = value[part]
        } else {
          return null
        }
      }
      
      // summary 필드의 경우, summary.jobSum이 없으면 duty.jobSum도 확인
      if (field === 'summary' && (!value || value === '')) {
        const dutyJobSum = raw?.duty?.jobSum
        if (dutyJobSum && dutyJobSum.trim() !== '') {
          return dutyJobSum
        }
      }
      
      return value || null
    }
  }
  
  // WORK24_DJOB 필드 매핑
  if (system === 'WORK24_DJOB') {
    const mapping: Record<string, string> = {
      'summary': 'workSum',
      'doWork': 'doWork',
      'workStrong': 'optionJobInfo.workStrong',
      'workPlace': 'optionJobInfo.workPlace',
      'physicalAct': 'optionJobInfo.physicalAct',
      'eduLevel': 'optionJobInfo.eduLevel',
      'skillYear': 'optionJobInfo.skillYear',
      'dJobICdNm': 'optionJobInfo.dJobICdNm'  // 표준산업분류명
    }
    
    const path = mapping[field]
    if (path) {
      const parts = path.split('.')
      let value = raw
      for (const part of parts) {
        if (value && typeof value === 'object') {
          value = value[part]
        } else {
          return null
        }
      }
      // dJobICdNm 필드는 대괄호 제거 정제
      if (field === 'dJobICdNm' && typeof value === 'string') {
        return removeBrackets(value)
      }
      return value || null
    }
  }
  
  // CAREERNET은 정규화가 잘 되어있으므로 raw_payload 확인 불필요
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
 * 커리어넷 eduChart 배열을 고용24 형식 객체로 변환
 * 커리어넷 형식: [{ chart_name: "중졸이하,고졸,전문대졸,대졸,대학원졸,박사졸", chart_data: "0,0,10,80,10,0" }]
 * 변환 결과: { middleSchoolOrLess: "0%", highSchool: "0%", college: "10%", university: "80%", ... }
 */
function convertCareernetEduChart(eduChart: any[] | null | undefined): Record<string, string> | null {
  if (!eduChart || !Array.isArray(eduChart) || eduChart.length === 0) return null
  
  // 커리어넷은 쉼표로 구분된 값을 하나의 문자열로 제공
  const item = eduChart[0]
  if (!item) return null
  
  const namesStr = item?.chart_name || item?.name || ''
  const dataStr = item?.chart_data || item?.data || ''
  
  if (!namesStr || !dataStr) return null
  
  const names = namesStr.split(',').map((s: string) => s.trim())
  const values = dataStr.split(',').map((s: string) => s.trim())
  
  if (names.length !== values.length) return null
  
  // 커리어넷 라벨 → 고용24 키 매핑
  const nameToKeyMap: Record<string, string> = {
    '중졸이하': 'middleSchoolOrLess',
    '중학교 졸업 이하': 'middleSchoolOrLess',
    '중졸 이하': 'middleSchoolOrLess',
    '고졸': 'highSchool',
    '고등학교 졸업': 'highSchool',
    '전문대졸': 'college',
    '전문대학 졸업': 'college',
    '대졸': 'university',
    '대학교 졸업': 'university',
    '대학원졸': 'graduate',
    '대학원 졸업(석사)': 'graduate',
    '석사': 'graduate',
    '박사졸': 'doctor',
    '대학원 졸업(박사)': 'doctor',
    '박사': 'doctor'
  }
  
  const result: Record<string, string> = {}
  for (let i = 0; i < names.length; i++) {
    const name = names[i]
    const value = values[i]
    const key = nameToKeyMap[name]
    if (key && value && value !== '0') {
      result[key] = value.includes('%') ? value : `${value}%`
    }
  }
  
  return Object.keys(result).length > 0 ? result : null
}

/**
 * 커리어넷 majorChart 배열을 고용24 형식 객체로 변환
 * 커리어넷 형식: [{ major: "인문계열,사회계열,교육계열,공학계열,...", major_data: "0,0,0,47,53,0,0" }]
 * 변환 결과: { humanities: "0%", social: "0%", engineering: "47%", natural: "53%", ... }
 */
function convertCareernetMajorChart(majorChart: any[] | null | undefined): Record<string, string> | null {
  if (!majorChart || !Array.isArray(majorChart) || majorChart.length === 0) return null
  
  // 커리어넷은 쉼표로 구분된 값을 하나의 문자열로 제공
  const item = majorChart[0]
  if (!item) return null
  
  const namesStr = item?.major || item?.name || ''
  const dataStr = item?.major_data || item?.data || ''
  
  if (!namesStr || !dataStr) return null
  
  const names = namesStr.split(',').map((s: string) => s.trim())
  const values = dataStr.split(',').map((s: string) => s.trim())
  
  if (names.length !== values.length) return null
  
  // 커리어넷 라벨 → 고용24 키 매핑
  const nameToKeyMap: Record<string, string> = {
    '인문계열': 'humanities',
    '사회계열': 'social',
    '교육계열': 'education',
    '공학계열': 'engineering',
    '자연계열': 'natural',
    '의학계열': 'medical',
    '의약계열': 'medical',
    '예체능계열': 'artsSports',
    '예체능': 'artsSports'
  }
  
  const result: Record<string, string> = {}
  for (let i = 0; i < names.length; i++) {
    const name = names[i]
    const value = values[i]
    const key = nameToKeyMap[name]
    if (key && value && value !== '0') {
      result[key] = value.includes('%') ? value : `${value}%`
    }
  }
  
  return Object.keys(result).length > 0 ? result : null
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

export async function mergeJobProfiles(
  db: D1Database,
  options: {
    limit?: number
    jobNames?: string[]
  } = {}
): Promise<MergeProgress> {
  console.log('🔀 Merging Job Profiles...')
  
  const progress: MergeProgress = {
    total: 0,
    processed: 0,
    success: 0,
    failed: 0,
    errors: [],
    startTime: Date.now()
  }
  
  const seedLogId = await createSeedLog(db, 'ETL_MERGE_JOBS', 'running', progress)
  
  try {
    // 0. 이름 매핑 테이블 조회 (유사 이름 병합용)
    console.log('📋 Loading name mappings...')
    const nameMappings = await getNameMappingsForETL(db, 'job')
    console.log(`  ✓ Loaded ${nameMappings.size} name mappings`)
    
    // 매핑 적용 함수: source_name → target_name 변환
    const applyNameMapping = (name: string): string => {
      return nameMappings.get(name) || name
    }
    
    // 역매핑 생성: target_name → [source_name1, source_name2, ...]
    const reverseMapping = new Map<string, string[]>()
    nameMappings.forEach((targetName, sourceName) => {
      if (!reverseMapping.has(targetName)) {
        reverseMapping.set(targetName, [])
      }
      reverseMapping.get(targetName)!.push(sourceName)
    })
    
    // 1. 이름 기준으로 그룹화 (normalized_payload.name)
    console.log('📊 Grouping jobs by name...')
    
    let query = `
      SELECT DISTINCT 
        COALESCE(
          JSON_EXTRACT(normalized_payload, '$.name'),
          JSON_EXTRACT(raw_payload, '$.dJobNm'),
          JSON_EXTRACT(raw_payload, '$.jobNm')
        ) as job_name
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
    `
    
    // 특정 직업명 리스트가 주어지면 필터링
    const bindings: any[] = []
    if (options.jobNames && options.jobNames.length > 0) {
      const placeholders = options.jobNames.map(() => '?').join(',')
      query += ` AND COALESCE(
          JSON_EXTRACT(normalized_payload, '$.name'),
          JSON_EXTRACT(raw_payload, '$.dJobNm'),
          JSON_EXTRACT(raw_payload, '$.jobNm')
        ) IN (${placeholders})`
      bindings.push(...options.jobNames)
    }
    
    if (options.limit) {
      query += ` LIMIT ${options.limit}`
    }
    
    const preparedQuery = db.prepare(query)
    const { results: rawResults } = bindings.length > 0 
      ? await preparedQuery.bind(...bindings).all<{ job_name: string }>()
      : await preparedQuery.all<{ job_name: string }>()
    
    if (!rawResults || rawResults.length === 0) {
      console.log('ℹ️  No jobs to merge')
      await createSeedLog(db, 'ETL_MERGE_JOBS', 'completed', progress)
      return progress
    }
    
    // 매핑을 적용하여 이름 그룹화 (source_name → target_name)
    const normalizedNames = new Set<string>()
    const nameToOriginals = new Map<string, Set<string>>()  // target_name → original names
    
    for (const row of rawResults) {
      const originalName = row.job_name
      const normalizedName = applyNameMapping(originalName)
      normalizedNames.add(normalizedName)
      
      if (!nameToOriginals.has(normalizedName)) {
        nameToOriginals.set(normalizedName, new Set())
      }
      nameToOriginals.get(normalizedName)!.add(originalName)
    }
    
    const results = [...normalizedNames].map(name => ({ job_name: name }))
    
    progress.total = results.length
    console.log(`📊 Found ${rawResults.length} raw names → ${progress.total} unique jobs after mapping`)
    
    for (const row of results) {
      const jobName = row.job_name
      progress.processed++
      
      if (progress.processed % 10 === 0) {
        console.log(`📊 Progress: ${progress.processed}/${progress.total}`)
      }
      
      try {
        // 2. 해당 이름의 모든 소스 가져오기 (매핑된 원본 이름들도 포함)
        const originalNames = nameToOriginals.get(jobName) || new Set([jobName])
        const namePlaceholders = [...originalNames].map(() => '?').join(',')
        
        const { results: sources } = await db.prepare(`
          SELECT 
            id,
            source_system,
            source_key,
            raw_payload,
            normalized_payload,
            std_job_cd,
            keco_cd
          FROM job_sources
          WHERE COALESCE(
            JSON_EXTRACT(normalized_payload, '$.name'),
            JSON_EXTRACT(raw_payload, '$.dJobNm'),
            JSON_EXTRACT(raw_payload, '$.jobNm')
          ) IN (${namePlaceholders})
        `).bind(...originalNames).all<any>()
        
        if (!sources || sources.length === 0) continue
        
        console.log(`  🔀 Merging: ${jobName} (${sources.length} sources)`)
        
        // 3. normalized_payload 파싱 및 중복 소스 제거
        const parsedSourcesMap = new Map<string, any>()
        
        for (const s of sources) {
          const system = s.source_system
          // 같은 시스템의 소스가 여러 개면 첫 번째것만 사용 (예: CAREERNET:375, CAREERNET:375:ENCYCLOPEDIA)
          if (!parsedSourcesMap.has(system)) {
            try {
              const normalizedData = s.normalized_payload && s.normalized_payload.trim() !== '' 
                ? JSON.parse(s.normalized_payload) 
                : {}
              const rawData = s.raw_payload && s.raw_payload.trim() !== '' 
                ? JSON.parse(s.raw_payload) 
                : {}
              
              // normalized_payload가 비어있으면 raw_payload에서 직접 매핑
              let finalData = normalizedData
              if (Object.keys(normalizedData).length === 0 && Object.keys(rawData).length > 0) {
                // WORK24_DJOB (직업사전) raw_payload 매핑
                if (system === 'WORK24_DJOB' && rawData.dJobNm) {
                  // 대괄호 제거 헬퍼 함수
                  const removeBrackets = (value: any): any => {
                    if (typeof value !== 'string') return value
                    return value.replace(/^\s*\[[^\]]*\]\s*/, '').trim() || null
                  }
                  
                  finalData = {
                    name: rawData.dJobNm,
                    summary: rawData.workSum || null,
                    doWork: rawData.doWork || null,  // ✅ 올바른 필드명 사용
                    workStrong: rawData.optionJobInfo?.workStrong || null,  // ✅ 올바른 필드명 사용
                    workPlace: rawData.optionJobInfo?.workPlace || null,  // ✅ 올바른 필드명 사용
                    physicalAct: rawData.optionJobInfo?.physicalAct || null,  // ✅ 올바른 필드명 사용
                    eduLevel: rawData.optionJobInfo?.eduLevel || null,
                    skillYear: rawData.optionJobInfo?.skillYear || null,
                    workEnv: rawData.optionJobInfo?.workEnv || null,
                    similarNm: rawData.optionJobInfo?.similarNm || null,
                    connectJob: rawData.optionJobInfo?.connectJob || null,
                    certLic: rawData.optionJobInfo?.certLic || null,
                    dJobICdNm: rawData.optionJobInfo?.dJobICdNm ? removeBrackets(rawData.optionJobInfo.dJobICdNm) : null  // ✅ 대괄호 제거 정제
                  }
                }
                // WORK24_JOB (직업정보) raw_payload 매핑
                else if (system === 'WORK24_JOB' && rawData.jobNm) {
                  try {
                    // 정규화 함수 사용하여 모든 필드 매핑
                    // rawData가 Goyong24JobDetailAggregated 형식이어야 함
                    const normalized = normalizeGoyong24JobDetail(rawData as Goyong24JobDetailAggregated)
                    finalData = normalized
                    console.log(`  ✅ Normalized WORK24_JOB data for ${s.source_key} using normalizeGoyong24JobDetail`)
                  } catch (normalizeError) {
                    console.warn(`  ⚠️ Failed to normalize WORK24_JOB data for ${s.source_key}, using fallback mapping:`, normalizeError)
                    // Fallback: 기본 필드만 매핑
                  finalData = {
                    name: rawData.jobNm,
                    summary: rawData.jobSum || null,
                      salary: rawData.sal || null,
                    prospect: rawData.jobProspect || null
                    }
                  }
                }
                else {
                  console.warn(`  ⚠️ Empty normalized_payload and unrecognized format for ${s.source_key}, skipping`)
                  continue
                }
              }
              // normalized와 raw 둘 다 비어있으면 스킵
              else if (Object.keys(finalData).length === 0) {
                console.warn(`  ⚠️ Empty payload for source ${s.source_key}, skipping`)
                continue
              }
              
              parsedSourcesMap.set(system, {
                id: s.id,
                system: system,
                sourceKey: s.source_key,
                stdJobCd: s.std_job_cd,
                kecoCd: s.keco_cd,
                data: finalData,
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
          console.warn(`  ⚠️ No valid sources found for ${jobName}, skipping`)
          continue
        }
        
        // 4. 병합 로직 적용 - 계층적 구조 + 기존 평탄한 필드 모두 유지
        const careernetSource = parsedSources.find(s => s.system === 'CAREERNET')
        const jobSource = parsedSources.find(s => s.system === 'WORK24_JOB')
        const djobSource = parsedSources.find(s => s.system === 'WORK24_DJOB')
        
        const careernetRaw = careernetSource?.raw || {}
        const careernetData = careernetSource?.data || {}
        const jobData = jobSource?.data || {}
        const djobData = djobSource?.data || {}
        const djobRaw = djobSource?.raw || {}
        const goyong24Raw = jobSource?.raw || djobSource?.raw || {}
        
        // ========== 히어로 섹션 병합 ==========
        // 1.1 카테고리 (조건부 병합: 고용24 대/중/소분류 → 커리어넷 → 직업사전)
        let heroCategory = null
        
        // normalized_payload에서 classifications 우선 확인
        const jobClassifications = jobData?.classifications || djobData?.classifications
        if (jobClassifications?.large && jobClassifications?.medium && jobClassifications?.small) {
          heroCategory = {
            type: 'breadcrumb',
            large: jobClassifications.large,
            medium: jobClassifications.medium,
            small: jobClassifications.small
          }
        } else {
          // Fallback: raw_payload에서 직접 접근 (normalized_payload에 없을 때만)
        const jobLrclNm = goyong24Raw?.summary?.jobLrclNm || goyong24Raw?.jobLrclNm
        const jobMdclNm = goyong24Raw?.summary?.jobMdclNm || goyong24Raw?.jobMdclNm
        const jobSmclNm = goyong24Raw?.summary?.jobSmclNm || goyong24Raw?.jobSmclNm
        
        if (jobLrclNm && jobMdclNm && jobSmclNm) {
          heroCategory = {
            type: 'breadcrumb',
            large: jobLrclNm,
            medium: jobMdclNm,
            small: jobSmclNm
          }
        } else {
          // Fallback: 커리어넷 aptit_name → 직업사전 dJobICdNm (정제된 값)
          const fallbackValue = careernetRaw?.encyclopedia?.baseInfo?.aptit_name || 
                                djobData?.dJobICdNm ||
                                (djobRaw?.optionJobInfo?.dJobICdNm ? removeBrackets(djobRaw.optionJobInfo.dJobICdNm) : null)
          if (fallbackValue) {
            heroCategory = {
              type: 'single',
              value: fallbackValue
              }
            }
          }
        }
        
        // 1.2 직업명 (우선순위: 커리어넷 → 고용24 직업정보 → 직업사전)
        const heroTitle = selectBestValue(
          careernetData?.name,
          jobData?.name,
          djobData?.name
        )
        
        // 1.3 직업 소개 (우선순위: 고용24 직업정보 → 커리어넷 첫 문장 → 직업사전)
        const heroIntro = selectBestValue(
          jobData?.summary || goyong24Raw?.summary?.jobSum || goyong24Raw?.duty?.jobSum,  // 고용24 우선
          careernetData?.summary ? (careernetData.summary.split('.')[0] + '.').trim() : null,  // 첫 문장만
          djobData?.summary || djobData?.workSum
        )
        
        // 1.5 태그 (병합 + 중복제거: 쉼표/공백 기준 split)
        const allTagSources = [
          careernetRaw?.encyclopedia?.baseInfo?.tag,
          careernetRaw?.encyclopedia?.tagList,
          djobData?.similarNm || djobData?.optionJobInfo?.similarNm,
          djobData?.connectJob || djobData?.optionJobInfo?.connectJob
        ]
        
        const tagSet = new Set<string>()
        allTagSources.forEach(source => {
          if (!source) return
          
          let tags: string[] = []
          if (typeof source === 'string') {
            // 문자열: 쉼표/공백 기준 split
            tags = source.split(/[,，\s]+/).map(t => t.trim()).filter(t => t.length > 0)
          } else if (Array.isArray(source)) {
            // 배열: 그대로 사용
            tags = source.map(t => typeof t === 'string' ? t.trim() : String(t).trim()).filter(t => t.length > 0)
          }
          
          tags.forEach(tag => {
            if (tag && tag.length > 0) {
              tagSet.add(tag)
            }
          })
        })
        
        const heroTags = Array.from(tagSet)
        
        // ========== 개요 탭 필드 구조화 ==========
        // 2.1 overview-work (우선순위 1개 + 추가 필드)
        const overviewWork = {
          main: selectBestValue(
            careernetData?.summary,
            jobData?.duties || goyong24Raw?.duty?.execJob,
            djobData?.doWork
          ),
          workStrong: djobData?.workStrong || null,
          workPlace: djobData?.workPlace || null,
          physicalAct: djobData?.physicalAct || null,
          workEnv: djobData?.workEnv || null
        }
        
        // 2.2 overview-prospect (forecastList 우선 + jobSumProspect 별도)
        const overviewProspect = {
          main: selectBestValue(
            careernetRaw?.encyclopedia?.forecastList,
            goyong24Raw?.salProspect?.jobProspect
          ),
          forecastList: careernetRaw?.encyclopedia?.forecastList || null,
          jobProspect: goyong24Raw?.salProspect?.jobProspect || null,
          jobSumProspect: goyong24Raw?.salProspect?.jobSumProspect || null
        }
        
        // 2.3 overview-abilities (전체 병합)
        const overviewAbilities = {
          abilityList: careernetRaw?.encyclopedia?.abilityList || null,
          technKnow: goyong24Raw?.path?.technKnow || null,
          eduLevel: djobData?.eduLevel || null,
          skillYear: djobData?.skillYear || null
        }
        
        // 2.4 overview-aptitude (조건부 만족도)
        const jobSatis = goyong24Raw?.salProspect?.jobSatis
        const careernetSatis = careernetRaw?.encyclopedia?.baseInfo?.satisfication
        const careernetSatisSource = careernetRaw?.encyclopedia?.baseInfo?.satisfi_source
        
        const overviewAptitude = {
          aptitudeList: careernetRaw?.encyclopedia?.aptitudeList || null,
          interestList: careernetRaw?.encyclopedia?.interestList || null,
          satisfaction: jobSatis 
            ? { value: jobSatis, source: 'WORK24_JOB' }
            : (careernetSatis 
                ? { value: careernetSatis, source: careernetSatisSource || 'CAREERNET' }
                : null)
        }
        
        // 2.5 overview-salary (조건부 세트: 직업정보 우선 → 커리어넷 세트)
        const goyong24Sal = goyong24Raw?.salProspect?.sal
        const careernetWage = careernetRaw?.encyclopedia?.baseInfo?.wage
        const careernetWageSource = careernetRaw?.encyclopedia?.baseInfo?.wage_source
        
        const overviewSalary = goyong24Sal
          ? { sal: goyong24Sal, source: 'WORK24_JOB' }
          : (careernetWage
              ? { wage: careernetWage, wageSource: careernetWageSource, source: 'CAREERNET' }
              : null)
        
        const merged: any = {
          // 기본 정보 (UnifiedJobDetail 인터페이스 필드)
          name: jobName,
          
          // ========== 히어로 섹션 필드 ==========
          heroCategory,
          heroTitle: heroTitle || jobName,
          heroIntro,
          heroTags,
          
          // ========== 개요 탭 구조화 필드 ==========
          overviewWork,
          overviewProspect,
          overviewAbilities,
          overviewAptitude,
          overviewSalary,
          
          // ========== 상세정보 탭 구조화 필드 ==========
          // 3.1 detail-education (우선순위: 고용24 → 커리어넷, 커리어넷은 차트 형식을 객체로 변환)
          detailEducation: {
            majorDistribution: selectBestValue(
              goyong24Raw?.path?.majorDistribution,
              convertCareernetMajorChart(careernetRaw?.encyclopedia?.majorChart)
            ),
            educationDistribution: selectBestValue(
              goyong24Raw?.path?.educationDistribution,
              convertCareernetEduChart(careernetRaw?.encyclopedia?.eduChart)
            )
          },
          
          // 3.2 detail-ready (전체 포함)
          detailReady: {
            recruit: careernetRaw?.encyclopedia?.jobReadyList?.recruit || null,
            certificate: careernetRaw?.encyclopedia?.jobReadyList?.certificate || null,
            training: careernetRaw?.encyclopedia?.jobReadyList?.training || null,
            curriculum: careernetRaw?.encyclopedia?.jobReadyList?.curriculum || null,
            researchList: careernetRaw?.encyclopedia?.researchList || null
          },
          
          // 3.3 detail-classification (연관직업 소스용 - 표시 안함)
          detailClassification: {
            kecoList: goyong24Raw?.path?.kecoList || null,
            empJobNm: careernetRaw?.encyclopedia?.baseInfo?.emp_job_nm || null,
            stdJobNm: careernetRaw?.encyclopedia?.baseInfo?.std_job_nm || null,
            dJobECdNm: djobRaw?.optionJobInfo?.dJobECdNm 
              ? removeBrackets(djobRaw.optionJobInfo.dJobECdNm) 
              : null
          },
          
          // 3.4 detail-wlb (둘 다)
          detailWlb: {
            wlb: careernetRaw?.encyclopedia?.baseInfo?.wlb || null,
            social: careernetRaw?.encyclopedia?.baseInfo?.social || null
          },
          
          // 3.5 detail-indicators
          detailIndicators: careernetRaw?.encyclopedia?.indicatorChart || null,
          
          // ========== 업무특성 탭 구조화 필드 ==========
          // 4.1 char-knowledge (고용24 우선 → 커리어넷)
          charKnowledge: goyong24Raw?.ablKnwEnv?.Knwldg
            ? {
                Knwldg: goyong24Raw.ablKnwEnv.Knwldg,
                KnwldgCmpr: goyong24Raw.ablKnwEnv.KnwldgCmpr || null,
                KnwldgLvl: goyong24Raw.ablKnwEnv.KnwldgLvl || null,
                KnwldgLvlCmpr: goyong24Raw.ablKnwEnv.KnwldgLvlCmpr || null,
                source: 'WORK24_JOB'
              }
            : (careernetRaw?.encyclopedia?.performList?.knowledge 
                ? { knowledge: careernetRaw.encyclopedia.performList.knowledge, source: 'CAREERNET' }
                : null),
          
          // 4.2 char-status (전체)
          charStatus: goyong24Raw?.actv
            ? {
                jobActvImprtnc: goyong24Raw.actv.jobActvImprtnc || null,
                jobActvImprtncCmpr: goyong24Raw.actv.jobActvImprtncCmpr || null,
                jobActvLvl: goyong24Raw.actv.jobActvLvl || null,
                jobActvLvlCmpr: goyong24Raw.actv.jobActvLvlCmpr || null
              }
            : null,
          
          // 4.3 char-environment (전체)
          charEnvironment: goyong24Raw?.ablKnwEnv
            ? {
                jobsEnv: goyong24Raw.ablKnwEnv.jobsEnv || null,
                jobsEnvCmpr: goyong24Raw.ablKnwEnv.jobsEnvCmpr || null
              }
            : null,
          
          // 4.4 char-performance (고용24 우선 → 커리어넷)
          charPerformance: goyong24Raw?.ablKnwEnv?.jobAbil
            ? {
                jobAbil: goyong24Raw.ablKnwEnv.jobAbil,
                jobAbilCmpr: goyong24Raw.ablKnwEnv.jobAbilCmpr || null,
                jobAbilLvl: goyong24Raw.ablKnwEnv.jobAbilLvl || null,
                jobAbilLvlCmpr: goyong24Raw.ablKnwEnv.jobAbilLvlCmpr || null,
                source: 'WORK24_JOB'
              }
            : (careernetRaw?.encyclopedia?.performList?.perform
                ? { perform: careernetRaw.encyclopedia.performList.perform, source: 'CAREERNET' }
                : null),
          
          // 4.5 char-interest (흥미)
          charInterest: goyong24Raw?.chrIntrVals
            ? {
                jobIntrst: goyong24Raw.chrIntrVals.jobIntrst || null,
                jobIntrstCmpr: goyong24Raw.chrIntrVals.jobIntrstCmpr || null
              }
            : null,
          
          // 4.6 char-values (가치관)
          charValues: goyong24Raw?.chrIntrVals
            ? {
                jobVals: goyong24Raw.chrIntrVals.jobVals || null,
                jobValsCmpr: goyong24Raw.chrIntrVals.jobValsCmpr || null
              }
            : null,
          
          // ========== 평탄한 필드 (기존 템플릿 호환성 유지) ==========
          summary: mergeFieldByPriority(parsedSources, 'summary'),
          duties: mergeFieldByPriority(parsedSources, 'duties'),
          way: mergeFieldByPriority(parsedSources, 'way'),
          
          // 전망 및 통계
          salary: mergeFieldByPriority(parsedSources, 'salary'),
          satisfaction: mergeFieldByPriority(parsedSources, 'satisfaction'),
          prospect: mergeFieldByPriority(parsedSources, 'prospect'),
          status: mergeFieldByPriority(parsedSources, 'status'),
          
          // 능력 및 지식
          abilities: mergeFieldByPriority(parsedSources, 'abilities'),
          knowledge: mergeFieldByPriority(parsedSources, 'knowledge'),
          environment: mergeFieldByPriority(parsedSources, 'environment'),
          
          // 적성 및 흥미
          personality: mergeFieldByPriority(parsedSources, 'personality'),
          interests: mergeFieldByPriority(parsedSources, 'interests'),
          values: mergeFieldByPriority(parsedSources, 'values'),
          
          // 활동 및 업무
          activitiesImportance: mergeFieldByPriority(parsedSources, 'activitiesImportance'),
          activitiesLevels: mergeFieldByPriority(parsedSources, 'activitiesLevels'),
          workList: mergeArrayFields(parsedSources, 'workList'),
          performList: mergeFieldByPriority(parsedSources, 'performList'),
          
          // 교육 관련 (고용24 사전)
          eduLevel: mergeFieldByPriority(parsedSources, 'eduLevel'),
          skillYear: mergeFieldByPriority(parsedSources, 'skillYear'),

          // 배열 필드: 관계 정보 (기존 호환성 유지)
          relatedJobs: mergeArrayFields(parsedSources, 'relatedJobs'),
          relatedMajors: mergeArrayFields(parsedSources, 'relatedMajors'),
          relatedCertificates: mergeArrayFields(parsedSources, 'relatedCertificates'),
          relatedOrganizations: mergeArrayFields(parsedSources, 'relatedOrganizations'),
          
          // ========== 사이드바 구조화 필드 ==========
          // 5.1 sidebar-jobs (connectJob 제외 - heroTags에만 포함)
          // relatedJobs에서 connectJob 값들을 제외하고 중복 제거
          sidebarJobs: (() => {
            const allJobs = mergeArrayFields(parsedSources, 'relatedJobs')
            // connectJob 값들 (태그에 이미 포함되어 있으므로 연관직업에서 제외)
            const connectJobValues = new Set<string>()
            const connectJob = djobData?.connectJob || djobData?.optionJobInfo?.connectJob
            if (typeof connectJob === 'string') {
              connectJob.split(/[,，\s]+/).forEach((j: string) => {
                if (j.trim()) connectJobValues.add(j.trim())
              })
            } else if (Array.isArray(connectJob)) {
              connectJob.forEach((j: any) => {
                const name = typeof j === 'string' ? j : j?.name
                if (name?.trim()) connectJobValues.add(name.trim())
              })
            }
            // connectJob에 있는 값은 제외
            return allJobs.filter((job: any) => {
              const jobName = typeof job === 'string' ? job : job?.name
              return jobName && !connectJobValues.has(jobName.trim())
            })
          })(),
          
          // 5.2 sidebar-majors (중복 없이 병합)
          sidebarMajors: (() => {
            const majors: any[] = []
            const seen = new Set<string>()
            
            // WORK24_JOB.path.relMajorList
            const jobMajors = goyong24Raw?.path?.relMajorList
            if (Array.isArray(jobMajors)) {
              jobMajors.forEach((m: any) => {
                const key = m?.majorNm || m?.name || (typeof m === 'string' ? m : null)
                if (key && !seen.has(key)) {
                  seen.add(key)
                  majors.push(m)
                }
              })
            }
            
            // CAREERNET.encyclopedia.departList
            const careernetMajors = careernetRaw?.encyclopedia?.departList
            if (Array.isArray(careernetMajors)) {
              careernetMajors.forEach((m: any) => {
                const key = m?.depart_name || m?.name || (typeof m === 'string' ? m : null)
                if (key && !seen.has(key)) {
                  seen.add(key)
                  majors.push(m)
                }
              })
            }
            
            return majors.length > 0 ? majors : null
          })(),
          
          // 5.3 sidebar-orgs (중복 없이 병합 + 링크 포함)
          sidebarOrgs: (() => {
            const orgs: any[] = []
            const seen = new Set<string>()
            
            // WORK24_JOB.path.relOrgList
            const jobOrgs = goyong24Raw?.path?.relOrgList
            if (Array.isArray(jobOrgs)) {
              jobOrgs.forEach((o: any) => {
                const key = o?.orgNm || o?.name || (typeof o === 'string' ? o : null)
                if (key && !seen.has(key)) {
                  seen.add(key)
                  orgs.push({
                    name: key,
                    url: o?.orgSiteUrl || o?.url || null
                  })
                }
              })
            }
            
            // CAREERNET.encyclopedia.jobRelOrgList
            const careernetOrgs = careernetRaw?.encyclopedia?.jobRelOrgList
            if (Array.isArray(careernetOrgs)) {
              careernetOrgs.forEach((o: any) => {
                const key = o?.rel_org || o?.name || (typeof o === 'string' ? o : null)
                if (key && !seen.has(key)) {
                  seen.add(key)
                  orgs.push({
                    name: key,
                    url: o?.rel_org_url || o?.url || null
                  })
                }
              })
            }
            
            return orgs.length > 0 ? orgs : null
          })(),
          
          // 5.4 sidebar-certs (중복 없이 병합 + 링크 포함 + 포함 관계 체크)
          sidebarCerts: (() => {
            const certs: any[] = []
            const seen = new Set<string>()
            
            // 포함 관계 체크: 기존 항목 중 새 항목을 포함하는 게 있는지 확인
            // 예: "기계정비기능사, 산업기사(국가기술)"가 있으면 "기계정비기능사"는 스킵
            const isAlreadyIncluded = (newKey: string): boolean => {
              for (const existing of seen) {
                if (existing.includes(newKey)) return true
              }
              return false
            }
            
            // WORK24_JOB.path.relCertList
            const jobCerts = goyong24Raw?.path?.relCertList
            if (Array.isArray(jobCerts)) {
              jobCerts.forEach((c: any) => {
                const key = c?.certNm || c?.name || (typeof c === 'string' ? c : null)
                if (key && !seen.has(key) && !isAlreadyIncluded(key)) {
                  seen.add(key)
                  certs.push({
                    name: key,
                    url: c?.url || null
                  })
                }
              })
            }
            
            // CAREERNET.encyclopedia.certiList
            const careernetCerts = careernetRaw?.encyclopedia?.certiList
            if (Array.isArray(careernetCerts)) {
              careernetCerts.forEach((c: any) => {
                const key = c?.certi || c?.name || (typeof c === 'string' ? c : null)
                if (key && !seen.has(key) && !isAlreadyIncluded(key)) {
                  seen.add(key)
                  certs.push({
                    name: key,
                    url: null  // 커리어넷에는 링크 없음
                  })
                }
              })
            }
            
            // WORK24_DJOB.optionJobInfo.certLic
            const djobCerts = djobData?.certLic || djobRaw?.optionJobInfo?.certLic
            if (typeof djobCerts === 'string') {
              djobCerts.split(/[,，\s]+/).forEach((c: string) => {
                const key = c.trim()
                if (key && !seen.has(key) && !isAlreadyIncluded(key)) {
                  seen.add(key)
                  certs.push({
                    name: key,
                    url: null
                  })
                }
              })
            }
            
            return certs.length > 0 ? certs : null
          })(),
          
          // 분류 정보
          category: mergeFieldByPriority(parsedSources, 'category'),
          classifications: mergeFieldByPriority(parsedSources, 'classifications'),
          kecoCodes: mergeArrayFields(parsedSources, 'kecoCodes'),
          
          // 분포 데이터
          educationDistribution: mergeFieldByPriority(parsedSources, 'educationDistribution'),
          majorDistribution: mergeFieldByPriority(parsedSources, 'majorDistribution'),
          
          // 능력 리스트
          abilityList: mergeArrayFields(parsedSources, 'abilityList'),
          aptitudeList: mergeArrayFields(parsedSources, 'aptitudeList'),
          interestList: mergeArrayFields(parsedSources, 'interestList'),
        }
        
        // 준비 정보 (jobReadyList) - relatedCertificates와 중복 제거 로직 포함
        const rawJobReadyList = mergeFieldByPriority(parsedSources, 'jobReadyList')
        if (rawJobReadyList && typeof rawJobReadyList === 'object') {
          const dedupedJobReadyList = { ...rawJobReadyList }
          
          // jobReadyList.certificate에서 relatedCertificates와 중복되는 항목 제거
          if (Array.isArray(dedupedJobReadyList.certificate) && Array.isArray(merged.relatedCertificates)) {
            dedupedJobReadyList.certificate = dedupedJobReadyList.certificate.filter(
              (cert: string) => !merged.relatedCertificates.includes(cert)
            )
            // 빈 배열이면 필드 자체를 제거
            if (dedupedJobReadyList.certificate.length === 0) {
              delete dedupedJobReadyList.certificate
            }
          }
          
          merged.jobReadyList = dedupedJobReadyList
        }
        
        const merged2 = {
          ...merged,
          
          // 전망 리스트
          forecastList: mergeArrayFields(parsedSources, 'forecastList'),
          indicatorChart: mergeArrayFields(parsedSources, 'indicatorChart'),
          
          // 리소스
          relVideoList: mergeArrayFields(parsedSources, 'relVideoList'),
          relSolList: mergeArrayFields(parsedSources, 'relSolList'),
          relJinsolList: mergeArrayFields(parsedSources, 'relJinsolList'),
          researchList: mergeArrayFields(parsedSources, 'researchList'),
          
          // 기타
          technKnow: mergeFieldByPriority(parsedSources, 'technKnow'),
          
          // WORK24_DJOB 특수 필드 (주요 업무 섹션용)
          // finalData에서 이미 올바른 필드명으로 매핑되었으므로 djobData에서 직접 사용
          doWork: djobData?.doWork || null,
          workStrong: djobData?.workStrong || null,
          workPlace: djobData?.workPlace || null,
          physicalAct: djobData?.physicalAct || null,
          dJobICdNm: djobData?.dJobICdNm || null,
          workEnv: djobData?.workEnv || null,
          similarNm: djobData?.similarNm || null,
          connectJob: djobData?.connectJob || null,
          certLic: djobData?.certLic || null,
          workSum: djobData?.workSum || null,
          aptitude: djobData?.aptitude || null,
          
          // Phase 4: 평탄한 필드 구조 - CAREERNET 전용 필드
          wlb: careernetRaw?.encyclopedia?.baseInfo?.wlb || null,
          social: careernetRaw?.encyclopedia?.baseInfo?.social || null,
          tagList: careernetRaw?.encyclopedia?.tagList || (careernetRaw?.encyclopedia?.baseInfo?.tag ? careernetRaw.encyclopedia.baseInfo.tag.split(',').map((t: string) => t.trim()).filter(Boolean) : null),
          performList: careernetRaw?.encyclopedia?.performList || null,
          eduChart: careernetRaw?.encyclopedia?.eduChart || null,
          majorChart: careernetRaw?.encyclopedia?.majorChart || null,
          
          // Phase 4: 평탄한 필드 구조 - WORK24_JOB 전용 필드
          jobSumProspect: goyong24Raw?.salProspect?.jobSumProspect || null,
          ablKnwEnv: goyong24Raw?.ablKnwEnv || null,
          chrIntrVals: goyong24Raw?.chrIntrVals || null,
          actv: goyong24Raw?.actv || null,
          
          // [DEPRECATED] 계층적 구조 - 제거 예정, 하위 호환성을 위해 임시 유지
          work: {
            simple: mergeArrayFields(parsedSources, 'workList'),
            summary: mergeFieldByPriority(parsedSources, 'summary'),
            detailed: mergeFieldByPriority(parsedSources, 'duties')
          },
          abilitiesDetail: {
            simple: mergeArrayFields(parsedSources, 'abilityList'),
            summary: mergeFieldByPriority(parsedSources, 'abilities')
          },
          knowledgeDetail: {
            simple: mergeFieldByPriority(parsedSources, 'knowledge')
          },
          educationDetail: {
            simple: mergeFieldByPriority(parsedSources, 'educationDistribution')
          },
          majorDetail: {
            simple: mergeArrayFields(parsedSources, 'relatedMajors')
          },
          
          // [DEPRECATED] 소스별 독립 데이터 - 제거 예정, 하위 호환성을 위해 임시 유지
          careernetOnly: {
            wlb: careernetRaw?.encyclopedia?.baseInfo?.wlb || null,
            social: careernetRaw?.encyclopedia?.baseInfo?.social || null,
            researchList: careernetRaw?.encyclopedia?.researchList || null,
            tagList: careernetRaw?.encyclopedia?.tagList || null,
            jobReadyList: careernetRaw?.encyclopedia?.jobReadyList || null,
            licenseAdv: careernetRaw?.encyclopedia?.baseInfo?.licenseAdv || null,
            videos: careernetRaw?.encyclopedia?.relVideoList || null,
            performList: careernetRaw?.encyclopedia?.performList || null
          },
          goyong24Only: {
            prospectDetail: goyong24Raw?.salProspect?.jobSumProspect || null,
            prospectChart: goyong24Raw?.salProspect?.jobSumProspect || null,
            personality: goyong24Raw?.chrIntrVals || null,
            interest: goyong24Raw?.chrIntrVals || null,
            values: goyong24Raw?.chrIntrVals || null,
            activity: goyong24Raw?.actv || null,
            workEnvironment: goyong24Raw?.ablKnwEnv || null,
            entryStatistics: goyong24Raw?.workCond?.entry || null
          },
          
          // 소스 정보 (중복 제거)
          sources: Array.from(new Set(parsedSources.map(s => s.system))),
          sourceIds: {
            careernet: parsedSources.find(s => s.system === 'CAREERNET')?.sourceKey?.split(':')[1] || null,
            goyong24: parsedSources.find(s => s.system === 'WORK24_JOB')?.sourceKey?.split(':')[1] || 
                      parsedSources.find(s => s.system === 'WORK24_DJOB')?.sourceKey?.split(':')[1] || null
          }
        }
        
        // null/undefined/빈 배열/빈 객체 제거
        Object.keys(merged2).forEach(key => {
          const value = merged2[key]
          if (value === null || value === undefined || 
              (Array.isArray(value) && value.length === 0) ||
              (typeof value === 'object' && value !== null && !Array.isArray(value) && Object.keys(value).length === 0)) {
            delete merged2[key]
          }
        })
        
        // 필수 필드 검증
        if (!merged2.name || merged2.name.trim() === '') {
          throw new Error('Merged profile has no name')
        }
        
        // sources 배열이 비어있으면 에러
        if (!merged2.sources || merged2.sources.length === 0) {
          throw new Error('Merged profile has no sources')
        }
        
        // 최소한의 데이터 검증: summary 또는 duties가 있어야 함
        if (!merged2.summary && !merged2.duties) {
          console.warn(`  ⚠️ ${jobName}: No summary or duties, but proceeding`)
        }
        
        // 5. Primary source 결정
        let primarySource = 'CAREERNET'
        if (parsedSources.every(s => s.system !== 'CAREERNET')) {
          primarySource = parsedSources.some(s => s.system === 'WORK24_JOB') 
            ? 'WORK24_JOB' 
            : 'WORK24_DJOB'
        }
        
        // 6. Slug 생성 및 기존 레코드 확인
        const slug = generateSlug(merged2.name)
        
        // 먼저 slug로 기존 레코드 조회
        const existingJob = await db.prepare(`
          SELECT id FROM jobs WHERE slug = ? LIMIT 1
        `).bind(slug).first<{ id: string }>()
        
        // ID 생성: 기존 ID 사용 또는 타임스탬프 기반 숫자 ID 생성
        const jobId = existingJob?.id || `${Date.now()}${Math.floor(Math.random() * 1000)}`
        
        // merged2 객체에 id 추가 (템플릿에서 사용)
        merged2.id = jobId
        
        // 7. jobs 테이블 삽입/업데이트
        // ⚠️ careernet_id, goyong24_id는 NULL로 설정 (FOREIGN KEY 제약 조건 회피)
        // sourceIds는 merged_profile_json 안에 저장되어 있음
        if (existingJob) {
          // 기존 레코드 업데이트
          await db.prepare(`
            UPDATE jobs
            SET name = ?,
                primary_source = ?,
                merged_profile_json = ?
            WHERE id = ?
          `).bind(
            merged2.name,
            primarySource,
            JSON.stringify(merged2),
            jobId
          ).run()
        } else {
          // 새 레코드 삽입
          await db.prepare(`
            INSERT INTO jobs (
              id, name, slug, primary_source, merged_profile_json,
              created_at, is_active
            ) VALUES (?, ?, ?, ?, ?, ?, 1)
          `).bind(
            jobId,
            merged2.name,
            slug,
            primarySource,
            JSON.stringify(merged2),
            Date.now()
          ).run()
        }
        
        // 8. job_sources의 job_id 업데이트 (역참조)
        for (const source of sources) {
          await db.prepare(`
            UPDATE job_sources
            SET job_id = ?
            WHERE id = ?
          `).bind(jobId, source.id).run()
        }
        
        progress.success++
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`  ❌ ${jobName}: ${errorMessage}`)
        
        progress.failed++
        progress.errors.push({
          id: jobName,
          error: errorMessage
        })
      }
    }
    
    // ===== 2단계: 병합 안 된 단독 소스들 추가 =====
    console.log('\n📦 Processing unmerged standalone sources...')
    
    // 이미 jobs 테이블에 있는 소스 ID 가져오기
    const { results: processedSources } = await db.prepare(`
      SELECT DISTINCT js.id
      FROM job_sources js
      INNER JOIN jobs j ON js.job_id = j.id
    `).all<{ id: number }>()
    
    const processedIds = new Set(processedSources?.map(r => r.id) || [])
    
    // 병합 안 된 소스들 가져오기
    const { results: unmergedSources } = await db.prepare(`
      SELECT 
        id,
        source_system,
        source_key,
        raw_payload,
        normalized_payload
      FROM job_sources
      WHERE job_id IS NULL
        AND JSON_EXTRACT(normalized_payload, '$.name') IS NOT NULL
        AND JSON_EXTRACT(normalized_payload, '$.name') != ''
    `).all<any>()
    
    console.log(`📊 Found ${unmergedSources?.length || 0} unmerged sources`)
    
    let standaloneSuccess = 0
    let standaloneFailed = 0
    
    for (const source of unmergedSources || []) {
      // 이미 처리된 소스는 스킵
      if (processedIds.has(source.id)) continue
      
      try {
        const normalizedData = JSON.parse(source.normalized_payload || '{}')
        const rawData = JSON.parse(source.raw_payload || '{}')
        const jobName = normalizedData.name
        
        if (!jobName) {
          standaloneFailed++
          continue
        }
        
        // 단독 소스로 jobs에 추가 (병합 없이)
        const slug = generateSlug(jobName)
        const primarySource = source.source_system
        
        // merged_profile_json은 normalized_payload를 그대로 사용
        const merged = {
          name: jobName,
          ...normalizedData,
          sources: [primarySource],
          sourceIds: {
            [primarySource.toLowerCase()]: source.source_key?.split(':')[1] || null
          }
        }
        
        // jobs 테이블에 INSERT (중복 방지)
        const existingJob = await db.prepare(`
          SELECT id FROM jobs WHERE slug = ? LIMIT 1
        `).bind(slug).first<{ id: string }>()
        
        let jobId: string
        
        if (existingJob) {
          jobId = existingJob.id
        } else {
          // 타임스탬프 기반 숫자 ID 생성
          jobId = `${Date.now()}${Math.floor(Math.random() * 1000)}`
        }
        
        // merged 객체에 id 추가 (템플릿에서 사용)
        merged.id = jobId
        
        if (!existingJob) {
          const insertResult = await db.prepare(`
            INSERT INTO jobs (
              id, name, slug, primary_source, merged_profile_json, created_at
            ) VALUES (?, ?, ?, ?, ?, ?)
          `).bind(
            jobId,
            jobName,
            slug,
            primarySource,
            JSON.stringify(merged),
            Date.now()
          ).run()
        }
        
        // job_sources의 job_id 업데이트
        await db.prepare(`
          UPDATE job_sources SET job_id = ? WHERE id = ?
        `).bind(jobId, source.id).run()
        
        standaloneSuccess++
        
        if (standaloneSuccess % 100 === 0) {
          console.log(`📊 Standalone progress: ${standaloneSuccess}/${unmergedSources.length}`)
        }
        
      } catch (error) {
        console.error(`  ❌ Failed to add standalone source ${source.id}:`, error)
        standaloneFailed++
      }
    }
    
    console.log(`\n✅ Standalone Sources Added`)
    console.log(`   Success: ${standaloneSuccess}`)
    console.log(`   Failed: ${standaloneFailed}`)
    
    await createSeedLog(db, 'ETL_MERGE_JOBS', 'completed', progress)
    
    console.log('\n✅ Job Profile Merging Complete')
    console.log(`   Merged: ${progress.success}`)
    console.log(`   Standalone: ${standaloneSuccess}`)
    console.log(`   Total: ${progress.success + standaloneSuccess}`)
    console.log(`   Failed: ${progress.failed + standaloneFailed}`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during merging:', error)
    await createSeedLog(db, 'ETL_MERGE_JOBS', 'failed', progress)
    throw error
  }
}
