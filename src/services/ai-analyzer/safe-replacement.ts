// CareerWiki AI Analyzer - Phase 4: Safe Replacement Logic
// Version: v1.0.0
// 목적: Follow-up "no" 응답 시 Hard Filter + Diversity Guard + 대체 직업 선정

import type { D1Database } from '@cloudflare/workers-types'
import type { ScoredJob } from './question-generation'
import type { 
  ConstraintType, 
  ReplacementResult, 
  RankChangeInfo, 
  FollowupNoResult 
} from './types'

// Re-export for convenience
export type { ReplacementResult, RankChangeInfo, FollowupNoResult }

// ============================================
// 제약 → 필터 설정 매핑
// ============================================

interface FilterConfig {
  constraintType: ConstraintType | string
  attributeField: string
  riskValues: string[]
  penaltyBoost: number
  effectType: 'hard_filter' | 'soft_rerank'
}

export const CONSTRAINT_FILTER_MAP: Record<string, FilterConfig> = {
  // Hard Filters (confirmed_constraint.*)
  'work_hours_strict': {
    constraintType: 'work_hours_strict',
    attributeField: 'work_hours',
    riskValues: ['overtime_frequent', 'long_hours', 'overtime_occasional'],
    penaltyBoost: 50,
    effectType: 'hard_filter',
  },
  'shift_work_no': {
    constraintType: 'shift_work_no',
    attributeField: 'shift_work',
    riskValues: ['required', 'frequent', 'sometimes'],
    penaltyBoost: 50,
    effectType: 'hard_filter',
  },
  'remote_only': {
    constraintType: 'remote_only',
    attributeField: 'remote_possible',
    riskValues: ['none', 'rare', 'occasional'],
    penaltyBoost: 40,
    effectType: 'hard_filter',
  },
  'degree_impossible': {
    constraintType: 'degree_impossible',
    attributeField: 'degree_required',
    riskValues: ['bachelor', 'master', 'phd', 'associate'],
    penaltyBoost: 35,
    effectType: 'hard_filter',
  },
  'license_impossible': {
    constraintType: 'license_impossible',
    attributeField: 'license_required',
    riskValues: ['required', 'multiple_required', 'preferred'],
    penaltyBoost: 30,
    effectType: 'hard_filter',
  },
  // 🆕 새로운 Hard Filter (Universal Intake에서 자동 승격됨)
  'travel_impossible': {
    constraintType: 'travel_impossible',
    attributeField: 'travel',
    riskValues: ['frequent', 'regular', 'occasional'],
    penaltyBoost: 35,
    effectType: 'hard_filter',
  },
  
  // Soft Rerank (트레이드오프)
  'salary_vs_wlb': {
    constraintType: 'tradeoff.salary_vs_wlb',
    attributeField: 'wlb',
    riskValues: [],  // 값에 따라 다름
    penaltyBoost: 15,
    effectType: 'soft_rerank',
  },
  'growth_vs_stability': {
    constraintType: 'tradeoff.growth_vs_stability',
    attributeField: 'growth',
    riskValues: [],
    penaltyBoost: 15,
    effectType: 'soft_rerank',
  },
}

// ============================================
// Diversity Guard 설정
// ============================================

export const DIVERSITY_RULES = {
  // TOP3 내 동일 cluster/family 최대 개수
  MAX_SAME_CLUSTER: 1,
  
  // Research/분석 계열 판별 (analytical + solo_deep 조합)
  RESEARCH_THRESHOLD: {
    analytical: 70,
    solo_deep: 70,
  },
  
  // 점수 캡 (Research Bias 방지)
  SCORE_CAPS: {
    analytical_like_max: 15,   // analytical이 Like에 기여하는 최대값
    solo_deep_like_max: 12,    // solo_deep이 Like에 기여하는 최대값
    combined_bonus_penalty: -8, // analytical + solo_deep 동시에 높으면 페널티
  },
  
  // 대체 직업 선택 기준
  REPLACEMENT: {
    min_fit_score_diff: -10,  // 기존 3위 대비 최대 하락폭
    min_similarity: 0.3,      // 최소 유사도
  },
}

// ============================================
// Job Cluster/Family 판별 (간단 버전)
// ============================================

type JobCluster =
  | 'research_analytical'
  | 'creative_design'
  | 'people_service'
  | 'technical_execution'
  | 'management_leadership'
  | 'maintenance_repair'
  | 'other'

// 정비/수리/점검 직업명 패턴
const MAINTENANCE_JOB_PATTERN = /정비|수리|점검|보수|설비|배관|전기공|용접|도장|도금|세척|검사원|조작원|기능원|기운전원|운전원$|운전사$|운전기사$/

// 직업명 유사도 기반 그룹핑 (접미사 패턴)
const JOB_SUFFIX_GROUPS: Record<string, RegExp> = {
  'maintenance': MAINTENANCE_JOB_PATTERN,
  'researcher': /연구원$|연구사$|연구관$/,
  'engineer': /기술자$|기사$|엔지니어$/,
  'manager': /관리자$|매니저$|책임자$/,
  'analyst': /분석가$|분석사$|분석원$/,
  'designer': /디자이너$|설계사$|설계원$/,
  'consultant': /컨설턴트$|상담사$|상담원$/,
}

