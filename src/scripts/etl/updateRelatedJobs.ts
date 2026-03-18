/**
 * Update Related Jobs - 양방향 연관직업 관계 업데이트
 *
 * 1. detailClassification 기반 연관직업 추가
 *    - kecoList.kecoNm, emp_job_nm, std_job_nm, dJobECdNm에서 직업명 추출
 *
 * 2. heroTags 교차매칭 (v2)
 *    - 직업 A의 heroTags에 직업 B의 이름이 포함되면 관련직업으로 추가
 *    - 예: 숲해설사의 heroTags에 "산림치유지도사"가 있으면 양방향 연결
 *
 * 3. 이름 핵심 키워드 유사도 (v2)
 *    - 직업명에서 도메인 키워드(2글자+) 추출
 *    - 같은 도메인 키워드를 공유하는 직업끼리 연결 (빈도 2~30개 사이만)
 *    - 너무 흔한 키워드(기술, 관리 등)는 제외
 *
 * 4. 양방향 관계 보장
 *    - A가 B를 연관직업으로 가지면 B도 A를 가지도록
 *
 * 5. 중복 제거 + 자기 자신 제외
 */

import type { D1Database } from '@cloudflare/workers-types'

interface UpdateProgress {
  total: number
  updated: number
  skipped: number
  errors: Array<{ jobName: string; error: string }>
  startTime: number
}

/**
 * 대괄호 제거 헬퍼 함수
 */
function removeBrackets(value: string): string {
  return value.replace(/^\s*\[[^\]]*\]\s*/, '').trim()
}

/**
 * 문자열에서 직업명 배열 추출 (쉼표/공백 구분)
 */
function parseJobNames(value: string | null | undefined): string[] {
  if (!value) return []
  return value
    .split(/[,，\s]+/)
    .map(s => s.trim())
    .filter(s => s.length > 0)
}

/**
 * 직업명에서 도메인 키워드 추출 (접미사 제거 후 2글자 이상 서브스트링)
 * 예: "유아숲지도사" → ["유아숲", "유아", "숲지도", "숲"]
 *     "산림치유지도사" → ["산림치유", "산림", "치유"]
 */
const ROLE_SUFFIXES = [
  '연구원', '기술자', '조작원', '조립원', '정비원', '검사원', '생산원', '관리원', '관리자',
  '상담사', '치료사', '지도사', '해설사', '안내사', '안내원', '강사', '교사', '교수',
  '설계자', '개발자', '분석가', '전문가', '디자이너', '컨설턴트', '코디네이터',
  '사무원', '판매원', '운전원', '조종사', '승무원', '감독관', '조사원', '평가사',
]

// 너무 흔해서 도메인 특이성이 없는 키워드
const GENERIC_KEYWORDS = new Set([
  '기술', '관리', '전문', '연구', '개발', '설계', '검사', '조립', '생산', '운영',
  '보조', '지원', '담당', '서비스', '시스템', '정보', '사업', '기획', '제조',
  '품질', '안전', '영업', '마케팅', '홍보', '기타', '일반', '특수', '고급',
])

/**
 * 도메인 동의어 그룹: 1글자 키워드나 다른 표현이지만 같은 분야인 단어들
 * 이 단어들 중 하나라도 직업명에 포함되면 같은 도메인 그룹에 속함
 */
const DOMAIN_SYNONYM_GROUPS: string[][] = [
  ['숲', '산림'],           // 숲해설사 ↔ 산림치유지도사 ↔ 유아숲지도사
  ['바다', '해양', '수산'], // 해양생태연구원 ↔ 수산기술사
  ['항공', '비행'],         // 항공기조종사 ↔ 비행교관
  ['로봇', '자동화'],       // 로봇공학기술자 ↔ 자동화설비기술자
  ['웹', '인터넷'],         // 웹개발자 ↔ 인터넷마케터
]

function extractDomainKeywords(name: string): string[] {
  let base = name
  for (const suffix of ROLE_SUFFIXES) {
    if (base.endsWith(suffix) && base.length > suffix.length) {
      base = base.slice(0, -suffix.length)
      break
    }
  }

  // 전체 base 키워드 + 3~4글자 서브스트링 (2글자는 노이즈 많아 제외)
  const keywords: string[] = []
  // 전체 base가 2글자 이상이면 추가
  if (base.length >= 2) keywords.push(base)
  // 3~4글자 서브스트링만 추가 (2글자 서브스트링은 "치유"→"유지" 같은 오매칭 유발)
  for (let len = 3; len <= Math.min(4, base.length - 1); len++) {
    for (let i = 0; i <= base.length - len; i++) {
      const sub = base.slice(i, i + len)
      if (!GENERIC_KEYWORDS.has(sub)) {
        keywords.push(sub)
      }
    }
  }

  return [...new Set(keywords)].filter(kw => !GENERIC_KEYWORDS.has(kw))
}

