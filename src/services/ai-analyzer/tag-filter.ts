// src/services/ai-analyzer/tag-filter.ts
// ============================================
// V3 TAG Filter: Hard Exclusion + Risk Penalty
// TAG는 더 이상 점수 랭킹에 사용되지 않음
// 대신 "확실히 아닌 것 제거" + "경고/패널티"로만 사용
// ============================================

import type { D1Database } from '@cloudflare/workers-types'
import type { VectorSearchResult } from './vectorize-pipeline'
import type { HardCutItem, UserConstraints } from './types'

// ============================================
// Types
// ============================================
export interface HardExclusionRule {
  id: string
  userConstraint: keyof UserConstraints
  jobAttribute: string
  jobCondition: (value: string | number | null) => boolean
  reason: string
}

export interface RiskPenaltyRule {
  id: string
  userConstraint: keyof UserConstraints
  jobAttribute: string
  jobCondition: (value: string | number | null) => boolean
  penalty: number
  warningLabel: string
}

export interface FilteredCandidate extends VectorSearchResult {
  riskPenalty: number
  riskWarnings: string[]
  tagSource: 'tagged' | 'untagged'
}

// ============================================
// P1: Risk 강도 구분 시스템
// - absolute: 절대 불가 (건강/가족 이유 등)
// - prefer_avoid: 가능하면 피하고 싶음
// - acceptable: 가끔은 괜찮음
// ============================================
export type ConstraintIntensity = 'absolute' | 'prefer_avoid' | 'acceptable'

export interface UserConstraintWithIntensity {
  constraint: keyof UserConstraints
  intensity: ConstraintIntensity
}

/**
 * 강도에 따른 페널티 배율 계산
 * - absolute: 150% (Hard Exclusion 대상)
 * - prefer_avoid: 100% (기존 방식)
 * - acceptable: 30% (약한 페널티)
 */
export function calculateIntensityMultiplier(intensity: ConstraintIntensity): number {
  switch (intensity) {
    case 'absolute': return 1.5
    case 'prefer_avoid': return 1.0
    case 'acceptable': return 0.3
  }
}

/**
 * 강도 기반 페널티 계산
 */
export function calculateIntensityPenalty(
  basePenalty: number,
  intensity: ConstraintIntensity
): number {
  return Math.round(basePenalty * calculateIntensityMultiplier(intensity))
}

/**
 * Hard Exclusion 적용 여부 결정
 * - absolute 강도일 때만 Hard Exclusion 적용
 * - prefer_avoid/acceptable은 Risk Penalty만 적용
 */
export function shouldApplyHardExclusion(intensity: ConstraintIntensity): boolean {
  return intensity === 'absolute'
}

// ============================================
// P1: Hard Exclusion 경력 단계 조건
// Can 검증 결과에 따라 entry/junior 레벨 직업은 허용 가능
// ============================================
export type JobLevel = 'entry' | 'junior' | 'mid' | 'senior' | 'expert'

interface ExclusionOverrideRule {
  level: JobLevel
  canThresholdToAllow: number  // 이 Can Boost 이상이면 허용
}

/**
 * 경력 단계별 제외 완화 규칙
 * - entry/junior 레벨 직업은 Can 검증 결과에 따라 진입 허용
 */
export const EXCLUSION_OVERRIDE_RULES: Record<string, ExclusionOverrideRule[]> = {
  // 분석 경험 없음 → 분석직 제외 완화
  'no_analytical_experience': [
    { level: 'entry', canThresholdToAllow: 8 },   // 프로젝트 경험 있으면 허용
    { level: 'junior', canThresholdToAllow: 15 }, // 1-3년 경험 있으면 허용
  ],
  // 창의 경험 없음 → 크리에이티브직 제외 완화
  'no_creative_experience': [
    { level: 'entry', canThresholdToAllow: 6 },
    { level: 'junior', canThresholdToAllow: 12 },
  ],
  // 소통 경험 없음 → 대인직 제외 완화
  'no_communication_experience': [
    { level: 'entry', canThresholdToAllow: 10 },
    { level: 'junior', canThresholdToAllow: 15 },
  ],
}

/**
 * 경력 단계 조건에 따라 제외 완화 여부 결정
 */
export function shouldOverrideExclusion(
  ruleId: string,
  jobLevel: JobLevel | undefined,
  canBoost: number
): { override: boolean; warning?: string } {
  const overrides = EXCLUSION_OVERRIDE_RULES[ruleId]
  if (!overrides) return { override: false }

  const level = jobLevel || 'mid'  // 기본값은 mid (완화 없음)
  const override = overrides.find(o => o.level === level)

  if (override && canBoost >= override.canThresholdToAllow) {
    return {
      override: true,
      warning: `⚠️ 경험 부족 (진입 가능성 있음, Can Boost: ${canBoost})`,
    }
  }

  return { override: false }
}

/**
 * 직업의 경력 단계 추출 (attributes에서)
 */
export function extractJobLevel(attributes: Record<string, any>): JobLevel {
  const level = attributes?.level || attributes?.job_level
  if (['entry', 'junior', 'mid', 'senior', 'expert'].includes(level)) {
    return level as JobLevel
  }
  return 'mid'  // 기본값
}

// ============================================
// TAG 근거 패킷 (설명용)
// ============================================
export interface TagEvidencePacket {
  exclusion_details: Array<{
    job_id: string
    job_name: string
    rule_id: string
    reason: string
    confidence: 'high' | 'medium' | 'low'
    source: 'user_fact' | 'job_attribute' | 'inferred'
  }>
  soft_details: Array<{
    job_id: string
    job_name: string
    rule_id: string
    warning: string
    penalty: number
    confidence: 'high' | 'medium' | 'low'
  }>
}

export interface FilterResult {
  passed: FilteredCandidate[]
  excluded: HardCutItem[]
  stats: {
    totalInput: number
    hardExcluded: number
    passed: number
    withRiskPenalty: number
    untaggedCount: number
  }
  // 근거 패킷 (최종 결과 설명용)
  evidence: TagEvidencePacket
}