function identifyJobCluster(job: ScoredJob): JobCluster {
  const attrs = job.attributes
  const name = job.job_name || ''

  const analytical = typeof attrs.analytical === 'number' ? attrs.analytical : 0
  const solo_deep = typeof attrs.solo_work === 'number' ? attrs.solo_work : 0
  const creative = typeof attrs.creative === 'number' ? attrs.creative : 0
  const people_facing = typeof attrs.people_facing === 'number' ? attrs.people_facing : 0
  const teamwork = typeof attrs.teamwork === 'number' ? attrs.teamwork : 0
  const execution = typeof attrs.execution === 'number' ? attrs.execution : 0

  // 정비/수리/점검 클러스터 (이름 기반 — 속성보다 우선!)
  if (MAINTENANCE_JOB_PATTERN.test(name)) {
    return 'maintenance_repair'
  }

  // Research/Analytical 판별 (Research Bias 핵심!)
  if (analytical >= DIVERSITY_RULES.RESEARCH_THRESHOLD.analytical &&
      solo_deep >= DIVERSITY_RULES.RESEARCH_THRESHOLD.solo_deep) {
    return 'research_analytical'
  }

  // Creative/Design
  if (creative >= 70) {
    return 'creative_design'
  }

  // People/Service
  if (people_facing >= 70 || (teamwork >= 70 && people_facing >= 50)) {
    return 'people_service'
  }

  // Technical Execution
  if (execution >= 70 && analytical >= 50) {
    return 'technical_execution'
  }

  // Management
  if (teamwork >= 70 && execution >= 50) {
    return 'management_leadership'
  }

  return 'other'
}

/**
 * 직업명의 유사도 그룹 식별 (접미사 기반)
 * 같은 그룹에 속하면 "비슷한 직업"으로 간주
 */
function identifyJobSuffixGroup(jobName: string): string {
  for (const [group, pattern] of Object.entries(JOB_SUFFIX_GROUPS)) {
    if (pattern.test(jobName)) return group
  }
  return 'none'
}

// Research 계열인지 빠르게 확인
export function isResearchCluster(job: ScoredJob): boolean {
  return identifyJobCluster(job) === 'research_analytical'
}

// ============================================
// Hard Filter 적용
// ============================================

export function filterCandidates(
  candidates: ScoredJob[],
  confirmedConstraints: string[]
): { filtered: ScoredJob[]; removedCount: number; removedJobs: string[] } {
  const removedJobs: string[] = []
  
  const filtered = candidates.filter(job => {
    for (const constraint of confirmedConstraints) {
      // constraint에서 실제 타입 추출 (confirmed_constraint.work_hours_strict → work_hours_strict)
      const constraintType = constraint.replace('confirmed_constraint.', '')
      const config = CONSTRAINT_FILTER_MAP[constraintType]
      
      if (!config || config.effectType !== 'hard_filter') continue
      
      const attrValue = job.attributes[config.attributeField]
      const stringValue = typeof attrValue === 'string' ? attrValue : String(attrValue)
      
      if (config.riskValues.includes(stringValue)) {
        removedJobs.push(job.job_name)
        return false  // 완전 제외 (Hard Filter)
      }
    }
    return true
  })
  
  return {
    filtered,
    removedCount: removedJobs.length,
    removedJobs,
  }
}

// ============================================
// Diversity Guard 체크
// ============================================

export function checkDiversityViolations(
  top3: ScoredJob[]
): { hasViolation: boolean; violations: string[] } {
  const violations: string[] = []
  
  // 1. Cluster별 카운트
  const clusterCounts: Record<JobCluster, number> = {
    'research_analytical': 0,
    'creative_design': 0,
    'people_service': 0,
    'technical_execution': 0,
    'management_leadership': 0,
    'maintenance_repair': 0,
    'other': 0,
  }
  
  for (const job of top3) {
    const cluster = identifyJobCluster(job)
    clusterCounts[cluster]++
    
    if (clusterCounts[cluster] > DIVERSITY_RULES.MAX_SAME_CLUSTER) {
      violations.push(`${cluster}: ${job.job_name} (${clusterCounts[cluster]}개 초과)`)
    }
  }
  
  // 2. Research Bias 특별 체크 (2개 이상이면 위반)
  if (clusterCounts['research_analytical'] >= 2) {
    violations.push(`research_analytical 과다: ${clusterCounts['research_analytical']}개`)
  }
  
  return {
    hasViolation: violations.length > 0,
    violations,
  }
}

// ============================================
// 유사도 계산
// ============================================

function calculateSimilarity(job1: ScoredJob, job2: ScoredJob): number {
  let score = 0
  
  // 1. 업무 스타일 유사도 (0~0.4)
  const styleFields = ['teamwork', 'solo_work', 'analytical', 'creative', 'people_facing']
  let styleDiff = 0
  let validFields = 0
  
  for (const field of styleFields) {
    const v1 = typeof job1.attributes[field] === 'number' ? job1.attributes[field] as number : null
    const v2 = typeof job2.attributes[field] === 'number' ? job2.attributes[field] as number : null
    
    if (v1 !== null && v2 !== null) {
      styleDiff += Math.abs(v1 - v2)
      validFields++
    }
  }
  
  if (validFields > 0) {
    const styleScore = 1 - (styleDiff / (validFields * 100))
    score += styleScore * 0.4
  }
  
  // 2. 가치 유사도 (0~0.3)
  const valueFields = ['wlb', 'growth', 'stability', 'income']
  let valueDiff = 0
  let validValueFields = 0
  
  for (const field of valueFields) {
    const v1 = typeof job1.attributes[field] === 'number' ? job1.attributes[field] as number : null
    const v2 = typeof job2.attributes[field] === 'number' ? job2.attributes[field] as number : null
    
    if (v1 !== null && v2 !== null) {
      valueDiff += Math.abs(v1 - v2)
      validValueFields++
    }
  }
  
  if (validValueFields > 0) {
    const valueScore = 1 - (valueDiff / (validValueFields * 100))
    score += valueScore * 0.3
  }
  
  // 3. Fit 점수 유사도 (0~0.2)
  const fitDiff = Math.abs(job1.scores.fit - job2.scores.fit)
  score += (1 - Math.min(fitDiff / 50, 1)) * 0.2
  
  // 4. 다른 Cluster면 보너스 (0~0.1)
  if (identifyJobCluster(job1) !== identifyJobCluster(job2)) {
    score += 0.1
  }
  
  return score
}

