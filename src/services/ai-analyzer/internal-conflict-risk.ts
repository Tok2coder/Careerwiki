// src/services/ai-analyzer/internal-conflict-risk.ts
// ============================================
// P3: 내면갈등 → Risk 조정 시스템
// ============================================
// 사용자의 내면갈등(가치 충돌)을 감지하고
// 해당 갈등이 직업과 관련될 때 Risk를 조정
// ============================================

import type { MiniModuleResult } from './mini-module-questions'

// ============================================
// 내면갈등 유형 정의
// ============================================

/**
 * 갈등 유형별 정의
 */
export interface InternalConflict {
  id: string
  label: string
  description: string
  /** 갈등 관련 직업 속성들 */
  relatedJobAttributes: string[]
  /** 기본 Risk 조정 값 (0-15) */
  baseRiskAdjust: number
  /** 갈등 해소 가능 조건 */
  resolutionHint: string
}

export const INTERNAL_CONFLICTS: Record<string, InternalConflict> = {
  // 가치 충돌 갈등
  autonomy_vs_stability: {
    id: 'autonomy_vs_stability',
    label: '자율성 vs 안정성',
    description: '자유롭게 일하고 싶지만 안정도 원함',
    relatedJobAttributes: ['stability', 'remote_possible', 'work_schedule'],
    baseRiskAdjust: 8,
    resolutionHint: '안정적인 조직 내 자율적 역할',
  },
  growth_vs_income: {
    id: 'growth_vs_income',
    label: '성장 vs 소득',
    description: '성장하고 싶지만 당장 소득도 중요',
    relatedJobAttributes: ['growth', 'income', 'stability'],
    baseRiskAdjust: 6,
    resolutionHint: '성장 가능성 있는 안정 직종',
  },
  impact_vs_wlb: {
    id: 'impact_vs_wlb',
    label: '영향력 vs 워라밸',
    description: '영향력을 미치고 싶지만 개인 시간도 중요',
    relatedJobAttributes: ['decision_authority', 'wlb', 'work_hours'],
    baseRiskAdjust: 7,
    resolutionHint: '워라밸 좋은 임팩트 역할',
  },

  // Hard Bias 갈등 (sacrifice_flags + energy_drain_flags)
  no_sacrifice_unpredictability: {
    id: 'no_sacrifice_unpredictability',
    label: '무희생 + 불확실성',
    description: '희생 싫지만 변화도 감당해야 하는 상황',
    relatedJobAttributes: ['stability', 'work_schedule'],
    baseRiskAdjust: 10,
    resolutionHint: '안정적이면서 도전적인 환경',
  },
  no_sacrifice_time_pressure: {
    id: 'no_sacrifice_time_pressure',
    label: '무희생 + 시간압박',
    description: '희생 싫지만 시간에 쫓기는 상황',
    relatedJobAttributes: ['wlb', 'work_hours'],
    baseRiskAdjust: 10,
    resolutionHint: '여유로운 페이스의 직업',
  },
  no_sacrifice_responsibility: {
    id: 'no_sacrifice_responsibility',
    label: '무희생 + 책임부담',
    description: '희생 싫지만 책임도 부담되는 상황',
    relatedJobAttributes: ['decision_authority'],
    baseRiskAdjust: 8,
    resolutionHint: '적정 책임 수준의 역할',
  },
  low_income_time_pressure: {
    id: 'low_income_time_pressure',
    label: '저소득 감수 + 시간압박',
    description: '낮은 초봉 감수하면서 시간에도 쫓기는 상황',
    relatedJobAttributes: ['income', 'work_hours'],
    baseRiskAdjust: 6,
    resolutionHint: '성장형 but 여유 있는 환경',
  },
  low_income_cognitive: {
    id: 'low_income_cognitive',
    label: '저소득 감수 + 인지부하',
    description: '낮은 초봉 감수하면서 정신적으로도 힘든 상황',
    relatedJobAttributes: ['income', 'analytical'],
    baseRiskAdjust: 7,
    resolutionHint: '점진적 성장 경로',
  },
  study_cognitive_conflict: {
    id: 'study_cognitive_conflict',
    label: '공부 병행 + 인지부하',
    description: '공부하면서 일도 복잡한 상황',
    relatedJobAttributes: ['analytical', 'wlb'],
    baseRiskAdjust: 9,
    resolutionHint: '파트타임 또는 유연 근무',
  },
  study_time_pressure: {
    id: 'study_time_pressure',
    label: '공부 병행 + 시간압박',
    description: '공부와 야근 병행이 어려운 상황',
    relatedJobAttributes: ['work_hours', 'wlb'],
    baseRiskAdjust: 10,
    resolutionHint: '정시 퇴근 가능 직업',
  },
  field_change_unpredictability: {
    id: 'field_change_unpredictability',
    label: '분야 전환 + 불확실성',
    description: '새 분야 도전하면서 불확실성도 감당',
    relatedJobAttributes: ['stability', 'growth'],
    baseRiskAdjust: 8,
    resolutionHint: '안정적인 전환 경로',
  },
  field_change_people: {
    id: 'field_change_people',
    label: '분야 전환 + 대인관계',
    description: '새 분야 적응하면서 사람 관계도 어려움',
    relatedJobAttributes: ['people_facing', 'teamwork'],
    baseRiskAdjust: 7,
    resolutionHint: '독립적 업무 가능 직업',
  },
}

