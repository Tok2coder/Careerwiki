import type { DataSource, JobRelatedEntity, UnifiedJobDetail } from '../types/unifiedProfiles'
import type { SourceStatus, SourceStatusRecord } from '../services/profileDataService'
import {
  TabEntry,
  BuildCardOptions,
  buildCard,
  buildDetailScaffold,
  DEFAULT_SOURCE_LABELS,
  escapeHtml,
  formatRichText,
  renderChips,
  renderHeroImage,
  renderSourcesPanel,
  sanitizeJson,
  SampleCommentPayload
} from './detailTemplateUtils'
import { composeDetailSlug } from '../utils/slug'
import { mergeJobData, type MergedJobData } from '../services/jobDataMerger'

export interface UnifiedJobDetailTemplateParams {
  profile: UnifiedJobDetail
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  sources?: SourceStatusRecord
  rawApiData?: {
    careernet?: any
    goyong24?: any
  }
}

const SOURCE_DESCRIPTIONS: Record<DataSource, string> = {
  CAREERNET: '교육부 산하 진로·진학 정보 플랫폼',
  GOYONG24: '고용노동부 고용24 직업 정보'
}

const SOURCE_NOTE_LABELS: Record<DataSource, string> = {
  CAREERNET: '커리어넷 데이터',
  GOYONG24: '고용24 데이터'
}

const SKIPPED_REASON_MESSAGES: Record<string, string> = {
  excluded: '제외됨',
  'keyword-required': '키워드 필요',
  'missing-id': '식별자 필요',
  'missing-params': '추가 정보 필요',
  'synthetic-fallback': '샘플 데이터',
  default: '상태 확인 중'
}

const LAWYER_IDENTIFIER_TOKENS = [
  'lawyer',
  '변호사',
  'job:c_375',
  'job-c-375',
  'job:g_k000007482',
  'job-g-k000007482',
  'jobgk000007482',
  'c_375',
  'k000007482'
]

const LAWYER_EXACT_IDS = ['375', 'k000007482']

const matchesLawyerIdentifier = (value?: string | null): boolean => {
  if (!value) {
    return false
  }
  const normalized = value.trim().toLowerCase()
  if (!normalized) {
    return false
  }
  if (LAWYER_EXACT_IDS.includes(normalized)) {
    return true
  }
  return LAWYER_IDENTIFIER_TOKENS.some((token) => normalized.includes(token))
}

const isLawyerProfile = (profile?: UnifiedJobDetail | null): boolean => {
  if (!profile) {
    return false
  }
  if (matchesLawyerIdentifier(profile.id)) {
    return true
  }
  if (matchesLawyerIdentifier(profile.name)) {
    return true
  }
  if (profile.sourceIds) {
    if (matchesLawyerIdentifier(profile.sourceIds.careernet)) {
      return true
    }
    if (matchesLawyerIdentifier(profile.sourceIds.goyong24)) {
      return true
    }
  }
  return false
}

const describeSourceStatus = (source: DataSource, status?: SourceStatus): string => {
  if (!status) {
    return '상태 확인 중'
  }
  if (status.error) {
    return '오류 발생'
  }
  if (typeof status.count === 'number' && status.count > 0) {
    return '실시간 데이터'
  }
  if (status.skippedReason) {
    return SKIPPED_REASON_MESSAGES[status.skippedReason] ?? SKIPPED_REASON_MESSAGES.default
  }
  if (status.attempted) {
    return '응답 없음'
  }
  return '대기 중'
}

const resolveJobTelemetryVariant = (profile: UnifiedJobDetail): string | undefined => {
  const normalizedId = profile?.id?.toLowerCase() ?? ''
  if (normalizedId.includes('growth-marketing-director')) {
    return 'growth-marketing-director-phase1'
  }
  if (isLawyerProfile(profile)) {
    return 'lawyer-live-data-v1'
  }
  return undefined
}

const hasMatrixValue = (value: unknown): boolean => {
  if (value === null || value === undefined) {
    return false
  }
  if (typeof value === 'string') {
    return value.trim().length > 0
  }
  if (Array.isArray(value)) {
    return value.some((item) =>
      hasMatrixValue(
        typeof item === 'string'
          ? item
          : item && typeof item === 'object' && 'name' in item
            ? (item as { name?: string }).name ?? ''
            : item
      )
    )
  }
  if (typeof value === 'object') {
    return Object.values(value as Record<string, unknown>).some((entry) => hasMatrixValue(entry))
  }
  return true
}

const renderMatrixValue = (value: unknown, labelMap?: Record<string, string>): string => {
  if (!hasMatrixValue(value)) {
    return `<span class="text-[11px] text-wiki-muted">제공 안됨</span>`
  }
  if (typeof value === 'string') {
    return value
      .split(/\n+/)
      .map(
        (line, index) =>
          `<p class="text-[11px] leading-relaxed text-wiki-text${index ? ' mt-1' : ''}">${escapeHtml(line.trim())}</p>`
      )
      .join('')
  }
  if (Array.isArray(value)) {
    const items = value
      .map((item) => {
        if (typeof item === 'string') {
          return item.trim()
        }
        if (item && typeof item === 'object' && 'name' in item && typeof (item as { name?: string }).name === 'string') {
          return ((item as { name?: string }).name ?? '').trim()
        }
        return ''
      })
      .filter((item) => item.length > 0)
    if (!items.length) {
      return `<span class="text-[11px] text-wiki-muted">제공 안됨</span>`
    }
    return `<ul class="space-y-1">${items
      .map((item) => `<li class="text-[11px] text-wiki-text">${escapeHtml(item)}</li>`)
      .join('')}</ul>`
  }
  if (value && typeof value === 'object') {
    const entries = Object.entries(value as Record<string, unknown>)
      .map(([key, raw]) => {
        if (typeof raw !== 'string') {
          return null
        }
        const trimmed = raw.trim()
        if (!trimmed) {
          return null
        }
        const label = labelMap?.[key] ?? key
        return { label, value: trimmed }
      })
      .filter((entry): entry is { label: string; value: string } => Boolean(entry))
    if (!entries.length) {
      return `<span class="text-[11px] text-wiki-muted">제공 안됨</span>`
    }
    return `<ul class="space-y-1">${entries
      .map(
        ({ label, value: entryValue }) =>
          `<li class="flex justify-between gap-3 text-[11px]"><span class="text-wiki-muted">${escapeHtml(
            label
          )}</span><span class="text-wiki-text font-semibold">${escapeHtml(entryValue)}</span></li>`
      )
      .join('')}</ul>`
  }
  return `<span class="text-[11px] text-wiki-text">${escapeHtml(String(value))}</span>`
}

/**
 * 직업 내/직업 간 비교 데이터를 렌더링하는 헬퍼 함수
 * Goyong24 API의 비교 데이터를 시각화합니다.
 */
const renderComparisonData = (
  withinJob: any,
  betweenJobs: any,
  title: string,
  icon: string
): string => {
  if (!withinJob && !betweenJobs) {
    return ''
  }

  const blocks: string[] = []

  // 직업 내 비교 (Within Job)
  if (withinJob && Array.isArray(withinJob) && withinJob.length > 0) {
    const withinJobHtml = withinJob
      .slice(0, 10) // 최대 10개 항목
      .map((item: any) => {
        // Goyong24 API 필드명 매핑
        // 성격: chrNmCmpr, chrStatusCmpr
        // 흥미: intrstNmCmpr, intrstStatusCmpr
        // 가치관: valsNmCmpr, valsStatusCmpr
        // 활동: jobActvImprtncNmCmpr, jobActvImprtncStatusCmpr, jobActvLvlNmCmpr, jobActvLvlStatusCmpr
        // 지식: KnwldgNmCmpr, KnwldgStatusCmpr, KnwldgLvlNmCmpr, KnwldgLvlStatusCmpr (대문자 K!)
        // 능력: jobAblNmCmpr, jobAblStatusCmpr, jobAblLvlNmCmpr, jobAblLvlStatusCmpr
        // 업무환경: jobEnvNmCmpr, jobEnvStatusCmpr
        const label = item.chrNmCmpr || item.intrstNmCmpr || item.valsNmCmpr || 
                      item.jobActvImprtncNmCmpr || item.jobActvLvlNmCmpr ||
                      item.KnwldgNmCmpr || item.KnwldgLvlNmCmpr ||
                      item.jobAblNmCmpr || item.jobAblLvlNmCmpr ||
                      item.jobEnvNmCmpr ||
                      item.inform || item.name || item.activity || item.list_content || ''
        const value = item.chrStatusCmpr || item.intrstStatusCmpr || item.valsStatusCmpr ||
                      item.jobActvImprtncStatusCmpr || item.jobActvLvlStatusCmpr ||
                      item.KnwldgStatusCmpr || item.KnwldgLvlStatusCmpr ||
                      item.jobAblStatusCmpr || item.jobAblLvlStatusCmpr ||
                      item.jobEnvStatusCmpr ||
                      item.importance || item.level || item.value || ''
        
        if (!label.trim()) return ''
        
        // value가 있으면 진행 바 표시, 없으면 텍스트만
        if (value) {
          const numericValue = typeof value === 'number' ? value : Number.parseFloat(String(value)) || 0
          // 값이 1-5 범위면 100으로 스케일링 (직업 내 비교)
          const percentage = numericValue <= 5 ? (numericValue / 5) * 100 : Math.min(numericValue, 100)
          
          // 진행 바 색상 결정 (값에 따라)
          const barColor = percentage >= 80 ? 'bg-green-500' : percentage >= 60 ? 'bg-blue-500' : percentage >= 40 ? 'bg-yellow-500' : 'bg-gray-400'
          
          return `
            <div class="mb-4">
              <div class="flex justify-between items-center mb-2">
                <span class="text-sm font-medium text-wiki-text">${escapeHtml(label)}</span>
                <span class="text-sm font-semibold text-wiki-primary">${numericValue.toFixed(1)}</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3 overflow-hidden">
                <div class="${barColor} h-3 rounded-full transition-all duration-300" style="width: ${percentage.toFixed(1)}%"></div>
              </div>
            </div>
          `
        }
        return `<li class="text-sm text-wiki-text">${escapeHtml(label)}</li>`
      })
      .filter(Boolean)
      .join('')

    if (withinJobHtml) {
      blocks.push(`
        <div>
          <h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-3">
            <i class="${icon} mr-2"></i>직업 내 비교
          </h3>
          <div>${withinJobHtml}</div>
        </div>
      `)
    }
  }

  // 직업 간 비교 (Between Jobs)
  if (betweenJobs && Array.isArray(betweenJobs) && betweenJobs.length > 0) {
    const betweenJobsHtml = betweenJobs
      .slice(0, 10) // 최대 10개 항목
      .map((item: any) => {
        // Goyong24 API 필드명 매핑 (직업 간 비교는 Cmpr 없음)
        // 성격: chrNm, chrStatus
        // 흥미: intrstNm, intrstStatus
        // 가치관: valsNm, valsStatus
        // 활동: jobActvImprtncNm, jobActvImprtncStatus, jobActvLvlNm, jobActvLvlStatus
        // 지식: knwldgNm, knwldgStatus, knwldgLvlNm, knwldgLvlStatus (소문자!)
        // 능력: jobAblNm, jobAblStatus, jobAblLvlNm, jobAblLvlStatus
        // 업무환경: jobEnvNm, jobEnvStatus
        const label = item.chrNm || item.intrstNm || item.valsNm ||
                      item.jobActvImprtncNm || item.jobActvLvlNm ||
                      item.knwldgNm || item.knwldgLvlNm ||
                      item.jobAblNm || item.jobAblLvlNm ||
                      item.jobEnvNm ||
                      item.inform || item.name || item.activity || item.list_content || ''
        const value = item.chrStatus || item.intrstStatus || item.valsStatus ||
                      item.jobActvImprtncStatus || item.jobActvLvlStatus ||
                      item.knwldgStatus || item.knwldgLvlStatus ||
                      item.jobAblStatus || item.jobAblLvlStatus ||
                      item.jobEnvStatus ||
                      item.importance || item.level || item.value || ''
        
        if (!label.trim()) return ''
        
        if (value) {
          const numericValue = typeof value === 'number' ? value : Number.parseFloat(String(value)) || 0
          // 직업 간 비교는 0-100 범위 (백분위 점수)
          const percentage = Math.max(0, Math.min(numericValue, 100))
          
          // 진행 바 색상 결정 (백분위 기준)
          const barColor = percentage >= 75 ? 'bg-green-500' : percentage >= 50 ? 'bg-blue-500' : percentage >= 25 ? 'bg-yellow-500' : 'bg-orange-500'
          
          return `
            <div class="mb-4">
              <div class="flex justify-between items-center mb-2">
                <span class="text-sm font-medium text-wiki-text">${escapeHtml(label)}</span>
                <span class="text-sm font-semibold text-wiki-accent">${numericValue.toFixed(0)}%</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3 overflow-hidden">
                <div class="${barColor} h-3 rounded-full transition-all duration-300" style="width: ${percentage}%"></div>
              </div>
            </div>
          `
        }
        return `<li class="text-sm text-wiki-text">${escapeHtml(label)}</li>`
      })
      .filter(Boolean)
      .join('')

    if (betweenJobsHtml) {
      blocks.push(`
        <div class="mt-6">
          <h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-3">
            <i class="${icon} mr-2"></i>직업 간 비교
          </h3>
          <div>${betweenJobsHtml}</div>
        </div>
      `)
    }
  }

  return blocks.join('')
}

