// CareerWiki AI Analyzer - Evidence Generator
// Version: v1.0.0
// 
// ⚠️ 역할 경계 명확화 (중요!)
// ============================================
// Evidence Generator는 "결정자"가 아닌 "설명/정당화 레이어"입니다.
// 
// ✅ 하는 것:
//    - 이미 계산된 추천 결과에 대한 "근거(Evidence)" 생성
//    - 유저 답변과 직업 속성 간의 연결점 찾기
//    - 프론트엔드에 표시할 설명 텍스트 생성
//
// ❌ 하지 않는 것:
//    - 추천 점수 재계산
//    - 추천 순위 변경
//    - fit_score/like_score/can_score 수정
//
// 점수 계산은 fact-score-mapping.ts가 담당합니다.
// Evidence Generator는 그 결과를 "설명"하는 역할만 합니다.
// ============================================

import type { EvidenceLink } from './types'
import type { JobAttributes, JobAttributesRow } from './job-attributes-types'

// ============================================
// Fact 타입 (DB에서 가져온 형태)
// ============================================
export interface Fact {
  fact_key: string
  value_json: string
}

// ============================================
// ScoredJob 타입 (추천 결과)
// ============================================
export interface ScoredJobForEvidence {
  job_id: string
  job_name: string
  scores: {
    fit: number
    like: number
    can: number
    risk_penalty: number
  }
  attributes: Record<string, string | number>
}

// ============================================
// Evidence 매핑 설정 타입
// ============================================
// ⚠️ 확장 포인트: 현재는 상수 객체이지만,
// 향후 외부 JSON/Config/DB로 분리 가능한 구조입니다.
// 예: evidence-mapping.config.ts → DB/관리 UI 확장

export interface EvidenceMappingRule {
  // 유저 fact 패턴 (문자열 또는 정규식)
  userFactPattern: string | RegExp
  // 매칭되는 직업 속성들
  jobAttributes: string[]
  // match_type 결정 로직
  matchLogic: EvidenceMatchLogic
  // 설명 템플릿
  explanationTemplate: string
  // 라벨 템플릿
  userLabelTemplate: string
  jobLabelTemplate: string
}

export type EvidenceMatchLogic = 
  | { type: 'threshold', positive: number, negative: number }  // 수치 비교
  | { type: 'equality', positiveValues: string[], negativeValues: string[] }  // 값 비교
  | { type: 'inverse' }  // 반대 (싫어함 → 낮으면 positive)

// ============================================
// Evidence 매핑 테이블 (확장 가능 구조)
// ============================================
// 📌 이 테이블은 향후 외부 설정으로 분리 가능합니다.
// 현재는 P0 빠른 구현을 위해 코드 내 상수로 정의합니다.