// ============================================
// Hard Exclusion Rules (확실히 아닌 것 제거)
// ============================================
export const HARD_EXCLUSION_RULES: HardExclusionRule[] = [
  {
    id: 'remote_only_vs_none',
    userConstraint: 'remote_only',
    jobAttribute: 'remote_possible',
    jobCondition: (value) => value === 'none',
    reason: '원격근무 필수이나 해당 직업은 원격 불가',
  },
  {
    id: 'work_hours_strict_vs_heavy',
    userConstraint: 'work_hours_strict',
    jobAttribute: 'work_hours',
    jobCondition: (value) => value === 'overtime_heavy' || value === 'always_overtime',
    reason: '야근 불가이나 해당 직업은 야근이 매우 잦음',
  },
  {
    id: 'shift_work_no_vs_required',
    userConstraint: 'shift_work_no',
    jobAttribute: 'shift_work',
    jobCondition: (value) => value === 'required' || value === 'always',
    reason: '교대근무 불가이나 해당 직업은 교대근무 필수',
  },
  {
    id: 'degree_impossible_vs_required',
    userConstraint: 'degree_impossible',
    jobAttribute: 'degree_required',
    jobCondition: (value) => value === 'required' || value === 'masters_required',
    reason: '학위 취득 불가이나 해당 직업은 학위 필수',
  },
  {
    id: 'license_impossible_vs_required',
    userConstraint: 'license_impossible',
    jobAttribute: 'license_required',
    jobCondition: (value) => value === 'required' || value === 'mandatory',
    reason: '자격증 취득 불가이나 해당 직업은 자격증 필수',
  },
  // ============================================
  // 🆕 V3 Hard Exclusion (미니모듈 기반 - 석제품제작원 같은 미스 방지)
  // ============================================
  {
    id: 'physical_labor_no_vs_high',
    userConstraint: 'physical_labor_no',
    jobAttribute: 'physical_demand',
    jobCondition: (value) => value === 'high' || value === 'very_high' || value === 'manual',
    reason: '육체노동 회피 신호가 있으나 해당 직업은 현장/육체노동 중심',
  },
  {
    id: 'physical_labor_no_vs_field',
    userConstraint: 'physical_labor_no',
    jobAttribute: 'work_environment',
    jobCondition: (value) => value === 'field' || value === 'factory' || value === 'workshop' || value === 'outdoor',
    reason: '육체노동 회피 신호가 있으나 해당 직업은 현장/공장 환경',
  },
  {
    id: 'repetitive_manual_no_vs_high',
    userConstraint: 'repetitive_manual_no',
    jobAttribute: 'repetitive_level',
    jobCondition: (value) => value === 'high' || value === 'very_high' || (typeof value === 'number' && value >= 70),
    reason: '반복 작업 회피 신호가 있으나 해당 직업은 반복 숙련 노동 중심',
  },
  {
    id: 'repetitive_manual_no_vs_manufacturing',
    userConstraint: 'repetitive_manual_no',
    jobAttribute: 'job_type',
    jobCondition: (value) => ['manufacturing', 'assembly', 'production', 'crafts', 'manual_skilled'].includes(String(value)),
    reason: '반복 작업 회피 신호가 있으나 해당 직업은 제조/조립/생산 직종',
  },
  {
    id: 'no_decision_impact_avoid_vs_low',
    userConstraint: 'no_decision_impact_avoid',
    jobAttribute: 'decision_authority',
    jobCondition: (value) => typeof value === 'number' && value < 20,
    reason: '의사결정 영향력을 원하나 해당 직업은 의사결정권이 거의 없음',
  },
  {
    id: 'requires_data_work_vs_none',
    userConstraint: 'requires_data_work',
    jobAttribute: 'analytical',
    jobCondition: (value) => typeof value === 'number' && value < 20,
    reason: '데이터/분석 업무 선호가 있으나 해당 직업은 분석 요소가 거의 없음',
  },
]

// ============================================
// Risk Penalty Rules (경고 + 감점)
// ============================================
export const RISK_PENALTY_RULES: RiskPenaltyRule[] = [
  {
    id: 'prefer_low_overtime_vs_frequent',
    userConstraint: 'prefer_low_overtime',
    jobAttribute: 'work_hours',
    jobCondition: (value) => value === 'overtime_frequent' || value === 'overtime_sometimes',
    penalty: 10,
    warningLabel: '야근이 종종 있는 직업',
  },
  {
    id: 'prefer_remote_vs_none',
    userConstraint: 'prefer_remote',
    jobAttribute: 'remote_possible',
    jobCondition: (value) => value === 'none',
    penalty: 8,
    warningLabel: '원격근무가 어려운 직업',
  },
  {
    id: 'prefer_stability_vs_contract',
    userConstraint: 'prefer_stability',
    jobAttribute: 'employment_type',
    jobCondition: (value) => value === 'contract' || value === 'freelance' || value === 'gig',
    penalty: 12,
    warningLabel: '고용 안정성이 낮을 수 있음',
  },
  {
    id: 'work_hours_strict_vs_sometimes',
    userConstraint: 'work_hours_strict',
    jobAttribute: 'work_hours',
    jobCondition: (value) => value === 'overtime_sometimes',
    penalty: 15,
    warningLabel: '야근이 있을 수 있는 직업',
  },
  {
    id: 'shift_work_no_vs_sometimes',
    userConstraint: 'shift_work_no',
    jobAttribute: 'shift_work',
    jobCondition: (value) => value === 'sometimes' || value === 'possible',
    penalty: 10,
    warningLabel: '교대근무 가능성 있음',
  },
  {
    id: 'travel_frequent',
    userConstraint: 'remote_only',
    jobAttribute: 'travel',
    jobCondition: (value) => value === 'frequent' || value === 'always',
    penalty: 8,
    warningLabel: '출장이 잦은 직업',
  },
]

// ============================================
// Main Filter Function
// ============================================
export async function applyTagFilter(
  db: D1Database,
  candidates: VectorSearchResult[],
  userConstraints: UserConstraints
): Promise<FilterResult> {
  const excluded: HardCutItem[] = []
  const passed: FilteredCandidate[] = []
  let withRiskPenalty = 0
  let untaggedCount = 0
  
  // 근거 패킷 수집
  const exclusionDetails: TagEvidencePacket['exclusion_details'] = []
  const softDetails: TagEvidencePacket['soft_details'] = []
  
  // 1. 후보들의 job_attributes 조회
  const jobIds = candidates.map(c => c.job_id)
  const attributesMap = await getJobAttributes(db, jobIds)
  
  // 2. 각 후보에 대해 필터링
  for (const candidate of candidates) {
    const attrs = attributesMap.get(candidate.job_id)
    const isTagged = !!attrs
    
    if (!isTagged) {
      untaggedCount++
    }
    
    // Hard Exclusion 체크
    let isExcluded = false
    let excludeReason = ''
    let excludeRule = ''
    
    if (isTagged) {
      for (const rule of HARD_EXCLUSION_RULES) {
        const userHasConstraint = userConstraints[rule.userConstraint]
        if (userHasConstraint) {
          const jobValue = attrs[rule.jobAttribute]
          if (rule.jobCondition(jobValue)) {
            isExcluded = true
            excludeReason = rule.reason
            excludeRule = rule.id
            break
          }
        }
      }
    }
    
    if (isExcluded) {
      excluded.push({
        job_id: candidate.job_id,
        job_name: candidate.job_name,
        reason: excludeReason,
        rule_matched: excludeRule,
      })
      
      // 근거 패킷에 추가
      exclusionDetails.push({
        job_id: candidate.job_id,
        job_name: candidate.job_name,
        rule_id: excludeRule,
        reason: excludeReason,
        confidence: 'high',  // Hard exclusion은 항상 high
        source: isTagged ? 'job_attribute' : 'inferred',
      })
      
      continue
    }
    
    // Risk Penalty 계산
    let totalPenalty = 0
    const warnings: string[] = []
    const appliedRules: Array<{ ruleId: string; warning: string; penalty: number }> = []
    
    if (isTagged) {
      for (const rule of RISK_PENALTY_RULES) {
        const userHasConstraint = userConstraints[rule.userConstraint]
        if (userHasConstraint) {
          const jobValue = attrs[rule.jobAttribute]
          if (rule.jobCondition(jobValue)) {
            totalPenalty += rule.penalty
            warnings.push(rule.warningLabel)
            appliedRules.push({
              ruleId: rule.id,
              warning: rule.warningLabel,
              penalty: rule.penalty,
            })
          }
        }
      }
    }
    
    if (totalPenalty > 0) {
      withRiskPenalty++
      
      // 근거 패킷에 soft details 추가
      for (const appliedRule of appliedRules) {
        softDetails.push({
          job_id: candidate.job_id,
          job_name: candidate.job_name,
          rule_id: appliedRule.ruleId,
          warning: appliedRule.warning,
          penalty: appliedRule.penalty,
          confidence: isTagged ? 'high' : 'low',
        })
      }
    }
    
    passed.push({
      ...candidate,
      riskPenalty: totalPenalty,
      riskWarnings: warnings,
      tagSource: isTagged ? 'tagged' : 'untagged',
    })
  }
  
  return {
    passed,
    excluded,
    stats: {
      totalInput: candidates.length,
      hardExcluded: excluded.length,
      passed: passed.length,
      withRiskPenalty,
      untaggedCount,
    },
    evidence: {
      exclusion_details: exclusionDetails,
      soft_details: softDetails,
    },
  }
}

