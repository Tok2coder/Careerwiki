// CareerWiki AI Analyzer - Fact Score Mapping
// Version: v1.0.3 (Phase 1C Deep Intake)
// 단일 파일로 모든 fact→점수 매핑 관리

import type { 
  WorkStyleTag, 
  StressTriggerTag, 
  EnergySourceTag,
  MBTIType 
} from './types'

// ============================================
// 타입 정의
// ============================================

export type ScoreType = 'like' | 'can' | 'risk'
export type JobAttribute = 'wlb' | 'growth' | 'stability' | 'income' | 'remote' | 'solo_work' | 'creative' | 'analytical' | 'people_facing' | 'teamwork' | 'execution' | 'autonomy' | 'remote_possible'

export interface FactScoreEffect {
  score_type: ScoreType
  job_attribute: JobAttribute
  boost: number  // 양수: 가산, 음수: 감산
  condition?: (jobValue: string) => boolean  // 조건부 적용
}

export interface FactScoreRule {
  fact_key_pattern: string | RegExp  // 'tradeoff.salary_vs_wlb' or /^motivation\./
  priority: number  // 높을수록 우선
  effects: (factValue: any) => FactScoreEffect[]
}

// ============================================
// 전역 매핑 정책 (v1.0.2)
// ============================================

export const MAPPING_POLICY = {
  // 하나의 fact가 줄 수 있는 최대 boost
  MAX_BOOST_PER_FACT: 20,
  
  // 같은 job_attribute에 대한 중복 boost 처리
  // 'sum': 모두 합산
  // 'highest_wins': 가장 큰 값만
  // 'average': 평균
  DUPLICATE_POLICY: 'highest_wins' as const,
  
  // 전체 Like/Can에 대한 fact boost 총합 상한
  MAX_TOTAL_LIKE_BOOST: 25,  // 개인화 스코어링 도입으로 40→25 (이중 카운팅 방지)
  MAX_TOTAL_CAN_BOOST: 30,   // 개인화 스코어링 도입으로 50→30 (이중 카운팅 방지)
  MAX_TOTAL_RISK_REDUCTION: 20,  // Risk 감소 상한
  
  // 충돌 시 우선순위 (높은 숫자가 우선)
  PRIORITY_ORDER: {
    'confirmed_constraint': 100,  // L1: 최우선
    'priority.dealbreaker': 80,   // L2
    'priority.top1': 70,
    'tradeoff': 60,
    'motivation': 50,
    'discovery': 40,
    'insight': 30,
  } as Record<string, number>,
}

// ============================================
// 표준 태그 정의
// ============================================

export type ValueTag = 
  | 'work_life_balance'
  | 'stability'
  | 'growth'
  | 'autonomy'
  | 'impact'
  | 'income'
  | 'recognition'
  | 'health'
  | 'family'
  | 'learning'

// 자유 텍스트 → 표준 태그 룩업
export const REASON_TO_TAG_MAP: Record<string, ValueTag[]> = {
  // 야근 싫은 이유
  '체력': ['health'],
  '건강': ['health'],
  '가족': ['family', 'work_life_balance'],
  '육아': ['family', 'work_life_balance'],
  '공부': ['learning', 'growth'],
  '자기계발': ['learning', 'growth'],
  '스트레스': ['health', 'work_life_balance'],
  '취미': ['work_life_balance', 'autonomy'],
  '번아웃': ['health', 'work_life_balance'],
  
  // 원격 원하는 이유
  '집중': ['autonomy'],
  '통근': ['work_life_balance', 'health'],
  '효율': ['autonomy', 'growth'],
  
  // 가치관
  '성장': ['growth'],
  '안정': ['stability'],
  '돈': ['income'],
  '연봉': ['income'],
  '인정': ['recognition'],
  '의미': ['impact'],
  '자율': ['autonomy'],
}

export function normalizeReasonToTags(freeText: string): ValueTag[] {
  // 1. 직접 매칭
  const directMatch = REASON_TO_TAG_MAP[freeText]
  if (directMatch) return directMatch
  
  // 2. 부분 매칭
  for (const [keyword, tags] of Object.entries(REASON_TO_TAG_MAP)) {
    if (freeText.includes(keyword)) return tags
  }
  
  // 3. 기본값
  return []
}

// ============================================
// Phase 1C: Deep Intake 정규화 룩업
// ============================================

// 오픈 텍스트 → WorkStyleTag 매핑
export const TEXT_TO_WORKSTYLE_MAP: Record<string, WorkStyleTag[]> = {
  // 혼자/집중 관련
  '혼자': ['solo_deep', 'autonomous'],
  '집중': ['solo_deep', 'steady_paced'],
  '몰입': ['solo_deep', 'analytical'],
  '깊게': ['solo_deep', 'analytical'],
  '파고들': ['solo_deep', 'analytical'],
  '조용': ['solo_deep', 'structured'],
  '독립': ['solo_deep', 'autonomous'],
  
  // 팀/협업 관련
  '팀': ['team_collab', 'people_facing'],
  '협업': ['team_collab', 'people_facing'],
  '같이': ['team_collab'],
  '함께': ['team_collab'],
  '소통': ['team_collab', 'people_facing'],
  '회의': ['team_collab'],
  
  // 분석/논리 관련
  '분석': ['analytical', 'solo_deep'],
  '데이터': ['analytical'],
  '숫자': ['analytical'],
  '논리': ['analytical', 'structured'],
  '문제해결': ['analytical'],
  '패턴': ['analytical'],
  
  // 창의/기획 관련
  '창의': ['creative', 'flexible'],
  '기획': ['creative'],
  '아이디어': ['creative', 'variety'],
  '디자인': ['creative'],
  '새로운': ['creative', 'variety'],
  '만들': ['creative', 'autonomous'],
  
  // 구조/루틴 관련
  '체계': ['structured', 'routine'],
  '정리': ['structured', 'routine'],
  '계획': ['structured'],
  '규칙': ['structured', 'routine'],
  '안정': ['structured', 'steady_paced'],
  '예측': ['structured', 'routine'],
  
  // 자율/유연 관련
  '자율': ['autonomous', 'flexible'],
  '재량': ['autonomous'],
  '자유': ['autonomous', 'flexible'],
  '유연': ['flexible', 'autonomous'],
  '원격': ['autonomous', 'flexible'],
  '재택': ['autonomous', 'flexible'],
  
  // 빠른 템포 관련
  '빠른': ['fast_paced', 'variety'],
  '역동': ['fast_paced', 'variety'],
  '도전': ['fast_paced'],
  '신규': ['fast_paced', 'variety'],  // '새로운' 중복 방지
  '변화': ['fast_paced', 'flexible'],
  
  // 대인 관련
  '사람': ['people_facing', 'team_collab'],
  '고객': ['people_facing'],
  '상담': ['people_facing'],
  '영업': ['people_facing', 'fast_paced'],
  '교육': ['people_facing'],
  '도움': ['people_facing'],
}

// 오픈 텍스트 → StressTrigger 매핑
export const TEXT_TO_STRESS_MAP: Record<string, StressTriggerTag> = {
  '마감': 'deadline',
  '급하': 'deadline',
  '시간': 'deadline',
  '촉박': 'deadline',
  
  '갈등': 'people',
  '상사': 'people',
  '동료': 'people',
  '눈치': 'people',
  '정치': 'people',
  
  '불확실': 'uncertainty',
  '모르': 'uncertainty',
  '애매': 'uncertainty',
  '바뀌': 'uncertainty',
  '변경': 'uncertainty',
  
  '체력': 'physical',
  '육체': 'physical',
  '야근': 'physical',
  '피곤': 'physical',
  '힘들': 'physical',
  
  '동시에': 'multitask',
  '여러': 'multitask',
  '멀티': 'multitask',
  
  '회의': 'meeting',
  '미팅': 'meeting',
  '보고': 'meeting',
  
  '간섭': 'micromanage',
  '관리': 'micromanage',
  '지시': 'micromanage',
  
  '혼자': 'isolation',
  '외로': 'isolation',
  '고립': 'isolation',
  
  '발표': 'public_speaking',
  '프레젠테이션': 'public_speaking',
  '앞에서': 'public_speaking',
}