export const EVIDENCE_MAPPING_RULES: EvidenceMappingRule[] = [
  // ============================================
  // 1. 워라밸/야근 관련
  // ============================================
  {
    userFactPattern: 'profile.dislike.keywords',
    jobAttributes: ['wlb', 'work_hours'],
    matchLogic: { type: 'threshold', positive: 60, negative: 40 },
    explanationTemplate: '야근/긴 근무를 피하고 싶다고 하셨는데, 이 직업은 워라밸 지수가 {jobValue}점입니다',
    userLabelTemplate: '"{userValue}"을(를) 피하고 싶다고 하셨습니다',
    jobLabelTemplate: '워라밸 지수: {jobValue}/100',
  },
  
  // ============================================
  // 2. 작업 스타일 - 혼자 vs 팀
  // ============================================
  {
    userFactPattern: 'profile.workstyle.social',
    jobAttributes: ['solo_deep', 'teamwork', 'people_facing'],
    matchLogic: { type: 'equality', positiveValues: ['solo'], negativeValues: ['team'] },
    explanationTemplate: '{userValue} 스타일을 선호하시는데, 이 직업의 {attrName}은(는) {jobValue}점입니다',
    userLabelTemplate: '"{userValue}" 스타일 선호',
    jobLabelTemplate: '{attrName}: {jobValue}/100',
  },
  
  // ============================================
  // 3. 관심사 - 기술/IT
  // ============================================
  {
    userFactPattern: /^profile\.interest\.keywords$/,
    jobAttributes: ['analytical', 'creative', 'people_facing', 'growth'],
    matchLogic: { type: 'threshold', positive: 50, negative: 30 },
    explanationTemplate: '"{userValue}" 분야에 관심 있으시다고 하셨는데, 이 직업은 관련 역량이 {jobValue}점입니다',
    userLabelTemplate: '"{userValue}" 관심사',
    jobLabelTemplate: '관련 역량: {jobValue}/100',
  },
  
  // ============================================
  // 4. 우선순위 - 성장
  // ============================================
  {
    userFactPattern: 'priority.top1',
    jobAttributes: ['growth', 'income', 'stability', 'wlb'],
    matchLogic: { type: 'threshold', positive: 60, negative: 40 },
    explanationTemplate: '"{userValue}"을(를) 가장 중요하게 생각하신다고 하셨는데, 이 직업은 해당 지수가 {jobValue}점입니다',
    userLabelTemplate: '최우선 가치: "{userValue}"',
    jobLabelTemplate: '{attrName}: {jobValue}/100',
  },
  
  // ============================================
  // 5. 학력 제약
  // ============================================
  {
    userFactPattern: /^profile\.constraints\.qualification$/,
    jobAttributes: ['degree_required', 'license_required'],
    matchLogic: { type: 'equality', positiveValues: ['none', 'preferred'], negativeValues: ['required', 'multiple_required'] },
    explanationTemplate: '학력/자격 취득이 어렵다고 하셨는데, 이 직업은 {attrName}이(가) "{jobValue}"입니다',
    userLabelTemplate: '자격/학력 제약 있음',
    jobLabelTemplate: '{attrName}: {jobValue}',
  },
  
  // ============================================
  // 6. 원격근무 선호
  // ============================================
  {
    userFactPattern: /^profile\.constraints\.location$/,
    jobAttributes: ['remote_possible'],
    matchLogic: { type: 'equality', positiveValues: ['partial', 'full'], negativeValues: ['none'] },
    explanationTemplate: '원격/재택근무를 원하신다고 하셨는데, 이 직업은 원격근무가 "{jobValue}"입니다',
    userLabelTemplate: '원격근무 선호',
    jobLabelTemplate: '원격근무: {jobValue}',
  },
  
  // ============================================
  // 7. 안정성 선호
  // ============================================
  {
    userFactPattern: /^priority\.top1$/,
    jobAttributes: ['stability'],
    matchLogic: { type: 'threshold', positive: 60, negative: 40 },
    explanationTemplate: '안정성을 중시하신다고 하셨는데, 이 직업의 안정성 지수는 {jobValue}점입니다',
    userLabelTemplate: '안정성 중시',
    jobLabelTemplate: '안정성: {jobValue}/100',
  },
  
  // ============================================
  // 8. 수입 선호
  // ============================================
  {
    userFactPattern: /^priority\.top1$/,
    jobAttributes: ['income'],
    matchLogic: { type: 'threshold', positive: 60, negative: 40 },
    explanationTemplate: '수입을 중시하신다고 하셨는데, 이 직업의 수입 수준은 {jobValue}점입니다',
    userLabelTemplate: '수입 중시',
    jobLabelTemplate: '수입 수준: {jobValue}/100',
  },
  
  // ============================================
  // 9. 창의성 관심
  // ============================================
  {
    userFactPattern: /^profile\.interest\.keywords$/,
    jobAttributes: ['creative'],
    matchLogic: { type: 'threshold', positive: 50, negative: 30 },
    explanationTemplate: '창의적인 분야에 관심 있으시다고 하셨는데, 이 직업의 창의성 요구도는 {jobValue}점입니다',
    userLabelTemplate: '창의적 분야 관심',
    jobLabelTemplate: '창의성: {jobValue}/100',
  },
  
  // ============================================
  // 10. 분석적 업무 관심
  // ============================================
  {
    userFactPattern: /^profile\.interest\.keywords$/,
    jobAttributes: ['analytical'],
    matchLogic: { type: 'threshold', positive: 50, negative: 30 },
    explanationTemplate: '분석적 업무에 관심 있으시다고 하셨는데, 이 직업의 분석 업무 비중은 {jobValue}점입니다',
    userLabelTemplate: '분석적 업무 관심',
    jobLabelTemplate: '분석 업무: {jobValue}/100',
  },

  // ============================================
  // P0: Can 검증 강점 → 직업 속성 매칭 (6개)
  // 유저가 경험으로 검증한 강점과 직업 요구 역량 연결
  // ============================================
  {
    userFactPattern: 'can_verified_analytical',
    jobAttributes: ['analytical'],
    matchLogic: { type: 'threshold', positive: 60, negative: 30 },
    explanationTemplate: '분석력이 검증된 강점이시네요! 이 직업은 분석 역량을 {jobValue}점 수준으로 활용합니다',
    userLabelTemplate: '검증된 분석력 강점',
    jobLabelTemplate: '분석 요구: {jobValue}/100',
  },
  {
    userFactPattern: 'can_verified_creative',
    jobAttributes: ['creative'],
    matchLogic: { type: 'threshold', positive: 60, negative: 30 },
    explanationTemplate: '창의력이 검증된 강점이시네요! 이 직업은 창의성을 {jobValue}점 수준으로 요구합니다',
    userLabelTemplate: '검증된 창의력 강점',
    jobLabelTemplate: '창의성 요구: {jobValue}/100',
  },
  {
    userFactPattern: 'can_verified_communication',
    jobAttributes: ['people_facing', 'teamwork'],
    matchLogic: { type: 'threshold', positive: 60, negative: 30 },
    explanationTemplate: '소통력이 검증된 강점이시네요! 이 직업은 대인/협업 역량을 {jobValue}점 수준으로 요구합니다',
    userLabelTemplate: '검증된 소통력 강점',
    jobLabelTemplate: '대인/협업: {jobValue}/100',
  },
  {
    userFactPattern: 'can_verified_structured_execution',
    jobAttributes: ['execution'],
    matchLogic: { type: 'threshold', positive: 60, negative: 30 },
    explanationTemplate: '체계적 실행력이 검증된 강점이시네요! 이 직업은 실행 역량을 {jobValue}점 수준으로 요구합니다',
    userLabelTemplate: '검증된 실행력 강점',
    jobLabelTemplate: '실행력 요구: {jobValue}/100',
  },
  {
    userFactPattern: 'can_verified_persistence',
    jobAttributes: ['execution', 'growth'],
    matchLogic: { type: 'threshold', positive: 50, negative: 30 },
    explanationTemplate: '끈기가 검증된 강점이시네요! 이 직업은 꾸준함과 성장을 {jobValue}점 수준으로 요구합니다',
    userLabelTemplate: '검증된 끈기 강점',
    jobLabelTemplate: '성장/지속성: {jobValue}/100',
  },
  {
    userFactPattern: 'can_verified_fast_learning',
    jobAttributes: ['growth', 'analytical'],
    matchLogic: { type: 'threshold', positive: 60, negative: 30 },
    explanationTemplate: '빠른 학습력이 검증된 강점이시네요! 이 직업은 학습 성장을 {jobValue}점 수준으로 기대합니다',
    userLabelTemplate: '검증된 학습력 강점',
    jobLabelTemplate: '성장 기회: {jobValue}/100',
  },
]