// ============================================
// Helper: Job Attributes 조회
// ============================================
async function getJobAttributes(
  db: D1Database,
  jobIds: string[]
): Promise<Map<string, Record<string, any>>> {
  if (jobIds.length === 0) {
    return new Map()
  }
  
  // 배치로 나눠서 조회 (SQL 제한 대응)
  const BATCH_SIZE = 100
  const results = new Map<string, Record<string, any>>()
  
  for (let i = 0; i < jobIds.length; i += BATCH_SIZE) {
    const batch = jobIds.slice(i, i + BATCH_SIZE)
    const placeholders = batch.map(() => '?').join(',')
    
    try {
      const queryResult = await db.prepare(`
        SELECT 
          job_id,
          work_hours,
          shift_work,
          travel,
          remote_possible,
          degree_required,
          license_required,
          wlb,
          growth,
          stability,
          income
        FROM job_attributes
        WHERE job_id IN (${placeholders})
      `).bind(...batch).all<{
        job_id: string
        work_hours: string
        shift_work: string
        travel: string
        remote_possible: string
        degree_required: string
        license_required: string
        wlb: number
        growth: number
        stability: number
        income: number
      }>()
      
      for (const row of queryResult.results || []) {
        results.set(row.job_id, row)
      }
    } catch (error) {
      console.warn('[TagFilter] Batch query failed:', error)
    }
  }
  
  return results
}

// ============================================
// Pre-Filter: RAG 검색 전 Hard Constraint 기반 필터링
// TAG 데이터가 있는 직업들 중에서 확실히 제외할 job_id 목록 반환
// ============================================
export interface PreFilterResult {
  excludedJobIds: Set<string>
  excludedItems: HardCutItem[]
  stats: {
    totalTagged: number
    excluded: number
    remainingTagged: number
  }
}

export async function preFilterByHardConstraints(
  db: D1Database,
  userConstraints: UserConstraints
): Promise<PreFilterResult> {
  const excludedJobIds = new Set<string>()
  const excludedItems: HardCutItem[] = []
  
  // 사용자 제약 조건이 없으면 필터링 없이 반환
  const activeConstraints = Object.entries(userConstraints).filter(([_, v]) => v)
  if (activeConstraints.length === 0) {
    return {
      excludedJobIds,
      excludedItems,
      stats: { totalTagged: 0, excluded: 0, remainingTagged: 0 },
    }
  }
  
  // 각 Hard Exclusion Rule에 대해 SQL 기반 필터링
  // 효율성을 위해 DB에서 직접 제외 대상 조회
  const exclusionQueries: Promise<void>[] = []
  
  for (const rule of HARD_EXCLUSION_RULES) {
    if (!userConstraints[rule.userConstraint]) continue
    
    // 조건에 맞는 직업 조회
    exclusionQueries.push(
      (async () => {
        try {
          let condition: string
          switch (rule.id) {
            case 'remote_only_vs_none':
              condition = "remote_possible = 'none'"
              break
            case 'work_hours_strict_vs_heavy':
              condition = "work_hours IN ('overtime_heavy', 'always_overtime')"
              break
            case 'shift_work_no_vs_required':
              condition = "shift_work IN ('required', 'always')"
              break
            case 'degree_impossible_vs_required':
              condition = "degree_required IN ('required', 'masters_required')"
              break
            case 'license_impossible_vs_required':
              condition = "license_required IN ('required', 'mandatory')"
              break
            default:
              return
          }
          
          const result = await db.prepare(`
            SELECT ja.job_id, j.job_name
            FROM job_attributes ja
            LEFT JOIN jobs j ON ja.job_id = j.job_id
            WHERE ${condition}
          `).all<{ job_id: string; job_name: string }>()
          
          for (const row of result.results || []) {
            excludedJobIds.add(row.job_id)
            excludedItems.push({
              job_id: row.job_id,
              job_name: row.job_name || row.job_id,
              reason: rule.reason,
              rule_matched: rule.id,
            })
          }
        } catch (error) {
          console.warn(`[PreFilter] Rule ${rule.id} query failed:`, error)
        }
      })()
    )
  }
  
  await Promise.all(exclusionQueries)
  
  // 태그된 직업 총 수 조회
  let totalTagged = 0
  try {
    const countResult = await db.prepare('SELECT COUNT(*) as cnt FROM job_attributes').first<{ cnt: number }>()
    totalTagged = countResult?.cnt || 0
  } catch (error) {
    console.warn('[PreFilter] Count query failed:', error)
  }
  
  return {
    excludedJobIds,
    excludedItems,
    stats: {
      totalTagged,
      excluded: excludedJobIds.size,
      remainingTagged: totalTagged - excludedJobIds.size,
    },
  }
}

// ============================================
// Get All Non-Excluded Job IDs (for RAG filter)
// RAG 검색 시 filter 옵션으로 전달할 수 있는 job_id 목록 반환
// ============================================
export async function getAllowedJobIdsForRag(
  db: D1Database,
  userConstraints: UserConstraints
): Promise<string[] | null> {
  // 사용자 제약 조건이 없으면 null 반환 (RAG 전체 검색)
  const activeConstraints = Object.entries(userConstraints).filter(([_, v]) => v)
  if (activeConstraints.length === 0) {
    return null  // null = 필터 없이 전체 검색
  }
  
  // Pre-filter 실행
  const preFilterResult = await preFilterByHardConstraints(db, userConstraints)
  
  // 제외된 job_id가 없으면 null 반환 (전체 검색)
  if (preFilterResult.excludedJobIds.size === 0) {
    return null
  }
  
  // 전체 jobs에서 제외 목록을 빼고 반환
  // (Vectorize 검색 시 filter로 사용)
  try {
    const allJobs = await db.prepare('SELECT job_id FROM jobs').all<{ job_id: string }>()
    const allowedIds: string[] = []
    
    for (const row of allJobs.results || []) {
      if (!preFilterResult.excludedJobIds.has(row.job_id)) {
        allowedIds.push(row.job_id)
      }
    }
    
    console.log(`[PreFilter] Allowed jobs for RAG: ${allowedIds.length} / ${allJobs.results?.length || 0}`)
    return allowedIds
    
  } catch (error) {
    console.warn('[PreFilter] Failed to get allowed job IDs:', error)
    return null  // 실패 시 필터 없이 전체 검색
  }
}