// 조사/연구자료 렌더링
const renderResearchList = (researchList: any[]): string => {
  if (!researchList || !Array.isArray(researchList) || researchList.length === 0) {
    return ''
  }

  const items = researchList
    .filter((item) => item && typeof item === 'object' && item.research)
    .map((item, index) => {
      const title = item.research || '연구자료'
      // research 필드는 텍스트만 있고 URL이 없을 수 있음
      
      return `
        <li class="flex items-start gap-3 p-3 rounded-lg bg-wiki-bg/40 border border-wiki-border/30">
          <span class="flex-shrink-0 flex h-8 w-8 items-center justify-center rounded-lg bg-blue-500/20 text-blue-300">
            <i class="fas fa-file-alt text-sm"></i>
          </span>
          <div class="flex-1 min-w-0">
            <p class="text-sm font-medium text-wiki-text">${escapeHtml(title)}</p>
          </div>
        </li>
      `
    })
    .join('')

  if (!items) {
    return ''
  }

  return `
    <section class="glass-card p-6 md:p-7 rounded-3xl border border-wiki-border/70 bg-gradient-to-br from-wiki-bg/90 via-wiki-bg/65 to-wiki-bg/40">
      <header class="flex items-center gap-3 mb-4">
        <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-green-500/30 via-emerald-500/30 to-green-400/20 text-white">
          <i class="fas fa-book-reader text-lg"></i>
        </span>
        <div>
          <h2 class="text-lg sm:text-xl font-bold text-white leading-tight">조사/연구자료</h2>
          <p class="mt-1 text-sm text-wiki-muted">직업 관련 조사 및 연구 자료를 확인하세요</p>
        </div>
      </header>
      <ul class="space-y-2">
        ${items}
      </ul>
    </section>
  `
}

// 태그 렌더링
const renderTags = (tagList: any[]): string => {
  if (!tagList || !Array.isArray(tagList) || tagList.length === 0) {
    return ''
  }

  // tagList는 단순 string[] 배열
  const tags = tagList
    .filter((tag) => typeof tag === 'string' && tag.trim())
    .map((tag) => {
      const tagText = tag.startsWith('#') ? tag : `#${tag}`
      return `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-gradient-to-r from-blue-500/20 to-purple-500/20 border border-blue-400/30 text-sm font-medium text-blue-200 hover:bg-blue-500/30 hover:border-blue-400/50 transition-all duration-200">
          <i class="fas fa-hashtag text-xs text-blue-300"></i>
          ${escapeHtml(tagText.replace('#', ''))}
        </span>
      `
    })
    .join('')

  if (!tags) {
    return ''
  }

  return `
    <section class="glass-card p-6 md:p-7 rounded-3xl border border-wiki-border/70 bg-gradient-to-br from-wiki-bg/90 via-wiki-bg/65 to-wiki-bg/40">
      <header class="flex items-center gap-3 mb-4">
        <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-blue-500/30 via-purple-500/30 to-blue-400/20 text-white">
          <i class="fas fa-tags text-lg"></i>
        </span>
        <div>
          <h2 class="text-lg sm:text-xl font-bold text-white leading-tight">관련 태그</h2>
          <p class="mt-1 text-sm text-wiki-muted">직업과 관련된 키워드를 확인하세요</p>
        </div>
      </header>
      <div class="flex flex-wrap gap-2">
        ${tags}
      </div>
    </section>
  `
}

// 한국의 직업지표 바 차트 렌더링
const renderIndicatorChart = (indicatorData: any[]): string => {
  if (!indicatorData || !Array.isArray(indicatorData) || indicatorData.length === 0) {
    return ''
  }

  // indicatorChart는 배열 형태: [{ indicator: 'name', indicator_data: 'value', source: '...' }]
  const bars = indicatorData
    .filter((item) => item && item.indicator && item.indicator_data)
    .map((item) => {
      const label = item.indicator || '지표'
      const value = item.indicator_data || '0'
      
      const numericValue = typeof value === 'number' ? value : Number.parseFloat(String(value)) || 0
      const percentage = Math.min(numericValue, 100)
      
      // 색상 결정 (높을수록 녹색)
      const barColor = percentage >= 90 ? 'bg-green-500' : percentage >= 80 ? 'bg-blue-500' : percentage >= 70 ? 'bg-yellow-500' : 'bg-orange-500'
      
      return `
        <div class="mb-5">
          <div class="flex justify-between items-center mb-2">
            <span class="text-sm font-medium text-wiki-text flex items-center gap-2">
              <i class="fas fa-chart-bar text-wiki-primary w-4 text-center"></i>
              ${escapeHtml(label)}
            </span>
            <span class="text-sm font-bold text-wiki-primary">${numericValue.toFixed(1)}%</span>
          </div>
          <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-4 overflow-hidden shadow-inner">
            <div class="${barColor} h-4 rounded-full transition-all duration-500 shadow-sm" style="width: ${percentage}%"></div>
          </div>
        </div>
      `
    })
    .join('')

  if (!bars) {
    return ''
  }

  return `
    <section class="glass-card p-6 md:p-7 rounded-3xl border border-wiki-border/70 bg-gradient-to-br from-wiki-bg/90 via-wiki-bg/65 to-wiki-bg/40">
      <header class="flex items-center gap-3 mb-5">
        <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-purple-500/30 via-blue-500/30 to-purple-400/20 text-white">
          <i class="fas fa-chart-bar text-lg"></i>
        </span>
        <div>
          <h2 class="text-lg sm:text-xl font-bold text-white leading-tight">한국의 직업지표</h2>
          <p class="mt-1 text-sm text-wiki-muted">직업백과(커리어넷) 제공 지표</p>
        </div>
      </header>
      <div class="space-y-1">
        ${bars}
      </div>
    </section>
  `
}

const renderLawyerFieldMatrix = (
  profile: UnifiedJobDetail,
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>,
  sources?: SourceStatusRecord,
  telemetryVariant?: string
): string => {
  if (!isLawyerProfile(profile)) {
    return ''
  }

  const careernetProfile = partials?.CAREERNET ?? null
  const goyongProfile = partials?.GOYONG24 ?? null

  if (!careernetProfile && !goyongProfile) {
    return ''
  }

  const matrixRows: Array<{
    key: string
    label: string
    extract: (profile?: UnifiedJobDetail | null) => unknown
    labelMap?: Record<string, string>
  }> = [
    // 기본 정보
    { key: 'summary', label: '직업 소개 (하는 일)', extract: (entry) => entry?.summary },
    { key: 'duties', label: '수행 직무 (주요 업무)', extract: (entry) => entry?.duties },
    { key: 'way', label: '되는 방법 (진입 경로)', extract: (entry) => entry?.way },
    
    // 분류 정보
    {
      key: 'classifications',
      label: '직업 분류 체계',
      extract: (entry) => entry?.classifications ? [
        entry.classifications.large,
        entry.classifications.medium,
        entry.classifications.small
      ].filter(Boolean).join(' > ') : undefined
    },
    {
      key: 'kecoCodes',
      label: '한국표준직업분류 (KECO)',
      extract: (entry) => entry?.kecoCodes?.map((item) => `${item.code} - ${item.name}`).filter((str): str is string => Boolean(str && str.trim()))
    },
    
    // 임금 및 전망
    { key: 'salary', label: '평균 연봉 (임금 수준)', extract: (entry) => entry?.salary },
    { key: 'satisfaction', label: '직업 만족도', extract: (entry) => entry?.satisfaction },
    { key: 'prospect', label: '직업 전망', extract: (entry) => entry?.prospect },
    { key: 'status', label: '고용 형태', extract: (entry) => entry?.status },
    
    // 역량 및 특성
    { key: 'abilities', label: '업무수행능력 (능력)', extract: (entry) => entry?.abilities },
    { key: 'knowledge', label: '지식 중요도 (지식)', extract: (entry) => entry?.knowledge },
    { key: 'technKnow', label: '필요 기술 및 지식', extract: (entry) => entry?.technKnow },
    
    // 성향 및 환경
    { key: 'personality', label: '성격 중요도', extract: (entry) => entry?.personality },
    { key: 'interests', label: '흥미 중요도', extract: (entry) => entry?.interests },
    { key: 'values', label: '가치관 중요도', extract: (entry) => entry?.values },
    { key: 'environment', label: '업무환경 중요도', extract: (entry) => entry?.environment },
    
    // 업무활동
    { key: 'activitiesImportance', label: '업무활동 중요도', extract: (entry) => entry?.activitiesImportance },
    { key: 'activitiesLevels', label: '업무활동 수준', extract: (entry) => entry?.activitiesLevels },
    
    // 교육 및 전공
    {
      key: 'educationDistribution',
      label: '학력 분포',
      extract: (entry) => entry?.educationDistribution,
      labelMap: {
        middleSchoolOrLess: '중학교 이하',
        highSchool: '고등학교',
        college: '전문대',
        university: '대학',
        graduate: '석사 이상',
        doctor: '박사'
      }
    },
    {
      key: 'majorDistribution',
      label: '전공 계열 분포 (전공학과분포)',
      extract: (entry) => entry?.majorDistribution,
      labelMap: {
        humanities: '인문계열',
        social: '사회계열',
        education: '교육계열',
        engineering: '공학계열',
        natural: '자연계열',
        medical: '의약계열',
        artsSports: '예체능'
      }
    },
    {
      key: 'relatedMajors',
      label: '관련 학과 (관련 전공)',
      extract: (entry) => entry?.relatedMajors?.map((item) => item.name).filter((name): name is string => Boolean(name && name.trim()))
    },
    { key: 'relatedCertificates', label: '관련 자격증 (추천 자격)', extract: (entry) => entry?.relatedCertificates },
    
    // 관련 정보
    {
      key: 'relatedJobs',
      label: '관련 직업 (유사 직업)',
      extract: (entry) => entry?.relatedJobs?.map((item) => item.name).filter((name): name is string => Boolean(name && name.trim()))
    },
    {
      key: 'relatedOrganizations',
      label: '관련 기관 (관련 단체)',
      extract: (entry) => entry?.relatedOrganizations?.map((item) => item.name).filter((name): name is string => Boolean(name && name.trim()))
    },
    
    // CareerNet 확장 필드들 (배열 데이터)
    {
      key: 'workList',
      label: '세부 업무 목록',
      extract: (entry) => entry?.workList?.map((item) => `${item.workName}: ${item.workDesc}`).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'performList.environment',
      label: '업무 환경 (중요도별)',
      extract: (entry) => entry?.performList?.environment
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'performList.perform',
      label: '업무 수행 능력 (중요도별)',
      extract: (entry) => entry?.performList?.perform
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'performList.knowledge',
      label: '필요 지식 (중요도별)',
      extract: (entry) => entry?.performList?.knowledge
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'abilityList',
      label: '필요 능력 (점수별)',
      extract: (entry) => entry?.abilityList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'aptitudeList',
      label: '필요 적성 (점수별)',
      extract: (entry) => entry?.aptitudeList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'interestList',
      label: '흥미 유형 (점수별)',
      extract: (entry) => entry?.interestList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'jobReadyList.recruit',
      label: '채용 정보',
      extract: (entry) => entry?.jobReadyList?.recruit
    },
    {
      key: 'jobReadyList.certificate',
      label: '추천 자격증 목록',
      extract: (entry) => entry?.jobReadyList?.certificate
    },
    {
      key: 'jobReadyList.training',
      label: '추천 교육 과정',
      extract: (entry) => entry?.jobReadyList?.training
    },
    {
      key: 'jobReadyList.curriculum',
      label: '관련 교육 과정',
      extract: (entry) => entry?.jobReadyList?.curriculum
    },
    {
      key: 'forecastList',
      label: '미래 전망 상세',
      extract: (entry) => entry?.forecastList?.map((item) => `[${item.period}] ${item.outlook}: ${item.description}`).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'indicatorChart',
      label: '직업 지표',
      extract: (entry) => entry?.indicatorChart?.map((item) => `${item.category}: ${item.value} (${item.description})`).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'relVideoList',
      label: '관련 영상 자료',
      extract: (entry) => entry?.relVideoList?.map((item) => `${item.title} [${item.duration}]`).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'relSolList',
      label: '관련 자료',
      extract: (entry) => entry?.relSolList?.map((item) => item.title).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'relJinsolList',
      label: '진로 상담 자료',
      extract: (entry) => entry?.relJinsolList?.map((item) => item.title).filter((str): str is string => Boolean(str && str.trim()))
    },
    {
      key: 'researchList',
      label: '연구 자료',
      extract: (entry) => entry?.researchList?.map((item) => `${item.title} (${item.author}, ${item.date})`).filter((str): str is string => Boolean(str && str.trim()))
    }
  ]

  const matrixSources: Array<{ key: DataSource; label: string }> = [
    { key: 'CAREERNET', label: DEFAULT_SOURCE_LABELS.CAREERNET ?? 'CAREERNET' },
    { key: 'GOYONG24', label: DEFAULT_SOURCE_LABELS.GOYONG24 ?? 'GOYONG24' }
  ]

  const rowsMarkup = matrixRows
    .map((row) => {
      const cells = matrixSources.map(({ key }) => {
        const partialProfile = key === 'CAREERNET' ? careernetProfile : goyongProfile
        const rawValue = row.extract(partialProfile)
        const status = sources?.[key]
        const statusLabel = describeSourceStatus(key, status)
        const content = renderMatrixValue(rawValue, row.labelMap)
        return {
          hasValue: hasMatrixValue(rawValue),
          markup: `
            <td
              class="align-top px-4 py-3"
              data-cw-telemetry-component="job-source-matrix-cell"
              data-source-group="${escapeHtml(key)}"
              data-source-status="${escapeHtml(statusLabel)}"
            >
              ${content}
            </td>
          `
        }
      })

      if (!cells.some((cell) => cell.hasValue)) {
        return ''
      }

      return `
        <tr data-cw-telemetry-component="job-source-matrix-row" data-matrix-field="${escapeHtml(row.key)}">
          <th scope="row" class="bg-wiki-bg/60 px-4 py-3 text-[11px] font-semibold text-wiki-text">
            ${escapeHtml(row.label)}
          </th>
          ${cells.map((cell) => cell.markup).join('')}
        </tr>
      `
    })
    .filter((row) => row && row.trim().length > 0)
    .join('')

  if (!rowsMarkup) {
    return ''
  }

  const variantAttr = telemetryVariant ? ` data-cw-telemetry-variant="${escapeHtml(telemetryVariant)}"` : ''

  const headerMarkup = matrixSources
    .map(({ key, label }) => {
      const status = sources?.[key]
      const statusLabel = describeSourceStatus(key, status)
      const caption = statusLabel ? `<span class="mt-0.5 block text-[10px] text-wiki-muted">${escapeHtml(statusLabel)}</span>` : ''
      return `
        <th
          scope="col"
          class="px-4 py-3 text-[11px] font-semibold text-wiki-text"
          data-cw-telemetry-component="job-source-matrix-header"
          data-source-group="${escapeHtml(key)}"
          data-source-status="${escapeHtml(statusLabel)}"
        >
          ${escapeHtml(label)}
          ${caption}
        </th>
      `
    })
    .join('')

  return `
    <div class="space-y-3" data-job-source-matrix data-cw-telemetry-scope="job-source-matrix"${variantAttr}>
      <p class="text-xs text-wiki-muted leading-relaxed">
        CareerNet과 고용24가 제공한 법조 직업 데이터를 필드별로 비교한 매트릭스입니다.
      </p>
      <div class="overflow-x-auto rounded-xl border border-wiki-border/60" data-cw-telemetry-component="job-source-matrix">
        <table class="min-w-full divide-y divide-wiki-border/60 text-left">
          <thead class="bg-wiki-bg/70 text-[11px] uppercase tracking-wide text-wiki-muted">
            <tr>
              <th scope="col" class="px-4 py-3 font-semibold text-wiki-text">필드</th>
              ${headerMarkup}
            </tr>
          </thead>
          <tbody class="divide-y divide-wiki-border/40 text-[11px] text-wiki-text/90">
            ${rowsMarkup}
          </tbody>
        </table>
      </div>
    </div>
  `
}

