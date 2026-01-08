/**
 * Update Related Jobs - 양방향 연관직업 관계 업데이트
 * 
 * 1. detailClassification 기반 연관직업 추가
 *    - kecoList.kecoNm, emp_job_nm, std_job_nm, dJobECdNm에서 직업명 추출
 * 
 * 2. 양방향 관계 보장
 *    - A가 B를 연관직업으로 가지면 B도 A를 가지도록
 * 
 * 3. 같은 분류코드 직업끼리 연관직업 추가
 *    - 같은 kecoList를 가진 직업들
 *    - 같은 emp_job_nm/std_job_nm/dJobECdNm을 가진 직업들
 * 
 * 4. 중복 제거 + 자기 자신 제외
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
    
    console.log(`📊 Classification maps built:`)
    console.log(`   - KECO codes: ${kecoToJobs.size}`)
    console.log(`   - empJobNm: ${empJobNmToJobs.size}`)
    console.log(`   - stdJobNm: ${stdJobNmToJobs.size}`)
    console.log(`   - dJobECdNm: ${dJobECdNmToJobs.size}`)
    
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
        
        // 4.3 양방향 관계 보장: 다른 직업이 이 직업을 연관직업으로 가지면 역방향 추가
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