// ============================================
// Hard Bias → Hard Constraint 자동 연결
// Q9 에너지 소모원(energy_drain)에서 Hard Constraint 자동 생성
// ============================================
export interface HardBiasConstraintMapping {
  energyDrainFlag: string
  targetAttribute: string
  condition: string
  penalty: number
  description: string
}

export const HARD_BIAS_TO_CONSTRAINT_RULES: HardBiasConstraintMapping[] = [
  {
    energyDrainFlag: 'people_drain',
    targetAttribute: 'people_interaction',
    condition: 'high',
    penalty: 15,
    description: '대면비중 높은 직업 soft exclude',
  },
  {
    energyDrainFlag: 'time_pressure_drain',
    targetAttribute: 'work_hours',
    condition: 'overtime_frequent',
    penalty: 12,
    description: '상시 야근 직업 penalty',
  },
  {
    energyDrainFlag: 'unpredictability_drain',
    targetAttribute: 'work_schedule',
    condition: 'irregular',
    penalty: 10,
    description: '불규칙 근무 직업 제외',
  },
  {
    energyDrainFlag: 'responsibility_drain',
    targetAttribute: 'decision_authority',
    condition: 'high',  // 의사결정권이 높은 = 책임 큼
    penalty: 8,
    description: '관리직/리더십 역할 가중치 감소',
  },
  {
    energyDrainFlag: 'cognitive_drain',
    targetAttribute: 'cognitive_demand',
    condition: 'high',
    penalty: 10,
    description: '고인지부하 직업 penalty',
  },
  {
    energyDrainFlag: 'repetition_drain',
    targetAttribute: 'task_variety',
    condition: 'low',  // 다양성 낮음 = 반복 많음
    penalty: 8,
    description: '반복 업무 직업 penalty',
  },
]

export interface HardBiasDerivedConstraints {
  penalties: Array<{
    jobAttribute: string
    condition: string
    penalty: number
    reason: string
  }>
  totalMaxPenalty: number
  summary: string
}

/**
 * Hard Bias(Q9 energy_drain)에서 Hard Constraint 자동 생성
 * "사람이 싫다"고 말했으면, 시스템이 직업 조건에서도 그걸 반영
 */
export function deriveConstraintsFromHardBias(
  energyDrainFlags: string[]
): HardBiasDerivedConstraints {
  const penalties: HardBiasDerivedConstraints['penalties'] = []
  
  for (const rule of HARD_BIAS_TO_CONSTRAINT_RULES) {
    if (energyDrainFlags.includes(rule.energyDrainFlag)) {
      penalties.push({
        jobAttribute: rule.targetAttribute,
        condition: rule.condition,
        penalty: rule.penalty,
        reason: rule.description,
      })
    }
  }
  
  const totalMaxPenalty = penalties.reduce((sum, p) => sum + p.penalty, 0)
  
  // 요약 문구 생성
  const summaryParts: string[] = []
  if (energyDrainFlags.includes('people_drain')) {
    summaryParts.push('low-interaction roles preferred')
  }
  if (energyDrainFlags.includes('time_pressure_drain')) {
    summaryParts.push('flexible schedule required')
  }
  if (energyDrainFlags.includes('unpredictability_drain')) {
    summaryParts.push('structured environment needed')
  }
  if (energyDrainFlags.includes('responsibility_drain')) {
    summaryParts.push('contributor role over leadership')
  }
  
  return {
    penalties,
    totalMaxPenalty,
    summary: summaryParts.length > 0 
      ? `Energy constraints: ${summaryParts.join(', ')}`
      : 'No specific energy constraints',
  }
}

/**
 * 직업 속성에 Hard Bias 기반 패널티 적용
 */
export function applyHardBiasPenalty(
  jobAttributes: Record<string, any>,
  derivedConstraints: HardBiasDerivedConstraints
): { penalty: number; warnings: string[] } {
  let totalPenalty = 0
  const warnings: string[] = []
  
  for (const constraint of derivedConstraints.penalties) {
    const jobValue = jobAttributes[constraint.jobAttribute]
    
    // 속성이 없으면 스킵 (unknown은 패널티 없음)
    if (jobValue === undefined || jobValue === null) continue
    
    // 조건 매칭 체크
    let matches = false
    if (typeof jobValue === 'string') {
      matches = jobValue === constraint.condition || jobValue.includes(constraint.condition)
    } else if (typeof jobValue === 'number') {
      // high = 70 이상, low = 30 이하로 해석
      if (constraint.condition === 'high' && jobValue >= 70) matches = true
      if (constraint.condition === 'low' && jobValue <= 30) matches = true
    }
    
    if (matches) {
      totalPenalty += constraint.penalty
      warnings.push(constraint.reason)
    }
  }
  
  return {
    penalty: Math.min(totalPenalty, 35),  // 최대 35점 패널티
    warnings,
  }
}

// ============================================
// Utility: 사용자 제약조건 추출
// ============================================
// ============================================
// 미니모듈 기반 Hard Exclusion (Phase 2.1)
// 사용자의 에너지 소모원 + 작업스타일을 기반으로 부적합 직업 사전 제외
// ============================================

import type { MiniModuleResult } from './mini-module-questions'

export interface MiniModuleHardFilter {
  excludedJobIds: string[]
  appliedRules: Array<{
    ruleId: string
    reason: string
    excludedCount: number
  }>
  stats: {
    totalFiltered: number
    beforeCount: number
    afterCount: number
  }
}

/**
 * 미니모듈 기반 Hard Exclusion 규칙
 * energy_drain_flags, workstyle_top, sacrifice_flags 기반으로 부적합 직업 제외
 */
export interface MiniModuleExclusionRule {
  id: string
  description: string
  // 조건 체크 함수
  shouldExclude: (
    miniModule: MiniModuleResult,
    jobAttrs: Record<string, any>
  ) => boolean
}