// ============================================
// 대체 직업 찾기 (Diversity 고려)
// ============================================

export function findReplacement(
  rejectedJob: ScoredJob,
  candidates: ScoredJob[],
  currentTop3: ScoredJob[],
  confirmedConstraints: string[]
): ScoredJob | null {
  const rejectedCluster = identifyJobCluster(rejectedJob)
  const minFitScore = rejectedJob.scores.fit + DIVERSITY_RULES.REPLACEMENT.min_fit_score_diff
  
  // 후보 필터링
  const eligibleCandidates = candidates.filter(job => {
    // 1. 자기 자신 제외
    if (job.job_id === rejectedJob.job_id) return false
    
    // 2. 이미 TOP3에 있으면 제외
    if (currentTop3.some(t => t.job_id === job.job_id)) return false
    
    // 3. Hard Filter 통과 확인
    for (const constraint of confirmedConstraints) {
      const constraintType = constraint.replace('confirmed_constraint.', '')
      const config = CONSTRAINT_FILTER_MAP[constraintType]
      
      if (!config || config.effectType !== 'hard_filter') continue
      
      const attrValue = job.attributes[config.attributeField]
      const stringValue = typeof attrValue === 'string' ? attrValue : String(attrValue)
      
      if (config.riskValues.includes(stringValue)) {
        return false
      }
    }
    
    // 4. Fit 점수 최소 기준
    if (job.scores.fit < minFitScore) return false
    
    return true
  })
  
  // Diversity를 고려한 정렬
  const scoredCandidates = eligibleCandidates.map(job => {
    const similarity = calculateSimilarity(rejectedJob, job)
    const cluster = identifyJobCluster(job)
    
    // 이미 TOP3에 같은 클러스터가 있으면 페널티
    const sameClusterInTop3 = currentTop3
      .filter(t => t.job_id !== rejectedJob.job_id)
      .some(t => identifyJobCluster(t) === cluster)
    
    // Research 클러스터면 추가 페널티 (Research Bias 방지)
    const researchPenalty = cluster === 'research_analytical' ? 0.2 : 0
    const diversityBonus = sameClusterInTop3 ? -0.3 : 0.1
    
    const totalScore = similarity + diversityBonus - researchPenalty
    
    return { job, similarity, totalScore, cluster }
  })
  
  // 총점 기준 정렬
  scoredCandidates.sort((a, b) => b.totalScore - a.totalScore)
  
  // 최소 유사도 체크
  const best = scoredCandidates[0]
  if (best && best.similarity >= DIVERSITY_RULES.REPLACEMENT.min_similarity) {
    return best.job
  }
  
  // 유사도가 낮아도 Diversity가 좋으면 선택
  const diverseOption = scoredCandidates.find(c => 
    !currentTop3.some(t => identifyJobCluster(t) === c.cluster)
  )
  
  return diverseOption?.job || scoredCandidates[0]?.job || null
}

// ============================================
// Research Bias 방지 점수 캡 적용
// ============================================

export function applyResearchBiasCap(job: ScoredJob): ScoredJob {
  const attrs = job.attributes
  const caps = DIVERSITY_RULES.SCORE_CAPS
  
  const analytical = typeof attrs.analytical === 'number' ? attrs.analytical : 0
  const solo_deep = typeof attrs.solo_work === 'number' ? attrs.solo_work : 0
  
  // 둘 다 높으면 결합 페널티
  if (analytical >= DIVERSITY_RULES.RESEARCH_THRESHOLD.analytical && 
      solo_deep >= DIVERSITY_RULES.RESEARCH_THRESHOLD.solo_deep) {
    return {
      ...job,
      scores: {
        ...job.scores,
        like: Math.max(0, job.scores.like + caps.combined_bonus_penalty),
        fit: Math.max(0, job.scores.fit + Math.round(caps.combined_bonus_penalty * 0.5)),
      },
    }
  }
  
  return job
}

// ============================================
// 결과 업데이트
// ============================================

export function updateResultWithReplacement(
  originalTop3: ScoredJob[],
  replacements: ReplacementResult[],
  allCandidates: ScoredJob[],
  confirmedConstraints: string[]
): {
  newTop3: ScoredJob[]
  rankChange: RankChangeInfo
} {
  const beforeTop3 = originalTop3.map(j => j.job_name)
  let newTop3 = [...originalTop3]
  
  // 대체 적용
  for (const rep of replacements) {
    if (rep.replacement_job) {
      const idx = newTop3.findIndex(j => j.job_id === rep.original_job.job_id)
      if (idx >= 0) {
        const replacement = allCandidates.find(j => j.job_id === rep.replacement_job!.job_id)
        if (replacement) {
          newTop3[idx] = replacement
        }
      }
    } else {
      // 대체 없으면 제거
      newTop3 = newTop3.filter(j => j.job_id !== rep.original_job.job_id)
    }
  }
  
  // Diversity 체크
  const diversityCheck = checkDiversityViolations(newTop3)
  
  // 점수 재정렬
  newTop3.sort((a, b) => b.scores.fit - a.scores.fit)
  
  const afterTop3 = newTop3.map(j => j.job_name)
  
  const rankChange: RankChangeInfo = {
    changed: JSON.stringify(beforeTop3) !== JSON.stringify(afterTop3),
    replacements,
    before_top3: beforeTop3,
    after_top3: afterTop3,
    removed_count: originalTop3.length - newTop3.length,
    diversity_applied: replacements.some(r => r.rule_applied === 'diversity_guard'),
    debug: {
      hard_filtered: replacements.filter(r => r.rule_applied === 'hard_filter').length,
      soft_reranked: replacements.filter(r => r.rule_applied === 'soft_rerank').length,
      constraints_applied: confirmedConstraints,
      diversity_violations: diversityCheck.violations,
    },
  }
  
  return { newTop3, rankChange }
}

