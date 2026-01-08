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
  | 'other'

function identifyJobCluster(job: ScoredJob): JobCluster {
  const attrs = job.attributes
  
  const analytical = typeof attrs.analytical === 'number' ? attrs.analytical : 0
  const solo_deep = typeof attrs.solo_work === 'number' ? attrs.solo_work : 0
  const creative = typeof attrs.creative === 'number' ? attrs.creative : 0
  const people_facing = typeof attrs.people_facing === 'number' ? attrs.people_facing : 0
  const teamwork = typeof attrs.teamwork === 'number' ? attrs.teamwork : 0
  const execution = typeof attrs.execution === 'number' ? attrs.execution : 0
  
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
        console.error('Failed to update result_json:', error)
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
  
  // Research 계열 중복 해결
  const researchJobs = adjusted.filter(isResearchCluster)
  
  if (researchJobs.length >= 2) {
    // Research Bias Cap이 적용된 후보들
    const cappedCandidates = allCandidates.map(applyResearchBiasCap)
    cappedCandidates.sort((a, b) => b.scores.fit - a.scores.fit)
    
    // 첫 번째 연구직만 유지
    for (let i = 1; i < researchJobs.length; i++) {
      const toReplace = researchJobs[i]
      const replacement = findReplacement(
        toReplace,
        cappedCandidates,
        adjusted,
        []  // 분석 시점에서는 confirmed_constraints 없음
      )
      
      if (replacement) {
        const idx = adjusted.findIndex(j => j.job_id === toReplace.job_id)
        if (idx >= 0) {
          changes.push(`${toReplace.job_name} → ${replacement.job_name} (Diversity Guard)`)
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