const buildEntityUrl = (entity: JobRelatedEntity, type: 'job' | 'major'): string => {
  const identifier = entity?.id?.trim()
  if (!identifier && !entity?.name?.trim()) return '#'
  const slug = composeDetailSlug(type, entity?.name, identifier ?? entity.name)
  return `/${type}/${encodeURIComponent(slug)}`
}

const renderEntityList = (entities?: JobRelatedEntity[] | null, type: 'job' | 'major', emptyText = '정보 없음'): string => {
  if (!entities || entities.length === 0) {
    return `<p class="text-sm text-wiki-muted">${escapeHtml(emptyText)}</p>`
  }

  return `
    <div class="flex flex-col gap-2">
      ${entities
        .filter((entity) => !!entity?.name?.trim())
        .map((entity) => {
          const name = escapeHtml(entity.name.trim())
          const url = buildEntityUrl(entity, type)
          return `<a href="${url}" class="text-sm text-wiki-primary hover:text-wiki-secondary transition">${name}</a>`
        })
        .join('')}
    </div>
  `
}

const renderDistributionList = (distribution?: Record<string, string | undefined> | null, labels?: Record<string, string>): string => {
  if (!distribution) {
    return ''
  }

  const entries = Object.entries(distribution)
    .filter(([, value]) => !!value && !!value.trim())
    .map(([key, value]) => ({
      label: labels?.[key] ?? key,
      value: value!.trim()
    }))

  if (entries.length === 0) {
    return ''
  }

  return `
    <ul class="space-y-2">
      ${entries
        .map(({ label, value }) => `
          <li class="flex justify-between text-xs">
            <span class="text-wiki-muted">${escapeHtml(label)}</span>
            <span class="text-wiki-text font-semibold">${escapeHtml(value)}</span>
          </li>
        `)
        .join('')}
    </ul>
  `
}

const formatSalaryValue = (value: number): string => `${value.toLocaleString('ko-KR')}만원`

const renderSalaryCard = (salary?: string | null, options?: BuildCardOptions): string => {
  if (!salary || !salary.trim()) {
    return ''
  }

  const raw = salary.trim()
  
  // 고용24 형식 파싱: "하위(25%) 8450만원, 평균(50%) 10000만원, 상위(25%) 14200만원"
  const goyong24Pattern = /하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/
  const goyong24Match = raw.match(goyong24Pattern)
  
  let dataset: { label: string; value: number }[] = []
  
  if (goyong24Match) {
    // 고용24 데이터 파싱
    const lower = Number.parseInt(goyong24Match[1].replace(/,/g, ''), 10)
    const median = Number.parseInt(goyong24Match[2].replace(/,/g, ''), 10)
    const upper = Number.parseInt(goyong24Match[3].replace(/,/g, ''), 10)
    
    dataset = [
      { label: '하위 25%', value: lower },
      { label: '평균 50%', value: median },
      { label: '상위 25%', value: upper }
    ]
  } else {
    // 기존 로직 (범위 또는 일반 숫자)
    const matches = raw.match(/(\d[\d,]*)/g)
    if (!matches || !matches.length) {
      return buildCard('임금 정보', 'fa-coins', `<p class="text-sm text-wiki-text">${escapeHtml(raw)}</p>`, options ?? {})
    }

    const values = matches
      .map((value) => Number.parseInt(value.replace(/,/g, ''), 10))
      .filter((value) => Number.isFinite(value) && value > 0)

    if (!values.length) {
      return buildCard('임금 정보', 'fa-coins', `<p class="text-sm text-wiki-text">${escapeHtml(raw)}</p>`, options ?? {})
    }

    const hasRange = raw.includes('~') && values.length >= 2
    dataset = hasRange
      ? [
          { label: '하한', value: values[0] },
          { label: '상한', value: values[1] }
        ]
      : values.map((value, index) => ({
          label: index === 0 ? '평균' : `지표 ${index + 1}`,
          value
        }))
  }

  const maxValue = Math.max(...dataset.map((item) => item.value))
  const barMarkup = dataset
    .map(({ label, value }) => {
      const percent = maxValue === 0 ? 0 : Math.round((value / maxValue) * 100)
      const width = Math.min(100, Math.max(12, percent))
      return `
        <div class="space-y-1" data-cw-telemetry-component="job-salary-bar">
          <div class="flex justify-between text-[11px] text-wiki-muted">
            <span>${escapeHtml(label)}</span>
            <span>${formatSalaryValue(value)}</span>
          </div>
          <div class="h-2 rounded-full bg-wiki-border/40 overflow-hidden">
            <div class="h-full bg-gradient-to-r from-wiki-primary to-wiki-secondary" style="width:${width}%"></div>
          </div>
        </div>
      `
    })
    .join('')

  // 조사년도 추출
  const yearMatch = raw.match(/조사년도\s*[:：]?\s*(\d{4})\s*년?/)
  const yearInfo = yearMatch ? `조사년도: ${yearMatch[1]}년` : ''
  
  // 출처 정보 (고용24 데이터인 경우)
  const source = goyong24Match ? '출처: 고용24' : '출처: 커리어넷'
  const footerText = yearInfo ? `${yearInfo} | ${source}` : source

  return buildCard(
    '임금 정보',
    'fa-coins',
    `
      <div class="space-y-4" data-cw-telemetry-component="job-salary-card">
        <div class="space-y-2">${barMarkup}</div>
        <p class="text-xs text-wiki-muted leading-relaxed">${escapeHtml(footerText)}</p>
      </div>
    `,
    options ?? {}
  )
}

/**
 * 파이 차트로 분포 데이터를 렌더링하는 함수
 * Chart.js를 사용하여 시각화
 */
const renderDistributionPieChart = (
  title: string,
  icon: string,
  distribution?: Record<string, string | undefined> | null,
  labels?: Record<string, string>,
  options?: BuildCardOptions
): string => {
  if (!distribution) {
    return ''
  }

  const entries = Object.entries(distribution)
    .filter(([, value]) => typeof value === 'string' && value.trim().length > 0)

  if (!entries.length) {
    return ''
  }

  const parsed = entries.map(([key, value]) => {
    const label = labels?.[key] ?? key
    const raw = value!.trim()
    const numericMatch = raw.match(/(\d+(?:[.,]\d+)?)/)
    const numeric = numericMatch ? Number.parseFloat(numericMatch[1].replace(',', '.')) : null
    return {
      key,
      label,
      raw,
      numeric: Number.isFinite(numeric) ? numeric : null
    }
  })

  const numericEntries = parsed.filter((entry) => entry.numeric !== null)

  if (!numericEntries.length) {
    const listMarkup = renderDistributionList(distribution, labels)
    return listMarkup ? buildCard(title, icon, listMarkup) : ''
  }

  // 고유 ID 생성
  const chartId = `chart-${normalizeAnchorValue(title)}-${Date.now()}`
  
  // 차트 데이터 준비
  const chartLabels = numericEntries.map(e => e.label)
  const chartData = numericEntries.map(e => e.numeric)
  const chartColors = [
    'rgba(59, 130, 246, 0.8)',  // blue
    'rgba(16, 185, 129, 0.8)',  // green
    'rgba(251, 146, 60, 0.8)',  // orange
    'rgba(168, 85, 247, 0.8)',  // purple
    'rgba(236, 72, 153, 0.8)',  // pink
    'rgba(245, 158, 11, 0.8)',  // amber
    'rgba(20, 184, 166, 0.8)',  // teal
    'rgba(239, 68, 68, 0.8)'    // red
  ]

  const chartHtml = `
    <div class="flex flex-col lg:flex-row gap-6 items-center">
      <div class="w-full lg:w-1/2 max-w-xs mx-auto">
        <canvas id="${chartId}"></canvas>
      </div>
      <div class="w-full lg:w-1/2 space-y-2">
        ${numericEntries.map((entry, idx) => `
          <div class="flex items-center justify-between text-sm">
            <div class="flex items-center gap-2">
              <div class="w-3 h-3 rounded-full" style="background-color: ${chartColors[idx % chartColors.length]}"></div>
              <span class="text-wiki-text">${escapeHtml(entry.label)}</span>
            </div>
            <span class="font-semibold text-wiki-primary">${entry.raw}</span>
          </div>
        `).join('')}
      </div>
    </div>
    <script>
      (function() {
        const ctx = document.getElementById('${chartId}');
        if (ctx && typeof Chart !== 'undefined') {
          new Chart(ctx, {
            type: 'doughnut',
            data: {
              labels: ${JSON.stringify(chartLabels)},
              datasets: [{
                data: ${JSON.stringify(chartData)},
                backgroundColor: ${JSON.stringify(chartColors.slice(0, numericEntries.length))},
                borderWidth: 2,
                borderColor: '#ffffff'
              }]
            },
            options: {
              responsive: true,
              maintainAspectRatio: true,
              plugins: {
                legend: {
                  display: false
                },
                tooltip: {
                  callbacks: {
                    label: function(context) {
                      const label = context.label || '';
                      const value = context.parsed || 0;
                      const total = context.dataset.data.reduce((a, b) => a + b, 0);
                      const percentage = ((value / total) * 100).toFixed(1);
                      return label + ': ' + value + ' (' + percentage + '%)';
                    }
                  }
                }
              }
            }
          });
        }
      })();
    </script>
  `

  return buildCard(title, icon, chartHtml, options ?? {})
}