// ============================================
// 메인: handleFollowupNo
// ============================================

export async function handleFollowupNo(
  db: D1Database,
  sessionId: string,
  userId: string | undefined,
  questionId: string,
  constraintType: string,
  rejectedJobId: string,
  allCandidates: ScoredJob[],
  originalTop3: ScoredJob[],
  requestId: number
): Promise<FollowupNoResult> {
  const factKey = `confirmed_constraint.${constraintType}`
  
  // 1. 이미 확정된 제약인지 확인
  const existingConstraint = await db.prepare(`
    SELECT * FROM facts
    WHERE session_id = ? AND fact_key = ?
  `).bind(sessionId, factKey).first()
  
  if (existingConstraint) {
    return {
      success: true,
      action: 'already_confirmed',
      rank_change: null,
      fact_saved: null,
      message: '이미 확인된 제약 조건입니다.',
    }
  }
  
  // 2. Raw event 저장
  await db.prepare(`
    INSERT INTO raw_events (user_id, session_id, event_type, payload_json)
    VALUES (?, ?, 'FOLLOWUP_NO', ?)
  `).bind(
    userId || null,
    sessionId,
    JSON.stringify({
      question_id: questionId,
      constraint_type: constraintType,
      rejected_job_id: rejectedJobId,
      answer: 'no',
      timestamp: new Date().toISOString(),
    })
  ).run()
  
  // 3. Fact 승격 저장 (fact_level=1, confirmed_constraint)
  await db.prepare(`
    INSERT INTO facts (session_id, user_id, fact_key, value_json, confidence, source_type, fact_level)
    VALUES (?, ?, ?, ?, 1.0, 'followup', 1)
    ON CONFLICT(session_id, fact_key) DO UPDATE SET
      value_json = excluded.value_json,
      confidence = 1.0,
      fact_level = 1
  `).bind(
    sessionId,
    userId || null,
    factKey,
    JSON.stringify({
      confirmed: true,
      rejected_job_id: rejectedJobId,
      confirmed_at: new Date().toISOString(),
    })
  ).run()
  
  // 4. 모든 confirmed_constraints 조회
  const constraintsResult = await db.prepare(`
    SELECT fact_key FROM facts
    WHERE session_id = ? AND fact_key LIKE 'confirmed_constraint.%'
  `).bind(sessionId).all<{ fact_key: string }>()
  
  const confirmedConstraints = constraintsResult.results?.map(r => r.fact_key) || [factKey]
  
  // 5. Hard Filter 적용
  const { filtered: filteredCandidates, removedCount, removedJobs } = filterCandidates(
    allCandidates,
    confirmedConstraints
  )
  
  // 6. Research Bias Cap 적용
  const cappedCandidates = filteredCandidates.map(applyResearchBiasCap)
  
  // 7. 재정렬
  cappedCandidates.sort((a, b) => b.scores.fit - a.scores.fit)
  
  // 8. 대체 필요 여부 확인
  const rejectedJob = originalTop3.find(j => j.job_id === rejectedJobId)
  const replacements: ReplacementResult[] = []
  
  if (rejectedJob) {
    // 거절된 직업이 필터링되었거나 TOP3에서 빠졌는지 확인
    const stillInFiltered = cappedCandidates.some(j => j.job_id === rejectedJobId)
    const newTop3Candidates = cappedCandidates.slice(0, 3)
    const stillInTop3 = newTop3Candidates.some(j => j.job_id === rejectedJobId)
    
    if (!stillInFiltered) {
      // Hard Filter로 완전 제외됨
      const replacement = findReplacement(
        rejectedJob,
        cappedCandidates,
        originalTop3,
        confirmedConstraints
      )
      
      replacements.push({
        original_job: {
          job_id: rejectedJob.job_id,
          job_name: rejectedJob.job_name,
          rank: originalTop3.indexOf(rejectedJob) + 1,
        },
        replacement_job: replacement ? {
          job_id: replacement.job_id,
          job_name: replacement.job_name,
          fit_score: replacement.scores.fit,
          similarity_score: calculateSimilarity(rejectedJob, replacement),
        } : null,
        reason: factKey,
        rule_applied: 'hard_filter',
      })
    } else if (!stillInTop3) {
      // 점수 변동으로 TOP3에서 밀려남 (Soft Rerank)
      replacements.push({
        original_job: {
          job_id: rejectedJob.job_id,
          job_name: rejectedJob.job_name,
          rank: originalTop3.indexOf(rejectedJob) + 1,
        },
        replacement_job: newTop3Candidates[2] ? {
          job_id: newTop3Candidates[2].job_id,
          job_name: newTop3Candidates[2].job_name,
          fit_score: newTop3Candidates[2].scores.fit,
          similarity_score: calculateSimilarity(rejectedJob, newTop3Candidates[2]),
        } : null,
        reason: 'score_rerank',
        rule_applied: 'soft_rerank',
      })
    }
  }
  
  // 9. Diversity Guard 적용
  let newTop3 = cappedCandidates.slice(0, 3)
  const diversityCheck = checkDiversityViolations(newTop3)
  
  if (diversityCheck.hasViolation) {
    // Research 계열 중복 해결
    const researchJobs = newTop3.filter(isResearchCluster)
    
    if (researchJobs.length >= 2) {
      // 첫 번째 연구직만 유지, 나머지는 대체
      for (let i = 1; i < researchJobs.length; i++) {
        const toReplace = researchJobs[i]
        const replacement = findReplacement(
          toReplace,
          cappedCandidates,
          newTop3,
          confirmedConstraints
        )
        
        if (replacement) {
          const idx = newTop3.findIndex(j => j.job_id === toReplace.job_id)
          if (idx >= 0) {
            replacements.push({
              original_job: {
                job_id: toReplace.job_id,
                job_name: toReplace.job_name,
                rank: idx + 1,
              },
              replacement_job: {
                job_id: replacement.job_id,
                job_name: replacement.job_name,
                fit_score: replacement.scores.fit,
                similarity_score: calculateSimilarity(toReplace, replacement),
              },
              reason: 'diversity_guard_research_bias',
              rule_applied: 'diversity_guard',
            })
            newTop3[idx] = replacement
          }
        }
      }
    }
  }
  
  // 10. 최종 결과 구성
  const { rankChange } = updateResultWithReplacement(
    originalTop3,
    replacements,
    cappedCandidates,
    confirmedConstraints
  )
  
  // 11. result_json 업데이트 (DB)
  if (rankChange.changed && requestId) {
    const existingResult = await db.prepare(`
      SELECT result_json FROM ai_analysis_results WHERE request_id = ?
    `).bind(requestId).first<{ result_json: string }>()
    
    if (existingResult) {
      try {
        const resultData = JSON.parse(existingResult.result_json)
        
        // TOP3 업데이트
        resultData.fit_top3 = newTop3.map(j => ({
          job_id: j.job_id,
          job_name: j.job_name,
          fit_score: j.scores.fit,
          like_score: j.scores.like,
          can_score: j.scores.can,
          risk_details: [],
          evidence_links: [],
        }))
        
        // rank_change 추가
        resultData.rank_change = rankChange
        
        // Phase 4 플래그
        resultData.phase4_applied = true
        resultData.diversity_guard_active = true
        
        await db.prepare(`
          UPDATE ai_analysis_results
          SET result_json = ?
          WHERE request_id = ?
        `).bind(JSON.stringify(resultData), requestId).run()
        
      } catch (error) {
      }
    }
  }
  
  // 12. 응답 반환
  const action = rankChange.changed 
    ? (replacements.some(r => r.replacement_job) ? 'replaced' : 'removed')
    : 'no_change'
  
  return {
    success: true,
    action,
    rank_change: rankChange,
    fact_saved: {
      fact_key: factKey,
      fact_level: 1,
    },
    message: action === 'replaced' 
      ? `${replacements.length}개 직업이 대체되었습니다.`
      : action === 'removed'
        ? `해당 직업이 추천에서 제외되었습니다.`
        : '변경 사항이 없습니다.',
    new_top3: newTop3.map(j => ({
      job_id: j.job_id,
      job_name: j.job_name,
      fit_score: j.scores.fit,
      like_score: j.scores.like,
      can_score: j.scores.can,
    })),
  }
}