export const MINI_MODULE_EXCLUSION_RULES: MiniModuleExclusionRule[] = [
  // 1. people_drain + 대면 서비스직 → Hard Exclusion
  {
    id: 'people_drain_vs_high_facing',
    description: '대인 상호작용 에너지 소모 → 대면 서비스직 제외',
    shouldExclude: (mm, job) => {
      const hasPeopleDrain = mm.energy_drain_flags?.includes('people_drain')
      const highPeopleFacing = (job.people_facing || 50) >= 70
      return hasPeopleDrain === true && highPeopleFacing
    },
  },
  // 2. solo 선호 + 팀워크 필수 → Hard Exclusion
  {
    id: 'solo_vs_teamwork_required',
    description: '혼자 집중 선호 → 팀워크 필수 직업 제외',
    shouldExclude: (mm, job) => {
      const prefersSolo = mm.workstyle_top?.includes('solo')
      const highTeamwork = (job.teamwork || 50) >= 80
      return prefersSolo === true && highTeamwork
    },
  },
  // 3. structured 선호 + 유동적 환경 → Risk Penalty (not hard exclusion)
  // 이건 Hard Exclusion이 아닌 Penalty로 처리
  
  // 4. time_pressure_drain + 야근 잦음 → Hard Exclusion
  {
    id: 'time_drain_vs_overtime_heavy',
    description: '시간 압박 에너지 소모 → 야근 잦은 직업 제외',
    shouldExclude: (mm, job) => {
      const hasTimeDrain = mm.energy_drain_flags?.includes('time_pressure_drain')
      const heavyOvertime = job.work_hours === 'overtime_heavy' || job.work_hours === 'always_overtime'
      return hasTimeDrain === true && heavyOvertime
    },
  },
  // 5. responsibility_drain + 관리직/리더십 → Hard Exclusion
  {
    id: 'responsibility_drain_vs_management',
    description: '책임 부담 에너지 소모 → 관리직/리더십 역할 제외',
    shouldExclude: (mm, job) => {
      const hasResponsibilityDrain = mm.energy_drain_flags?.includes('responsibility_drain')
      // decision_authority가 없으면 job_name으로 판단
      const isManagement = (job.decision_authority && job.decision_authority >= 70) ||
        (job.job_name && /관리자|매니저|팀장|감독|책임자|리더/.test(job.job_name))
      return hasResponsibilityDrain === true && isManagement
    },
  },
  // 6. no_sacrifice + 불안정 직업군 → Hard Exclusion
  {
    id: 'no_sacrifice_vs_unstable',
    description: '희생 불가 선택 → 불안정 직업군 제외',
    shouldExclude: (mm, job) => {
      const noSacrifice = mm.sacrifice_flags?.includes('no_sacrifice')
      // 불안정 = stability < 40 또는 employment_type이 contract/freelance
      const isUnstable = (job.stability || 50) < 40 ||
        ['contract', 'freelance', 'gig'].includes(job.employment_type)
      return noSacrifice === true && isUnstable
    },
  },
  // 7. cognitive_drain + 고인지부하 직업 → Risk Penalty +20 (Hard Exclusion 아님)
  // 별도 penalty 함수에서 처리
  
  // 8. repetition_drain + 반복 업무 직업 → Hard Exclusion
  {
    id: 'repetition_drain_vs_low_variety',
    description: '반복 에너지 소모 → 단순 반복 업무 직업 제외',
    shouldExclude: (mm, job) => {
      const hasRepetitionDrain = mm.energy_drain_flags?.includes('repetition_drain')
      // task_variety가 없으면 execution 수치로 추정
      const isLowVariety = (job.task_variety && job.task_variety <= 30) ||
        ((job.execution || 50) >= 80 && (job.creative || 50) <= 30)
      return hasRepetitionDrain === true && isLowVariety
    },
  },
  // 9. 분석형 강점 + 현장직/제조업 → Hard Exclusion (핵심 피드백 반영)
  {
    id: 'analytical_vs_field_manufacturing',
    description: '분석형 강점 → 현장직/제조업 제외',
    shouldExclude: (mm, job) => {
      const hasAnalytical = mm.strength_top?.includes('analytical') ||
        mm.interest_top?.includes('problem_solving') ||
        mm.interest_top?.includes('data_numbers')
      // 현장직/제조업 판단: analytical/creative가 모두 낮거나, 직업명이 현장직 패턴
      const anal = job.analytical || 0
      const crea = job.creative || 0
      const exec = job.execution || 0
      // 속성 기반: execution이 지배적이고 analytical+creative가 약한 경우
      const isFieldByAttrs = (exec >= 60 && anal <= 45 && crea <= 40)
      // 직업명 기반: 현장직/제조업/기능직 접미사 패턴
      const isFieldByName = job.job_name && /제조|조립|생산|현장|설치|제작원|반장|포장|검사원|조작원|용융원|성형|기능원|정비원|수리원|포설원|연마|주형|용접|절삭|선반|밀링|프레스|주조|톱질|절단|도장|도금|세척|적재|하역|운반|건축기능|기운전원|제판원|충방전원|어닐링원|용해원|할석원|상감원|계량원|처리원|모사공|제련원|수밀수정원|가공원|배양원|도자기|조각원/.test(job.job_name)
      return hasAnalytical === true && (isFieldByAttrs || isFieldByName)
    },
  },
  // ============================================
  // 🆕 V3.1 강화된 Hard Exclusion (석제품제작원 문제 해결)
  // ============================================
  // 10. physical_constraint + 육체노동 직업 → Hard Exclusion
  {
    id: 'physical_constraint_vs_manual_labor',
    description: '체력 제약 → 육체노동/현장직 제외',
    shouldExclude: (mm, job) => {
      const hasPhysicalConstraint = mm.constraint_flags?.includes('physical_constraint')
      // 육체노동 직업 판단
      const isManualLabor = (job.physical_demand === 'high' || job.physical_demand === 'very_high') ||
        (job.work_environment === 'field' || job.work_environment === 'factory' || job.work_environment === 'workshop' || job.work_environment === 'outdoor') ||
        (job.job_name && /석편수|석공|석제품|도자기|조각원|용접|배관|전기|설비|목수|미장|건설|토목|광부|광원|제작원|가공원|조립원|설치원|기운전원|제판원|충방전원|어닐링원|용해원|할석원|상감원|계량원|처리원|제련원|수밀수정원|배양원/.test(job.job_name))
      return hasPhysicalConstraint === true && isManualLabor
    },
  },
  // 11. repetition_drain + 제조/공예/숙련직 → Hard Exclusion (더 강력)
  {
    id: 'repetition_drain_vs_skilled_crafts',
    description: '반복 에너지 소모 → 숙련 공예/제조직 제외',
    shouldExclude: (mm, job) => {
      const hasRepetitionDrain = mm.energy_drain_flags?.includes('repetition_drain')
      // 숙련 공예/제조직 판단 - 직업명으로 강하게 필터링
      const isSkilledCraft = job.job_name && /석제품|도자기|공예|조각|가구|세공|직조|염색|제작원|제조원|가공원|조립|용접|절삭|선반|밀링|프레스|조작원|용융원|성형|주조|연마|도장|도금|기능원|정비원|수리원|기운전원|제판원|충방전원|어닐링원|용해원|할석원|상감원|계량원|처리원|모사공|원사가공|제련원|수밀수정원|배양원/.test(job.job_name)
      return hasRepetitionDrain === true && isSkilledCraft
    },
  },
  // 12. data_numbers 관심 + 데이터 작업 없는 직업 → Hard Exclusion
  {
    id: 'data_interest_vs_no_data_work',
    description: '데이터/숫자 관심 → 데이터 작업 없는 직업 제외',
    shouldExclude: (mm, job) => {
      const hasDataInterest = mm.interest_top?.includes('data_numbers') || 
        mm.strength_top?.includes('analytical')
      // 데이터 작업 거의 없음 (analytical < 20, 직업명에서도 분석/데이터 없음)
      const noDataWork = (job.analytical || 50) <= 20 &&
        !(job.job_name && /분석|데이터|통계|연구|조사|기획|전략|컨설팅/.test(job.job_name))
      return hasDataInterest === true && noDataWork
    },
  },
  // 13. 반복 업무 싫음 (dislike) + 단순 반복 직업 → Hard Exclusion
  {
    id: 'dislike_routine_vs_repetitive_job',
    description: '반복/정형화 업무 싫음 → 단순 반복 직업 제외',
    shouldExclude: (mm, job) => {
      // 싫어하는 것에 반복/루틴/정형화 포함 여부
      const dislikesRoutine = mm.energy_drain_flags?.includes('repetition_drain') ||
        mm.constraint_flags?.includes('uncertainty_constraint') === false // 변화를 원함
      // 고정된 반복 패턴 직업 (저분석, 저창의, 고실행)
      const isRepetitiveJob = ((job.analytical || 50) <= 30 && (job.creative || 50) <= 30 && (job.execution || 50) >= 60) ||
        (job.task_variety && job.task_variety <= 25) ||
        (job.job_name && /단순|포장|검수|분류|입력|정리|청소|경비|주차|배달/.test(job.job_name))
      return dislikesRoutine === true && isRepetitiveJob
    },
  },
  // 15. 지식노동 선호 유저 + 비지식노동 직업명 패턴 → Hard Exclusion
  {
    id: 'knowledge_user_vs_non_knowledge_job',
    description: '지식노동형 유저 → 비지식 직업 광범위 제외',
    shouldExclude: (mm, job) => {
      // 유저가 지식/분석/창의 지향인지
      const isKnowledgeUser = mm.interest_top?.includes('data_numbers') ||
        mm.interest_top?.includes('problem_solving') ||
        mm.interest_top?.includes('creating') ||
        mm.interest_top?.includes('research') ||
        mm.strength_top?.includes('analytical') ||
        mm.strength_top?.includes('creative')
      if (!isKnowledgeUser || !job.job_name) return false

      // ──── 제조/공장 ────
      const isFactory = /조작원|기능원|용융원|성형원|연마공|주형|도장원|도금원|세척원|절단원|톱질원|포설원|배관원|농축원|건조원|증류원|소성원|혼합원|분쇄원|파쇄원|압출원|압연원|단조원|주물원|소둔원|열처리원|표백원|재단원|봉제원|적재원|하역원|운반원|원료준비원|방사원|탈색|세정원|측정원|배합원|충전원|권취원|정련원|소결원|피복원|도포원|함침원|기운전원|제판원|충방전원|어닐링원|용해원|할석원|처리원|계량원|상감원|모사공|직조원|원사가공|제련원|수밀수정원|가공원|배양원|도자기|조각원/.test(job.job_name)

      // ──── 스포츠/체육 ────
      const isSports = /운동선수|코치|심판|체육|스포츠|헬스트레이너|생활체육/.test(job.job_name)

      // ──── 농축수산업 ────
      const isFarming = /재배원|사육사|농부|축산|목장|양식|양봉|낙농|농업|임업|어업|어부|수산|과수|채소|곡물|화훼|종돈|종축|원예/.test(job.job_name)

      // ──── 식품가공/검사 ────
      const isFoodProcessing = /등급원|식품가공|도축|도계|제분|양조|제빵사[^가-힣]|떡제조|김치제조|음료제조|식육|발효균|배양원/.test(job.job_name)

      // ──── 건설/건축 현장직 ────
      const isConstruction = /건축기능|미장|타일|방수공|비계|철근|거푸집|콘크리트공|도배|창호|유리시공|지붕잇기|배관공|덕트|보온|단열|석공|석재/.test(job.job_name)

      // ──── 운전/운송 ────
      const isTransport = /택시운전|버스운전|화물차|트럭운전|택배|배달|지게차|굴삭기|크레인|항공기조종|선박조종|기관사|열차운전/.test(job.job_name)

      // ──── 미용/서비스 (분석형에게 부적합) ────
      const isPersonalService = /미용사|이용사|네일아티스트|피부관리사|애견미용|세탁|다림질|구두수선|혼례종사원|추심원/.test(job.job_name)

      return isFactory || isSports || isFarming || isFoodProcessing || isConstruction || isTransport || isPersonalService
    },
  },
  // 14. 문제정의/의사결정 선호 + 의사결정권 없는 직업 → Hard Exclusion
  {
    id: 'decision_preference_vs_no_authority',
    description: '의사결정 선호 → 결정권 없는 실행직 제외',
    shouldExclude: (mm, job) => {
      // 문제정의, 분석, 의사결정 관심
      const prefersDecision = mm.interest_top?.includes('problem_solving') ||
        mm.strength_top?.includes('analytical') ||
        mm.workstyle_top?.includes('leader')
      // 의사결정권 매우 낮음 (단순 실행직)
      const noDecisionAuthority = (job.decision_authority && job.decision_authority <= 15) ||
        (job.job_name && /보조|조수|인부|막노동|단순|잡부|아르바이트/.test(job.job_name))
      return prefersDecision === true && noDecisionAuthority
    },
  },
]