// ============================================
// score_contribution 가중치 (상수 분리 - Calibration 가능)
// ============================================
export const CONTRIBUTION_WEIGHTS = {
  positive: { base: 12, max: 20 },
  negative: { base: -12, min: -20 },
  neutral: { base: 5, max: 8 },
} as const

// ============================================
// 속성명 한글 라벨
// ============================================
const ATTRIBUTE_LABELS: Record<string, string> = {
  wlb: '워라밸',
  growth: '성장 가능성',
  stability: '안정성',
  income: '수입 수준',
  remote_possible: '원격근무',
  work_hours: '근무시간',
  shift_work: '교대근무',
  travel: '출장 빈도',
  degree_required: '학위 요구',
  license_required: '자격증 요구',
  teamwork: '협업 비중',
  solo_deep: '집중 업무',
  analytical: '분석 업무',
  creative: '창의 업무',
  execution: '실행/운영',
  people_facing: '대인 업무',
}

// ============================================
// 메인 함수: buildEvidenceLinks
// ============================================
// ⚠️ 이 함수는 점수를 "계산"하지 않습니다.
// 이미 계산된 추천 결과를 "설명"하기 위한 Evidence만 생성합니다.

export function buildEvidenceLinks(
  facts: Fact[],
  job: ScoredJobForEvidence,
  jobAttributes?: Partial<JobAttributesRow>
): EvidenceLink[] {
  const evidenceLinks: EvidenceLink[] = []
  const usedFactKeys = new Set<string>()
  
  // 직업 속성 (DB에서 가져온 것 또는 추천 결과의 attributes)
  const attrs = jobAttributes || job.attributes
  
  for (const fact of facts) {
    // 이미 사용된 fact_key는 스킵 (중복 방지)
    if (usedFactKeys.has(fact.fact_key)) continue
    
    // 매칭되는 규칙 찾기
    const matchingRules = findMatchingRules(fact.fact_key)
    
    for (const rule of matchingRules) {
      // fact 값 파싱
      let factValue: any
      try {
        factValue = JSON.parse(fact.value_json)
      } catch {
        factValue = fact.value_json
      }
      
      // 실제 값 추출 (object면 .value 사용)
      const actualValue = typeof factValue === 'object' && factValue !== null 
        ? (factValue.value || factValue) 
        : factValue
      
      // 각 직업 속성에 대해 Evidence 생성
      for (const attrKey of rule.jobAttributes) {
        const jobValue = attrs[attrKey as keyof typeof attrs]
        if (jobValue === undefined) continue
        
        // match_type 결정
        const matchType = determineMatchType(rule.matchLogic, actualValue, jobValue, attrKey)
        
        // 관련 없으면 스킵
        if (matchType === null) continue
        
        // score_contribution 계산 (설명용, 실제 점수에 영향 X)
        const contribution = calculateContribution(matchType, jobValue)
        
        // 라벨 및 설명 생성
        const userLabel = formatTemplate(rule.userLabelTemplate, {
          userValue: formatUserValue(actualValue),
        })
        
        const jobLabel = formatTemplate(rule.jobLabelTemplate, {
          attrName: ATTRIBUTE_LABELS[attrKey] || attrKey,
          jobValue: String(jobValue),
        })
        
        const explanation = formatTemplate(rule.explanationTemplate, {
          userValue: formatUserValue(actualValue),
          attrName: ATTRIBUTE_LABELS[attrKey] || attrKey,
          jobValue: String(jobValue),
        })
        
        evidenceLinks.push({
          user_fact: {
            key: fact.fact_key,
            value: String(actualValue),
            label: userLabel,
          },
          job_attribute: {
            key: attrKey,
            value: String(jobValue),
            label: jobLabel,
          },
          match_type: matchType,
          score_contribution: contribution,
          explanation,
        })
        
        usedFactKeys.add(fact.fact_key)
        
        // 한 fact당 최대 2개 Evidence (과다 방지)
        if (evidenceLinks.filter(e => e.user_fact.key === fact.fact_key).length >= 2) {
          break
        }
      }
    }
  }
  
  // 정렬: positive 먼저, 그 다음 contribution 크기순
  evidenceLinks.sort((a, b) => {
    if (a.match_type === 'positive' && b.match_type !== 'positive') return -1
    if (a.match_type !== 'positive' && b.match_type === 'positive') return 1
    return Math.abs(b.score_contribution) - Math.abs(a.score_contribution)
  })
  
  // 최소 3개, 최대 10개
  return evidenceLinks.slice(0, 10)
}