// ============================================
// Diversity Guard만 적용 (분석 시점에서 사용)
// ============================================

export function applyDiversityGuard(
  top3: ScoredJob[],
  allCandidates: ScoredJob[]
): { adjusted: ScoredJob[]; diversityApplied: boolean; changes: string[] } {
  const changes: string[] = []
  let adjusted = [...top3]
  
  // Research Bias Cap 먼저 적용
  adjusted = adjusted.map(applyResearchBiasCap)
  
  // Diversity 체크
  const check = checkDiversityViolations(adjusted)
  
  if (!check.hasViolation) {
    return { adjusted, diversityApplied: false, changes }
  }
  
  // 클러스터별 중복 해결 (Research + Maintenance + 기타)
  const clusterGroups = new Map<JobCluster, ScoredJob[]>()
  for (const job of adjusted) {
    const cluster = identifyJobCluster(job)
    const existing = clusterGroups.get(cluster) || []
    existing.push(job)
    clusterGroups.set(cluster, existing)
  }

  // Research Bias Cap이 적용된 후보들
  const cappedCandidates = allCandidates.map(applyResearchBiasCap)
  cappedCandidates.sort((a, b) => b.scores.fit - a.scores.fit)

  // 각 클러스터에서 MAX_SAME_CLUSTER 초과분 대체
  for (const [cluster, jobs] of clusterGroups) {
    if (jobs.length <= DIVERSITY_RULES.MAX_SAME_CLUSTER) continue

    // 첫 번째만 유지, 나머지 대체
    for (let i = DIVERSITY_RULES.MAX_SAME_CLUSTER; i < jobs.length; i++) {
      const toReplace = jobs[i]
      const replacement = findReplacement(
        toReplace,
        cappedCandidates,
        adjusted,
        []  // 분석 시점에서는 confirmed_constraints 없음
      )

      if (replacement) {
        const idx = adjusted.findIndex(j => j.job_id === toReplace.job_id)
        if (idx >= 0) {
          changes.push(`${toReplace.job_name} → ${replacement.job_name} (Diversity Guard: ${cluster})`)
          adjusted[idx] = replacement
        }
      }
    }
  }
  
  // 재정렬
  adjusted.sort((a, b) => b.scores.fit - a.scores.fit)

  return {
    adjusted,
    diversityApplied: changes.length > 0,
    changes,
  }
}

// ============================================
// v3.9.2: 정무직/임명직 블랙리스트 (추천 부적합)
// 이 직업들은 일반 커리어 추천 대상이 아님
// ============================================

// 이름에 포함만 되어도 제거 (false positive 걱정 없는 명확한 정치/임명직)
const UNREALISTIC_PATTERNS = [
  '차관', '장관', '국무총리', '대통령', '부통령',
  '법원장', '대법관', '헌법재판관',
  '총영사', '검찰총장', '감사원장',
  '국회의원', '도지사',
]