// ============================================
// Risk 조정 계산
// ============================================

export interface ConflictRiskResult {
  /** 총 Risk 조정량 */
  totalRiskAdjust: number
  /** 감지된 갈등 목록 */
  detectedConflicts: Array<{
    id: string
    label: string
    riskAdjust: number
    matchedAttribute?: string
  }>
  /** 경고 메시지 */
  warnings: string[]
  /** 해소 힌트 */
  resolutionHints: string[]
}

/**
 * 미니모듈 결과에서 내면갈등 추출 및 Risk 조정 계산
 */
export function calculateConflictRisk(
  miniModule: MiniModuleResult | undefined,
  jobAttrs: Record<string, any>
): ConflictRiskResult {
  if (!miniModule) {
    return {
      totalRiskAdjust: 0,
      detectedConflicts: [],
      warnings: [],
      resolutionHints: [],
    }
  }

  const detectedConflicts: ConflictRiskResult['detectedConflicts'] = []
  const warnings: string[] = []
  const resolutionHints: string[] = []
  let totalRiskAdjust = 0

  // 1. internal_conflict_flags에서 직접 갈등 추출
  if (miniModule.internal_conflict_flags?.length) {
    for (const conflictId of miniModule.internal_conflict_flags) {
      const conflict = INTERNAL_CONFLICTS[conflictId]
      if (!conflict) continue

      // 해당 갈등이 이 직업과 관련있는지 확인
      const matchedAttr = conflict.relatedJobAttributes.find(attr => {
        const jobValue = jobAttrs[attr]
        // 속성이 있고, 극단적인 값이면 갈등 트리거
        if (typeof jobValue === 'number') {
          return jobValue >= 70 || jobValue <= 30
        }
        return jobValue !== undefined
      })

      if (matchedAttr) {
        // 갈등 관련 속성이 있으면 Risk 조정
        const riskAdjust = Math.round(conflict.baseRiskAdjust * 0.8)  // 80% 적용
        detectedConflicts.push({
          id: conflictId,
          label: conflict.label,
          riskAdjust,
          matchedAttribute: matchedAttr,
        })
        totalRiskAdjust += riskAdjust
        warnings.push(`${conflict.label}: ${conflict.description}`)
        resolutionHints.push(conflict.resolutionHint)
      } else {
        // 관련 속성이 없어도 약하게 적용
        const riskAdjust = Math.round(conflict.baseRiskAdjust * 0.3)  // 30% 적용
        detectedConflicts.push({
          id: conflictId,
          label: conflict.label,
          riskAdjust,
        })
        totalRiskAdjust += riskAdjust
      }
    }
  }

  // 2. low_confidence_flags가 있으면 추가 불확실성 Risk
  if (miniModule.low_confidence_flags?.length) {
    const confidenceRisk = miniModule.low_confidence_flags.length * 2  // 각 +2
    totalRiskAdjust += confidenceRisk
    if (confidenceRisk > 0) {
      warnings.push('일부 선호도가 명확하지 않습니다')
    }
  }

  // 최대 Risk 제한 (25)
  totalRiskAdjust = Math.min(totalRiskAdjust, 25)

  return {
    totalRiskAdjust,
    detectedConflicts,
    warnings,
    resolutionHints,
  }
}