// 오픈 텍스트 → EnergySource 매핑
export const TEXT_TO_ENERGY_MAP: Record<string, EnergySourceTag> = {
  '혼자': 'solo',
  '조용': 'solo',
  '집중': 'solo',
  
  '사람': 'people',
  '함께': 'people',
  '팀': 'people',
  
  '배우': 'learning',
  '공부': 'learning',
  '성장': 'learning',
  '새로운': 'learning',
  
  '만들': 'creating',
  '창작': 'creating',
  '결과물': 'creating',
  '완성': 'creating',
  
  '도움': 'helping',
  '기여': 'helping',
  '가르': 'helping',
  
  '성취': 'achieving',
  '달성': 'achieving',
  '해냈': 'achieving',
  '완료': 'achieving',
  
  '탐험': 'exploring',
  '발견': 'exploring',
  '도전': 'exploring',
  
  '정리': 'organizing',
  '체계': 'organizing',
  '구조': 'organizing',
}

// MBTI → 기본 성향 매핑
export const MBTI_TO_TRAITS: Record<MBTIType, { workStyles: WorkStyleTag[]; energySource: EnergySourceTag }> = {
  // 분석가 그룹
  'INTJ': { workStyles: ['solo_deep', 'analytical', 'structured', 'autonomous'], energySource: 'solo' },
  'INTP': { workStyles: ['solo_deep', 'analytical', 'flexible', 'autonomous'], energySource: 'solo' },
  'ENTJ': { workStyles: ['team_collab', 'analytical', 'structured', 'fast_paced'], energySource: 'achieving' },
  'ENTP': { workStyles: ['team_collab', 'creative', 'flexible', 'fast_paced'], energySource: 'exploring' },
  
  // 외교관 그룹
  'INFJ': { workStyles: ['solo_deep', 'creative', 'structured', 'autonomous'], energySource: 'helping' },
  'INFP': { workStyles: ['solo_deep', 'creative', 'flexible', 'autonomous'], energySource: 'creating' },
  'ENFJ': { workStyles: ['team_collab', 'people_facing', 'structured'], energySource: 'helping' },
  'ENFP': { workStyles: ['team_collab', 'creative', 'flexible', 'variety'], energySource: 'exploring' },
  
  // 관리자 그룹
  'ISTJ': { workStyles: ['solo_deep', 'structured', 'routine', 'steady_paced'], energySource: 'organizing' },
  'ISFJ': { workStyles: ['solo_deep', 'structured', 'routine', 'steady_paced'], energySource: 'helping' },
  'ESTJ': { workStyles: ['team_collab', 'structured', 'fast_paced'], energySource: 'achieving' },
  'ESFJ': { workStyles: ['team_collab', 'people_facing', 'structured'], energySource: 'helping' },
  
  // 탐험가 그룹
  'ISTP': { workStyles: ['solo_deep', 'analytical', 'flexible', 'autonomous'], energySource: 'creating' },
  'ISFP': { workStyles: ['solo_deep', 'creative', 'flexible', 'autonomous'], energySource: 'creating' },
  'ESTP': { workStyles: ['team_collab', 'fast_paced', 'flexible', 'variety'], energySource: 'achieving' },
  'ESFP': { workStyles: ['team_collab', 'people_facing', 'flexible', 'variety'], energySource: 'people' },
}

/**
 * 오픈 텍스트에서 WorkStyle 태그 추출
 */
export function extractWorkStyleTags(text: string): WorkStyleTag[] {
  const tags = new Set<WorkStyleTag>()
  
  for (const [keyword, workStyles] of Object.entries(TEXT_TO_WORKSTYLE_MAP)) {
    if (text.includes(keyword)) {
      workStyles.forEach(tag => tags.add(tag))
    }
  }
  
  return Array.from(tags)
}

/**
 * 오픈 텍스트에서 StressTrigger 추출 (가장 강한 것 1개)
 */
export function extractStressTrigger(text: string): StressTriggerTag | undefined {
  for (const [keyword, trigger] of Object.entries(TEXT_TO_STRESS_MAP)) {
    if (text.includes(keyword)) {
      return trigger
    }
  }
  return undefined
}

/**
 * 오픈 텍스트에서 EnergySource 추출 (가장 강한 것 1개)
 */
export function extractEnergySource(text: string): EnergySourceTag | undefined {
  for (const [keyword, source] of Object.entries(TEXT_TO_ENERGY_MAP)) {
    if (text.includes(keyword)) {
      return source
    }
  }
  return undefined
}

/**
 * Deep Intake 전체 정규화
 */
export interface NormalizedDeepIntake {
  mbti?: MBTIType
  mbti_traits?: {
    workStyles: WorkStyleTag[]
    energySource: EnergySourceTag
  }
  best_moment?: {
    raw: string
    tags: WorkStyleTag[]
    energy_source?: EnergySourceTag
  }
  worst_moment?: {
    raw: string
    tags: WorkStyleTag[]
    stress_trigger?: StressTriggerTag
  }
  change_reason?: {
    raw: string
    tags: ValueTag[]
  }
  priority_top1?: string
}

export function normalizeDeepIntake(input: {
  mbti?: string
  best_moment?: string
  worst_moment?: string
  change_reason?: string
  priority_top1?: string
}): NormalizedDeepIntake {
  const result: NormalizedDeepIntake = {}
  
  // MBTI 처리
  if (input.mbti) {
    const mbti = input.mbti.toUpperCase() as MBTIType
    if (MBTI_TO_TRAITS[mbti]) {
      result.mbti = mbti
      result.mbti_traits = MBTI_TO_TRAITS[mbti]
    }
  }
  
  // best_moment 처리
  if (input.best_moment) {
    result.best_moment = {
      raw: input.best_moment,
      tags: extractWorkStyleTags(input.best_moment),
      energy_source: extractEnergySource(input.best_moment),
    }
  }
  
  // worst_moment 처리
  if (input.worst_moment) {
    result.worst_moment = {
      raw: input.worst_moment,
      tags: extractWorkStyleTags(input.worst_moment),
      stress_trigger: extractStressTrigger(input.worst_moment),
    }
  }
  
  // change_reason 처리
  if (input.change_reason) {
    result.change_reason = {
      raw: input.change_reason,
      tags: normalizeReasonToTags(input.change_reason),
    }
  }
  
  // priority_top1
  if (input.priority_top1) {
    result.priority_top1 = input.priority_top1
  }
  
  return result
}

// ============================================
// Fact Score 규칙 정의 (최소 5개 + 알파)
// ============================================