// 정확히 일치해야만 제거 (다른 직업명에 포함될 수 있는 모호한 단어)
// "시장" → 시장분석가 오탐 방지, "군수" → 군수산업 오탐 방지
// "대사" → 홍보대사 오탐 방지, "공사" → 한국도로공사 오탐 방지
const UNREALISTIC_EXACT = new Set([
  '대사', '공사', '시장', '군수', '구청장',
])

function isUnrealisticJob(jobName: string): boolean {
  const name = jobName.trim()
  if (UNREALISTIC_EXACT.has(name)) return true
  for (const pattern of UNREALISTIC_PATTERNS) {
    if (name.includes(pattern)) return true
  }
  return false
}

/**
 * 정무직/임명직/선출직 직업을 필터링
 * 일반적인 커리어 추천에 부적합한 직업 제거
 */
export function filterUnrealisticJobs(jobs: ScoredJob[]): ScoredJob[] {
  const before = jobs.length
  const filtered = jobs.filter(j => !isUnrealisticJob(j.job_name))
  if (before !== filtered.length) {
    const removed = jobs.filter(j => isUnrealisticJob(j.job_name)).map(j => j.job_name)
  }
  return filtered
}

/**
 * 응답 직전 최종 안전망: fit_top3/like_top10/can_top10에서 정치직 제거
 * filterUnrealisticJobs가 놓치더라도 여기서 잡음
 */
export function sanitizeJobListOutput<T extends { job_name: string }>(jobs: T[]): T[] {
  return jobs.filter(j => !isUnrealisticJob(j.job_name))
}

// ============================================
// v3.9.9: 소재/분야 기반 니치 직업 조건부 필터
// 유저 배경이 받쳐줄 때는 통과, 아닐 때만 제거
// ============================================

// 도메인별 니치 패턴 + 유저 배경 탐지 시그널
interface NicheDomain {
  patterns: string[]
  // MiniModule background_flags 중 이 도메인을 면제하는 것
  exemptBackgrounds: string[]
  // MiniModule interest_top 중 이 도메인을 면제하는 것
  exemptInterests: string[]
}

const NICHE_DOMAINS: NicheDomain[] = [
  {
    // 화학/소재 기반
    patterns: ['바이오화학제품', '석유화학', '고무제품', '화학정보학'],
    exemptBackgrounds: ['research_academic', 'license_cert'],
    exemptInterests: ['tech'],
  },
  {
    // 제조/가공 극세분화
    patterns: ['직물수지', '목재분쇄', '단청', '도금', '열처리'],
    exemptBackgrounds: ['license_cert'],
    exemptInterests: ['tech'],  // routine 제외: 너무 광범위 (정형화된 업무 ≠ 제조가공)
  },
  {
    // 설비/기구/기계정비 극세분화
    patterns: ['용수설비', '수상레저기구', '철도차량배관', '인쇄기계정비',
               '원자력기술', '수력발전설비', '반도체제조기술'],
    exemptBackgrounds: ['license_cert'],
    exemptInterests: ['tech'],
  },
  {
    // 보험 극세분화
    patterns: ['보험영업실적', '보험계리'],
    exemptBackgrounds: ['license_cert'],
    exemptInterests: ['data_numbers', 'influencing'],
  },
  {
    // 제조현장 감독/반장 (사무직 지향 유저에게 부적절)
    patterns: ['반장', '현장감독', '작업반장', '조장', '유지보수반장'],
    exemptBackgrounds: ['license_cert', 'field_experience'],
    exemptInterests: ['physical_activity'],
  },
]

// 유저 시그널을 기반으로 면제할 패턴 Set 구성
function buildExemptPatterns(mm?: { interest_top?: string[]; background_flags?: string[] }): Set<string> {
  const exempt = new Set<string>()
  if (!mm) return exempt

  const interests = mm.interest_top || []
  const backgrounds = mm.background_flags || []

  for (const domain of NICHE_DOMAINS) {
    const hasBackground = domain.exemptBackgrounds.some(b => backgrounds.includes(b))
    const hasInterest = domain.exemptInterests.some(i => interests.includes(i))
    if (hasBackground || hasInterest) {
      for (const p of domain.patterns) exempt.add(p)
    }
  }
  return exempt
}

function isNicheMaterialJob(jobName: string, exemptPatterns: Set<string>): boolean {
  const name = jobName.trim()
  for (const domain of NICHE_DOMAINS) {
    for (const pattern of domain.patterns) {
      if (name.includes(pattern)) {
        return !exemptPatterns.has(pattern)  // 면제 대상이면 false(=니치 아님)
      }
    }
  }
  return false
}

/**
 * v3.9.9: 니치 소재/분야 직업 조건부 필터
 * mm(MiniModule) 배경이 받쳐줄 때는 통과, 아닐 때만 제거
 */
export function filterNicheMaterialJobs<T extends { job_name: string }>(
  jobs: T[],
  mm?: { interest_top?: string[]; background_flags?: string[] }
): T[] {
  const exempt = buildExemptPatterns(mm)
  const before = jobs.length
  const filtered = jobs.filter(j => !isNicheMaterialJob(j.job_name, exempt))
  if (before !== filtered.length) {
    const removed = jobs.filter(j => isNicheMaterialJob(j.job_name, exempt)).map(j => j.job_name)
  }
  return filtered
}

// ============================================
// v3.9.0: like_top10 / can_top10 다양성 강제
// 클러스터 + 접미사 그룹 기반으로 같은 유형 최대 MAX개
// ============================================
const MAX_PER_CLUSTER_IN_TOP10 = 3  // 10개 중 같은 클러스터 최대 3개
const MAX_PER_SUFFIX_GROUP_IN_TOP10 = 2  // 같은 접미사 그룹 최대 2개