/**
 * 미니모듈 기반 Hard Exclusion 적용
 * sampleJobs 배열에서 부적합 직업을 제거하고 결과 반환
 */
export function applyMiniModuleHardFilter<T extends { job_id: string; job_name: string; attributes?: Record<string, any> }>(
  jobs: T[],
  miniModule: MiniModuleResult | undefined
): { filtered: T[]; filterResult: MiniModuleHardFilter } {
  // 미니모듈이 없으면 필터링 없이 반환
  if (!miniModule) {
    return {
      filtered: jobs,
      filterResult: {
        excludedJobIds: [],
        appliedRules: [],
        stats: { totalFiltered: 0, beforeCount: jobs.length, afterCount: jobs.length },
      },
    }
  }

  const excludedJobIds: string[] = []
  const ruleExclusionCount: Record<string, number> = {}

  const filtered = jobs.filter(job => {
    // job의 attributes를 가져옴
    const attrs = (job as any).attributes || job
    
    for (const rule of MINI_MODULE_EXCLUSION_RULES) {
      if (rule.shouldExclude(miniModule, { ...attrs, job_name: job.job_name })) {
        excludedJobIds.push(job.job_id)
        ruleExclusionCount[rule.id] = (ruleExclusionCount[rule.id] || 0) + 1
        return false // 제외
      }
    }
    return true // 포함
  })

  const appliedRules = MINI_MODULE_EXCLUSION_RULES
    .filter(rule => ruleExclusionCount[rule.id] && ruleExclusionCount[rule.id] > 0)
    .map(rule => ({
      ruleId: rule.id,
      reason: rule.description,
      excludedCount: ruleExclusionCount[rule.id] || 0,
    }))

  console.log(`[MiniModuleHardFilter] Filtered ${excludedJobIds.length} jobs:`, 
    appliedRules.map(r => `${r.ruleId}(${r.excludedCount})`).join(', '))

  return {
    filtered,
    filterResult: {
      excludedJobIds,
      appliedRules,
      stats: {
        totalFiltered: excludedJobIds.length,
        beforeCount: jobs.length,
        afterCount: filtered.length,
      },
    },
  }
}

/**
 * 미니모듈 기반 추가 Risk Penalty 계산
 * Hard Exclusion이 아닌 soft penalty 적용
 */