export async function updateRelatedJobs(
  db: D1Database,
  options: {
    limit?: number
    dryRun?: boolean  // true면 실제 업데이트 안함
  } = {}
): Promise<UpdateProgress> {
  console.log('🔗 Updating Related Jobs (Bidirectional)...')
  
  const progress: UpdateProgress = {
    total: 0,
    updated: 0,
    skipped: 0,
    errors: [],
    startTime: Date.now()
  }
  
  try {
    // === Phase 1: 분류/태그 데이터만 경량 로드 (json_extract로 메모리 절약) ===
    let metaQuery = `
      SELECT
        id, name, slug,
        json_extract(merged_profile_json, '$.detailClassification') as classification_json,
        json_extract(merged_profile_json, '$.heroTags') as hero_tags_json,
        json_extract(merged_profile_json, '$.sidebarJobs') as sidebar_jobs_json,
        json_extract(merged_profile_json, '$.relatedJobs') as related_jobs_json
      FROM jobs
      WHERE merged_profile_json IS NOT NULL
    `
    if (options.limit) {
      metaQuery += ` LIMIT ${options.limit}`
    }

    const { results: jobMeta } = await db.prepare(metaQuery).all<{
      id: string
      name: string
      slug: string
      classification_json: string | null
      hero_tags_json: string | null
      sidebar_jobs_json: string | null
      related_jobs_json: string | null
    }>()

    if (!jobMeta || jobMeta.length === 0) {
      console.log('ℹ️  No jobs found')
      return progress
    }

    progress.total = jobMeta.length
    console.log(`📊 Found ${progress.total} jobs to process (lightweight mode)`)

    // 2. 분류 코드별 직업 맵 생성
    const kecoToJobs = new Map<string, Set<string>>()
    const empJobNmToJobs = new Map<string, Set<string>>()
    const stdJobNmToJobs = new Map<string, Set<string>>()
    const dJobECdNmToJobs = new Map<string, Set<string>>()

    // 3. 각 직업의 메타 정보 수집
    interface JobMeta {
      id: string
      slug: string
      classification: any
      heroTags: string[]
      existingSidebarJobs: string[]
      existingRelatedJobs: string[]
    }
    const jobMetaMap = new Map<string, JobMeta>()

    for (const job of jobMeta) {
      try {
        const classification = job.classification_json ? JSON.parse(job.classification_json) : null
        const heroTags = job.hero_tags_json ? JSON.parse(job.hero_tags_json) : []
        const sidebarJobs = job.sidebar_jobs_json ? JSON.parse(job.sidebar_jobs_json) : []
        const relatedJobs = job.related_jobs_json ? JSON.parse(job.related_jobs_json) : []

        jobMetaMap.set(job.name, {
          id: job.id,
          slug: job.slug,
          classification,
          heroTags: Array.isArray(heroTags) ? heroTags.map((t: any) => typeof t === 'string' ? t : '') : [],
          existingSidebarJobs: Array.isArray(sidebarJobs) ? sidebarJobs.map((j: any) => typeof j === 'string' ? j : j?.name || '').filter(Boolean) : [],
          existingRelatedJobs: Array.isArray(relatedJobs) ? relatedJobs.map((j: any) => typeof j === 'string' ? j : j?.name || '').filter(Boolean) : [],
        })

        if (!classification) continue

        // kecoList 처리
        if (Array.isArray(classification.kecoList)) {
          classification.kecoList.forEach((keco: any) => {
            const code = keco?.kecoCd || keco?.code
            if (code) {
              if (!kecoToJobs.has(code)) kecoToJobs.set(code, new Set())
              kecoToJobs.get(code)!.add(job.name)
            }
          })
        }

        if (classification.empJobNm) {
          const key = classification.empJobNm.trim()
          if (!empJobNmToJobs.has(key)) empJobNmToJobs.set(key, new Set())
          empJobNmToJobs.get(key)!.add(job.name)
        }

        if (classification.stdJobNm) {
          const key = classification.stdJobNm.trim()
          if (!stdJobNmToJobs.has(key)) stdJobNmToJobs.set(key, new Set())
          stdJobNmToJobs.get(key)!.add(job.name)
        }

        if (classification.dJobECdNm) {
          const key = classification.dJobECdNm.trim()
          if (!dJobECdNmToJobs.has(key)) dJobECdNmToJobs.set(key, new Set())
          dJobECdNmToJobs.get(key)!.add(job.name)
        }

      } catch (e) {
        console.warn(`⚠️ Failed to parse meta for ${job.name}:`, e)
      }
    }
    
    // === v2: heroTags → jobName 교차매칭 맵 ===
    const allJobNames = new Set(jobMeta.map(j => j.name))
    const tagToOwnerJobs = new Map<string, Set<string>>()

    for (const job of jobMeta) {
      const meta = jobMetaMap.get(job.name)
      if (!meta) continue
      for (const tag of meta.heroTags) {
        const t = tag.trim()
        if (!t || t === job.name) continue
        if (!tagToOwnerJobs.has(t)) tagToOwnerJobs.set(t, new Set())
        tagToOwnerJobs.get(t)!.add(job.name)
      }
    }

    // heroTag가 실제 직업명과 일치하는 것만 필터
    const heroTagCrossMatches = new Map<string, Set<string>>()  // jobName → Set<relatedJobName>
    for (const [tag, ownerJobs] of tagToOwnerJobs) {
      if (allJobNames.has(tag)) {
        // tag가 실제 직업이름 → 양방향 연결
        for (const owner of ownerJobs) {
          if (!heroTagCrossMatches.has(owner)) heroTagCrossMatches.set(owner, new Set())
          heroTagCrossMatches.get(owner)!.add(tag)
          if (!heroTagCrossMatches.has(tag)) heroTagCrossMatches.set(tag, new Set())
          heroTagCrossMatches.get(tag)!.add(owner)
        }
      }
    }

    // === v2: 이름 핵심 키워드 유사도 맵 ===
    const keywordToJobs = new Map<string, Set<string>>()
    for (const job of jobMeta) {
      const keywords = extractDomainKeywords(job.name)
      for (const kw of keywords) {
        if (!keywordToJobs.has(kw)) keywordToJobs.set(kw, new Set())
        keywordToJobs.get(kw)!.add(job.name)
      }
    }
    // 빈도 필터: 2~30개 사이만 유효 (1개=유일, 30+개=너무 흔함)
    const validKeywords = new Map<string, Set<string>>()
    for (const [kw, jobSet] of keywordToJobs) {
      if (jobSet.size >= 2 && jobSet.size <= 30 && kw.length >= 2) {
        validKeywords.set(kw, jobSet)
      }
    }

    // === v2: 도메인 동의어 그룹 매칭 ===
    const domainGroupToJobs = new Map<number, Set<string>>()
    for (const job of jobMeta) {
      for (let gi = 0; gi < DOMAIN_SYNONYM_GROUPS.length; gi++) {
        const group = DOMAIN_SYNONYM_GROUPS[gi]
        if (group.some(word => job.name.includes(word))) {
          if (!domainGroupToJobs.has(gi)) domainGroupToJobs.set(gi, new Set())
          domainGroupToJobs.get(gi)!.add(job.name)
        }
      }
    }

    console.log(`📊 Classification maps built:`)
    console.log(`   - KECO codes: ${kecoToJobs.size}`)
    console.log(`   - empJobNm: ${empJobNmToJobs.size}`)
    console.log(`   - stdJobNm: ${stdJobNmToJobs.size}`)
    console.log(`   - dJobECdNm: ${dJobECdNmToJobs.size}`)
    console.log(`   - heroTag cross-matches: ${heroTagCrossMatches.size} jobs`)
    console.log(`   - keyword matches: ${validKeywords.size} keywords`)
    console.log(`   - domain synonym groups: ${domainGroupToJobs.size} groups (${DOMAIN_SYNONYM_GROUPS.length} defined)`)
    
    // === Phase 2: 각 직업의 연관직업 계산 (메모리 경량) ===
    // 먼저 모든 직업의 새 관련직업을 계산
    const newRelatedMap = new Map<string, string[]>()

    for (const job of jobMeta) {
      try {
        const meta = jobMetaMap.get(job.name)
        if (!meta) continue

        const classification = meta.classification || {}
        const currentRelatedJobs = new Set<string>()

        // 기존 sidebarJobs/relatedJobs 유지
        meta.existingSidebarJobs.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
        meta.existingRelatedJobs.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })

        // 4.1 kecoList.kecoNm에서 직업명 추출
        if (Array.isArray(classification.kecoList)) {
          classification.kecoList.forEach((keco: any) => {
            const kecoNm = keco?.kecoNm || keco?.name
            if (kecoNm && kecoNm !== job.name) currentRelatedJobs.add(kecoNm)
          })
        }

        // 4.2 같은 분류코드를 가진 직업들
        if (Array.isArray(classification.kecoList)) {
          classification.kecoList.forEach((keco: any) => {
            const code = keco?.kecoCd || keco?.code
            if (code) kecoToJobs.get(code)?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
          })
        }
        if (classification.empJobNm) {
          empJobNmToJobs.get(classification.empJobNm.trim())?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
        }
        if (classification.stdJobNm) {
          stdJobNmToJobs.get(classification.stdJobNm.trim())?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
        }
        if (classification.dJobECdNm) {
          dJobECdNmToJobs.get(classification.dJobECdNm.trim())?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
        }

        // 4.3 (v2) heroTags 교차매칭
        heroTagCrossMatches.get(job.name)?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })

        // 4.4 (v2) 이름 핵심 키워드 유사도
        for (const kw of extractDomainKeywords(job.name)) {
          validKeywords.get(kw)?.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
        }

        // 4.5 (v2) 도메인 동의어 그룹 매칭 (그룹 크기 40 이하만)
        for (let gi = 0; gi < DOMAIN_SYNONYM_GROUPS.length; gi++) {
          if (DOMAIN_SYNONYM_GROUPS[gi].some(word => job.name.includes(word))) {
            const groupJobs = domainGroupToJobs.get(gi)
            if (groupJobs && groupJobs.size <= 40) {
              groupJobs.forEach(n => { if (n !== job.name) currentRelatedJobs.add(n) })
            }
          }
        }

        newRelatedMap.set(job.name, Array.from(currentRelatedJobs).filter(n => n && n !== job.name).sort())
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        progress.errors.push({ jobName: job.name, error: errorMessage })
      }
    }

    // 4.6 양방향 관계 보장 (별도 패스)
    for (const [jobName, relatedList] of newRelatedMap) {
      for (const relatedName of relatedList) {
        const otherList = newRelatedMap.get(relatedName)
        if (otherList && !otherList.includes(jobName)) {
          otherList.push(jobName)
          otherList.sort()
        }
      }
    }

    // === Phase 3: 변경된 직업만 DB 업데이트 (배치) ===
    const BATCH_SIZE = 50
    const updateQueue: { id: string; name: string; newRelated: string[] }[] = []

    for (const job of jobMeta) {
      const meta = jobMetaMap.get(job.name)
      if (!meta) continue

      const newRelated = newRelatedMap.get(job.name) || []
      const existingJobs = new Set([...meta.existingSidebarJobs, ...meta.existingRelatedJobs])
      const hasChanges = newRelated.length !== existingJobs.size ||
        newRelated.some(name => !existingJobs.has(name))

      if (!hasChanges) {
        progress.skipped++
        continue
      }

      updateQueue.push({ id: meta.id, name: job.name, newRelated })
    }

    console.log(`📊 ${updateQueue.length} jobs need updating, ${progress.skipped} skipped`)

    if (!options.dryRun) {
      // 배치 업데이트: json_set으로 sidebarJobs/relatedJobs만 교체 (전체 프로필 로드 불필요)
      for (let i = 0; i < updateQueue.length; i += BATCH_SIZE) {
        const batch = updateQueue.slice(i, i + BATCH_SIZE)
        const stmts = batch.map(item =>
          db.prepare(`
            UPDATE jobs
            SET merged_profile_json = json_set(
              merged_profile_json,
              '$.sidebarJobs', json(?),
              '$.relatedJobs', json(?)
            )
            WHERE id = ?
          `).bind(JSON.stringify(item.newRelated), JSON.stringify(item.newRelated), item.id)
        )
        await db.batch(stmts)
        console.log(`📊 Batch ${Math.floor(i / BATCH_SIZE) + 1}: updated ${Math.min(i + BATCH_SIZE, updateQueue.length)}/${updateQueue.length}`)
      }
    }

    progress.updated = updateQueue.length
    
    console.log('\n✅ Related Jobs Update Complete')
    console.log(`   Updated: ${progress.updated}`)
    console.log(`   Skipped (no changes): ${progress.skipped}`)
    console.log(`   Errors: ${progress.errors.length}`)
    console.log(`   Duration: ${((Date.now() - progress.startTime) / 1000).toFixed(1)}s`)
    
    return progress
    
  } catch (error) {
    console.error('❌ Fatal error during related jobs update:', error)
    throw error
  }
}