export const FACT_SCORE_RULES: FactScoreRule[] = [
  // ============================================
  // 1. 트레이드오프: salary vs wlb
  // ============================================
  {
    fact_key_pattern: 'tradeoff.salary_vs_wlb',
    priority: MAPPING_POLICY.PRIORITY_ORDER['tradeoff'],
    effects: (factValue) => {
      const choice = typeof factValue === 'object' ? factValue.value : factValue
      
      if (choice === 'wlb') {
        return [
          { score_type: 'like', job_attribute: 'wlb', boost: 15 },
          { score_type: 'like', job_attribute: 'income', boost: -5 },
          { score_type: 'risk', job_attribute: 'wlb', boost: -10 },  // wlb risk 감소
        ]
      } else if (choice === 'salary') {
        return [
          { score_type: 'like', job_attribute: 'income', boost: 15 },
          { score_type: 'like', job_attribute: 'wlb', boost: -5 },
          { score_type: 'risk', job_attribute: 'wlb', boost: 10 },  // wlb risk 수용
        ]
      }
      return []
    }
  },
  
  // ============================================
  // 2. 트레이드오프: growth vs stability
  // ============================================
  {
    fact_key_pattern: 'tradeoff.growth_vs_stability',
    priority: MAPPING_POLICY.PRIORITY_ORDER['tradeoff'],
    effects: (factValue) => {
      const choice = typeof factValue === 'object' ? factValue.value : factValue
      
      if (choice === 'growth') {
        return [
          { score_type: 'like', job_attribute: 'growth', boost: 15 },
          { score_type: 'like', job_attribute: 'stability', boost: -5 },
        ]
      } else if (choice === 'stability') {
        return [
          { score_type: 'like', job_attribute: 'stability', boost: 15 },
          { score_type: 'like', job_attribute: 'growth', boost: -5 },
        ]
      }
      return []
    }
  },
  
  // ============================================
  // 3. 트레이드오프: solo vs team
  // ============================================
  {
    fact_key_pattern: 'tradeoff.solo_vs_team',
    priority: MAPPING_POLICY.PRIORITY_ORDER['tradeoff'],
    effects: (factValue) => {
      const choice = typeof factValue === 'object' ? factValue.value : factValue
      
      if (choice === 'solo') {
        return [
          { score_type: 'like', job_attribute: 'solo_work', boost: 15 },
          { score_type: 'like', job_attribute: 'people_facing', boost: -10 },
        ]
      } else if (choice === 'team') {
        return [
          { score_type: 'like', job_attribute: 'people_facing', boost: 10 },
          { score_type: 'like', job_attribute: 'solo_work', boost: -5 },
        ]
      }
      return []
    }
  },
  
  // ============================================
  // 4. 동기: 야근 싫은 이유
  // ============================================
  {
    fact_key_pattern: 'motivation.work_hours_reason',
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const reason = typeof factValue === 'object' ? factValue.value : factValue
      const tags = normalizeReasonToTags(reason)
      
      const effects: FactScoreEffect[] = []
      
      if (tags.includes('health')) {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 10 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 15 })  // 야근 risk 더 강화
      }
      if (tags.includes('family')) {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 15 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 20 })  // 가족 이유면 최대 패널티
      }
      if (tags.includes('growth') || tags.includes('learning')) {
        effects.push({ score_type: 'can', job_attribute: 'growth', boost: 10 })
      }
      
      return effects
    }
  },
  
  // ============================================
  // 5. 동기: 원격 원하는 이유
  // ============================================
  {
    fact_key_pattern: 'motivation.remote_reason',
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const reason = typeof factValue === 'object' ? factValue.value : factValue
      const tags = normalizeReasonToTags(reason)
      
      const effects: FactScoreEffect[] = []
      
      if (tags.includes('autonomy')) {
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 10 })
        effects.push({ score_type: 'like', job_attribute: 'autonomy', boost: 10 })
      }
      if (tags.includes('health') || tags.includes('work_life_balance')) {
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 15 })
      }
      
      return effects
    }
  },
  
  // ============================================
  // 6. 우선순위: 가장 중요한 것
  // ============================================
  {
    fact_key_pattern: 'priority.top1',
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.top1'],
    effects: (factValue) => {
      const top1 = typeof factValue === 'object' ? factValue.value : factValue
      
      const attributeMap: Record<string, JobAttribute> = {
        'work_life_balance': 'wlb',
        'wlb': 'wlb',
        'growth': 'growth',
        'stability': 'stability',
        'income': 'income',
        'autonomy': 'remote',
      }
      
      const attr = attributeMap[top1]
      if (attr) {
        return [{ score_type: 'like', job_attribute: attr, boost: 20 }]
      }
      return []
    }
  },
  
  // ============================================
  // 7. 발견: 에너지 충전 방식
  // ============================================
  {
    fact_key_pattern: 'discovery.energy_source',
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const source = typeof factValue === 'object' ? factValue.value : factValue
      
      if (source === 'alone' || source === '혼자' || source === 'solo') {
        return [
          { score_type: 'like', job_attribute: 'solo_work', boost: 10 },
          { score_type: 'like', job_attribute: 'people_facing', boost: -5 },
        ]
      } else if (source === 'people' || source === '사람') {
        return [
          { score_type: 'like', job_attribute: 'people_facing', boost: 10 },
          { score_type: 'like', job_attribute: 'solo_work', boost: -5 },
        ]
      }
      return []
    }
  },
  
  // ============================================
  // Phase 1C: Deep Intake 스코어링 룰
  // ============================================
  
  // 8. MBTI 기반 성향 (L4 - 참고용, 낮은 boost)
  {
    fact_key_pattern: 'profile.mbti',
    priority: MAPPING_POLICY.PRIORITY_ORDER['insight'],
    effects: (factValue) => {
      const mbti = typeof factValue === 'object' ? factValue.value : factValue
      if (!mbti) return []
      
      const traits = MBTI_TO_TRAITS[mbti as MBTIType]
      if (!traits) return []
      
      const effects: FactScoreEffect[] = []
      
      // 혼자/팀 성향
      if (traits.workStyles.includes('solo_deep')) {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 5 })
        effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 5 })
      }
      if (traits.workStyles.includes('team_collab')) {
        effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 5 })
        effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 5 })
      }
      if (traits.workStyles.includes('creative')) {
        effects.push({ score_type: 'like', job_attribute: 'creative', boost: 5 })
      }
      if (traits.workStyles.includes('structured')) {
        effects.push({ score_type: 'like', job_attribute: 'stability', boost: 3 })
      }
      
      return effects
    }
  },
  
  // 9. 가장 좋았던 순간 (best_moment) → WorkStyle 추출
  {
    fact_key_pattern: 'discovery.best_moment',
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { tags: [] }
      const tags = data.tags || []
      const effects: FactScoreEffect[] = []
      
      // 태그별 부스트
      if (tags.includes('solo_deep')) {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
        effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 10 })
      }
      if (tags.includes('team_collab')) {
        effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 15 })
        effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 10 })
      }
      if (tags.includes('analytical')) {
        effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 15 })
        effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 10 })
      }
      if (tags.includes('creative')) {
        effects.push({ score_type: 'like', job_attribute: 'creative', boost: 15 })
      }
      if (tags.includes('autonomous')) {
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 10 })
      }
      if (tags.includes('people_facing')) {
        effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
      }
      
      return effects
    }
  },
  
  // 10. 가장 싫었던 순간 (worst_moment) → 회피 성향
  {
    fact_key_pattern: 'discovery.worst_moment',
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { tags: [], stress_trigger: undefined }
      const tags = data.tags || []
      const stressTrigger = data.stress_trigger
      const effects: FactScoreEffect[] = []
      
      // 반대 성향에 페널티 (싫었던 거 → 피하고 싶은 것)
      if (tags.includes('team_collab') || tags.includes('people_facing')) {
        // 팀/사람 관련 싫었으면 → solo 선호
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 10 })
        effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: -15 })
      }
      if (tags.includes('fast_paced')) {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 10 })
        effects.push({ score_type: 'like', job_attribute: 'stability', boost: 10 })
      }
      
      // 스트레스 트리거별 처리
      if (stressTrigger === 'deadline') {
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 10 })
      }
      if (stressTrigger === 'people') {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
        effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: -10 })
      }
      if (stressTrigger === 'meeting') {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 10 })
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 10 })
      }
      if (stressTrigger === 'micromanage') {
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 15 })
      }
      
      return effects
    }
  },
  
  // 11. 변화 이유 (change_reason) → 가치관 부스트
  {
    fact_key_pattern: 'motivation.change_reason',
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { tags: [] }
      const tags = data.tags || []
      const effects: FactScoreEffect[] = []
      
      if (tags.includes('growth') || tags.includes('learning')) {
        effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
        effects.push({ score_type: 'can', job_attribute: 'growth', boost: 10 })
      }
      if (tags.includes('stability')) {
        effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
      }
      if (tags.includes('work_life_balance')) {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 15 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 10 })
      }
      if (tags.includes('income')) {
        effects.push({ score_type: 'like', job_attribute: 'income', boost: 15 })
      }
      if (tags.includes('autonomy')) {
        effects.push({ score_type: 'like', job_attribute: 'remote', boost: 10 })
      }
      
      return effects
    }
  },
  
  // 12. 스트레스 트리거 (직접 저장된 경우)
  {
    fact_key_pattern: 'insight.stress_trigger',
    priority: MAPPING_POLICY.PRIORITY_ORDER['insight'],
    effects: (factValue) => {
      const trigger = typeof factValue === 'object' ? factValue.value : factValue
      const effects: FactScoreEffect[] = []
      
      if (trigger === 'deadline') {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 10 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 15 })
      }
      if (trigger === 'people') {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
      }
      if (trigger === 'physical') {
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 15 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 20 })
      }
      if (trigger === 'multitask') {
        effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 10 })
      }
      
      return effects
    }
  },

  // ============================================
  // Universal Intake Facts (Phase 3)
  // ============================================

  // profile.interest.keywords: 관심사 기반 매핑
  {
    fact_key_pattern: /^profile\.interest\.keywords$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const interests = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []

      interests.forEach((interest: string) => {
        switch (interest) {
          case 'tech':
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
            break
          case 'numbers':
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 20 })
            break
          case 'people':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 15 })
            break
          case 'art':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 20 })
            break
          case 'media':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 10 })
            break
          case 'health':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
            break
          case 'business':
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'income', boost: 10 })
            break
          case 'education':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 10 })
            break
          case 'management':
            effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
            break
          case 'research':
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 10 })
            break
        }
      })

      return effects
    }
  },

  // profile.workstyle.social: 작업 스타일 선호도
  {
    fact_key_pattern: /^profile\.workstyle\.social$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const style = data.value
      const effects: FactScoreEffect[] = []

      switch (style) {
        case 'solo':
          effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 20 })
          effects.push({ score_type: 'risk', job_attribute: 'people_facing', boost: -10 })
          break
        case 'team':
          effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 20 })
          effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
          break
      }

      return effects
    }
  },

  // priority.top1: 우선순위
  {
    fact_key_pattern: /^priority\.top1$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.top1'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const priority = data.value
      const effects: FactScoreEffect[] = []

      switch (priority) {
        case 'growth':
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 25 })
          break
        case 'income':
          effects.push({ score_type: 'like', job_attribute: 'income', boost: 25 })
          break
        case 'stability':
          effects.push({ score_type: 'like', job_attribute: 'stability', boost: 25 })
          break
        case 'wlb':
          effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 25 })
          break
        case 'autonomy':
          effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
          effects.push({ score_type: 'like', job_attribute: 'remote', boost: 15 })
          break
        case 'impact':
          // impact는 측정하기 어려움 - people_facing과 execution으로 대체
          effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
          effects.push({ score_type: 'like', job_attribute: 'execution', boost: 15 })
          break
      }

      return effects
    }
  },

  // profile.dislike.keywords: 싫어하는 것들
  {
    fact_key_pattern: /^profile\.dislike\.keywords$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.dealbreaker'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const dislikes = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []

      dislikes.forEach((dislike: string) => {
        switch (dislike) {
          case 'tech':
            effects.push({ score_type: 'risk', job_attribute: 'analytical', boost: 20 })
            break
          case 'numbers':
            effects.push({ score_type: 'risk', job_attribute: 'analytical', boost: 15 })
            break
          case 'people':
            effects.push({ score_type: 'risk', job_attribute: 'people_facing', boost: 25 })
            effects.push({ score_type: 'risk', job_attribute: 'teamwork', boost: 20 })
            break
          case 'routine':
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: -15 }) // routine 싫어하면 execution 낮은 직업 선호
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 10 })
            break
          case 'risk':
            effects.push({ score_type: 'risk', job_attribute: 'stability', boost: -20 }) // risk 싫어하면 stability 낮은 직업 피함
            break
          case 'uncertainty':
            effects.push({ score_type: 'risk', job_attribute: 'stability', boost: 25 })
            break
        }
      })

      return effects
    }
  },

  // profile.constraints.location: 지역 제약
  {
    fact_key_pattern: /^profile\.constraints\.location$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const location = data.value
      const effects: FactScoreEffect[] = []

      if (location === 'big_city') {
        // 대도시 선호 = 이동/출장 감수
        effects.push({ score_type: 'can', job_attribute: 'execution', boost: 10 })
      } else if (location === 'small_city' || location === 'rural') {
        // 지방 선호 = 안정적 근무 환경
        effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
        effects.push({ score_type: 'risk', job_attribute: 'execution', boost: -10 }) // 잦은 출장 피함
      }

      return effects
    }
  },

  // profile.life_constraint: 생활 제약
  {
    fact_key_pattern: /^profile\.life_constraint$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const constraints = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []

      constraints.forEach((constraint: string) => {
        switch (constraint) {
          case 'caregiving':
            effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 20 })
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: -15 })
            break
          case 'health':
            effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 15 })
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: -10 })
            break
          case 'none':
            // 제약 없음 - 추가 효과 없음
            break
        }
      })

      return effects
    }
  },

  // profile.constraints.time: 시간 제약
  {
    fact_key_pattern: /^profile\.constraints\.time$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const timeConstraint = data.value
      const effects: FactScoreEffect[] = []

      switch (timeConstraint) {
        case 'no_overtime':
          effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 20 })
          effects.push({ score_type: 'risk', job_attribute: 'execution', boost: -15 })
          break
        case 'part_time':
          effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 25 })
          effects.push({ score_type: 'can', job_attribute: 'execution', boost: -20 }) // 파트타임은 업무 강도 낮음
          break
      }

      return effects
    }
  },

  // ============================================
  // 🆕 누락된 Universal Intake 매핑 추가
  // ============================================

  // profile.constraints.qualification: 자격/학력 제약
  {
    fact_key_pattern: /^profile\.constraints\.qualification$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const qualifications = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []

      qualifications.forEach((qual: string) => {
        switch (qual) {
          case 'no_degree':
            // 학력 필수 직업에 페널티
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 25 })
            break
          case 'no_license':
            // 자격증 필수 직업에 페널티
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 20 })
            break
          case 'no_certificate':
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 15 })
            break
        }
      })

      return effects
    }
  },

  // profile.workstyle.structure: 업무 구조 선호도
  {
    fact_key_pattern: /^profile\.workstyle\.structure$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const structure = data.value
      const effects: FactScoreEffect[] = []

      switch (structure) {
        case 'structured':
          // 체계적인 환경 선호 → 안정성, 루틴 직업에 부스트
          effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
          effects.push({ score_type: 'like', job_attribute: 'execution', boost: 10 })
          break
        case 'flexible':
          // 유연한 환경 선호 → 창의성, 자율성 직업에 부스트
          effects.push({ score_type: 'like', job_attribute: 'creative', boost: 15 })
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
          break
      }

      return effects
    }
  },

  // profile.strength.keywords: 강점 키워드
  {
    fact_key_pattern: /^profile\.strength\.keywords$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const strengths = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []

      strengths.forEach((strength: string) => {
        switch (strength) {
          case 'analytical':
            effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 15 })
            break
          case 'creative':
            effects.push({ score_type: 'can', job_attribute: 'creative', boost: 15 })
            break
          case 'communication':
            effects.push({ score_type: 'can', job_attribute: 'people_facing', boost: 15 })
            effects.push({ score_type: 'can', job_attribute: 'teamwork', boost: 10 })
            break
          case 'leadership':
            effects.push({ score_type: 'can', job_attribute: 'teamwork', boost: 15 })
            effects.push({ score_type: 'can', job_attribute: 'execution', boost: 10 })
            break
          case 'detail':
            effects.push({ score_type: 'can', job_attribute: 'execution', boost: 15 })
            effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 10 })
            break
          case 'empathy':
            effects.push({ score_type: 'can', job_attribute: 'people_facing', boost: 20 })
            break
        }
      })

      return effects
    }
  },

  // profile.environment_pref: 환경 선호도
  {
    fact_key_pattern: /^profile\.environment_pref$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const env = data.value
      const effects: FactScoreEffect[] = []

      switch (env) {
        case 'quiet':
          effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
          effects.push({ score_type: 'risk', job_attribute: 'people_facing', boost: 10 })
          break
        case 'active':
          effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 10 })
          effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 10 })
          break
        case 'outdoor':
          effects.push({ score_type: 'like', job_attribute: 'execution', boost: 10 })
          break
      }

      return effects
    }
  },
  
  // ============================================
  // P0: 5축 상태좌표 기반 scoring
  // ============================================
  
  // state.role_identity: 역할 정체성
  {
    fact_key_pattern: /^state\.role_identity$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const role = data.value
      const effects: FactScoreEffect[] = []
      
      switch (role) {
        case 'student':
          // 학생: 성장 잠재력 중시
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
          break
        case 'job_seeker':
          // 구직자: 취업 가능성 중시
          effects.push({ score_type: 'can', job_attribute: 'stability', boost: 10 })
          break
        case 'early_career':
          // 초기 경력: 성장 기회 중시
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
          break
        case 'mid_career':
          // 중간 경력: 균형 중시
          effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 5 })
          effects.push({ score_type: 'like', job_attribute: 'stability', boost: 5 })
          break
        case 'senior':
          // 시니어: 안정성 중시
          effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
          break
        case 'career_changer':
          // 전직자: 새로운 기회 중시
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
          effects.push({ score_type: 'risk', job_attribute: 'stability', boost: 5 })
          break
      }
      
      return effects
    }
  },
  
  // state.skill_level: 숙련도
  {
    fact_key_pattern: /^state\.skill_level$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const level = typeof data.value === 'number' ? data.value : parseInt(data.value, 10)
      const effects: FactScoreEffect[] = []
      
      if (level <= 1) {
        // 입문/초급: 학습 곡선 낮은 직업 선호
        effects.push({ score_type: 'can', job_attribute: 'growth', boost: 10 })
        effects.push({ score_type: 'risk', job_attribute: 'analytical', boost: 10 })
      } else if (level >= 4) {
        // 고급/전문가: 전문성 발휘 직업 선호
        effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 15 })
        effects.push({ score_type: 'like', job_attribute: 'income', boost: 10 })
      }
      
      return effects
    }
  },
  
  // state.transition_status: 전환 상태
  {
    fact_key_pattern: /^state\.transition_status$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const status = data.value
      const effects: FactScoreEffect[] = []
      
      switch (status) {
        case 'exploring':
          // 탐색 중: 다양한 옵션 제시
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 5 })
          break
        case 'decided':
          // 결정됨: 실행 가능성 중시
          effects.push({ score_type: 'can', job_attribute: 'stability', boost: 10 })
          break
        case 'preparing':
          // 준비 중: 준비 필요 직업 필터
          effects.push({ score_type: 'risk', job_attribute: 'stability', boost: -5 })
          break
        case 'transitioning':
          // 전환 중: 즉시 가능한 직업
          effects.push({ score_type: 'can', job_attribute: 'execution', boost: 10 })
          break
      }
      
      return effects
    }
  },
  
  // state.constraint.*: 제약 조건
  {
    fact_key_pattern: /^state\.constraint\.(time|money|location|family|health|qualification)$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const hasConstraint = data.value === true || data.value === 'true'
      const effects: FactScoreEffect[] = []
      
      if (hasConstraint) {
        // 제약이 있으면 워라밸 중시
        effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 10 })
        effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: -10 })
      }
      
      return effects
    }
  },
  
  // ============================================
  // P0: 전이 신호 기반 scoring
  // ============================================
  
  // transition.motivation_primary: 전환 동기
  {
    fact_key_pattern: /^transition\.motivation_primary$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['tradeoff'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const motivation = data.value
      const effects: FactScoreEffect[] = []
      
      switch (motivation) {
        case 'higher_income':
          effects.push({ score_type: 'like', job_attribute: 'income', boost: 20 })
          break
        case 'better_wlb':
          effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 20 })
          break
        case 'career_growth':
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 20 })
          break
        case 'job_security':
          effects.push({ score_type: 'like', job_attribute: 'stability', boost: 20 })
          break
        case 'passion':
          effects.push({ score_type: 'like', job_attribute: 'creative', boost: 15 })
          effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
          break
        case 'relocation':
          effects.push({ score_type: 'can', job_attribute: 'remote_possible', boost: 15 })
          break
      }
      
      return effects
    }
  },
  
  // transition.desired_type: 원하는 전환 유형
  {
    fact_key_pattern: /^transition\.desired_type$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['tradeoff'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { value: factValue }
      const types = Array.isArray(data.value) ? data.value : [data.value]
      const effects: FactScoreEffect[] = []
      
      for (const type of types) {
        switch (type) {
          case 'same_field_up':
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
            break
          case 'different_field':
            effects.push({ score_type: 'can', job_attribute: 'growth', boost: 10 })
            break
          case 'freelance':
            effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 10 })
            effects.push({ score_type: 'risk', job_attribute: 'stability', boost: 10 })
            break
          case 'startup':
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
            effects.push({ score_type: 'risk', job_attribute: 'stability', boost: 15 })
            break
        }
      }
      
      return effects
    }
  },
  
  // ============================================
  // Hard Dislike: 절대 안 되는 것 (Like 대폭 감점)
  // ============================================
  {
    fact_key_pattern: /^profile\.hard_dislike$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'], // 최고 우선순위
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { type: factValue }
      const dislikeType = data.type
      const effects: FactScoreEffect[] = []
      
      // hard_dislike → 직업 속성 매핑 (Like 점수 대폭 감점)
      const HARD_DISLIKE_PENALTY_MAP: Record<string, { attr: JobAttribute; penalty: number }[]> = {
        // 업무 유형 관련
        'sales': [{ attr: 'people_facing', penalty: -40 }],
        'public_speaking': [{ attr: 'people_facing', penalty: -35 }],
        'meetings': [{ attr: 'teamwork', penalty: -25 }],
        'call_center': [{ attr: 'people_facing', penalty: -45 }],
        
        // 근무 환경 관련
        'overtime': [{ attr: 'wlb', penalty: -40 }],
        'shift_work': [{ attr: 'wlb', penalty: -35 }],
        'travel': [{ attr: 'remote', penalty: -30 }],
        
        // 업무 성격 관련
        'routine': [{ attr: 'creative', penalty: -30 }],
        'conflict': [{ attr: 'people_facing', penalty: -35 }],
        'physical': [{ attr: 'execution', penalty: -40 }],
        'construction': [{ attr: 'execution', penalty: -45 }],
        
        // 특수 직종
        'woodwork': [{ attr: 'execution', penalty: -50 }], // 키워드 직접 매칭
      }
      
      const penalties = HARD_DISLIKE_PENALTY_MAP[dislikeType]
      if (penalties) {
        for (const { attr, penalty } of penalties) {
          effects.push({ score_type: 'like', job_attribute: attr, boost: penalty })
        }
      }
      
      return effects
    }
  },
  
  // 일반 dislike (mild - 약한 감점)
  {
    fact_key_pattern: /^profile\.dislike$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const data = typeof factValue === 'object' ? factValue : { type: factValue }
      const dislikeType = data.type
      const intensity = data.intensity || 'mild'
      const effects: FactScoreEffect[] = []
      
      // mild dislike는 약한 감점
      const basePenalty = intensity === 'hard' ? -30 : -10
      
      const MILD_DISLIKE_MAP: Record<string, JobAttribute> = {
        'overtime': 'wlb',
        'meeting': 'teamwork',
        'sales': 'people_facing',
        'routine': 'creative',
        'pressure': 'wlb',
        'travel': 'remote',
        'physical': 'execution',
        'conflict': 'people_facing',
        'public': 'people_facing',
        'uncertainty': 'stability',
      }
      
      const attr = MILD_DISLIKE_MAP[dislikeType]
      if (attr) {
        effects.push({ score_type: 'like', job_attribute: attr, boost: basePenalty })
      }
      
      return effects
    }
  },
  
  // ============================================
  // P2: 이력서 파싱 데이터 기반 scoring (resume_parsed)
  // ============================================
  
  // resume.skill: 이력서에서 추출된 스킬 → Can 점수 부스트
  {
    fact_key_pattern: /^resume\.skill$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const skill = typeof factValue === 'string' ? factValue.toLowerCase() : String(factValue).toLowerCase()
      const effects: FactScoreEffect[] = []
      
      // 스킬 카테고리별 매핑
      const SKILL_TO_ATTR_MAP: Record<string, { attr: JobAttribute; boost: number }[]> = {
        // 기술/IT 관련
        'python': [{ attr: 'analytical', boost: 12 }],
        'java': [{ attr: 'analytical', boost: 12 }],
        'javascript': [{ attr: 'analytical', boost: 10 }, { attr: 'creative', boost: 5 }],
        'typescript': [{ attr: 'analytical', boost: 12 }],
        'sql': [{ attr: 'analytical', boost: 10 }],
        'react': [{ attr: 'creative', boost: 8 }, { attr: 'analytical', boost: 5 }],
        'node': [{ attr: 'analytical', boost: 10 }],
        '프로그래밍': [{ attr: 'analytical', boost: 10 }],
        '코딩': [{ attr: 'analytical', boost: 10 }],
        '개발': [{ attr: 'analytical', boost: 10 }],
        'ai': [{ attr: 'analytical', boost: 12 }],
        '머신러닝': [{ attr: 'analytical', boost: 15 }],
        '데이터분석': [{ attr: 'analytical', boost: 15 }],
        
        // 디자인/창의 관련
        'photoshop': [{ attr: 'creative', boost: 12 }],
        'figma': [{ attr: 'creative', boost: 12 }],
        'illustrator': [{ attr: 'creative', boost: 12 }],
        '디자인': [{ attr: 'creative', boost: 12 }],
        'ui': [{ attr: 'creative', boost: 10 }],
        'ux': [{ attr: 'creative', boost: 10 }, { attr: 'analytical', boost: 5 }],
        '영상편집': [{ attr: 'creative', boost: 12 }],
        
        // 커뮤니케이션/대인 관련
        '영업': [{ attr: 'people_facing', boost: 15 }],
        '마케팅': [{ attr: 'people_facing', boost: 10 }, { attr: 'creative', boost: 8 }],
        '고객관리': [{ attr: 'people_facing', boost: 12 }],
        'crm': [{ attr: 'people_facing', boost: 10 }],
        '프레젠테이션': [{ attr: 'people_facing', boost: 10 }],
        '협상': [{ attr: 'people_facing', boost: 12 }],
        
        // 관리/실행 관련
        '프로젝트관리': [{ attr: 'execution', boost: 12 }, { attr: 'teamwork', boost: 8 }],
        'pm': [{ attr: 'execution', boost: 12 }],
        '리더십': [{ attr: 'teamwork', boost: 12 }, { attr: 'people_facing', boost: 8 }],
        '팀관리': [{ attr: 'teamwork', boost: 15 }],
        'excel': [{ attr: 'analytical', boost: 8 }],
        '엑셀': [{ attr: 'analytical', boost: 8 }],
        
        // 언어 관련
        '영어': [{ attr: 'people_facing', boost: 8 }],
        '중국어': [{ attr: 'people_facing', boost: 10 }],
        '일본어': [{ attr: 'people_facing', boost: 8 }],
      }
      
      // 부분 매칭으로 스킬 찾기
      for (const [skillKeyword, boosts] of Object.entries(SKILL_TO_ATTR_MAP)) {
        if (skill.includes(skillKeyword)) {
          for (const { attr, boost } of boosts) {
            effects.push({ score_type: 'can', job_attribute: attr, boost })
          }
          break // 첫 번째 매칭만 적용
        }
      }
      
      // 매칭되지 않은 스킬도 기본 Can 부스트
      if (effects.length === 0) {
        effects.push({ score_type: 'can', job_attribute: 'growth', boost: 5 })
      }
      
      return effects
    }
  },
  
  // resume.certification: 자격증 → Can 점수 부스트 + 전문성 신호
  {
    fact_key_pattern: /^resume\.certification$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const cert = typeof factValue === 'string' ? factValue.toLowerCase() : String(factValue).toLowerCase()
      const effects: FactScoreEffect[] = []
      
      // 자격증 카테고리별 매핑
      const CERT_TO_ATTR_MAP: Record<string, { attr: JobAttribute; boost: number }[]> = {
        // IT/기술 자격증
        '정보처리기사': [{ attr: 'analytical', boost: 15 }],
        '정보보안기사': [{ attr: 'analytical', boost: 15 }],
        'aws': [{ attr: 'analytical', boost: 12 }],
        '토익': [{ attr: 'people_facing', boost: 8 }],
        'toeic': [{ attr: 'people_facing', boost: 8 }],
        'opic': [{ attr: 'people_facing', boost: 10 }],
        
        // 전문직 자격증
        'cpa': [{ attr: 'analytical', boost: 20 }, { attr: 'stability', boost: 10 }],
        '회계사': [{ attr: 'analytical', boost: 20 }],
        '세무사': [{ attr: 'analytical', boost: 18 }],
        '변호사': [{ attr: 'analytical', boost: 20 }, { attr: 'people_facing', boost: 10 }],
        '의사': [{ attr: 'people_facing', boost: 15 }, { attr: 'stability', boost: 15 }],
        '간호사': [{ attr: 'people_facing', boost: 15 }],
        '약사': [{ attr: 'analytical', boost: 15 }, { attr: 'stability', boost: 10 }],
        
        // 기술/기능 자격증
        '운전면허': [{ attr: 'execution', boost: 5 }],
        '지게차': [{ attr: 'execution', boost: 10 }],
        '용접': [{ attr: 'execution', boost: 12 }],
        '전기기사': [{ attr: 'execution', boost: 15 }],
        
        // 관리/경영 자격증
        'pmp': [{ attr: 'execution', boost: 15 }, { attr: 'teamwork', boost: 10 }],
        '사회복지사': [{ attr: 'people_facing', boost: 15 }],
      }
      
      for (const [certKeyword, boosts] of Object.entries(CERT_TO_ATTR_MAP)) {
        if (cert.includes(certKeyword)) {
          for (const { attr, boost } of boosts) {
            effects.push({ score_type: 'can', job_attribute: attr, boost })
          }
          break
        }
      }
      
      // 기본 자격증 보유 시 안정성 + 실행력 부스트
      if (effects.length === 0) {
        effects.push({ score_type: 'can', job_attribute: 'stability', boost: 5 })
        effects.push({ score_type: 'can', job_attribute: 'execution', boost: 5 })
      }
      
      return effects
    }
  },
  
  // resume.industry: 경험 업종 → 관련 속성 Like/Can 부스트
  {
    fact_key_pattern: /^resume\.industry$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const industry = typeof factValue === 'string' ? factValue.toLowerCase() : String(factValue).toLowerCase()
      const effects: FactScoreEffect[] = []
      
      const INDUSTRY_TO_ATTR_MAP: Record<string, { attr: JobAttribute; likeBoost: number; canBoost: number }[]> = {
        'it': [{ attr: 'analytical', likeBoost: 8, canBoost: 12 }],
        '소프트웨어': [{ attr: 'analytical', likeBoost: 8, canBoost: 12 }],
        '금융': [{ attr: 'stability', likeBoost: 10, canBoost: 10 }, { attr: 'analytical', likeBoost: 5, canBoost: 8 }],
        '제조': [{ attr: 'execution', likeBoost: 5, canBoost: 12 }],
        '유통': [{ attr: 'people_facing', likeBoost: 5, canBoost: 10 }],
        '의료': [{ attr: 'people_facing', likeBoost: 8, canBoost: 10 }, { attr: 'stability', likeBoost: 5, canBoost: 8 }],
        '교육': [{ attr: 'people_facing', likeBoost: 10, canBoost: 10 }],
        '미디어': [{ attr: 'creative', likeBoost: 10, canBoost: 10 }],
        '광고': [{ attr: 'creative', likeBoost: 10, canBoost: 10 }],
        '컨설팅': [{ attr: 'analytical', likeBoost: 8, canBoost: 12 }, { attr: 'people_facing', likeBoost: 5, canBoost: 8 }],
        '스타트업': [{ attr: 'growth', likeBoost: 12, canBoost: 8 }],
        '공공기관': [{ attr: 'stability', likeBoost: 10, canBoost: 10 }],
      }
      
      for (const [industryKeyword, boosts] of Object.entries(INDUSTRY_TO_ATTR_MAP)) {
        if (industry.includes(industryKeyword)) {
          for (const { attr, likeBoost, canBoost } of boosts) {
            effects.push({ score_type: 'like', job_attribute: attr, boost: likeBoost })
            effects.push({ score_type: 'can', job_attribute: attr, boost: canBoost })
          }
          break
        }
      }
      
      return effects
    }
  },
  
  // resume.education_level: 학력 수준 → 자격요건 매칭에 활용
  {
    fact_key_pattern: /^resume\.education_level$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const level = typeof factValue === 'string' ? factValue.toLowerCase() : String(factValue).toLowerCase()
      const effects: FactScoreEffect[] = []
      
      // 학력에 따른 적합도 조정
      if (level.includes('석사') || level.includes('박사') || level.includes('master') || level.includes('phd')) {
        effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 12 })
        effects.push({ score_type: 'can', job_attribute: 'growth', boost: 8 })
      } else if (level.includes('대학') || level.includes('학사') || level.includes('bachelor')) {
        effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 8 })
      }
      
      // 학력이 높을수록 성장 기회 중시할 가능성
      if (level.includes('석사') || level.includes('박사')) {
        effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
      }
      
      return effects
    }
  },
  
  // resume.role_type: 현재/이전 역할 유형 → 경험 기반 Can 부스트
  {
    fact_key_pattern: /^resume\.role_type$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['discovery'],
    effects: (factValue) => {
      const role = typeof factValue === 'string' ? factValue.toLowerCase() : String(factValue).toLowerCase()
      const effects: FactScoreEffect[] = []
      
      const ROLE_TO_ATTR_MAP: Record<string, { attr: JobAttribute; boost: number }[]> = {
        '개발자': [{ attr: 'analytical', boost: 15 }],
        'developer': [{ attr: 'analytical', boost: 15 }],
        'engineer': [{ attr: 'analytical', boost: 15 }],
        '디자이너': [{ attr: 'creative', boost: 15 }],
        'designer': [{ attr: 'creative', boost: 15 }],
        '마케터': [{ attr: 'creative', boost: 10 }, { attr: 'people_facing', boost: 10 }],
        'marketer': [{ attr: 'creative', boost: 10 }, { attr: 'people_facing', boost: 10 }],
        '영업': [{ attr: 'people_facing', boost: 15 }],
        'sales': [{ attr: 'people_facing', boost: 15 }],
        '기획자': [{ attr: 'analytical', boost: 10 }, { attr: 'creative', boost: 8 }],
        'planner': [{ attr: 'analytical', boost: 10 }, { attr: 'creative', boost: 8 }],
        '관리자': [{ attr: 'teamwork', boost: 12 }, { attr: 'execution', boost: 10 }],
        'manager': [{ attr: 'teamwork', boost: 12 }, { attr: 'execution', boost: 10 }],
        '대표': [{ attr: 'teamwork', boost: 15 }, { attr: 'execution', boost: 12 }],
        'ceo': [{ attr: 'teamwork', boost: 15 }, { attr: 'execution', boost: 12 }],
        '연구원': [{ attr: 'analytical', boost: 15 }, { attr: 'solo_work', boost: 10 }],
        'researcher': [{ attr: 'analytical', boost: 15 }, { attr: 'solo_work', boost: 10 }],
      }
      
      for (const [roleKeyword, boosts] of Object.entries(ROLE_TO_ATTR_MAP)) {
        if (role.includes(roleKeyword)) {
          for (const { attr, boost } of boosts) {
            effects.push({ score_type: 'can', job_attribute: attr, boost })
          }
          break
        }
      }
      
      return effects
    }
  },

  // ============================================
  // Phase 2.1: 미니모듈 토큰 → 직업 속성 매핑 (강화된 버전)
  // ============================================

  // 미니모듈 interest_top 기반 매핑
  {
    fact_key_pattern: /^minimodule\.interest_top$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.top1'],
    effects: (factValue) => {
      const interests = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      interests.forEach((interest: string) => {
        switch (interest) {
          case 'problem_solving':
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 25 })
            effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 15 })
            break
          case 'data_numbers':
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 30 })
            effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 20 })
            // 현장직/제조업 회피 (분석 성향 + 현장직 불일치)
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 20 })
            break
          case 'creating':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 25 })
            effects.push({ score_type: 'can', job_attribute: 'creative', boost: 15 })
            break
          case 'helping_teaching':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 25 })
            break
          case 'organizing':
            effects.push({ score_type: 'like', job_attribute: 'execution', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
            break
          case 'influencing':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 15 })
            break
        }
      })

      return effects
    }
  },

  // 미니모듈 strength_top 기반 매핑 (강화된 버전)
  {
    fact_key_pattern: /^minimodule\.strength_top$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.top1'],
    effects: (factValue) => {
      const strengths = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      strengths.forEach((strength: string) => {
        switch (strength) {
          case 'analytical':
            // 분석형 강점 → 데이터 분석, 연구, 기획 직업군 Fit +30
            effects.push({ score_type: 'like', job_attribute: 'analytical', boost: 30 })
            effects.push({ score_type: 'can', job_attribute: 'analytical', boost: 25 })
            // 현장직/제조업 회피 (핵심 피드백 반영)
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 25 })
            break
          case 'creative':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 25 })
            effects.push({ score_type: 'can', job_attribute: 'creative', boost: 20 })
            break
          case 'communication':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 20 })
            effects.push({ score_type: 'can', job_attribute: 'people_facing', boost: 15 })
            break
          case 'structured_execution':
            // 체계적 실행 강점 → 관리, 운영 직업군 Fit +25
            effects.push({ score_type: 'like', job_attribute: 'execution', boost: 25 })
            effects.push({ score_type: 'can', job_attribute: 'execution', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 15 })
            break
          case 'persistence':
            effects.push({ score_type: 'can', job_attribute: 'execution', boost: 20 })
            break
          case 'fast_learning':
            effects.push({ score_type: 'can', job_attribute: 'growth', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
            break
        }
      })

      return effects
    }
  },

  // 미니모듈 energy_drain_flags 기반 매핑 (강화된 페널티)
  {
    fact_key_pattern: /^minimodule\.energy_drain_flags$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.dealbreaker'],
    effects: (factValue) => {
      const drains = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      drains.forEach((drain: string) => {
        switch (drain) {
          case 'people_drain':
            // 대인 피로 → 대면 서비스 직업군 Fit -40 (강화)
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: -40 })
            effects.push({ score_type: 'risk', job_attribute: 'people_facing', boost: 35 })
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 25 })
            break
          case 'time_pressure_drain':
            effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 25 })
            effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: 30 })
            break
          case 'cognitive_drain':
            effects.push({ score_type: 'risk', job_attribute: 'analytical', boost: 20 })
            break
          case 'responsibility_drain':
            effects.push({ score_type: 'risk', job_attribute: 'teamwork', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 15 })
            break
          case 'repetition_drain':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 20 })
            effects.push({ score_type: 'risk', job_attribute: 'execution', boost: 15 })
            break
          case 'unpredictability_drain':
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 25 })
            effects.push({ score_type: 'risk', job_attribute: 'growth', boost: 15 })
            break
        }
      })

      return effects
    }
  },

  // 미니모듈 sacrifice_flags 기반 매핑 (Hard Bias 충돌 페널티 강화)
  {
    fact_key_pattern: /^minimodule\.sacrifice_flags$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['confirmed_constraint'],
    effects: (factValue) => {
      const sacrifices = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      sacrifices.forEach((sacrifice: string) => {
        switch (sacrifice) {
          case 'no_sacrifice':
            // 희생 불가 → 모든 부정적 조건에 민감
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 30 })
            effects.push({ score_type: 'like', job_attribute: 'wlb', boost: 25 })
            effects.push({ score_type: 'risk', job_attribute: 'growth', boost: 20 })
            break
          case 'sacrifice_income':
            effects.push({ score_type: 'like', job_attribute: 'income', boost: -20 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 15 })
            break
          case 'sacrifice_wlb':
            effects.push({ score_type: 'risk', job_attribute: 'wlb', boost: -15 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 20 })
            break
          case 'sacrifice_stability':
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: -20 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 20 })
            break
        }
      })

      return effects
    }
  },

  // 미니모듈 workstyle_top 기반 매핑
  {
    fact_key_pattern: /^minimodule\.workstyle_top$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['motivation'],
    effects: (factValue) => {
      const styles = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      styles.forEach((style: string) => {
        switch (style) {
          case 'solo':
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 25 })
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: -15 })
            effects.push({ score_type: 'risk', job_attribute: 'teamwork', boost: 15 })
            break
          case 'team':
            effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 25 })
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: -10 })
            break
          case 'structured':
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'execution', boost: 15 })
            effects.push({ score_type: 'risk', job_attribute: 'creative', boost: 10 })
            break
          case 'flexible':
            effects.push({ score_type: 'like', job_attribute: 'creative', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'remote', boost: 15 })
            effects.push({ score_type: 'risk', job_attribute: 'stability', boost: 10 })
            break
        }
      })

      return effects
    }
  },

  // 미니모듈 value_top 기반 매핑
  {
    fact_key_pattern: /^minimodule\.value_top$/,
    priority: MAPPING_POLICY.PRIORITY_ORDER['priority.top1'],
    effects: (factValue) => {
      const values = Array.isArray(factValue) ? factValue : [factValue]
      const effects: FactScoreEffect[] = []

      values.forEach((value: string) => {
        switch (value) {
          case 'autonomy':
            effects.push({ score_type: 'like', job_attribute: 'solo_work', boost: 20 })
            effects.push({ score_type: 'like', job_attribute: 'remote', boost: 20 })
            break
          case 'growth':
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 25 })
            break
          case 'stability':
            effects.push({ score_type: 'like', job_attribute: 'stability', boost: 25 })
            effects.push({ score_type: 'risk', job_attribute: 'growth', boost: 10 })
            break
          case 'income':
            effects.push({ score_type: 'like', job_attribute: 'income', boost: 25 })
            break
          case 'meaning':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'growth', boost: 10 })
            break
          case 'recognition':
            effects.push({ score_type: 'like', job_attribute: 'people_facing', boost: 15 })
            effects.push({ score_type: 'like', job_attribute: 'teamwork', boost: 10 })
            break
        }
      })

      return effects
    }
  },

  // ============================================
  // P0: Can 검증 질문 결과 → Can Boost 규칙 (6개)
  // 자기평가 강점의 실제 경험 검증 시 Can 점수 가산
  // ============================================

  // 1. 분석력 검증
  {
    fact_key_pattern: 'can_verified_analytical',
    priority: 90,  // 높은 우선순위 (confirmed_constraint 바로 아래)
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [{ score_type: 'can', job_attribute: 'analytical', boost: 15 }]
        case 'some_evidence':
          return [{ score_type: 'can', job_attribute: 'analytical', boost: 8 }]
        default:
          return []
      }
    }
  },

  // 2. 창의력 검증
  {
    fact_key_pattern: 'can_verified_creative',
    priority: 90,
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [{ score_type: 'can', job_attribute: 'creative', boost: 15 }]
        case 'some_evidence':
          return [{ score_type: 'can', job_attribute: 'creative', boost: 8 }]
        default:
          return []
      }
    }
  },

  // 3. 소통력 검증
  {
    fact_key_pattern: 'can_verified_communication',
    priority: 90,
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [
            { score_type: 'can', job_attribute: 'people_facing', boost: 15 },
            { score_type: 'can', job_attribute: 'teamwork', boost: 10 }
          ]
        case 'some_evidence':
          return [
            { score_type: 'can', job_attribute: 'people_facing', boost: 8 },
            { score_type: 'can', job_attribute: 'teamwork', boost: 5 }
          ]
        default:
          return []
      }
    }
  },

  // 4. 실행력 검증
  {
    fact_key_pattern: 'can_verified_structured_execution',
    priority: 90,
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [{ score_type: 'can', job_attribute: 'execution', boost: 15 }]
        case 'some_evidence':
          return [{ score_type: 'can', job_attribute: 'execution', boost: 8 }]
        default:
          return []
      }
    }
  },

  // 5. 끈기 검증
  {
    fact_key_pattern: 'can_verified_persistence',
    priority: 90,
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [
            { score_type: 'can', job_attribute: 'execution', boost: 10 },
            { score_type: 'can', job_attribute: 'growth', boost: 10 }
          ]
        case 'some_evidence':
          return [
            { score_type: 'can', job_attribute: 'execution', boost: 5 },
            { score_type: 'can', job_attribute: 'growth', boost: 5 }
          ]
        default:
          return []
      }
    }
  },

  // 6. 학습력 검증
  {
    fact_key_pattern: 'can_verified_fast_learning',
    priority: 90,
    effects: (factValue) => {
      const value = typeof factValue === 'string' ? factValue : String(factValue)
      switch (value) {
        case 'strong_evidence':
          return [
            { score_type: 'can', job_attribute: 'growth', boost: 15 },
            { score_type: 'can', job_attribute: 'analytical', boost: 5 }
          ]
        case 'some_evidence':
          return [
            { score_type: 'can', job_attribute: 'growth', boost: 8 },
            { score_type: 'can', job_attribute: 'analytical', boost: 3 }
          ]
        default:
          return []
      }
    }
  },
]