export function calculateMiniModuleRiskPenalty(
  miniModule: MiniModuleResult | undefined,
  jobAttrs: Record<string, any>
): { penalty: number; warnings: string[] } {
  if (!miniModule) {
    return { penalty: 0, warnings: [] }
  }

  let penalty = 0
  const warnings: string[] = []

  // cognitive_drain + 고인지부하 → +20 penalty
  if (miniModule.energy_drain_flags?.includes('cognitive_drain')) {
    const highCognitive = (jobAttrs.analytical || 50) >= 80 || 
      (jobAttrs.cognitive_demand && jobAttrs.cognitive_demand >= 70)
    if (highCognitive) {
      penalty += 20
      warnings.push('고인지부하 직업 (에너지 소모 주의)')
    }
  }

  // structured 선호 + flexible 환경 → +15 penalty
  if (miniModule.workstyle_top?.includes('structured')) {
    const isFlexible = jobAttrs.work_schedule === 'flexible' || 
      jobAttrs.work_schedule === 'irregular' ||
      (jobAttrs.creative || 50) >= 70
    if (isFlexible) {
      penalty += 15
      warnings.push('유동적 업무 환경 (구조화 선호와 불일치)')
    }
  }

  // team 선호 + solo_deep 높음 → +10 penalty
  if (miniModule.workstyle_top?.includes('team')) {
    const highSoloDeep = (jobAttrs.solo_deep || 50) >= 70
    if (highSoloDeep) {
      penalty += 10
      warnings.push('독립 업무 비중 높음 (팀워크 선호와 불일치)')
    }
  }

  // unpredictability_drain + 불규칙 근무 → +15 penalty
  if (miniModule.energy_drain_flags?.includes('unpredictability_drain')) {
    const isIrregular = jobAttrs.work_schedule === 'irregular' ||
      jobAttrs.shift_work === 'sometimes' ||
      jobAttrs.travel === 'frequent'
    if (isIrregular) {
      penalty += 15
      warnings.push('불규칙한 근무 환경 (예측 가능성 선호와 불일치)')
    }
  }

  return {
    penalty: Math.min(penalty, 40), // 최대 40점 패널티
    warnings,
  }
}

export function extractUserConstraints(
  universalAnswers: Record<string, string | string[]>,
  careerState?: { constraints?: Record<string, any> }
): UserConstraints {
  const constraints: UserConstraints = {}
  
  // Universal Answers에서 추출
  const constraintTime = universalAnswers['univ_constraint_time']
  if (constraintTime) {
    const arr = Array.isArray(constraintTime) ? constraintTime : [constraintTime]
    if (arr.includes('work_hours_strict')) constraints.work_hours_strict = true
    if (arr.includes('shift_work_no')) constraints.shift_work_no = true
  }
  
  const constraintLocation = universalAnswers['univ_constraint_location']
  if (constraintLocation) {
    const arr = Array.isArray(constraintLocation) ? constraintLocation : [constraintLocation]
    if (arr.includes('remote_only')) constraints.remote_only = true
  }
  
  const constraintQual = universalAnswers['univ_constraint_qualification']
  if (constraintQual) {
    const arr = Array.isArray(constraintQual) ? constraintQual : [constraintQual]
    if (arr.includes('degree_impossible')) constraints.degree_impossible = true
    if (arr.includes('license_impossible')) constraints.license_impossible = true
  }
  
  // 선호도 (Preference)
  const dislike = universalAnswers['univ_dislike']
  if (dislike) {
    const arr = Array.isArray(dislike) ? dislike : [dislike]
    if (arr.includes('overtime')) constraints.prefer_low_overtime = true
  }
  
  // Career State에서 추출
  if (careerState?.constraints) {
    for (const [key, value] of Object.entries(careerState.constraints)) {
      if (value?.has_constraint) {
        if (key === 'work_hours') constraints.work_hours_strict = true
        if (key === 'shift_work') constraints.shift_work_no = true
        if (key === 'remote') constraints.remote_only = true
        if (key === 'degree') constraints.degree_impossible = true
        if (key === 'license') constraints.license_impossible = true
      }
    }
  }

  return constraints
}

// ============================================
// P1: 제외 이유 요약 (Transparency)
// 유저에게 왜 특정 직업이 제외됐는지 보여주기
// ============================================
export interface ExcludedJobsSummary {
  total_excluded: number
  by_reason: Array<{
    reason: string
    count: number
    example_jobs: string[]  // 최대 3개
  }>
  user_message: string  // "야근이 많은 직업 15개가 제외되었습니다" 등
}

/**
 * 제외된 직업 목록을 이유별로 그룹핑하여 요약
 */
export function buildExcludedJobsSummary(
  excluded: HardCutItem[]
): ExcludedJobsSummary {
  if (excluded.length === 0) {
    return {
      total_excluded: 0,
      by_reason: [],
      user_message: '제외된 직업이 없습니다',
    }
  }

  // 이유별 그룹핑
  const byReason = new Map<string, HardCutItem[]>()
  for (const item of excluded) {
    const existing = byReason.get(item.reason) || []
    existing.push(item)
    byReason.set(item.reason, existing)
  }

  // 요약 생성
  const summaries = Array.from(byReason.entries())
    .map(([reason, items]) => ({
      reason,
      count: items.length,
      example_jobs: items.slice(0, 3).map(i => i.job_name),
    }))
    .sort((a, b) => b.count - a.count)  // 많은 순서로 정렬

  // 유저 메시지 생성
  const topReason = summaries[0]
  let userMessage = ''
  if (summaries.length === 1) {
    userMessage = `${topReason.reason} (${topReason.count}개 직업 제외)`
  } else {
    userMessage = `${topReason.reason} 외 ${summaries.length - 1}가지 이유로 ${excluded.length}개 직업 제외`
  }

  return {
    total_excluded: excluded.length,
    by_reason: summaries,
    user_message: userMessage,
  }
}

/**
 * 제외 이유를 한글로 변환
 */
export function translateExclusionReason(reason: string): string {
  const translations: Record<string, string> = {
    '원격근무 불가능': '원격근무가 어려운 직업',
    '잦은 야근 가능성': '야근이 잦을 수 있는 직업',
    '교대근무 필요': '교대근무가 필요한 직업',
    '학위 필요': '학위가 필요한 직업',
    '자격증 필요': '자격증이 필요한 직업',
    '출장 빈번': '출장이 많은 직업',
    // 미니모듈 기반 제외 이유
    '분석형 강점 → 현장직/제조업 제외': '분석 역량을 활용하기 어려운 현장직',
    '체력 제약 → 육체노동/현장직 제외': '체력적 부담이 큰 직업',
    '반복 에너지 소모 → 단순 반복 업무 직업 제외': '반복적인 업무가 많은 직업',
    // Can 기반 제외 이유
    '분석 능력 부족 → 고분석 직업 제외': '분석 역량이 필요한 직업',
    '창의 경험 부족 → 크리에이티브직 제외': '창의적 경험이 필요한 직업',
    '소통 경험 부족 → 대인 서비스직 제외': '높은 소통 역량이 필요한 직업',
  }
  return translations[reason] || reason
}

// ============================================
// P2: Can 기반 TAG 필터
// 검증된 Can 능력을 기반으로 직업 필터링
// ============================================

/**
 * Can 능력 토큰 (can-validation-questions.ts와 동기화)
 */
export type CanToken =
  | 'analytical'      // 분석형
  | 'creative'        // 창의형
  | 'communication'   // 소통형
  | 'structured_execution' // 체계실행형
  | 'persistence'     // 끈기형
  | 'fast_learning'   // 빠른학습형

