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
    // 1. 모든 직업 가져오기
    let query = `
      SELECT id, name, slug, merged_profile_json
      FROM jobs
      WHERE merged_profile_json IS NOT NULL
    `
    
    if (options.limit) {
      query += ` LIMIT ${options.limit}`
    }
    
    const { results: jobs } = await db.prepare(query).all<{
      id: string
      name: string
      slug: string
      merged_profile_json: string
    }>()
    
    if (!jobs || jobs.length === 0) {
      console.log('ℹ️  No jobs found')
      return progress
    }
    
    progress.total = jobs.length
    console.log(`📊 Found ${progress.total} jobs to process`)
    
    // 2. 분류 코드별 직업 맵 생성
    const kecoToJobs = new Map<string, Set<string>>()      // keco코드 → 직업명 Set
    const empJobNmToJobs = new Map<string, Set<string>>()  // 고용직업분류명 → 직업명 Set
    const stdJobNmToJobs = new Map<string, Set<string>>()  // 표준직업분류명 → 직업명 Set
    const dJobECdNmToJobs = new Map<string, Set<string>>() // 직업사전분류명 → 직업명 Set
    
    // 3. 각 직업의 분류 정보 수집
    const jobProfiles = new Map<string, any>()
    
    for (const job of jobs) {
      try {
        const profile = JSON.parse(job.merged_profile_json)
        jobProfiles.set(job.name, {
          id: job.id,
          slug: job.slug,
          profile
        })
        
        const classification = profile.detailClassification
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
        
        // empJobNm 처리
        if (classification.empJobNm) {
          const key = classification.empJobNm.trim()
          if (!empJobNmToJobs.has(key)) empJobNmToJobs.set(key, new Set())
          empJobNmToJobs.get(key)!.add(job.name)
        }
        
        // stdJobNm 처리
        if (classification.stdJobNm) {
          const key = classification.stdJobNm.trim()
          if (!stdJobNmToJobs.has(key)) stdJobNmToJobs.set(key, new Set())
          stdJobNmToJobs.get(key)!.add(job.name)
        }
        
        // dJobECdNm 처리 (이미 대괄호 제거된 상태)
        if (classification.dJobECdNm) {
          const key = classification.dJobECdNm.trim()
          if (!dJobECdNmToJobs.has(key)) dJobECdNmToJobs.set(key, new Set())
          dJobECdNmToJobs.get(key)!.add(job.name)
        }
        
      } catch (e) {
        console.warn(`⚠️ Failed to parse profile for ${job.name}:`, e)
      }
    }
    
    // === v2: heroTags → jobName 교차매칭 맵 ===
    // tag가 다른 직업의 이름과 일치하면 관련직업
    const allJobNames = new Set(jobs.map(j => j.name))
    const tagToOwnerJobs = new Map<string, Set<string>>()  // tag → 이 tag를 가진 직업들

    for (const job of jobs) {
      const info = jobProfiles.get(job.name)
      if (!info) continue
      const tags = info.profile.heroTags
      if (!Array.isArray(tags)) continue
      for (const tag of tags) {
        const t = typeof tag === 'string' ? tag.trim() : ''
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
    for (const job of jobs) {
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
    const domainGroupToJobs = new Map<number, Set<string>>()  // groupIndex → jobNames
    for (const job of jobs) {
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
    
    // 4. 각 직업의 연관직업 업데이트
    for (const job of jobs) {
      try {
        const jobInfo = jobProfiles.get(job.name)
        if (!jobInfo) continue
        
        const profile = jobInfo.profile
        const classification = profile.detailClassification || {}
        
        // 현재 연관직업 Set
        const currentRelatedJobs = new Set<string>()
        
        // 기존 sidebarJobs에서 시작
        if (Array.isArray(profile.sidebarJobs)) {
          profile.sidebarJobs.forEach((j: any) => {
            const name = typeof j === 'string' ? j : j?.name
            if (name && name !== job.name) currentRelatedJobs.add(name)
          })
        }
        
        // 기존 relatedJobs에서도 추가
        if (Array.isArray(profile.relatedJobs)) {
          profile.relatedJobs.forEach((j: any) => {
            const name = typeof j === 'string' ? j : j?.name
            if (name && name !== job.name) currentRelatedJobs.add(name)
          })
        }
        
        // 4.1 분류 코드에서 직업명 추출하여 추가
        // kecoList.kecoNm
        if (Array.isArray(classification.kecoList)) {
          classification.kecoList.forEach((keco: any) => {
            const kecoNm = keco?.kecoNm || keco?.name
            if (kecoNm && kecoNm !== job.name) {
              currentRelatedJobs.add(kecoNm)
            }
          })
        }
        
        // empJobNm, stdJobNm (이름 자체가 직업명일 수 있음)
        // 하지만 보통 분류명이므로, 같은 분류의 직업들을 추가하는 게 맞음
        
        // 4.2 같은 분류코드를 가진 직업들 추가
        // 같은 KECO 코드를 가진 직업들
        if (Array.isArray(classification.kecoList)) {
          classification.kecoList.forEach((keco: any) => {
            const code = keco?.kecoCd || keco?.code
            if (code) {
              const sameCodeJobs = kecoToJobs.get(code)
              if (sameCodeJobs) {
                sameCodeJobs.forEach(relatedName => {
                  if (relatedName !== job.name) {
                    currentRelatedJobs.add(relatedName)
                  }
                })
              }
            }
          })
        }
        
        // 같은 empJobNm을 가진 직업들
        if (classification.empJobNm) {
          const sameEmpJobs = empJobNmToJobs.get(classification.empJobNm.trim())
          if (sameEmpJobs) {
            sameEmpJobs.forEach(relatedName => {
              if (relatedName !== job.name) {
                currentRelatedJobs.add(relatedName)
              }
            })
          }
        }
        
        // 같은 stdJobNm을 가진 직업들
        if (classification.stdJobNm) {
          const sameStdJobs = stdJobNmToJobs.get(classification.stdJobNm.trim())
          if (sameStdJobs) {
            sameStdJobs.forEach(relatedName => {
              if (relatedName !== job.name) {
                currentRelatedJobs.add(relatedName)
              }
            })
          }
        }
        
        // 같은 dJobECdNm을 가진 직업들
        if (classification.dJobECdNm) {
          const sameDJobJobs = dJobECdNmToJobs.get(classification.dJobECdNm.trim())
          if (sameDJobJobs) {
            sameDJobJobs.forEach(relatedName => {
              if (relatedName !== job.name) {
                currentRelatedJobs.add(relatedName)
              }
            })
          }
        }

        // 4.3 (v2) heroTags 교차매칭
        const tagMatches = heroTagCrossMatches.get(job.name)
        if (tagMatches) {
          tagMatches.forEach(relatedName => {
            if (relatedName !== job.name) {
              currentRelatedJobs.add(relatedName)
            }
          })
        }

        // 4.4 (v2) 이름 핵심 키워드 유사도
        const myKeywords = extractDomainKeywords(job.name)
        for (const kw of myKeywords) {
          const sameKwJobs = validKeywords.get(kw)
          if (sameKwJobs) {
            sameKwJobs.forEach(relatedName => {
              if (relatedName !== job.name) {
                currentRelatedJobs.add(relatedName)
              }
            })
          }
        }

        // 4.5 (v2) 도메인 동의어 그룹 매칭 (그룹 크기 40 이하만)
        for (let gi = 0; gi < DOMAIN_SYNONYM_GROUPS.length; gi++) {
          const group = DOMAIN_SYNONYM_GROUPS[gi]
          if (group.some(word => job.name.includes(word))) {
            const groupJobs = domainGroupToJobs.get(gi)
            if (groupJobs && groupJobs.size <= 40) {
              groupJobs.forEach(relatedName => {
                if (relatedName !== job.name) {
                  currentRelatedJobs.add(relatedName)
                }
              })
            }
          }
        }

        // 4.6 양방향 관계 보장: 다른 직업이 이 직업을 연관직업으로 가지면 역방향 추가
        for (const [otherName, otherInfo] of jobProfiles) {
          if (otherName === job.name) continue
          
          const otherProfile = otherInfo.profile
          const otherRelated = [
            ...(otherProfile.sidebarJobs || []),
            ...(otherProfile.relatedJobs || [])
          ]
          
          const hasThisJob = otherRelated.some((j: any) => {
            const name = typeof j === 'string' ? j : j?.name
            return name === job.name
          })
          
          if (hasThisJob) {
            currentRelatedJobs.add(otherName)
          }
        }
        
        // 5. 업데이트할 연관직업 배열 생성
        const updatedRelatedJobs = Array.from(currentRelatedJobs)
          .filter(name => name && name !== job.name)  // 자기 자신 제외
          .sort()
        
        // 6. 변경 사항 확인
        const existingJobs = new Set([
          ...(profile.sidebarJobs || []).map((j: any) => typeof j === 'string' ? j : j?.name),
          ...(profile.relatedJobs || []).map((j: any) => typeof j === 'string' ? j : j?.name)
        ])
        
        const hasChanges = updatedRelatedJobs.length !== existingJobs.size ||
          updatedRelatedJobs.some(name => !existingJobs.has(name))
        
        if (!hasChanges) {
          progress.skipped++
          continue
        }
        
        // 7. 프로필 업데이트
        profile.sidebarJobs = updatedRelatedJobs
        profile.relatedJobs = updatedRelatedJobs  // 기존 호환성 유지
        
        if (!options.dryRun) {
          await db.prepare(`
            UPDATE jobs
            SET merged_profile_json = ?
            WHERE id = ?
          `).bind(JSON.stringify(profile), job.id).run()
        }
        
        progress.updated++
        
        if (progress.updated % 50 === 0) {
          console.log(`📊 Progress: ${progress.updated}/${progress.total} updated`)
        }
        
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error)
        console.error(`❌ ${job.name}: ${errorMessage}`)
        progress.errors.push({
          jobName: job.name,
          error: errorMessage
        })
      }
    }
    
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