/**
 * Top10 결과에 다양성 강제 적용
 * - 클러스터별 최대 MAX_PER_CLUSTER_IN_TOP10개
 * - 접미사 그룹별 최대 MAX_PER_SUFFIX_GROUP_IN_TOP10개
 * - 초과분은 allCandidates에서 대체 직업으로 교체
 * - 대체 실패 시 skip (빈 자리는 2차 패스에서 채움)
 */
export function enforceDiversityOnTopN(
  topN: ScoredJob[],
  allCandidates: ScoredJob[],
  sortField: 'fit' | 'like' | 'can' = 'fit',
  maxResults: number = 10
): { diversified: ScoredJob[]; changes: string[] } {
  const changes: string[] = []
  const result: ScoredJob[] = []
  const usedJobIds = new Set<string>()
  const clusterCounts: Record<string, number> = {}
  const suffixCounts: Record<string, number> = {}
  const skippedJobs: ScoredJob[] = []  // 클러스터 초과로 skip된 직업들

  // 정렬된 전체 후보 목록 (대체 직업 풀)
  const sortedAll = [...allCandidates].sort((a, b) => {
    if (sortField === 'like') return b.scores.like - a.scores.like
    if (sortField === 'can') return b.scores.can - a.scores.can
    return b.scores.fit - a.scores.fit
  })

  // 1차 패스: topN에서 다양성 검사하며 추가
  for (const job of topN) {
    if (result.length >= maxResults) break

    const cluster = identifyJobCluster(job)
    const suffix = identifyJobSuffixGroup(job.job_name)
    const clusterCount = clusterCounts[cluster] || 0
    const suffixCount = suffix !== 'none' ? (suffixCounts[suffix] || 0) : 0

    // 클러스터 또는 접미사 그룹 초과 체크
    if (clusterCount >= MAX_PER_CLUSTER_IN_TOP10 || suffixCount >= MAX_PER_SUFFIX_GROUP_IN_TOP10) {
      // 대체 직업 찾기 (topN 밖에서)
      const replacement = sortedAll.find(c => {
        if (usedJobIds.has(c.job_id)) return false
        const rCluster = identifyJobCluster(c)
        const rSuffix = identifyJobSuffixGroup(c.job_name)
        const rClusterCount = clusterCounts[rCluster] || 0
        const rSuffixCount = rSuffix !== 'none' ? (suffixCounts[rSuffix] || 0) : 0
        return rClusterCount < MAX_PER_CLUSTER_IN_TOP10 && rSuffixCount < MAX_PER_SUFFIX_GROUP_IN_TOP10
      })

      if (replacement) {
        const rCluster = identifyJobCluster(replacement)
        const rSuffix = identifyJobSuffixGroup(replacement.job_name)
        clusterCounts[rCluster] = (clusterCounts[rCluster] || 0) + 1
        if (rSuffix !== 'none') suffixCounts[rSuffix] = (suffixCounts[rSuffix] || 0) + 1
        usedJobIds.add(replacement.job_id)
        result.push(replacement)
        changes.push(`${job.job_name}(${cluster}) → ${replacement.job_name}(${rCluster})`)
      } else {
        // 대체 실패: skip (나중에 빈 자리 채울 때 사용)
        skippedJobs.push(job)
        changes.push(`${job.job_name}(${cluster}) → SKIP (no replacement)`)
      }
      continue
    }

    clusterCounts[cluster] = (clusterCounts[cluster] || 0) + 1
    if (suffix !== 'none') suffixCounts[suffix] = (suffixCounts[suffix] || 0) + 1
    usedJobIds.add(job.job_id)
    result.push(job)
  }

  // 2차 패스: result가 maxResults보다 적으면 skipped 직업으로 채움
  if (result.length < maxResults && skippedJobs.length > 0) {
    for (const job of skippedJobs) {
      if (result.length >= maxResults) break
      if (!usedJobIds.has(job.job_id)) {
        usedJobIds.add(job.job_id)
        result.push(job)
      }
    }
  }

  if (changes.length > 0) {
  }

  return { diversified: result.slice(0, maxResults), changes }
}

// ============================================
// 전공 추천 전용 Safe Replacement
// ============================================
// 기존 직업 함수를 수정하지 않고, 전공 전용 함수만 추가
// ============================================

import type { ScoredMajor } from './types'

// 전공 Diversity Guard: field_category 기반
type MajorCluster = 'engineering' | 'natural_science' | 'social_science' | 'humanities' |
  'arts' | 'medical' | 'education' | 'business' | 'law' | 'agriculture' | 'general'

function identifyMajorCluster(major: ScoredMajor): MajorCluster {
  const category = major.field_category || major.attributes?.field_category || 'general'
  return category as MajorCluster
}

/**
 * 전공 Diversity Guard: 같은 field_category가 maxSameCategory개 이상 추천되지 않도록
 */
export function enforceMajorDiversity(
  majors: ScoredMajor[],
  maxSameCategory: number = 3,
  maxResults: number = 10
): { diversified: ScoredMajor[]; changes: string[] } {
  const result: ScoredMajor[] = []
  const changes: string[] = []
  const categoryCounts: Record<string, number> = {}
  const usedMajorIds = new Set<string | number>()
  const skippedMajors: ScoredMajor[] = []

  for (const major of majors) {
    if (result.length >= maxResults) break
    const cluster = identifyMajorCluster(major)
    const count = categoryCounts[cluster] || 0

    if (count >= maxSameCategory) {
      // 같은 계열 초과 → 다른 계열 전공으로 대체 시도
      const replacement = majors.find(m =>
        !usedMajorIds.has(m.major_id) &&
        identifyMajorCluster(m) !== cluster &&
        m.final_score >= major.final_score - 15
      )

      if (replacement) {
        const repCluster = identifyMajorCluster(replacement)
        categoryCounts[repCluster] = (categoryCounts[repCluster] || 0) + 1
        usedMajorIds.add(replacement.major_id)
        result.push(replacement)
        changes.push(`${major.major_name}(${cluster}) → ${replacement.major_name}(${repCluster})`)
      } else {
        skippedMajors.push(major)
      }
      continue
    }

    categoryCounts[cluster] = count + 1
    usedMajorIds.add(major.major_id)
    result.push(major)
  }

  // 2차 패스: 빈 자리 채우기
  if (result.length < maxResults && skippedMajors.length > 0) {
    for (const major of skippedMajors) {
      if (result.length >= maxResults) break
      if (!usedMajorIds.has(major.major_id)) {
        usedMajorIds.add(major.major_id)
        result.push(major)
      }
    }
  }

  return { diversified: result.slice(0, maxResults), changes }
}