/**
 * 갈등 심각도 계산 (0-100)
 */
export function calculateConflictSeverity(
  miniModule: MiniModuleResult | undefined
): { severity: number; level: 'none' | 'low' | 'medium' | 'high' } {
  if (!miniModule) {
    return { severity: 0, level: 'none' }
  }

  let severity = 0

  // internal_conflict_flags
  if (miniModule.internal_conflict_flags?.length) {
    severity += miniModule.internal_conflict_flags.length * 20
  }

  // low_confidence_flags (불확실성)
  if (miniModule.low_confidence_flags?.length) {
    severity += miniModule.low_confidence_flags.length * 10
  }

  // sacrifice 중 no_sacrifice가 있고 energy_drain도 있으면 갈등 가중
  const hasNoSacrifice = miniModule.sacrifice_flags?.includes('no_sacrifice')
  const hasEnergyDrain = (miniModule.energy_drain_flags?.length || 0) > 0
  if (hasNoSacrifice && hasEnergyDrain) {
    severity += 15
  }

  severity = Math.min(severity, 100)

  let level: 'none' | 'low' | 'medium' | 'high' = 'none'
  if (severity >= 60) level = 'high'
  else if (severity >= 30) level = 'medium'
  else if (severity > 0) level = 'low'

  return { severity, level }
}

/**
 * 배치 처리: 직업 목록에 갈등 Risk 적용
 */
export function applyConflictRiskBatch<T extends { job_id: string; attributes?: Record<string, any> }>(
  jobs: T[],
  miniModule: MiniModuleResult | undefined
): Array<T & { conflictRisk: ConflictRiskResult }> {
  return jobs.map(job => {
    const attrs = job.attributes || (job as any)
    const conflictRisk = calculateConflictRisk(miniModule, attrs)

    return {
      ...job,
      conflictRisk,
    }
  })
}

/**
 * 갈등 요약 메시지 생성
 */
export function generateConflictSummary(
  miniModule: MiniModuleResult | undefined
): string {
  if (!miniModule) return ''

  const { severity, level } = calculateConflictSeverity(miniModule)

  if (level === 'none') {
    return '가치관이 일관되어 명확한 방향 설정이 가능합니다'
  }

  if (level === 'low') {
    return '약간의 가치 충돌이 있지만 큰 문제가 되지 않습니다'
  }

  if (level === 'medium') {
    return '가치 충돌이 있어 일부 선택에서 고민이 있을 수 있습니다'
  }

  // high
  const conflicts = miniModule.internal_conflict_flags || []
  const conflictLabels = conflicts
    .map(c => INTERNAL_CONFLICTS[c]?.label)
    .filter(Boolean)
    .slice(0, 2)

  if (conflictLabels.length > 0) {
    return `내면 갈등이 있습니다: ${conflictLabels.join(', ')}. 우선순위 정리가 도움될 수 있습니다`
  }

  return '가치 충돌이 있어 결정에 어려움이 있을 수 있습니다'
}