// ============================================
// 헬퍼 함수들
// ============================================

function findMatchingRules(factKey: string): EvidenceMappingRule[] {
  return EVIDENCE_MAPPING_RULES.filter(rule => {
    if (typeof rule.userFactPattern === 'string') {
      return factKey === rule.userFactPattern || factKey.startsWith(rule.userFactPattern)
    }
    return rule.userFactPattern.test(factKey)
  })
}

function determineMatchType(
  logic: EvidenceMatchLogic,
  userValue: any,
  jobValue: any,
  attrKey: string
): 'positive' | 'neutral' | 'negative' | null {
  
  if (logic.type === 'threshold') {
    const numValue = typeof jobValue === 'number' ? jobValue : parseFloat(String(jobValue))
    if (isNaN(numValue)) return null
    
    if (numValue >= logic.positive) return 'positive'
    if (numValue <= logic.negative) return 'negative'
    return 'neutral'
  }
  
  if (logic.type === 'equality') {
    const strValue = String(jobValue).toLowerCase()
    if (logic.positiveValues.map(v => v.toLowerCase()).includes(strValue)) return 'positive'
    if (logic.negativeValues.map(v => v.toLowerCase()).includes(strValue)) return 'negative'
    return 'neutral'
  }
  
  if (logic.type === 'inverse') {
    // 사용자가 "싫다"고 한 것 → 낮으면 positive
    const numValue = typeof jobValue === 'number' ? jobValue : parseFloat(String(jobValue))
    if (isNaN(numValue)) return null
    
    if (numValue <= 30) return 'positive'  // 낮으면 좋음
    if (numValue >= 70) return 'negative'  // 높으면 나쁨
    return 'neutral'
  }
  
  return null
}