// ============================================
// 점수 계산 함수
// ============================================

export interface FactBoostResult {
  like_boosts: Map<JobAttribute, number>
  can_boosts: Map<JobAttribute, number>
  risk_adjustments: Map<JobAttribute, number>
  applied_rules: string[]
}

export function calculateFactBoosts(
  facts: Array<{ fact_key: string; value_json: string }>
): FactBoostResult {
  const result: FactBoostResult = {
    like_boosts: new Map(),
    can_boosts: new Map(),
    risk_adjustments: new Map(),
    applied_rules: [],
  }
  
  // 우선순위 순으로 정렬된 facts 처리
  const sortedFacts = [...facts].sort((a, b) => {
    const priorityA = getFactPriority(a.fact_key)
    const priorityB = getFactPriority(b.fact_key)
    return priorityB - priorityA
  })
  
  for (const fact of sortedFacts) {
    const rule = findMatchingRule(fact.fact_key)
    if (!rule) continue
    
    let factValue: any
    try {
      factValue = JSON.parse(fact.value_json)
    } catch {
      factValue = fact.value_json
    }
    
    const effects = rule.effects(factValue)
    
    for (const effect of effects) {
      // boost 상한 적용
      const clampedBoost = Math.max(
        -MAPPING_POLICY.MAX_BOOST_PER_FACT,
        Math.min(MAPPING_POLICY.MAX_BOOST_PER_FACT, effect.boost)
      )
      
      const targetMap = effect.score_type === 'like' 
        ? result.like_boosts 
        : effect.score_type === 'can' 
          ? result.can_boosts 
          : result.risk_adjustments
      
      // 중복 정책 적용
      const existing = targetMap.get(effect.job_attribute) || 0
      
      if (MAPPING_POLICY.DUPLICATE_POLICY === 'highest_wins') {
        if (Math.abs(clampedBoost) > Math.abs(existing)) {
          targetMap.set(effect.job_attribute, clampedBoost)
        }
      } else if (MAPPING_POLICY.DUPLICATE_POLICY === 'sum') {
        targetMap.set(effect.job_attribute, existing + clampedBoost)
      } else {
        // average: 나중에 구현
        targetMap.set(effect.job_attribute, clampedBoost)
      }
    }
    
    result.applied_rules.push(fact.fact_key)
  }
  
  // 전체 상한 적용
  applyTotalCap(result.like_boosts, MAPPING_POLICY.MAX_TOTAL_LIKE_BOOST)
  applyTotalCap(result.can_boosts, MAPPING_POLICY.MAX_TOTAL_CAN_BOOST)
  
  return result
}

