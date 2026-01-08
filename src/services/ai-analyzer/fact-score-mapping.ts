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
export type JobAttribute = 'wlb' | 'growth' | 'stability' | 'income' | 'remote' | 'solo_work' | 'creative' | 'analytical' | 'people_facing' | 'teamwork' | 'execution'

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
  MAX_TOTAL_LIKE_BOOST: 40,
  MAX_TOTAL_CAN_BOOST: 30,
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