function calculateContribution(matchType: 'positive' | 'neutral' | 'negative', jobValue: any): number {
  // ⚠️ 이 값은 "설명용"입니다. 실제 점수 계산에는 사용되지 않습니다.
  const numValue = typeof jobValue === 'number' ? jobValue : 50
  const intensity = Math.abs(numValue - 50) / 50  // 0~1 (50에서 얼마나 멀리 있는지)
  
  switch (matchType) {
    case 'positive':
      return Math.round(CONTRIBUTION_WEIGHTS.positive.base + intensity * 8)
    case 'negative':
      return Math.round(CONTRIBUTION_WEIGHTS.negative.base - intensity * 8)
    case 'neutral':
      return CONTRIBUTION_WEIGHTS.neutral.base
    default:
      return 0
  }
}

function formatTemplate(template: string, values: Record<string, string>): string {
  let result = template
  for (const [key, value] of Object.entries(values)) {
    result = result.replace(new RegExp(`\\{${key}\\}`, 'g'), value)
  }
  return result
}

function formatUserValue(value: any): string {
  if (Array.isArray(value)) {
    return value.slice(0, 3).join(', ')
  }
  if (typeof value === 'object' && value !== null) {
    return JSON.stringify(value)
  }
  return String(value)
}

// ============================================
// 기본 Evidence 생성 (fact가 없을 때 폴백)
// ============================================
export function generateDefaultEvidence(
  job: ScoredJobForEvidence,
  attrs?: Partial<JobAttributesRow>
): EvidenceLink[] {
  const defaultLinks: EvidenceLink[] = []
  const jobAttrs = attrs || job.attributes
  
  // 높은 속성값에서 기본 Evidence 생성
  const attrEntries = Object.entries(jobAttrs)
    .filter(([key, value]) => typeof value === 'number' && value >= 60)
    .sort(([, a], [, b]) => (b as number) - (a as number))
    .slice(0, 3)
  
  for (const [key, value] of attrEntries) {
    defaultLinks.push({
      user_fact: {
        key: 'default',
        value: 'general_match',
        label: '기본 적합도 분석',
      },
      job_attribute: {
        key,
        value: String(value),
        label: `${ATTRIBUTE_LABELS[key] || key}: ${value}/100`,
      },
      match_type: 'neutral',
      score_contribution: CONTRIBUTION_WEIGHTS.neutral.base,
      explanation: `이 직업의 ${ATTRIBUTE_LABELS[key] || key}은(는) ${value}점으로 높은 편입니다`,
    })
  }
  
  return defaultLinks
}