/**
 * Can 기반 필터링 규칙
 * - 직업의 해당 능력 요구 수준이 높은데 (threshold 이상)
 * - 유저의 검증된 Can Boost가 낮으면 (minBoost 미만)
 * - Soft Penalty 또는 Hard Exclusion 적용
 */
export interface CanBasedFilterRule {
  id: string
  canToken: CanToken
  jobAttribute: string       // job_attributes 테이블의 컬럼명
  jobThreshold: number       // 이 값 이상이면 해당 능력 필요
  minCanBoostForPass: number // 이 Can Boost 이상이면 통과
  penalty: number            // minBoost 미달 시 패널티
  isHardExclusion: boolean   // true면 Hard Exclusion (minBoost 0일 때)
  description: string
}

export const CAN_BASED_FILTER_RULES: CanBasedFilterRule[] = [
  // 분석형 (analytical)
  {
    id: 'analytical_required_high',
    canToken: 'analytical',
    jobAttribute: 'analytical',
    jobThreshold: 70,
    minCanBoostForPass: 8,
    penalty: 15,
    isHardExclusion: false,  // 분석 경험 없어도 배울 수 있음
    description: '분석 역량 필요 직업',
  },
  // 창의형 (creative)
  {
    id: 'creative_required_high',
    canToken: 'creative',
    jobAttribute: 'creative',
    jobThreshold: 70,
    minCanBoostForPass: 6,
    penalty: 12,
    isHardExclusion: false,
    description: '창의적 역량 필요 직업',
  },
  // 소통형 (communication) - 대면 서비스직
  {
    id: 'communication_required_high',
    canToken: 'communication',
    jobAttribute: 'people_facing',
    jobThreshold: 75,
    minCanBoostForPass: 10,
    penalty: 18,
    isHardExclusion: false,
    description: '높은 소통 역량 필요 직업',
  },
  // 체계실행형 (structured_execution)
  {
    id: 'structured_execution_required',
    canToken: 'structured_execution',
    jobAttribute: 'execution',
    jobThreshold: 80,
    minCanBoostForPass: 8,
    penalty: 10,
    isHardExclusion: false,
    description: '체계적 실행력 필요 직업',
  },
]

/**
 * 유저의 검증된 Can Boost 맵
 */
export type VerifiedCanMap = Partial<Record<CanToken, number>>

/**
 * Can 기반 필터링 결과
 */
export interface CanBasedFilterResult {
  shouldExclude: boolean
  totalPenalty: number
  warnings: string[]
  appliedRules: Array<{
    ruleId: string
    description: string
    penalty: number
    userCanBoost: number
    requiredBoost: number
  }>
}

/**
 * 직업에 Can 기반 필터 적용
 */
export function applyCanBasedFilter(
  jobAttrs: Record<string, any>,
  verifiedCan: VerifiedCanMap
): CanBasedFilterResult {
  let totalPenalty = 0
  const warnings: string[] = []
  const appliedRules: CanBasedFilterResult['appliedRules'] = []
  let shouldExclude = false

  for (const rule of CAN_BASED_FILTER_RULES) {
    const jobValue = jobAttrs[rule.jobAttribute]

    // 직업의 해당 능력 요구 수준 확인
    if (typeof jobValue !== 'number' || jobValue < rule.jobThreshold) {
      continue  // 이 능력이 요구되지 않는 직업
    }

    // 유저의 검증된 Can Boost 확인
    const userCanBoost = verifiedCan[rule.canToken] || 0

    // Can Boost가 충분하면 통과
    if (userCanBoost >= rule.minCanBoostForPass) {
      continue
    }

    // Can Boost가 0이고 Hard Exclusion 규칙이면 제외
    if (userCanBoost === 0 && rule.isHardExclusion) {
      shouldExclude = true
      appliedRules.push({
        ruleId: rule.id,
        description: rule.description,
        penalty: rule.penalty,
        userCanBoost,
        requiredBoost: rule.minCanBoostForPass,
      })
      break  // Hard Exclusion이면 바로 종료
    }

    // 부족한 정도에 비례하여 패널티 계산
    const shortfall = rule.minCanBoostForPass - userCanBoost
    const adjustedPenalty = Math.round(
      rule.penalty * (shortfall / rule.minCanBoostForPass)
    )

    totalPenalty += adjustedPenalty
    warnings.push(`${rule.description} (Can Boost ${userCanBoost}/${rule.minCanBoostForPass})`)
    appliedRules.push({
      ruleId: rule.id,
      description: rule.description,
      penalty: adjustedPenalty,
      userCanBoost,
      requiredBoost: rule.minCanBoostForPass,
    })
  }

  return {
    shouldExclude,
    totalPenalty: Math.min(totalPenalty, 35),  // 최대 35점 패널티
    warnings,
    appliedRules,
  }
}

/**
 * Facts에서 검증된 Can 맵 추출
 */
export function extractVerifiedCanFromFacts(
  facts: Array<{ fact_key: string; value_json: string }>
): VerifiedCanMap {
  const verifiedCan: VerifiedCanMap = {}

  const canTokens: CanToken[] = [
    'analytical',
    'creative',
    'communication',
    'structured_execution',
    'persistence',
    'fast_learning',
  ]

  for (const token of canTokens) {
    const factKey = `can_verified.${token}`
    const fact = facts.find(f => f.fact_key === factKey)

    if (fact) {
      try {
        const parsed = JSON.parse(fact.value_json)
        // Can boost 값 추출 (number 또는 { boost: number } 형태)
        if (typeof parsed === 'number') {
          verifiedCan[token] = parsed
        } else if (typeof parsed === 'object' && parsed.boost) {
          verifiedCan[token] = parsed.boost
        }
      } catch {
        // JSON 파싱 실패 시 무시
      }
    }
  }

  return verifiedCan
}

/**
 * 전체 Can 기반 필터 적용 (배치 처리)
 */
export function applyCanBasedFilterBatch<T extends { job_id: string; attributes?: Record<string, any> }>(
  jobs: T[],
  verifiedCan: VerifiedCanMap
): {
  passed: Array<T & { canPenalty: number; canWarnings: string[] }>
  excluded: Array<{ job_id: string; reason: string }>
  stats: { totalInput: number; excluded: number; withPenalty: number }
} {
  const passed: Array<T & { canPenalty: number; canWarnings: string[] }> = []
  const excluded: Array<{ job_id: string; reason: string }> = []
  let withPenalty = 0

  for (const job of jobs) {
    const attrs = job.attributes || (job as any)
    const filterResult = applyCanBasedFilter(attrs, verifiedCan)

    if (filterResult.shouldExclude) {
      const reason = filterResult.appliedRules[0]?.description || 'Can 능력 미달'
      excluded.push({ job_id: job.job_id, reason })
      continue
    }

    if (filterResult.totalPenalty > 0) {
      withPenalty++
    }

    passed.push({
      ...job,
      canPenalty: filterResult.totalPenalty,
      canWarnings: filterResult.warnings,
    })
  }

  return {
    passed,
    excluded,
    stats: {
      totalInput: jobs.length,
      excluded: excluded.length,
      withPenalty,
    },
  }
}