function getFactPriority(factKey: string): number {
  for (const [prefix, priority] of Object.entries(MAPPING_POLICY.PRIORITY_ORDER)) {
    if (factKey.startsWith(prefix)) return priority
  }
  return 0
}

function findMatchingRule(factKey: string): FactScoreRule | undefined {
  return FACT_SCORE_RULES.find(rule => {
    if (typeof rule.fact_key_pattern === 'string') {
      return factKey === rule.fact_key_pattern
    }
    return rule.fact_key_pattern.test(factKey)
  })
}

function applyTotalCap(boostMap: Map<JobAttribute, number>, cap: number): void {
  let total = 0
  for (const boost of boostMap.values()) {
    total += Math.max(0, boost)  // 양수만 합산
  }

  if (total > cap) {
    const ratio = cap / total
    for (const [attr, boost] of boostMap.entries()) {
      if (boost > 0) {
        boostMap.set(attr, boost * ratio)
      }
    }
  }
}

// ============================================
// P0: Can-Like 밸런스 캡
// |Can - Like| > 40일 경우 소프트 캡 적용
// 한쪽이 너무 높으면 현실성 낮음 → 적정 수준으로 조정
// ============================================
export const BALANCE_CAP_CONFIG = {
  MAX_IMBALANCE: 40,           // 허용되는 최대 불균형
  SOFT_CAP_RATIO: 0.6,         // 초과분에 적용되는 감쇠 비율 (40% 감쇠)
}