const renderDistributionBars = (
  title: string,
  icon: string,
  distribution?: Record<string, string | undefined> | null,
  labels?: Record<string, string>,
  options?: BuildCardOptions
): string => {
  if (!distribution) {
    return ''
  }

  const entries = Object.entries(distribution)
    .filter(([, value]) => typeof value === 'string' && value.trim().length > 0)

  if (!entries.length) {
    return ''
  }

  const parsed = entries.map(([key, value]) => {
    const label = labels?.[key] ?? key
    const raw = value!.trim()
    const numericMatch = raw.match(/(\d+(?:[.,]\d+)?)/)
    const numeric = numericMatch ? Number.parseFloat(numericMatch[1].replace(',', '.')) : null
    return {
      label,
      raw,
      numeric: Number.isFinite(numeric) ? numeric : null
    }
  })

  const numericEntries = parsed.filter((entry) => entry.numeric !== null)

  if (!numericEntries.length) {
    const listMarkup = renderDistributionList(distribution, labels)
    return listMarkup ? buildCard(title, icon, listMarkup) : ''
  }

  const maxValue = Math.max(...numericEntries.map((entry) => entry.numeric!))
  const bars = parsed
    .map((entry) => {
      if (entry.numeric === null || maxValue === 0) {
        return `
          <div class="flex justify-between text-sm text-wiki-muted">
            <span>${escapeHtml(entry.label)}</span>
            <span>${escapeHtml(entry.raw)}</span>
          </div>
        `
      }
      const width = Math.min(100, Math.max(10, Math.round((entry.numeric! / maxValue) * 100)))
      return `
        <div class="space-y-1" data-cw-telemetry-component="job-distribution-bar">
          <div class="flex justify-between text-[11px] text-wiki-muted">
            <span>${escapeHtml(entry.label)}</span>
            <span>${escapeHtml(entry.raw)}</span>
          </div>
          <div class="h-2 rounded-full bg-wiki-border/40 overflow-hidden">
            <div class="h-full bg-gradient-to-r from-wiki-secondary/80 to-wiki-primary/80" style="width:${width}%"></div>
          </div>
        </div>
      `
    })
    .join('')

  return buildCard(title, icon, `<div class="space-y-3">${bars}</div>`, options ?? {})
}

