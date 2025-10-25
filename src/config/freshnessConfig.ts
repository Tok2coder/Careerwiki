import type { DataSource } from '../types/unifiedProfiles'

export type FreshnessListType = 'job' | 'major'

export interface FreshnessTargetParams {
  keyword?: string
  category?: string
  page?: number
  perPage?: number
  includeSources?: DataSource[]
}

export interface FreshnessScheduleConfig {
  intervalMinutes: number
  jitterMinutes?: number
  allowRuntimeSync?: boolean
  fallbackIntervalMinutes?: number
}

export interface FreshnessTarget {
  id: string
  type: FreshnessListType
  description: string
  params: FreshnessTargetParams
  schedule: FreshnessScheduleConfig
  tags?: string[]
  priority?: 'high' | 'medium' | 'low'
}

export const SERP_FRESHNESS_TARGETS: FreshnessTarget[] = [
  {
    id: 'job-tech-developer',
    type: 'job',
    description: '직업위키 - 개발자/프로그래머 SERP (IT 핵심 키워드)',
    params: {
      keyword: '개발자',
      category: '100060',
      page: 1,
      perPage: 20,
      includeSources: ['CAREERNET', 'GOYONG24']
    },
    schedule: {
      intervalMinutes: 60,
      jitterMinutes: 10,
      allowRuntimeSync: true
    },
    tags: ['it', 'high-traffic'],
    priority: 'high'
  },
  {
    id: 'job-health-nurse',
    type: 'job',
    description: '직업위키 - 간호사 SERP (보건의료 수요)',
    params: {
      keyword: '간호사',
      category: '100070',
      page: 1,
      perPage: 20,
      includeSources: ['CAREERNET', 'GOYONG24']
    },
    schedule: {
      intervalMinutes: 90,
      jitterMinutes: 15,
      allowRuntimeSync: true
    },
    tags: ['healthcare'],
    priority: 'high'
  },
  {
    id: 'job-data-scientist',
    type: 'job',
    description: '직업위키 - 데이터 사이언티스트 SERP (AI/데이터 핵심)',
    params: {
      keyword: '데이터 사이언티스트',
      page: 1,
      perPage: 20,
      includeSources: ['CAREERNET', 'GOYONG24']
    },
    schedule: {
      intervalMinutes: 120,
      jitterMinutes: 20,
      allowRuntimeSync: true
    },
    tags: ['ai', 'growth'],
    priority: 'medium'
  },
  {
    id: 'major-ai',
    type: 'major',
    description: '전공위키 - 인공지능/AI 관련 전공 SERP',
    params: {
      keyword: '인공지능',
      page: 1,
      perPage: 20,
      includeSources: ['CAREERNET', 'GOYONG24']
    },
    schedule: {
      intervalMinutes: 180,
      jitterMinutes: 30,
      allowRuntimeSync: true
    },
    tags: ['ai', 'trend'],
    priority: 'medium'
  },
  {
    id: 'major-nursing',
    type: 'major',
    description: '전공위키 - 간호학과 SERP (보건의료 교육)',
    params: {
      keyword: '간호',
      page: 1,
      perPage: 20,
      includeSources: ['CAREERNET', 'GOYONG24']
    },
    schedule: {
      intervalMinutes: 240,
      jitterMinutes: 30,
      allowRuntimeSync: true
    },
    tags: ['healthcare'],
    priority: 'medium'
  }
]