export interface BalancedScores {
  like: number
  can: number
  balance_cap_applied: boolean
  original_diff: number
}

/**
 * Can-Like 밸런스 캡 적용
 * - |Can - Like| > 40이면 소프트 캡 적용
 * - 초과분의 40%만 인정하여 극단적 불균형 방지
 */
export function applyBalanceCap(like: number, can: number): BalancedScores {
  const diff = Math.abs(can - like)

  if (diff <= BALANCE_CAP_CONFIG.MAX_IMBALANCE) {
    return { like, can, balance_cap_applied: false, original_diff: diff }
  }

  // 초과분 계산
  const excess = diff - BALANCE_CAP_CONFIG.MAX_IMBALANCE
  const cappedExcess = excess * BALANCE_CAP_CONFIG.SOFT_CAP_RATIO

  let adjustedLike = like
  let adjustedCan = can

  if (can > like) {
    // Can이 너무 높음 → Can 감소
    adjustedCan = like + BALANCE_CAP_CONFIG.MAX_IMBALANCE + cappedExcess
  } else {
    // Like가 너무 높음 → Like 감소
    adjustedLike = can + BALANCE_CAP_CONFIG.MAX_IMBALANCE + cappedExcess
  }

  return {
    like: Math.round(adjustedLike),
    can: Math.round(adjustedCan),
    balance_cap_applied: true,
    original_diff: diff,
  }
}