const normalizeAnchorValue = (value: string): string => {
  if (!value) {
    return ''
  }
  return value
    .normalize('NFKC')
    .replace(/[^0-9A-Za-z가-힣\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .toLowerCase()
}

const createAnchorIdFactory = (entityId: string) => {
  const registry = new Set<string>()
  const fallbackBase = normalizeAnchorValue(entityId) || 'section'
  return (prefix: 'overview' | 'details', title: string) => {
    const normalizedTitle = normalizeAnchorValue(title)
    const base = normalizeAnchorValue(`${prefix}-${normalizedTitle || fallbackBase}`)
    const fallback = `${prefix}-${fallbackBase}`
    let candidate = base || fallback
    if (!candidate) {
      candidate = `${prefix}-section`
    }
    let attempt = 1
    while (registry.has(candidate)) {
      const suffixBase = base || fallback || `${prefix}-section`
      candidate = `${suffixBase}-${attempt}`.replace(/-+/g, '-')
      attempt += 1
    }
    registry.add(candidate)
    return candidate
  }
}

type SectionCardDescriptor = { id: string; label: string; icon: string; markup: string }

type TocItem = { id: string; label: string; icon: string }

const renderSectionToc = (sectionKey: 'overview' | 'details', heading: string, items: TocItem[]): string => {
  if (!items.length) {
    return ''
  }

  const headingIcon = sectionKey === 'overview' ? 'fa-list-check' : 'fa-layer-group'

  const listMarkup = items
    .map((item, index) => `
        <li data-toc-order="${index + 1}">
          <a
            href="#${escapeHtml(item.id)}"
            class="flex items-center gap-3 rounded-xl border border-transparent bg-wiki-bg/45 px-4 py-3 text-sm text-wiki-muted transition hover:text-white hover:border-wiki-primary/60"
            data-cw-telemetry-action="toc-link"
            data-cw-telemetry-component="section-toc-link"
            data-cw-telemetry-scope="${sectionKey}-toc"
            data-toc-target="${escapeHtml(item.id)}"
            data-toc-index="${index}"
          >
            <span class="flex h-7 w-7 items-center justify-center rounded-full bg-wiki-primary/25 text-xs font-semibold text-wiki-primary">
              ${index + 1}
            </span>
            <span class="text-sm text-wiki-text">${escapeHtml(item.label)}</span>
          </a>
        </li>
      `)
    .join('')

  return `
    <nav
      class="glass-card p-6 rounded-2xl border border-wiki-border/60 bg-wiki-bg/70"
      data-section-toc="${sectionKey}"
      data-cw-telemetry-scope="${sectionKey}-toc"
      data-cw-telemetry-component="section-toc"
      role="navigation"
      aria-label="${escapeHtml(heading)}"
    >
      <header class="mb-4 flex items-center gap-3">
        <span class="flex h-10 w-10 items-center justify-center rounded-2xl bg-wiki-primary/15 text-wiki-primary">
          <i class="fas ${headingIcon} text-lg" aria-hidden="true"></i>
        </span>
        <h3 class="text-lg sm:text-xl font-bold text-white leading-tight">${escapeHtml(heading)}</h3>
      </header>
      <ol class="space-y-2 list-none" data-section-toc-items>
        ${listMarkup}
      </ol>
    </nav>
  `
}

const resolveRecommendedHowtos = (jobId: string): Array<{ label: string; href: string }> => {
  const normalized = jobId.toLowerCase()
  if (normalized === 'growth-marketing-director') {
    return [
      { label: '법무법인 SEO 성장 플레이북', href: '/howto/seo-growth-playbook' },
      { label: 'AI 프로덕트 로드맵 스프린트', href: '/howto/ai-product-roadmap' }
    ]
  }
  if (normalized === 'ai-product-strategist') {
    return [
      { label: 'AI 프로덕트 로드맵 스프린트', href: '/howto/ai-product-roadmap' },
      { label: '법무법인 SEO 성장 플레이북', href: '/howto/seo-growth-playbook' }
    ]
  }
  if (
    normalized === 'job:g_k000007482' ||
    normalized === 'job:c_375' ||
    normalized === 'lawyer' ||
    normalized.includes('lawyer')
  ) {
    return [
      { label: '로펌 비즈니스 개발 전략 캔버스', href: '/howto/law-firm-business-development' },
      { label: 'AI 리걸 리서치 워크플로우 설계', href: '/howto/legal-ai-research' }
    ]
  }
  return []
}

const renderSidebarSection = (title: string, icon: string, body: string): string => {
  if (!body || !body.trim()) {
    return ''
  }

  return `
    <section class="glass-card p-5 rounded-2xl space-y-3" data-job-sidebar-section>
      <div class="flex items-center gap-2 text-sm font-semibold text-white">
        <i class="fas ${icon} text-wiki-secondary" aria-hidden="true"></i>
        <span>${escapeHtml(title)}</span>
      </div>
      ${body}
    </section>
  `
}

const renderJobSidebar = (profile: UnifiedJobDetail): string => {
  const sections: string[] = []

  if (profile.relatedJobs?.length) {
    sections.push(
      renderSidebarSection(
        '연관 직업',
        'fa-user-tie',
        renderEntityList(profile.relatedJobs, 'job', '연관 직업 정보가 준비 중입니다.')
      )
    )
  }

  if (profile.relatedMajors?.length) {
    sections.push(
      renderSidebarSection(
        '관련 전공',
        'fa-graduation-cap',
        renderEntityList(profile.relatedMajors, 'major', '관련 전공 정보가 준비 중입니다.')
      )
    )
  }

  const recommendedHowtos = resolveRecommendedHowtos(profile.id)
  if (recommendedHowtos.length) {
    const list = recommendedHowtos
      .map(
        (item) => `
          <li>
            <a href="${escapeHtml(item.href)}" class="flex flex-col gap-1 rounded-lg border border-wiki-border/70 bg-wiki-bg/60 px-4 py-3 text-sm text-wiki-primary hover:border-wiki-primary hover:text-white transition">
              <span class="font-semibold">${escapeHtml(item.label)}</span>
              <span class="text-xs text-wiki-muted">CareerWiki HowTo</span>
            </a>
          </li>
        `
      )
      .join('')
    sections.push(
      renderSidebarSection(
        '관련 HowTo',
        'fa-route',
        `<ul class="space-y-2" role="list">${list}</ul>`
      )
    )
  }

  const organizations = renderOrganizationsList(profile)
  if (organizations) {
    sections.push(renderSidebarSection('관련 기관', 'fa-building', organizations))
  }

  if (profile.relatedCertificates?.length) {
    sections.push(
      renderSidebarSection(
        '추천 자격증',
        'fa-certificate',
        renderChips(profile.relatedCertificates, '추천 자격증 정보가 없습니다.')
      )
    )
  }

  return sections.filter((section) => section && section.trim().length > 0).join('')
}

const renderSourcesCollapsible = (
  profile: UnifiedJobDetail,
  sources?: SourceStatusRecord,
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
): string => {
  // 변호사 페이지는 데이터 출처 패널 표시하지 않음
  if (isLawyerProfile(profile)) {
    return ''
  }

  const normalizedId = profile.id.replace(/[^a-z0-9]+/gi, '-').toLowerCase() || 'default'
  const panelId = `job-source-panel-${normalizedId}`

  const panel = renderSourcesPanel({
    profile,
    sources,
    partials,
    labels: DEFAULT_SOURCE_LABELS,
    descriptions: SOURCE_DESCRIPTIONS,
    title: '출처',
    description: '이 페이지에 노출된 주요 데이터 출처를 확인할 수 있습니다.'
  })

  if (!panel || !panel.trim()) {
    return ''
  }

  const activeSourceCount = partials ? Object.values(partials).filter((value) => Boolean(value)).length : 0
  const badgeLabel = activeSourceCount > 0 ? `${activeSourceCount}개 활성` : '확인하기'

  return `
    <section class="glass-card p-0 rounded-2xl border border-wiki-border/60 bg-wiki-bg/50" data-source-collapsible>
      <button
        type="button"
        class="w-full flex items-center justify-between gap-3 px-5 py-4 text-sm font-semibold text-white transition hover:text-white"
        data-source-toggle
        aria-controls="${panelId}"
        aria-expanded="false"
      >
        <span class="flex items-center gap-2">
          <i class="fas fa-database text-wiki-secondary" aria-hidden="true"></i>
          데이터 출처
        </span>
        <div class="flex items-center gap-2 text-[11px] text-wiki-muted">
          <span class="inline-flex items-center gap-1 rounded-full border border-wiki-border/60 bg-wiki-bg/60 px-2 py-1">${escapeHtml(badgeLabel)}</span>
          <i class="fas fa-chevron-down text-xs transition-transform duration-200" aria-hidden="true" data-source-toggle-icon></i>
        </div>
      </button>
      <div class="border-t border-wiki-border/60 hidden bg-wiki-bg/45 px-5 py-4" data-source-panel id="${panelId}">
        ${panel}
      </div>
    </section>
  `
}

const buildJobDemoComments = (profile: UnifiedJobDetail): SampleCommentPayload[] => {
  const now = Date.now()
  const hoursAgo = (hours: number) => new Date(now - hours * 60 * 60 * 1000).toISOString()
  const prefix = (profile.id || profile.name || 'job').replace(/[^a-z0-9]+/gi, '-').toLowerCase()

  type CommentSeed = Omit<SampleCommentPayload, 'id' | 'createdAt'> & { hoursAgo: number }

  const toPayloads = (seeds: CommentSeed[]): SampleCommentPayload[] =>
    seeds.map((seed, index) => ({
      ...seed,
      id: `${prefix}-c${String(index + 1).padStart(2, '0')}`,
      createdAt: hoursAgo(seed.hoursAgo)
    }))

  const normalizedId = (profile.id ?? '').toLowerCase()
  const normalizedName = (profile.name ?? '').toLowerCase()

  if (normalizedId === 'growth-marketing-director' || normalizedName.includes('growth')) {
    const seeds: CommentSeed[] = [
      {
        author: 'GrowthMarketer_J',
        content: `${profile.name} 역할의 핵심은 퍼널 전 구간 데이터를 매일 점검하면서 실험 캘린더를 돌리는 겁니다. ARR 20억대 SaaS에서 주 1회 테스트 속도로 ROAS를 2배 끌어올린 경험이 있어요.`,
        likes: 24,
        hoursAgo: 6,
        role: 'expert',
        badge: 'TOP 성장 사례'
      },
      {
        author: '데이터혜윰',
        content: '데이터레이크를 직접 다루지 못하면 성장 속도가 확 떨어집니다. Looker Studio 대신 dbt + Metabase 조합으로 팀 공용 대시보드 만들었더니 실험 승인 속도가 40% 줄었어요.',
        likes: 17,
        hoursAgo: 9,
        badge: '데이터 팀 추천'
      },
      {
        author: 'Collaborative_CMO',
        content: '세일즈 팀과 OKR을 묶어야 성과가 나옵니다. 마케팅만 성장 지표를 책임지면 LTV 계산이 느슨해져서 CAC-LTV 밸런스가 망가져요.',
        likes: 12,
        hoursAgo: 15
      },
      {
        author: '실험러버',
        content: '연간 그로스 로드맵을 분기별 미션으로 쪼개두면 좋지만, 실무에서는 긴급 실험 요청이 계속 들어옵니다. 백로그 우선순위 테이블 꼭 준비하세요.',
        likes: 9,
        dislikes: 2,
        hoursAgo: 20
      },
      {
        author: 'BudgetWatcher',
        content: '광고 집행을 성장팀이 직접 가져가는 건 동의하지만, PMM과 역할이 겹치면서 혼선이 있었습니다. 역할 정의를 분명히 하지 않으면 팀 갈등 생겨요.',
        dislikes: 5,
        hoursAgo: 26
      },
      {
        author: 'GrowthOps_Junior',
        content: '입사 후 첫 분기엔 메타 광고보다 CRM 자동화가 더 임팩트 컸어요. 사용자의 라이프사이클을 먼저 이해하면 손쉬운 승리가 생깁니다.',
        hoursAgo: 30
      },
      {
        author: 'AIStack_Builder',
        content: 'Generative AI를 마케팅 자동화에 붙일 때는 개인정보 처리 이슈가 있습니다. 법무 검토 프로세스를 미리 만들어두세요.',
        hoursAgo: 36
      },
      {
        author: 'UX리서처_겸임',
        content: 'UX 리서치 결과를 바로 실험 설계에 녹여내는 파트너십이 중요했어요. 세일즈 콜 녹취를 Growth 팀이 직접 코딩하면 인사이트가 빨라집니다.',
        hoursAgo: 44
      },
      {
        author: 'KPI정비중',
        content: '전환 지표만 보면 채널 믹스가 왜곡돼서 NPS 등 정성 지표를 함께 봤습니다. OKR 정렬이 안 되면 성장 팀이 소방수로만 움직여요.',
        hoursAgo: 55
      },
      {
        author: 'OnboardingPM',
        content: '온보딩 플로우와 리텐션 코호트 보는 법을 먼저 익히면 좋습니다. 퀵윈은 A/B 테스트보다도 이메일 시퀀스 최적화에서 나왔어요.',
        hoursAgo: 68
      }
    ]
    return toPayloads(seeds)
  }

  if (
    normalizedName.includes('변호사') ||
    normalizedId.includes('lawyer') ||
    normalizedId === 'job:g_k000007482' ||
    normalizedId === 'job:c_375'
  ) {
    const seeds: CommentSeed[] = [
      {
        author: '법조인턴_민지',
        content: `${profile.name} 준비하면서 로스쿨 진학보다 사법연수원 동기 네트워킹이 더 큰 자산이었어요. 수습 기간에는 사건 기록 정리가 가장 큰 업무입니다.`,
        likes: 19,
        hoursAgo: 5,
        badge: '로스쿨 현장 노트'
      },
      {
        author: 'Litigator_J',
        content: '대형로펌에서 ${profile.name}로 일하면서 가장 많이 배우는 건 증거 인멸 방지와 증인 신뢰도 관리입니다. 초기 변론에서 스토리라인을 탄탄히 짜두세요.',
        likes: 14,
        hoursAgo: 11,
        role: 'expert',
        badge: '민사 소송 실무'
      },
      {
        author: 'LawTech_AI',
        content: '최근 AI 리서치툴을 쓰면 판례 검색 시간이 절반으로 줄어요. 다만 개인정보 이슈 때문에 로펌 내 보안 가이드를 따라야 합니다.',
        likes: 11,
        hoursAgo: 16
      },
      {
        author: '공익변호사_서준',
        content: '공익 사건이 많으면 매출 KPI를 맞추기 어렵지만 브랜드 평판에는 큰 도움이 됩니다. 시간 배분을 잘해야 번아웃을 피할 수 있어요.',
        likes: 7,
        hoursAgo: 23
      },
      {
        author: '로펌매니저_혜진',
        content: '로펌에서 ${profile.name} 분들을 지원하려면 일정·자료 관리 시스템을 정비해야 합니다. 특히 변론기일 캘린더는 이중화가 필수예요.',
        hoursAgo: 31
      },
      {
        author: '사법연수원40기',
        content: '연수원 동기들과 사건 공동 수임을 많이 하게 됩니다. 사건 유형별로 템플릿을 만들어두면 커뮤니케이션이 쉬워요.',
        likes: 5,
        hoursAgo: 42
      },
      {
        author: '법률마케팅전문가_JW',
        content: '${profile.name} 페이지에 실시간 판례·칼럼을 연결하면 상담 문의 전환율이 30% 이상 올라갑니다. SEO와 연동하면 신규 의뢰 확보에 효과적이에요.',
        likes: 8,
        hoursAgo: 50,
        badge: 'SEO & Growth'
      },
      {
        author: 'InHouseCounsel_K',
        content: '인하우스 ${profile.name}는 계약 검토보다 컴플라이언스 프로세스 설계 비중이 늘어나고 있어요. 사내 교육 자료를 미리 만들어두면 협업이 쉽습니다.',
        hoursAgo: 60
      }
    ]
    return toPayloads(seeds)
  }

  const seeds: CommentSeed[] = [
    {
      author: 'Careerwiki_User',
      content: `${profile.name} 역할에 관심 있는 분들은 실제 업무 일과표와 필요한 역량을 먼저 정리해보세요.`,
      likes: 4,
      hoursAgo: 12
    },
    {
      author: 'SkillMapper',
      content: '필수 역량과 Nice-to-have 스킬을 분리해두면 학습 로드맵이 선명해집니다. 일주일 단위로 리소스를 배분해보세요.',
      hoursAgo: 18
    },
    {
      author: 'Mentor_J',
      content: `${profile.name} 현업 멘토를 인터뷰해 보면 공부해야 할 우선순위를 빠르게 잡을 수 있습니다.`,
      likes: 2,
      hoursAgo: 28
    },
    {
      author: 'Transitioner',
      content: '커리어 전환을 생각한다면 관련 직무의 사이드 프로젝트를 먼저 진행해보세요. 작은 실험이 자신감을 줍니다.',
      hoursAgo: 35
    },
    {
      author: 'CuriousMind',
      content: 'CareerWiki HowTo 가이드를 읽고 나만의 학습 노트를 만들어 공유하면 커뮤니티 피드백을 받기 좋습니다.',
      hoursAgo: 48
    }
  ]
  return toPayloads(seeds)
}

const STAT_CARD_ACCENTS = [
  {
    halo: 'bg-wiki-primary/20',
    iconBg: 'bg-gradient-to-br from-wiki-primary/35 via-wiki-secondary/35 to-wiki-primary/15 text-white'
  },
  {
    halo: 'bg-wiki-secondary/25',
    iconBg: 'bg-gradient-to-br from-wiki-secondary/30 via-wiki-primary/30 to-wiki-secondary/15 text-white'
  },
  {
    halo: 'bg-wiki-border/35',
    iconBg: 'bg-gradient-to-br from-wiki-bg/30 via-wiki-border/40 to-wiki-primary/20 text-white'
  },
  {
    halo: 'bg-wiki-primary/25',
    iconBg: 'bg-gradient-to-br from-wiki-primary/30 via-wiki-secondary/35 to-wiki-primary/20 text-white'
  }
] as const

const renderQuickStats = (
  profile: UnifiedJobDetail,
  sourceNote?: (source: DataSource | string) => string,
  telemetryVariant?: string
): string => {
  // 변호사 페이지는 Quick Stats 표시하지 않음
  if (isLawyerProfile(profile)) {
    return ''
  }

  const stats = [
    { label: '평균 연봉', value: profile.salary, icon: 'fa-coins', source: 'GOYONG24' as DataSource },
    { label: '직업 전망', value: profile.prospect, icon: 'fa-chart-line', source: 'GOYONG24' as DataSource },
    { label: '직무 만족도', value: profile.satisfaction, icon: 'fa-face-smile', source: 'CAREERNET' as DataSource }
  ].filter((stat) => typeof stat.value === 'string' && stat.value.trim().length > 0)

  if (!stats.length) {
    return ''
  }

  const valueMarkup = (raw: string): string => {
    const trimmed = raw.trim()
    if (!trimmed.length) {
      return ''
    }
    const [primary, ...rest] = trimmed.split(/\n+/)
    const primaryMarkup = `<p class="text-sm font-semibold text-white leading-snug" data-stat-value-primary>${escapeHtml(primary)}</p>`
    const secondaryMarkup = rest
      .map((line, index) => `<p class="text-xs text-wiki-muted leading-snug ${index === 0 ? 'mt-1' : 'mt-0.5'}" data-stat-value-secondary>${escapeHtml(line)}</p>`)
      .join('')
    return `${primaryMarkup}${secondaryMarkup}`
  }

  const accents = (index: number) => STAT_CARD_ACCENTS[index % STAT_CARD_ACCENTS.length]

  const variantAttr = telemetryVariant ? ` data-cw-telemetry-variant="${escapeHtml(telemetryVariant)}"` : ''

  const items = stats
    .map((stat, index) => {
      const trimmed = stat.value!.trim()
      const palette = accents(index)
      const noteText = sourceNote ? sourceNote(stat.source) : ''
      const noteLabel = noteText && noteText.trim().length ? noteText.trim() : ''
      const noteAttr = noteLabel ? ` data-stat-note="${escapeHtml(noteLabel)}"` : ''
      return `
        <article
          class="group relative overflow-hidden rounded-2xl border border-wiki-border/50 bg-wiki-bg/80 p-4 sm:p-5 shadow-sm transition hover:border-wiki-primary/50 hover:shadow-lg"
          data-cw-telemetry-component="job-quick-stat"
          data-cw-telemetry-scope="job-quick-stat"
          data-stat-index="${index}"
          data-stat-label="${escapeHtml(stat.label)}"
          data-source-group="${escapeHtml(stat.source)}"${noteAttr}
        >
          <div class="pointer-events-none absolute -top-12 -right-10 h-32 w-32 rounded-full ${palette.halo} blur-3xl opacity-40 transition group-hover:opacity-75"></div>
          <header class="relative flex items-center gap-2.5">
            <span class="flex h-8 w-8 items-center justify-center rounded-xl ${palette.iconBg}">
              <i class="fas ${stat.icon}" aria-hidden="true"></i>
            </span>
            <div class="flex flex-col justify-center">
              <h3 class="text-sm font-semibold text-white leading-tight">${escapeHtml(stat.label)}</h3>
              ${noteLabel ? `<span class="text-[11px] text-wiki-muted mt-0.5">${escapeHtml(noteLabel)}</span>` : ''}
            </div>
          </header>
          <div class="relative mt-2.5 space-y-1 text-left" title="${escapeHtml(trimmed)}" data-stat-value="${escapeHtml(trimmed)}">
            ${valueMarkup(trimmed)}
          </div>
        </article>
      `
    })
    .join('')

  return `
    <section
      class="glass-card p-6 md:p-7 rounded-3xl border border-wiki-border/70 bg-gradient-to-br from-wiki-bg/90 via-wiki-bg/65 to-wiki-bg/40 space-y-6"
      aria-label="핵심 지표"
      data-cw-telemetry-component="job-quick-stats"
      data-cw-telemetry-scope="job-quick-stats"
      data-cw-telemetry-action="quick-stats"${variantAttr}
    >
      <header class="flex items-center gap-3">
        <span class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-wiki-primary/30 via-wiki-secondary/30 to-wiki-primary/20 text-white">
          <i class="fas fa-gauge-high text-lg" aria-hidden="true"></i>
        </span>
        <div>
          <h2 class="text-lg sm:text-xl font-bold text-white leading-tight">핵심 지표 요약</h2>
          <p class="mt-1 text-sm text-wiki-muted">주요 성과 지표를 한눈에 확인하세요.</p>
        </div>
      </header>
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4" data-cw-stat-grid>
        ${items}
      </div>
    </section>
  `
}

const renderOrganizationsList = (profile: UnifiedJobDetail): string => {
  if (!profile.relatedOrganizations || profile.relatedOrganizations.length === 0) return ''
  const items = profile.relatedOrganizations
    .filter((org) => !!org?.name?.trim())
    .map((org) => {
      const name = escapeHtml(org.name.trim())
      if (org.url) {
        // URL에 프로토콜이 없으면 https:// 추가
        let fullUrl = org.url.trim()
        if (!/^https?:\/\//i.test(fullUrl)) {
          fullUrl = `https://${fullUrl}`
        }
        return `<li><a href="${escapeHtml(fullUrl)}" target="_blank" rel="noopener" class="text-sm text-wiki-primary hover:text-wiki-secondary transition">${name}</a></li>`
      }
      return `<li class="text-sm text-wiki-text">${name}</li>`
    })
  return items.length ? `<ul class="space-y-2">${items.join('')}</ul>` : ''
}

const renderKecoCodeList = (profile: UnifiedJobDetail): string => {
  if (!profile.kecoCodes || profile.kecoCodes.length === 0) return ''
  const items = profile.kecoCodes
    .filter((item) => !!item?.code || !!item?.name)
    .map((item) => {
      const code = item.code ? `<span class="text-wiki-muted mr-2">${escapeHtml(item.code)}</span>` : ''
      const name = item.name ? escapeHtml(item.name) : ''
      return `<li class="text-sm text-wiki-text">${code}${name}</li>`
    })
  return items.length ? `<ul class="space-y-2">${items.join('')}</ul>` : ''
}



export const renderUnifiedJobDetail = ({ profile, partials, sources, rawApiData }: UnifiedJobDetailTemplateParams): string => {
  // 병합된 데이터 생성 (Type A/B/C/D 규칙 적용)
  const mergedData = mergeJobData(rawApiData)
  
  const telemetryVariant = resolveJobTelemetryVariant(profile)
  const telemetryVariantAttr = telemetryVariant ? ` data-cw-telemetry-variant="${escapeHtml(telemetryVariant)}"` : ''
  const quickStats = renderQuickStats(
    profile,
    (source) => {
      const normalizedSource = (typeof source === 'string' ? source : `${source}`) as DataSource
      if (normalizedSource === 'CAREERNET' || normalizedSource === 'GOYONG24') {
        const baseLabel = SOURCE_NOTE_LABELS[normalizedSource] ?? DEFAULT_SOURCE_LABELS[normalizedSource] ?? normalizedSource
        const status = sources?.[normalizedSource]
        const statusLabel = describeSourceStatus(normalizedSource, status)
        return statusLabel ? `${baseLabel} · ${statusLabel}` : baseLabel
      }
      if (typeof source === 'string') {
        return source
      }
      return 'CareerWiki 통합 데이터'
    },
    telemetryVariant
  )
  const heroDescription = profile.summary?.split('\n')[0]?.trim()
  const lawyerMatrix = renderLawyerFieldMatrix(profile, partials, sources, telemetryVariant)

  const anchorIdFactory = createAnchorIdFactory(profile.id)
  const overviewCards: SectionCardDescriptor[] = []
  const detailCards: SectionCardDescriptor[] = []

  const pushOverviewCard = (title: string, icon: string, body: string) => {
    if (!body || !body.trim()) {
      return
    }
    const anchorId = anchorIdFactory('overview', title)
    const cardMarkup = buildCard(title, icon, body, {
      anchorId,
      telemetryScope: 'job-overview-card',
      telemetryComponent: 'job-overview-card'
    })
    if (cardMarkup.trim()) {
      overviewCards.push({ id: anchorId, label: title, icon, markup: cardMarkup })
    }
  }

  const pushDetailCard = (title: string, icon: string, body: string) => {
    if (!body || !body.trim()) {
      return
    }
    const anchorId = anchorIdFactory('details', title)
    const cardMarkup = buildCard(title, icon, body, {
      anchorId,
      telemetryScope: 'job-detail-card',
      telemetryComponent: 'job-detail-card'
    })
    if (cardMarkup.trim()) {
      detailCards.push({ id: anchorId, label: title, icon, markup: cardMarkup })
    }
  }

  // Type C: 업무 설명 (계층적 활용 - simple for overview)
  const workSimple = mergedData.work.simple
  const workSummary = mergedData.work.summary || profile.summary
  
  if (workSimple || workSummary || profile.duties?.trim()) {
    const introBlocks = []
    
    // 직업 소개
    if (typeof workSummary === 'string' && workSummary?.trim()) {
      introBlocks.push(`<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">직업 소개</h3>${formatRichText(workSummary)}</div>`)
    }
    
    // 주요 업무
    if (workSimple && Array.isArray(workSimple) && workSimple.length > 0) {
      const workList = workSimple
        .map((item: any) => {
          // work 필드만 추출
          const text = typeof item === 'string' ? item : item.work || item.list_content || ''
          return text.trim() ? `<li>${escapeHtml(text)}</li>` : ''
        })
        .filter(Boolean)
        .join('')
      if (workList) {
        introBlocks.push(`<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">주요 업무</h3><ul class="list-disc list-inside space-y-1">${workList}</ul></div>`)
      }
    } else if (profile.duties?.trim()) {
      introBlocks.push(`<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">주요 업무</h3>${formatRichText(profile.duties)}</div>`)
    }
    
    if (introBlocks.length > 0) {
      pushOverviewCard('하는 일', 'fa-rocket', introBlocks.join(''))
    }
  }

  // Type B: 전망 (우선순위 선택 - primary 사용)
  const prospectPrimary = mergedData.prospect.primary || profile.prospect
  if (prospectPrimary) {
    let prospectHtml = ''
    if (Array.isArray(prospectPrimary) && prospectPrimary.length > 0) {
      // 배열인 경우 각 항목을 블록으로 만들고 첫 단어 들여쓰기
      const prospectBlocks = prospectPrimary
        .map((item: any) => {
          const text = typeof item === 'string' ? item : item.list_content || ''
          if (!text.trim()) return ''
          // 첫 단어 들여쓰기를 위해 <span> 추가
          return `<div class="mb-3"><span class="inline-block w-4"></span>${escapeHtml(text)}</div>`
        })
        .filter(Boolean)
        .join('')
      prospectHtml = `<div class="space-y-2">${prospectBlocks}</div>`
    } else if (typeof prospectPrimary === 'string') {
      // 문자열인 경우 줄바꿈을 블록으로 변환
      const lines = prospectPrimary.split('\n').filter(line => line.trim())
      if (lines.length > 1) {
        prospectHtml = `<div class="space-y-2">${lines.map(line => `<div class="mb-3"><span class="inline-block w-4"></span>${escapeHtml(line)}</div>`).join('')}</div>`
      } else {
        prospectHtml = formatRichText(prospectPrimary)
      }
    }
    
    if (prospectHtml?.trim()) {
      pushOverviewCard('커리어 전망', 'fa-chart-line', prospectHtml)
    }
  }

  // Type C: 능력 & 지식 (계층적 활용 - simple for overview)
  const abilitiesSimple = mergedData.abilities.simple
  const knowledgeSimple = mergedData.knowledge.simple
  
  const abilityBlocks = []
  
  // 능력 섹션
  if (abilitiesSimple && Array.isArray(abilitiesSimple) && abilitiesSimple.length > 0) {
    const abilityList = abilitiesSimple
      .slice(0, 10)
      .map((item: any) => {
        const text = typeof item === 'string' ? item : item.list_content || item.ability_name || JSON.stringify(item)
        return `<li>${escapeHtml(text)}</li>`
      })
      .join('')
    abilityBlocks.push(`<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">핵심 역량</h3><ul class="list-disc list-inside space-y-1">${abilityList}</ul></div>`)
  } else if (typeof profile.abilities === 'string' && profile.abilities?.trim()) {
    abilityBlocks.push(`<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">핵심 역량</h3>${formatRichText(profile.abilities)}</div>`)
  }
  
  // 지식 섹션
  if (knowledgeSimple && Array.isArray(knowledgeSimple) && knowledgeSimple.length > 0) {
    const knowledgeList = knowledgeSimple
      .slice(0, 10)
      .map((item: any) => {
        // knowledge 필드 또는 inform 필드를 사용 (중요도 있으면 함께 표시)
        if (typeof item === 'string') {
          return `<li>${escapeHtml(item)}</li>`
        }
        const knowledgeName = item.knowledge || item.list_content || item.knowledge_name || ''
        const inform = item.inform || ''
        const importance = item.importance
        
        // inform이 더 상세한 설명이므로 우선 사용
        const displayText = inform || knowledgeName
        if (!displayText.trim()) return ''
        
        // 중요도가 있으면 함께 표시
        if (importance) {
          return `<li>${escapeHtml(displayText)} <span class="text-wiki-muted text-xs">(중요도 ${importance})</span></li>`
        }
        return `<li>${escapeHtml(displayText)}</li>`
      })
      .filter(Boolean)
      .join('')
    if (knowledgeList) {
      abilityBlocks.push(`<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">필수 지식</h3><ul class="list-disc list-inside space-y-1">${knowledgeList}</ul></div>`)
    }
  } else if (typeof profile.technKnow === 'string' && profile.technKnow?.trim()) {
    abilityBlocks.push(`<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">활용 기술</h3>${formatRichText(profile.technKnow)}</div>`)
  }
  
  if (abilityBlocks.length > 0) {
    pushOverviewCard('핵심 능력', 'fa-bolt', abilityBlocks.join(''))
  }

  const traitBlocks = [
    profile.personality?.trim()
      ? `<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">성격 특성</h3>${formatRichText(profile.personality)}</div>`
      : '',
    profile.interests?.trim()
      ? `<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">흥미 요소</h3>${formatRichText(profile.interests)}</div>`
      : '',
    profile.values?.trim()
      ? `<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">가치관</h3>${formatRichText(profile.values)}</div>`
      : ''
  ].filter(Boolean)
  if (traitBlocks.length) {
    pushOverviewCard('적성 및 흥미', 'fa-handshake', traitBlocks.join(''))
  }

  // Type B: 임금 (우선순위 선택 - primary 사용)
  const salaryPrimary = mergedData.salary.primary || profile.salary
  const salaryAnchor = anchorIdFactory('overview', '임금 정보')
  const salaryCard = renderSalaryCard(salaryPrimary, {
    anchorId: salaryAnchor,
    telemetryScope: 'job-overview-card',
    telemetryComponent: 'job-overview-salary-card'
  })
  if (salaryCard) {
    overviewCards.push({ id: salaryAnchor, label: '임금 정보', icon: 'fa-coins', markup: salaryCard })
  }

  const overviewContent = overviewCards.length
    ? `<div class="space-y-6" data-cw-job-overview>
        ${renderSectionToc('overview', '개요 목차', overviewCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${overviewCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">개요 정보가 준비 중입니다.</p>`

  // profile.way와 profile.environment는 잘못된 매핑이므로 사용하지 않음
  // profile.way → path.technKnow (되는 방법) - 이미 개요 탭에 표시됨
  // profile.environment → performList.environment (배열) - 업무환경이 아님
  
  // 필수 기술 및 지식은 profile.way에 있지만 실제로는 '되는 방법' 데이터
  // 이는 개요 탭의 "업무 방식" 섹션에 이미 표시되므로 여기서는 제외
  
  if (profile.knowledge?.trim()) {
    pushDetailCard('필수 지식', 'fa-book-open', formatRichText(profile.knowledge))
  }

  if (profile.activitiesImportance?.trim() || profile.activitiesLevels?.trim()) {
    const activityBlocks = [
      profile.activitiesImportance?.trim()
        ? `<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">활동 중요도</h3>${formatRichText(profile.activitiesImportance)}</div>`
        : '',
      profile.activitiesLevels?.trim()
        ? `<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">활동 수준</h3>${formatRichText(profile.activitiesLevels)}</div>`
        : ''
    ].join('')
    pushDetailCard('업무 수행 지표', 'fa-chart-area', activityBlocks)
  }

  // 1. Type C: 업무 상세 (detailed) - 먼저 표시
  const workDetailed = mergedData.work.detailed
  if (workDetailed && typeof workDetailed === 'string' && workDetailed.trim()) {
    pushDetailCard('업무 상세', 'fa-clipboard-list', formatRichText(workDetailed))
  }

  // 2. Type C: 학력 분포 (계층적 활용 - detailedDistribution 사용) - 파이 차트로 시각화
  const educationDistribution = mergedData.education.detailedDistribution || profile.educationDistribution
  const educationAnchor = anchorIdFactory('details', '학력 분포')
  const educationCard = renderDistributionPieChart(
    '학력 분포',
    'fa-user-graduate',
    educationDistribution,
    {
      middleSchoolOrLess: '중학교 이하',
      highSchool: '고등학교',
      college: '전문대',
      university: '대학',
      graduate: '석사 이상',
      doctor: '박사'
    },
    {
      anchorId: educationAnchor,
      telemetryScope: 'job-detail-card',
      telemetryComponent: 'job-detail-education'
    }
  )
  if (educationCard) {
    detailCards.push({ id: educationAnchor, label: '학력 분포', icon: 'fa-user-graduate', markup: educationCard })
  }

  // 3. Type C: 전공 분포 (계층적 활용 - detailedDistribution 사용) - 파이 차트로 시각화
  const majorDistribution = mergedData.major.detailedDistribution || profile.majorDistribution
  const majorAnchor = anchorIdFactory('details', '전공 분포')
  const majorCard = renderDistributionPieChart(
    '전공 분포',
    'fa-book-open-reader',
    majorDistribution,
    {
      humanities: '인문계열',
      social: '사회계열',
      education: '교육계열',
      engineering: '공학계열',
      natural: '자연계열',
      medical: '의약계열',
      artsSports: '예체능'
    },
    {
      anchorId: majorAnchor,
      telemetryScope: 'job-detail-card',
      telemetryComponent: 'job-detail-major'
    }
  )
  if (majorCard) {
    detailCards.push({ id: majorAnchor, label: '전공 분포', icon: 'fa-book-open-reader', markup: majorCard })
  }
  
  // 4. Type D: 커리어넷 전용 - 워라밸 & 사회적 기여도
  const wlb = mergedData.careernetOnly.wlb
  const social = mergedData.careernetOnly.social
  if (wlb || social) {
    const wlbBlocks = []
    if (wlb) {
      wlbBlocks.push(`<div><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">워라밸 지수</h3><p class="text-sm text-wiki-text">${escapeHtml(wlb)}</p></div>`)
    }
    if (social) {
      wlbBlocks.push(`<div class="mt-4"><h3 class="text-sm text-wiki-muted uppercase tracking-wide font-semibold mb-2">사회적 기여도</h3><p class="text-sm text-wiki-text">${escapeHtml(social)}</p></div>`)
    }
    pushDetailCard('워라밸 & 사회적 평가', 'fa-heart', wlbBlocks.join(''))
  }
  
  // 5-13. 아래 섹션들은 올바른 순서로 재배치됩니다
  
  // 5. Type D: 교육·자격 섹션 (진로 준비방법 + 진로 탐색 활동 통합)
  const jobReadyList = mergedData.careernetOnly.jobReadyList
  const researchList = rawApiData?.careernet?.encyclopedia?.researchList
  
  if ((jobReadyList && Array.isArray(jobReadyList) && jobReadyList.length > 0) ||
      (researchList && Array.isArray(researchList) && researchList.length > 0)) {
    const educationBlocks = []
    
    // 진로 준비방법
    if (jobReadyList && Array.isArray(jobReadyList) && jobReadyList.length > 0) {
      const readyHtml = jobReadyList
        .map((item: any) => {
          const title = item.title || item.list_title || ''
          const content = item.content || item.list_content || ''
          if (!title && !content) return ''
          return `<div class="mb-4"><h4 class="text-sm font-semibold text-wiki-text mb-1">${escapeHtml(title)}</h4><p class="text-sm text-wiki-muted">${escapeHtml(content)}</p></div>`
        })
        .filter(Boolean)
        .join('')
      
      if (readyHtml) {
        educationBlocks.push(`<div><h3 class="text-base font-bold text-white mb-4">진로 준비방법</h3>${readyHtml}</div>`)
      }
    }
    
    // 진로 탐색 활동 (이전의 조사/연구자료)
    if (researchList) {
      const researchHtml = renderResearchList(researchList)
      if (researchHtml) {
        educationBlocks.push(`<div class="${educationBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="text-base font-bold text-white mb-4">진로 탐색 활동</h3>${researchHtml}</div>`)
      }
    }
    
    if (educationBlocks.length > 0) {
      pushDetailCard('교육·자격', 'fa-graduation-cap', educationBlocks.join(''))
    }
  }

  // 6. Type D: 커리어넷 전용 - 한국의 직업지표
  const indicatorChart = rawApiData?.careernet?.encyclopedia?.indicatorChart
  if (indicatorChart) {
    const indicatorHtml = renderIndicatorChart(indicatorChart)
    if (indicatorHtml) {
      pushDetailCard('한국의 직업지표', 'fa-chart-bar', indicatorHtml)
    }
  }

  // 7. Type C: 업무수행능력 분석 (중요도 + 수준 통합)
  const abilityComparison = mergedData.abilities?.detailedComparison
  const abilityImportance = abilityComparison?.importance
  const abilityLevel = abilityComparison?.level
  
  if (abilityComparison && ((abilityImportance && (abilityImportance.withinJob || abilityImportance.betweenJobs)) ||
      (abilityLevel && (abilityLevel.withinJob || abilityLevel.betweenJobs)))) {
    const abilityBlocks = []
    
    // 업무수행능력 중요도
    if (abilityImportance && (abilityImportance.withinJob || abilityImportance.betweenJobs)) {
      const importanceHtml = renderComparisonData(
        abilityImportance.withinJob,
        abilityImportance.betweenJobs,
        '업무수행능력 중요도',
        'fa-brain'
      )
      if (importanceHtml) {
        abilityBlocks.push(`<div><h3 class="text-base font-bold text-white mb-4">업무수행능력 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 업무수행능력 수준
    if (abilityLevel && (abilityLevel.withinJob || abilityLevel.betweenJobs)) {
      const levelHtml = renderComparisonData(
        abilityLevel.withinJob,
        abilityLevel.betweenJobs,
        '업무수행능력 수준',
        'fa-star-half-alt'
      )
      if (levelHtml) {
        abilityBlocks.push(`<div class="${abilityBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="text-base font-bold text-white mb-4">업무수행능력 수준</h3>${levelHtml}</div>`)
      }
    }
    
    if (abilityBlocks.length > 0) {
      pushDetailCard('업무수행능력 분석', 'fa-brain', abilityBlocks.join(''))
    }
  }

  // 8. Type C: 지식 분석 (중요도 + 수준 통합)
  const knowledgeComparison = mergedData.knowledge?.detailedComparison
  const knowledgeImportance = knowledgeComparison?.importance
  const knowledgeLevel = knowledgeComparison?.level
  
  if (knowledgeComparison && ((knowledgeImportance && (knowledgeImportance.withinJob || knowledgeImportance.betweenJobs)) ||
      (knowledgeLevel && (knowledgeLevel.withinJob || knowledgeLevel.betweenJobs)))) {
    const knowledgeBlocks = []
    
    // 지식 중요도
    if (knowledgeImportance && (knowledgeImportance.withinJob || knowledgeImportance.betweenJobs)) {
      const importanceHtml = renderComparisonData(
        knowledgeImportance.withinJob,
        knowledgeImportance.betweenJobs,
        '지식 중요도',
        'fa-book'
      )
      if (importanceHtml) {
        knowledgeBlocks.push(`<div><h3 class="text-base font-bold text-white mb-4">지식 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 지식 수준
    if (knowledgeLevel && (knowledgeLevel.withinJob || knowledgeLevel.betweenJobs)) {
      const levelHtml = renderComparisonData(
        knowledgeLevel.withinJob,
        knowledgeLevel.betweenJobs,
        '지식 수준',
        'fa-layer-group'
      )
      if (levelHtml) {
        knowledgeBlocks.push(`<div class="${knowledgeBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="text-base font-bold text-white mb-4">지식 수준</h3>${levelHtml}</div>`)
      }
    }
    
    if (knowledgeBlocks.length > 0) {
      pushDetailCard('지식 분석', 'fa-book', knowledgeBlocks.join(''))
    }
  }

  // 9. Type D: 업무환경 분석 (고용24 + 커리어넷 통합)
  const workEnvironment = mergedData.goyong24Only.workEnvironment
  const workContext = rawApiData?.careernet?.encyclopedia?.performList?.environment
  
  if ((workEnvironment && (workEnvironment.comparison || workEnvironment.details)) ||
      (workContext && Array.isArray(workContext) && workContext.length > 0)) {
    const workEnvBlocks = []
    
    // 고용24 업무환경 데이터 (직업 내/간 비교)
    if (workEnvironment && (workEnvironment.comparison || workEnvironment.details)) {
      const workEnvHtml = renderComparisonData(
        workEnvironment.comparison, // jobsEnvCmpr (직업 내 비교)
        workEnvironment.details,    // jobsEnv (직업 간 비교)
        '업무환경 조건',
        'fa-building'
      )
      if (workEnvHtml) {
        workEnvBlocks.push(`<div><h3 class="text-base font-bold text-white mb-4">업무환경 조건</h3>${workEnvHtml}</div>`)
      }
    }
    
    // 커리어넷 업무환경 데이터 (중요도 바 차트)
    if (workContext && Array.isArray(workContext) && workContext.length > 0) {
      const contextItems = workContext
        .sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 15) // 상위 15개
        .map((item) => {
          const name = item.environment || item.inform || ''
          const importance = item.importance || 0
          const percentage = Math.min(importance, 100)
          const barColor = percentage >= 80 ? 'bg-green-500' : percentage >= 60 ? 'bg-blue-500' : percentage >= 40 ? 'bg-yellow-500' : 'bg-gray-400'
          
          return `
            <div class="mb-4">
              <div class="flex justify-between items-center mb-2">
                <span class="text-sm font-medium text-wiki-text">${escapeHtml(name)}</span>
                <span class="text-sm font-semibold text-wiki-primary">${importance}</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3 overflow-hidden">
                <div class="${barColor} h-3 rounded-full transition-all duration-300" style="width: ${percentage}%"></div>
              </div>
            </div>
          `
        })
        .join('')
      
      if (contextItems) {
        workEnvBlocks.push(`<div class="${workEnvBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="text-base font-bold text-white mb-4">업무환경 중요도</h3>${contextItems}</div>`)
      }
    }
    
    if (workEnvBlocks.length > 0) {
      pushDetailCard('업무환경 분석', 'fa-building', workEnvBlocks.join(''))
    }
  }

  
  // 10. Type D: 고용24 전용 - 성격 특성 비교
  const personality = mergedData.goyong24Only.personality
  if (personality && (personality.withinJob || personality.betweenJobs)) {
    const personalityHtml = renderComparisonData(
      personality.withinJob,
      personality.betweenJobs,
      '성격 특성',
      'fa-user-check'
    )
    if (personalityHtml) {
      pushDetailCard('성격 분석', 'fa-user-check', personalityHtml)
    }
  }

  // 11. Type D: 고용24 전용 - 흥미 분야 비교
  const interest = mergedData.goyong24Only.interest
  if (interest && (interest.withinJob || interest.betweenJobs)) {
    const interestHtml = renderComparisonData(
      interest.withinJob,
      interest.betweenJobs,
      '흥미 분야',
      'fa-heart'
    )
    if (interestHtml) {
      pushDetailCard('흥미 분야 분석', 'fa-heart', interestHtml)
    }
  }

  // 12. Type D: 고용24 전용 - 가치관 비교
  const values = mergedData.goyong24Only.values
  if (values && (values.withinJob || values.betweenJobs)) {
    const valuesHtml = renderComparisonData(
      values.withinJob,
      values.betweenJobs,
      '가치관',
      'fa-star'
    )
    if (valuesHtml) {
      pushDetailCard('가치관 분석', 'fa-star', valuesHtml)
    }
  }

  // 13. Type D: 고용24 전용 - 업무활동 분석 (중요도 + 수준 통합)
  const activityImportance = mergedData.goyong24Only.activity?.importance
  const activityLevel = mergedData.goyong24Only.activity?.level
  
  if ((activityImportance && (activityImportance.withinJob || activityImportance.betweenJobs)) ||
      (activityLevel && (activityLevel.withinJob || activityLevel.betweenJobs))) {
    const activityBlocks = []
    
    // 업무활동 중요도
    if (activityImportance && (activityImportance.withinJob || activityImportance.betweenJobs)) {
      const importanceHtml = renderComparisonData(
        activityImportance.withinJob,
        activityImportance.betweenJobs,
        '업무활동 중요도',
        'fa-chart-line'
      )
      if (importanceHtml) {
        activityBlocks.push(`<div><h3 class="text-base font-bold text-white mb-4">업무활동 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 업무활동 수준
    if (activityLevel && (activityLevel.withinJob || activityLevel.betweenJobs)) {
      const levelHtml = renderComparisonData(
        activityLevel.withinJob,
        activityLevel.betweenJobs,
        '업무활동 수준',
        'fa-signal'
      )
      if (levelHtml) {
        activityBlocks.push(`<div class="${activityBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="text-base font-bold text-white mb-4">업무활동 수준</h3>${levelHtml}</div>`)
      }
    }
    
    if (activityBlocks.length > 0) {
      pushDetailCard('업무활동 분석', 'fa-tasks', activityBlocks.join(''))
    }
  }

  // 변호사 페이지는 직업 분류 체계 표시하지 않음
  if (!isLawyerProfile(profile) && profile.classifications && (profile.classifications.large || profile.classifications.medium || profile.classifications.small)) {
    const classificationItems = [
      profile.classifications.large ? `<li class="flex justify-between text-sm"><span class="text-wiki-muted">대분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.large)}</span></li>` : '',
      profile.classifications.medium ? `<li class="flex justify-between text-sm"><span class="text-wiki-muted">중분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.medium)}</span></li>` : '',
      profile.classifications.small ? `<li class="flex justify-between text-sm"><span class="text-wiki-muted">소분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.small)}</span></li>` : ''
    ].join('')
    pushDetailCard('직업 분류 체계', 'fa-sitemap', `<ul class="space-y-2">${classificationItems}</ul>`)
  }

  // 한국표준직업분류 코드 섹션 제거됨
  // const kecoList = renderKecoCodeList(profile)
  // if (kecoList) {
  //   pushDetailCard('한국표준직업분류 코드', 'fa-layer-group', kecoList)
  // }

  const detailContent = detailCards.length
    ? `<div class="space-y-6" data-cw-job-details>
        ${renderSectionToc('details', '상세 정보 목차', detailCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${detailCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">상세 정보가 준비 중입니다.</p>`

  const tabEntries: TabEntry[] = [
    { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent },
    { id: 'details', label: '상세 정보', icon: 'fa-layer-group', content: detailContent }
  ]

  const entitySlug = composeDetailSlug('job', profile.name, profile.id)
  const detailPath = `/job/${encodeURIComponent(entitySlug)}`
  const summarySnippet = heroDescription ?? (profile.summary ? profile.summary.trim().slice(0, 400) : null)
  const detailMetaExtra: Record<string, unknown> = {
    sharePath: detailPath
  }
  if (profile.category?.code) {
    detailMetaExtra.categoryCode = profile.category.code
  }
  if (heroDescription) {
    detailMetaExtra.heroDescription = heroDescription
  }
  detailMetaExtra.networkCounts = {
    majors: profile.relatedMajors?.length ?? 0,
    jobs: profile.relatedJobs?.length ?? 0,
    certificates: profile.relatedCertificates?.length ?? 0
  }
  if (telemetryVariant) {
    detailMetaExtra.telemetryVariant = telemetryVariant
  }

  const sampleComments = buildJobDemoComments(profile)
  const { tabLayout, commentsPlaceholder, metaScript } = buildDetailScaffold({
    entityType: 'job',
    entityId: profile.id,
    entitySlug,
    entityName: profile.name,
    entitySummary: summarySnippet,
    entityCategory: profile.category?.name ?? null,
    entitySources: profile.sources,
    tabs: tabEntries,
    tabFallback: {
      title: '데이터 준비 중',
      icon: 'fa-circle-info',
      message: '이 직업은 아직 상세 정보가 충분하지 않습니다. 데이터가 수집되는 대로 탭이 활성화됩니다.'
    },
    ctaLinks: [],
    comments: {
      title: `${profile.name} 커뮤니티 이야기`,
      description: `${profile.name} 역할에서 겪은 성장 전략과 인사이트를 공유해주세요.`,
      feedbackLabel: '피드백 남기기',
      notifyLabel: '알림 받기',
      emptyLabel: `${profile.name}에 대한 의견을 남겨주세요.`,
      sampleComments,
      showForm: false
    },
    partials,
    sources,
    metaExtra: detailMetaExtra
  })

  const sidebarContent = renderJobSidebar(profile)
  const sourcesCollapsible = renderSourcesCollapsible(profile, sources, partials)
  const heroImage = renderHeroImage(profile.name, { dataAttribute: 'data-job-hero-image', context: 'job' })
  const hasSidebar = sidebarContent.trim().length > 0
  
  // 태그 렌더링 (tagList는 string[] 형식)
  const tagList = rawApiData?.careernet?.encyclopedia?.tagList
  let heroTagsMarkup = ''
  
  if (tagList && Array.isArray(tagList) && tagList.length > 0) {
    const heroTags = tagList
      .filter((tag: string | any) => {
        // string[] 또는 object[] 모두 지원
        const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
        return tagText && tagText.trim().length > 0
      })
      .map((tag: string | any) => {
        // string[] 또는 object[] 모두 지원
        const tagText = typeof tag === 'string' ? tag : (tag?.tag || tag?.list_content || '')
        return `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary font-medium border border-wiki-primary/20 hover:bg-wiki-primary/20 transition"><i class="fas fa-tag text-[10px]" aria-hidden="true"></i>${escapeHtml(tagText.trim())}</span>`
      })
      .join('')
    
    if (heroTags) {
      heroTagsMarkup = `<div class="flex flex-wrap gap-2 mt-4">${heroTags}</div>`
    }
  }

  const mainColumn = `<div class="space-y-6 min-w-0">${tabLayout}</div>`
  const sidebarMarkup = hasSidebar
    ? `<aside class="space-y-6 lg:sticky lg:top-28 lg:h-fit lg:self-start" data-job-sidebar>${sidebarContent}</aside>`
    : ''

  const layoutBlock = hasSidebar
    ? `
        <div class="grid gap-8 lg:grid-cols-[minmax(0,3fr)_minmax(260px,1fr)] lg:items-start" data-job-layout>
          ${mainColumn}
          ${sidebarMarkup}
        </div>
      `
    : `<div class="space-y-6" data-job-layout>${tabLayout}</div>`

  // 법조 직업 매트릭스 섹션 제거됨
  const lawyerMatrixSection = ''

  const sourcesBlock = sourcesCollapsible
    ? `<div data-job-sources>${sourcesCollapsible}</div>`
    : ''

  const communityBlock = `<div data-job-community>${commentsPlaceholder}</div>`

  return `
    <div class="max-w-[1400px] mx-auto space-y-8">
      <section class="glass-card p-8 rounded-2xl space-y-8" data-job-hero${telemetryVariantAttr}>
        <div class="space-y-5">
          ${profile.category?.name ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-primary/15 text-xs text-wiki-primary font-semibold"><i class="fas fa-layer-group" aria-hidden="true"></i>${escapeHtml(profile.category.name)}</span>` : ''}
          <div class="flex flex-wrap items-start justify-between gap-4">
            <h1 class="text-4xl font-bold text-white leading-tight">${escapeHtml(profile.name)}</h1>
            <div class="relative shrink-0" data-share-root data-cw-telemetry-scope="job-hero-actions">
              <button type="button" class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition inline-flex items-center gap-2" data-share-trigger data-share-path="${escapeHtml(detailPath)}" data-share-title="${escapeHtml(profile.name)}" data-cw-telemetry-component="job-share-trigger" data-cw-telemetry-action="share-open"${telemetryVariantAttr}>
                <i class="fas fa-share-nodes" aria-hidden="true"></i>
                공유
              </button>
              <div class="absolute right-0 mt-2 w-72 rounded-xl border border-wiki-border/60 bg-wiki-bg/95 shadow-xl backdrop-blur hidden" data-share-panel data-cw-telemetry-component="job-share-panel" role="dialog" aria-modal="false" aria-label="링크 공유">
                <div class="flex items-center justify-between px-4 py-3 border-b border-wiki-border/60">
                  <p class="text-sm font-semibold text-white">직업 상세 링크</p>
                  <button type="button" class="text-xs text-wiki-muted hover:text-white transition" data-share-close aria-label="닫기">
                    <i class="fas fa-times" aria-hidden="true"></i>
                  </button>
                </div>
                <div class="p-4 space-y-3">
                  <div class="flex items-center gap-2">
                    <input type="text" class="flex-1 px-3 py-2 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-xs text-white focus:outline-none" value="${escapeHtml(detailPath)}" readonly data-share-url>
                    <button type="button" class="px-3 py-2 bg-wiki-primary text-white text-xs rounded-md hover:bg-blue-600 transition" data-share-copy data-cw-telemetry-component="job-share-copy" data-cw-telemetry-action="share-copy"${telemetryVariantAttr}>
                      <i class="fas fa-copy mr-1" aria-hidden="true"></i>복사
                    </button>
                  </div>
                  <p class="text-[11px] text-wiki-muted">복사 버튼을 누르면 링크가 클립보드에 저장됩니다.</p>
                </div>
              </div>
            </div>
          </div>
          ${
            heroDescription
              ? `<p class="text-base text-wiki-muted leading-relaxed" data-cw-telemetry-component="job-hero-summary">${escapeHtml(heroDescription)}</p>`
              : ''
          }
          ${heroImage}
          ${heroTagsMarkup}
        </div>
        ${quickStats ? `<div>${quickStats}</div>` : ''}
      </section>

      ${lawyerMatrixSection}
      ${layoutBlock}
      ${sourcesBlock}
      ${communityBlock}

      ${metaScript}
    </div>
  `
}


export const createJobJsonLd = (profile: UnifiedJobDetail, canonicalUrl: string): string => {
  const jsonLd = sanitizeJson({
    '@context': 'https://schema.org',
    '@type': 'Occupation',
    name: profile.name,
    description: profile.summary,
    url: canonicalUrl,
    occupationalCategory: profile.category?.name,
    estimatedSalary: profile.salary,
    educationRequirements: profile.majorDistribution
      ? Object.entries(profile.majorDistribution)
          .filter(([, value]) => !!value && !!value.trim())
          .map(([key, value]) => `${key}: ${value}`)
      : undefined,
    skills: profile.abilities,
    qualifications: profile.relatedCertificates,
    industry: profile.classifications?.large,
    responsibilities: profile.duties,
    occupationalSpecialty: profile.relatedJobs?.map((job) => job.name)
  })

  if (!jsonLd) {
    return ''
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003c')
  return `<script type="application/ld+json">${script}</script>`
}