/**
 * 전공 아키타입 DB 쿼리 (흥미 토큰 → 전공명 패턴)
 */
export const MAJOR_ARCHETYPE_DB_QUERIES: Record<string, {
  patterns: string[]
  likePatterns: string[]
}> = {
  data_numbers: {
    patterns: ['통계', '수학', '데이터', '컴퓨터', '경제', '회계'],
    likePatterns: ['%통계%', '%수학%', '%데이터%', '%컴퓨터%', '%경제%', '%회계%'],
  },
  helping_teaching: {
    patterns: ['교육', '심리', '사회복지', '간호', '상담', '유아교육', '특수교육'],
    likePatterns: ['%교육%', '%심리%', '%사회복지%', '%간호%', '%상담%'],
  },
  creating: {
    patterns: ['디자인', '미술', '영상', '음악', '건축', '패션', '공예'],
    likePatterns: ['%디자인%', '%미술%', '%영상%', '%음악%', '%건축%'],
  },
  tech: {
    patterns: ['공학', '전자', '소프트웨어', '기계', 'IT', '전기', '컴퓨터'],
    likePatterns: ['%공학%', '%전자%', '%소프트웨어%', '%기계%', '%컴퓨터%'],
  },
  research: {
    patterns: ['물리', '화학', '생명과학', '생물', '천문', '수학', '약학'],
    likePatterns: ['%물리%', '%화학%', '%생명%', '%생물%', '%약학%'],
  },
  organizing: {
    patterns: ['경영', '행정', '무역', '국제', '정치', '법학'],
    likePatterns: ['%경영%', '%행정%', '%무역%', '%국제%', '%법%'],
  },
  influencing: {
    patterns: ['광고', '홍보', '미디어', '언론', '마케팅', '커뮤니케이션'],
    likePatterns: ['%광고%', '%홍보%', '%미디어%', '%언론%', '%마케팅%'],
  },
  problem_solving: {
    patterns: ['공학', '과학', '철학', '법학', '의학'],
    likePatterns: ['%공학%', '%과학%', '%철학%', '%법학%', '%의학%'],
  },
}

/**
 * 아키타입 기반 전공 주입 (벡터 검색에서 누락된 주류 전공 보충)
 */
export async function injectArchetypeMajors(
  db: D1Database,
  existingMajorIds: Set<string | number>,
  interestTokens: string[],
  limit: number = 5
): Promise<ScoredMajor[]> {
  const injected: ScoredMajor[] = []

  for (const token of interestTokens) {
    const archetype = MAJOR_ARCHETYPE_DB_QUERIES[token]
    if (!archetype) continue

    for (const pattern of archetype.likePatterns) {
      if (injected.length >= limit) break
      try {
        const result = await db.prepare(`
          SELECT m.id, m.name, m.slug, m.image_url,
                 ma.field_category, ma.academic_rigor, ma.math_intensity, ma.creativity,
                 ma.social_interaction, ma.lab_practical, ma.reading_writing,
                 ma.career_breadth, ma.career_income_potential, ma.employment_rate,
                 ma.competition_level, ma.growth_outlook, ma.stability, ma.autonomy, ma.teamwork,
                 ma.degree_level, ma.description
          FROM majors m
          LEFT JOIN major_attributes ma ON m.id = ma.major_id
          WHERE m.name LIKE ? AND m.name IS NOT NULL
          LIMIT 3
        `).bind(pattern).all<any>()

        for (const row of result.results || []) {
          if (existingMajorIds.has(String(row.id)) || existingMajorIds.has(row.id)) continue
          if (injected.length >= limit) break

          injected.push({
            entity_type: 'major',
            major_id: String(row.id),
            major_name: row.name,
            slug: row.slug || undefined,
            image_url: row.image_url || undefined,
            major_description: row.description || undefined,
            base_like: 50,
            base_can: 45,
            base_risk: 10,
            like_score: 50,
            can_score: 45,
            risk_penalty: 10,
            final_score: 40,
            field_category: row.field_category || 'general',
            tag_source: row.field_category ? 'tagged' : 'untagged',
            attributes: {
              academic_rigor: row.academic_rigor ?? 50,
              math_intensity: row.math_intensity ?? 50,
              creativity: row.creativity ?? 50,
              social_interaction: row.social_interaction ?? 50,
              lab_practical: row.lab_practical ?? 50,
              reading_writing: row.reading_writing ?? 50,
              career_breadth: row.career_breadth ?? 50,
              career_income_potential: row.career_income_potential ?? 50,
              employment_rate: row.employment_rate ?? 50,
              competition_level: row.competition_level ?? 50,
              growth_outlook: row.growth_outlook ?? 50,
              stability: row.stability ?? 50,
              autonomy: row.autonomy ?? 50,
              teamwork: row.teamwork ?? 50,
              field_category: row.field_category || 'general',
              degree_level: row.degree_level || 'bachelor',
            },
          })
          existingMajorIds.add(String(row.id))
        }
      } catch {}
    }
  }

  return injected
}