// ============================================
// 직업 점수에 boost 적용
// ============================================

export interface JobScores {
  like: number
  can: number
  risk_penalty: number
}

export function applyFactBoostsToJob(
  baseScores: JobScores,
  jobAttributes: Record<string, string | number>,
  factBoosts: FactBoostResult
): JobScores {
  const result = { ...baseScores }
  
  // Like boost 적용
  for (const [attr, boost] of factBoosts.like_boosts.entries()) {
    const jobValue = jobAttributes[attr]
    if (jobValue !== undefined) {
      // 직업이 해당 attribute를 가지고 있으면 boost 적용
      result.like += boost
    }
  }
  
  // Can boost 적용
  for (const [attr, boost] of factBoosts.can_boosts.entries()) {
    const jobValue = jobAttributes[attr]
    if (jobValue !== undefined) {
      result.can += boost
    }
  }
  
  // Risk adjustment 적용
  for (const [attr, adjustment] of factBoosts.risk_adjustments.entries()) {
    // 양수면 risk 수용(패널티 감소), 음수면 risk 강화(패널티 증가)
    result.risk_penalty -= adjustment
  }
  
  // 점수 범위 clamp (0~100)
  result.like = Math.max(0, Math.min(100, result.like))
  result.can = Math.max(0, Math.min(100, result.can))
  result.risk_penalty = Math.max(0, Math.min(80, result.risk_penalty))
  
  return result
}

