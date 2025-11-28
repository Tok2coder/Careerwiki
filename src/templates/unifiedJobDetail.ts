import type {
  DataSource,
  JobRelatedEntity,
  UnifiedJobDetail,
  ForecastItem,
  JobReadyItem,
  ResearchItem
} from '../types/unifiedProfiles'
import type { SourceStatus, SourceStatusRecord } from '../services/profileDataService'
import {
  TabEntry,
  BuildCardOptions,
  buildCard,
  buildDetailScaffold,
  DEFAULT_SOURCE_LABELS,
  escapeHtml,
  formatRichText,
  renderHeroImage,
  renderSourcesPanel,
  sanitizeJson,
  SampleCommentPayload
} from './detailTemplateUtils'
import { composeDetailSlug } from '../utils/slug'
import { getAbilityIcon } from '../utils/abilityIconMapper'

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
  GOYONG24: '고용노동부 고용24 직업 정보',
  WORK24_JOB: '고용노동부 고용24 직업 정보',
  WORK24_DJOB: '고용노동부 고용24 직업사전',
  WORK24_MAJOR: '고용노동부 고용24 전공 정보',
  AI: 'AI 보조 생성 데이터',
  USER_CONTRIBUTED: '사용자 기여 데이터',
  ADMIN_OVERRIDE: '관리자 검증 데이터'
}

const SOURCE_NOTE_LABELS: Record<DataSource, string> = {
  CAREERNET: '커리어넷 데이터',
  GOYONG24: '고용24 데이터',
  WORK24_JOB: '고용24 데이터',
  WORK24_DJOB: '고용24 사전 데이터',
  WORK24_MAJOR: '고용24 학과 데이터',
  AI: 'AI 생성 데이터',
  USER_CONTRIBUTED: '사용자 기여',
  ADMIN_OVERRIDE: '관리자 보정'
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

/**
 * 안전한 trim 함수 - undefined/null 체크
 */
const safeTrim = (value: any): string => {
  if (value === null || value === undefined) return ''
  if (typeof value !== 'string') return String(value).trim()
  return value.trim()  // ✅ Fixed: value가 string일 때는 직접 trim() 호출
}

const normalizeComparableText = (value?: string | null): string => {
  if (!value) return ''
  return safeTrim(value).replace(/\s+/g, ' ')
}

const collectStringValues = (value: unknown): string[] => {
  if (!value) return []
  if (typeof value === 'string') {
    return [value]
  }
  if (Array.isArray(value)) {
    return value
      .map((entry) => {
        if (typeof entry === 'string') {
          return entry
        }
        if (entry && typeof entry === 'object') {
          const candidate =
            (entry as Record<string, unknown>).description ??
            (entry as Record<string, unknown>).list_content ??
            (entry as Record<string, unknown>).workDesc ??
            (entry as Record<string, unknown>).work ??
            null
          return typeof candidate === 'string' ? candidate : ''
        }
        return ''
      })
      .filter((text): text is string => typeof text === 'string' && safeTrim(text).length > 0)
  }
  if (typeof value === 'object') {
    return Object.values(value as Record<string, unknown>).filter(
      (entry): entry is string => typeof entry === 'string' && safeTrim(entry).length > 0
    )
  }
  return []
}

const renderDutyListItems = (items: string[]): string => {
  if (!items.length) {
    return ''
  }
  return items
    .map(
      (sentence) => `
        <li class="flex items-start gap-2 text-[15px] leading-relaxed text-wiki-text" data-job-duty-item>
          <span class="text-wiki-primary mt-0.5 text-xs font-semibold">▶</span>
          <span>${escapeHtml(sentence)}</span>
        </li>
      `
    )
    .join('')
}

const renderDutyBulletList = (value?: string | null): string => {
  if (!value || !safeTrim(value)) {
    return formatRichText(value)
  }

  const normalizedValue = value.replace(/\r/g, '\n')
  let sentences = normalizedValue
    .split(/\n+/)
    .map((line) => safeTrim(line).replace(/^[\d\-\.\)\(]+\s*/, ''))
    .filter(Boolean)

  if (sentences.length <= 1) {
    const sentenceSplit = normalizedValue
      .replace(/([.!?])\s+(?=[^\s])/g, '$1|')
      .split('|')
      .map((line) => safeTrim(line).replace(/^[\d\-\.\)\(]+\s*/, ''))
      .filter(Boolean)
    if (sentenceSplit.length > sentences.length) {
      sentences = sentenceSplit
    }
  }

  if (!sentences.length) {
    return formatRichText(value)
  }

  return `<ul class="space-y-2" data-job-duty-list>${renderDutyListItems(sentences)}</ul>`
}

const resolveAbilityLabel = (item: any): string => {
  if (typeof item === 'string') {
    return safeTrim(item)
  }
  if (!item || typeof item !== 'object') {
    return ''
  }
  const base =
    safeTrim(item.name) ||
    safeTrim(item.ability_name) ||
    safeTrim(item.list_content) ||
    safeTrim(item.description)
  const score =
    typeof item.score === 'number' && Number.isFinite(item.score) && item.score > 0
      ? ` (${item.score}점)`
      : ''
  if (base) {
    return `${base}${score}`
  }
  if (score) {
    return score.trim()
  }
  return ''
}

const hasStructuredForecastData = (item?: ForecastItem | null): boolean => {
  if (!item) return false
  const period = typeof item.period === 'string' ? safeTrim(item.period) : ''
  const description = typeof item.description === 'string' ? safeTrim(item.description) : ''
  return Boolean(period || description)
}

/**
 * 안전한 문자열 체크 - 비어있지 않은 문자열인지 확인
 */
const isNonEmptyString = (value: any): boolean => {
  return value !== null && value !== undefined && typeof value === 'string' && safeTrim(value).length > 0
}

/**
 * 문장을 마침표(.)로 분리하여 불릿 리스트로 변환
 * 쉼표는 문장 내 구분자로 유지됨
 */
const formatAsBulletList = (text: string): string => {
  if (!text || !safeTrim(text)) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }
  
  // 마침표로만 문장 분리 (쉼표는 문장 내 구분자로 유지)
  const sentences = text
    .split(/\.\s*/)
    .map(s => safeTrim(s))
    .map(s => s.replace(/^[,，]\s*/, ''))  // 문장 시작의 쉼표 제거
    .filter(s => s.length > 0)
  
  if (sentences.length === 0) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }
  
  if (sentences.length === 1) {
    // 문장이 하나만 있으면 불릿 없이 그냥 표시
    return `<p class="content-text leading-relaxed text-wiki-text">${escapeHtml(sentences[0])}</p>`
  }
  
  // 여러 문장이 있으면 불릿 리스트로 변환
  const listItems = sentences
    .map(sentence => `<li>${escapeHtml(sentence)}</li>`)
    .join('')
  
  return `<ul class="list-disc list-inside space-y-1 content-text text-wiki-text">${listItems}</ul>`
}

/**
 * 업무 상세를 계층적 구조로 렌더링 (대분류 제목 + bullet point 항목)
 */
const formatWorkDetailAsNumberedCards = (text: string): string => {
  if (!text || !safeTrim(text)) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }
  
  // 줄 단위로 분리
  const lines = text
    .split(/\n/)
    .map(s => safeTrim(s))
    .filter(s => s.length > 0)
  
  if (lines.length === 0) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }
  
  // 단일 항목인 경우
  if (lines.length === 1) {
    const line = lines[0]
    const isCategory = /^[\[\【]/.test(line)
    if (isCategory) {
      // 대분류만 있는 경우
      const categoryName = line.replace(/[\[\】\]]/g, '').trim()
      return `<h4 class="text-base font-semibold text-white mb-2">${escapeHtml(categoryName)}</h4>`
    } else {
      // 일반 텍스트
      const cleanText = line.replace(/^[-–—•]\s*/, '').trim()
      return `<p class="content-text leading-relaxed text-wiki-text">${escapeHtml(cleanText)}</p>`
    }
  }
  
  // 계층 구조 파싱: 대분류([...])와 항목(- ...) 구분
  const sections: Array<{ category?: string; items: string[] }> = []
  let currentCategory: string | null = null
  let currentItems: string[] = []
  
  for (const line of lines) {
    // 대분류 감지: [철도신호원], 【철도수송원】 등
    const categoryMatch = line.match(/^[\[\【]([^\]】]+)[\]】]/)
    if (categoryMatch) {
      // 이전 섹션 저장
      if (currentCategory || currentItems.length > 0) {
        sections.push({
          category: currentCategory || undefined,
          items: currentItems
        })
      }
      // 새 섹션 시작
      currentCategory = categoryMatch[1].trim()
      currentItems = []
    } else {
      // 항목 추가 (하이픈 제거)
      const cleanItem = line.replace(/^[-–—•]\s*/, '').trim()
      if (cleanItem) {
        currentItems.push(cleanItem)
      }
    }
  }
  
  // 마지막 섹션 저장
  if (currentCategory || currentItems.length > 0) {
    sections.push({
      category: currentCategory || undefined,
      items: currentItems
    })
  }
  
  // 대분류가 없는 경우: 단순 리스트로 렌더링
  if (sections.length === 1 && !sections[0].category) {
    const items = sections[0].items
    return `<ul class="space-y-2" data-job-duty-list>${renderDutyListItems(items)}</ul>`
  }
  
  // 계층 구조 렌더링: 대분류 제목 + 항목 리스트
  const sectionsHtml = sections
    .map((section, index) => {
      if (!section.items.length) return ''
      
      // 대분류 제목
      const categoryMargin = index === 0 ? 'mt-0' : 'mt-6'
      const categoryHtml = section.category
        ? `<h4 class="text-base font-semibold text-white mb-3 ${categoryMargin}">${escapeHtml(section.category)}</h4>`
        : ''
      
      const listHtml = `<ul class="space-y-2" data-job-duty-list>${renderDutyListItems(section.items)}</ul>`
      
      return `<div>${categoryHtml}${listHtml}</div>`
    })
    .filter(Boolean)
    .join('')
  
  return `<div class="space-y-4">${sectionsHtml}</div>`
}

const matchesLawyerIdentifier = (value?: string | null): boolean => {
  if (!value) {
    return false
  }
  const normalized = safeTrim(value).toLowerCase()
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
    return safeTrim(value).length > 0
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
          `<p class="text-[11px] leading-relaxed text-wiki-text${index ? ' mt-1' : ''}">${escapeHtml(safeTrim(line))}</p>`
      )
      .join('')
  }
  if (Array.isArray(value)) {
    const items = value
      .map((item) => {
        if (typeof item === 'string') {
          return safeTrim(item)
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
        const trimmed = safeTrim(raw)
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
 * 직업 내/직업 간 비교 데이터를 표 형식으로 렌더링하는 헬퍼 함수
 * Goyong24 API의 비교 데이터를 표로 시각화합니다.
 */
const renderComparisonTable = (
  withinJob: any,
  betweenJobs: any,
  title: string,
  icon: string,
  uniqueSuffix?: string
): string => {
  if (!withinJob && !betweenJobs) {
    return ''
  }

  const blocks: string[] = []
  const suffix = uniqueSuffix ? `-${uniqueSuffix}` : ''

  // 직업 내 비교 (Within Job) - 표 형식
  if (withinJob && Array.isArray(withinJob) && withinJob.length > 0) {
    const tableId = `within-job-${title.replace(/\s+/g, '-')}${suffix}`
    
    // 먼저 유효한 데이터만 필터링
    const validItems = withinJob.map((item: any) => {
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
      const description = item.chrContCmpr || item.intrstContCmpr || item.valsContCmpr ||
                          item.jobActvImprtncContCmpr || item.jobActvLvlContCmpr ||
                          item.KnwldgContCmpr || item.KnwldgLvlContCmpr ||
                          item.jobAblContCmpr || item.jobAblLvlContCmpr ||
                          item.jobEnvContCmpr || ''
      
      if (!safeTrim(label)) return null
      
      const numericValue = typeof value === 'number' ? value : Number.parseFloat(String(value)) || 0
      return { label, value: numericValue, description }
    }).filter(Boolean)
    
    // 유효한 항목이 없으면 다음 블록(Between Jobs)으로
    if (validItems.length === 0) {
      // return ''하지 않고 계속 진행
    } else {
    
    // 필터링된 유효한 항목들로 행 생성
    const rows = validItems.map((item: any, index: number) => {
      const isHidden = index >= 5
      const hideClass = isHidden ? 'hidden' : ''
      const expandableAttr = isHidden ? 'data-expandable-row="true"' : ''
      
      return `
        <tr class="${hideClass} border-b border-wiki-border/30 hover:bg-wiki-card/30 transition-colors" ${expandableAttr}>
          <td class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">${item.value.toFixed(1)}</td>
          <td class="px-2 py-2 md:px-4 md:py-3 font-medium text-wiki-text" style="font-size: 15px;">${escapeHtml(item.label)}</td>
          <td class="px-2 py-2 md:px-4 md:py-3 text-wiki-muted" style="font-size: 15px;">${escapeHtml(item.description)}</td>
        </tr>
      `
    }).join('')

    const toggleIndicator = validItems.length > 5 ? `
      <div class="mt-3 text-center">
        <div 
          onclick="toggleExpandTable('${tableId}')" 
          id="${tableId}-toggle"
          class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-wiki-primary hover:text-wiki-secondary border border-wiki-primary/50 hover:border-wiki-secondary/50 rounded-lg transition-all cursor-pointer"
        >
          <span id="${tableId}-text">전체보기 (${validItems.length - 5}개 항목)</span>
          <i id="${tableId}-icon" class="fas fa-chevron-down transition-transform"></i>
        </div>
      </div>
    ` : ''

      blocks.push(`
        <div class="bg-transparent md:bg-white/5 rounded-none md:rounded-2xl px-0 md:px-6 py-6 border-0 md:border md:border-wiki-border/50">
          <div class="mb-4">
            <h3 class="text-base font-bold text-wiki-secondary mb-2">
              <i class="fas fa-clover mr-2"></i>직업 내 비교
            </h3>
            <p class="text-xs text-wiki-muted leading-relaxed">
              500여 개 직업 종사자들의 자신의 직업에 대해 평가한 ${title} 관련 항목별 중요도를 직업 내에 비교하여 본 직업에서 중요성(평가점수)이 높게 나타난 항목을 순서대로 제시함
            </p>
          </div>
          <div class="overflow-x-auto">
            <table class="w-full" id="${tableId}">
              <thead class="bg-wiki-card/50 border-b-2 border-wiki-primary/30">
                <tr>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 120px; font-size: 15px;">평균<br/>(5점 만점)</th>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 150px; font-size: 15px;">항목</th>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">설명</th>
                </tr>
              </thead>
              <tbody>
                ${rows}
              </tbody>
            </table>
          </div>
          ${toggleIndicator}
        </div>
      `)
    }
  }

  // 직업 간 비교 (Between Jobs) - 표 형식
  if (betweenJobs && Array.isArray(betweenJobs) && betweenJobs.length > 0) {
    const tableId = `between-jobs-${title.replace(/\s+/g, '-')}${suffix}`
    
    // 먼저 유효한 데이터만 필터링
    const validItems = betweenJobs.map((item: any) => {
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
      const description = item.chrCont || item.intrstCont || item.valsCont ||
                          item.jobActvImprtncCont || item.jobActvLvlCont ||
                          item.knwldgCont || item.knwldgLvlCont ||
                          item.jobAblCont || item.jobAblLvlCont ||
                          item.jobEnvCont || ''
      
      if (!safeTrim(label)) return null
      
      const numericValue = typeof value === 'number' ? value : Number.parseFloat(String(value)) || 0
      return { label, value: numericValue, description }
    }).filter(Boolean)
    
    // 유효한 항목이 없으면 건너뜀
    if (validItems.length === 0) {
      // 계속 진행
    } else {
    
    // 필터링된 유효한 항목들로 행 생성
    const rows = validItems.map((item: any, index: number) => {
      const isHidden = index >= 5
      const hideClass = isHidden ? 'hidden' : ''
      const expandableAttr = isHidden ? 'data-expandable-row="true"' : ''
      
      return `
        <tr class="${hideClass} border-b border-wiki-border/30 hover:bg-wiki-card/30 transition-colors" ${expandableAttr}>
          <td class="px-4 py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">${item.value.toFixed(0)}</td>
          <td class="px-2 py-2 md:px-4 md:py-3 font-medium text-wiki-text" style="font-size: 15px;">${escapeHtml(item.label)}</td>
          <td class="px-2 py-2 md:px-4 md:py-3 text-wiki-muted" style="font-size: 15px;">${escapeHtml(item.description)}</td>
        </tr>
      `
    }).join('')

    const toggleIndicator = validItems.length > 5 ? `
      <div class="mt-3 text-center">
        <div 
          onclick="toggleExpandTable('${tableId}')" 
          id="${tableId}-toggle"
          class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-wiki-primary hover:text-wiki-secondary border border-wiki-primary/50 hover:border-wiki-secondary/50 rounded-lg transition-all cursor-pointer"
        >
          <span id="${tableId}-text">전체보기 (${validItems.length - 5}개 항목)</span>
          <i id="${tableId}-icon" class="fas fa-chevron-down transition-transform"></i>
        </div>
      </div>
    ` : ''

      blocks.push(`
        <div class="bg-transparent md:bg-white/5 rounded-none md:rounded-2xl p-0 md:p-6 border-0 md:border md:border-wiki-border/50 ${withinJob ? 'mt-8' : ''}">
          <div class="mb-4">
            <h3 class="text-base font-bold text-wiki-secondary mb-2">
              <i class="fas fa-exchange-alt mr-2"></i>직업 간 비교
            </h3>
            <p class="text-xs text-wiki-muted leading-relaxed">
              500여 개 직업 종사자들의 자신의 직업에 대해 평가한 ${title} 관련 항목별 중요도를 직업 간에 비교하여 본 직업에서 중요성(백분위)이 높게 나타난 항목을 순서대로 제시함
            </p>
          </div>
          <div class="overflow-x-auto">
            <table class="w-full" id="${tableId}">
              <thead class="bg-wiki-card/50 border-b-2 border-wiki-primary/30">
                <tr>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 120px; font-size: 15px;">백분위</th>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 150px; font-size: 15px;">항목</th>
                  <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">설명</th>
                </tr>
              </thead>
              <tbody>
                ${rows}
              </tbody>
            </table>
          </div>
          ${toggleIndicator}
        </div>
      `)
    }
  }

  return blocks.join('')
}

/**
 * 직업 내/직업 간 비교 데이터를 렌더링하는 헬퍼 함수 (레거시 - 진행바 형식)
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
        
        if (!safeTrim(label)) return ''
        
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
                <span class="content-text font-medium text-wiki-text">${escapeHtml(label)}</span>
                <span class="content-text font-semibold text-wiki-primary">${numericValue.toFixed(1)}</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3 overflow-hidden">
                <div class="${barColor} h-3 rounded-full transition-all duration-300" style="width: ${percentage.toFixed(1)}%"></div>
              </div>
            </div>
          `
        }
        return `<li class="content-text text-wiki-text">${escapeHtml(label)}</li>`
      })
      .filter(Boolean)
      .join('')

    if (withinJobHtml) {
      blocks.push(`
        <div>
          <h3 class="content-heading">
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
        
        if (!safeTrim(label)) return ''
        
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
                <span class="content-text font-semibold text-wiki-accent">${numericValue.toFixed(0)}%</span>
              </div>
              <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3 overflow-hidden">
                <div class="${barColor} h-3 rounded-full transition-all duration-300" style="width: ${percentage}%"></div>
              </div>
            </div>
          `
        }
        return `<li class="content-text text-wiki-text">${escapeHtml(label)}</li>`
      })
      .filter(Boolean)
      .join('')

    if (betweenJobsHtml) {
      blocks.push(`
        <div class="mt-6">
          <h3 class="content-heading">
            <i class="${icon} mr-2"></i>직업 간 비교
          </h3>
          <div>${betweenJobsHtml}</div>
        </div>
      `)
    }
  }

  return blocks.join('')
}

// 진로탐색활동 렌더링
const renderResearchList = (researchList: any[]): string => {
  if (!researchList || !Array.isArray(researchList) || researchList.length === 0) {
    return ''
  }

  // 각 활동 유형에 맞는 아이콘 매핑
  const getActivityIcon = (text: string): string => {
    if (text.includes('법 체험') || text.includes('진로체험') || text.includes('프로그램')) {
      return 'fa-user-graduate'  // 체험 프로그램
    }
    if (text.includes('원격영상') || text.includes('멘토링') || text.includes('사이트')) {
      return 'fa-video'  // 원격 멘토링
    }
    if (text.includes('모의법정') || text.includes('동아리')) {
      return 'fa-gavel'  // 모의법정 (법정 망치)
    }
    return 'fa-compass'  // 기본 아이콘 (진로 탐색)
  }

  const items = researchList
    .filter((item) => item && typeof item === 'object' && item.research)
    .map((item) => {
      const text = item.research || ''
      const icon = getActivityIcon(text)
      
      return `
        <li class="flex items-start gap-3">
          <span class="flex-shrink-0 flex h-8 w-8 items-center justify-center rounded-lg bg-wiki-primary/20 text-wiki-secondary mt-1">
            <i class="fas ${icon}"></i>
          </span>
          <p class="content-text text-wiki-text flex-1">${escapeHtml(text)}</p>
        </li>
      `
    })
    .join('')

  if (!items) {
    return ''
  }

  return `<ul class="space-y-4">${items}</ul>`
}

const renderResearchBullets = (researchList: any[]): string => {
  if (!researchList || !Array.isArray(researchList) || researchList.length === 0) {
    return ''
  }
  const normalizedItems = researchList
    .map((item) => {
      if (typeof item === 'string') {
        return safeTrim(item)
      }
      if (item && typeof item === 'object') {
        return safeTrim(item.research || item.title || item.list_content || '')
      }
      return ''
    })
    .filter(Boolean)

  if (!normalizedItems.length) {
    return ''
  }

  const list = normalizedItems
    .map(
      (text) =>
        `<li class="flex items-start gap-2 text-[15px] leading-relaxed text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(
          text
        )}</span></li>`
    )
    .join('')
  return `<ul class="space-y-2">${list}</ul>`
}

// 태그 렌더링
const renderTags = (tagList: any[]): string => {
  if (!tagList || !Array.isArray(tagList) || tagList.length === 0) {
    return ''
  }

  // tagList는 단순 string[] 배열
  const tags = tagList
    .filter((tag) => typeof tag === 'string' && safeTrim(tag))
    .map((tag) => {
      const tagText = tag.startsWith('#') ? tag : `#${tag}`
      return `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-gradient-to-r from-blue-500/20 to-purple-500/20 border border-blue-400/30 content-text font-medium text-blue-200 hover:bg-blue-500/30 hover:border-blue-400/50 transition-all duration-200">
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
          <p class="mt-1 content-text text-wiki-muted">직업과 관련된 키워드를 확인하세요</p>
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

  // indicatorChart 데이터 구조:
  // Type 1 (타입 정의): [{ indicator: "name", indicator_data: "value", source: "..." }]
  // Type 2 (실제 API): [{ category: "융합성,대인관계,...", value: 0, description: "1.7,0.2,..." }]
  
  let categories: string[] = []
  let values: number[] = []
  
  // Type 2 형식 확인 (category와 description 필드)
  const firstItem = indicatorData[0]
  if (firstItem && firstItem.category && firstItem.description) {
    categories = firstItem.category.split(',').map((c: string) => safeTrim(c))
    values = firstItem.description.split(',').map((v: string) => Number.parseFloat(safeTrim(v)) || 0)
  }
  // Type 1 형식 확인 (indicator와 indicator_data 필드)
  else if (indicatorData.every(item => item && (item.indicator || item.indicator_data))) {
    // indicator와 indicator_data가 콤마로 구분된 문자열인 경우 처리
    const firstIndicator = indicatorData[0]
    if (firstIndicator && firstIndicator.indicator && typeof firstIndicator.indicator === 'string' && firstIndicator.indicator.includes(',')) {
      // 콤마로 구분된 경우
      categories = firstIndicator.indicator.split(',').map((c: string) => safeTrim(c))
      const dataStr = String(firstIndicator.indicator_data || '')
      values = dataStr.split(',').map((v: string) => Number.parseFloat(safeTrim(v)) || 0)
    } else {
      // 각 항목이 개별 객체인 경우
      categories = indicatorData.map(item => item.indicator || '지표').filter(Boolean)
      values = indicatorData.map(item => {
        const val = item.indicator_data
        return typeof val === 'number' ? val : Number.parseFloat(String(val)) || 0
      })
    }
  }

  if (categories.length === 0 || values.length === 0 || categories.length !== values.length) {
    return ''
  }

  // 각 지표별 색상 (스크린샷 참고)
  const barColors = [
    'rgba(168, 85, 247, 0.8)',   // purple
    'rgba(59, 130, 246, 0.8)',   // blue
    'rgba(236, 72, 153, 0.8)',   // pink
    'rgba(251, 191, 36, 0.8)',   // amber
    'rgba(251, 146, 60, 0.8)',   // orange
    'rgba(163, 163, 122, 0.8)',  // olive
    'rgba(244, 165, 171, 0.8)',  // light pink
    'rgba(16, 185, 129, 0.8)'    // green
  ]

  // 카테고리와 값을 함께 묶어서 정렬 (높은 순으로)
  const combined = categories.map((cat, idx) => ({
    category: cat,
    value: values[idx],
    originalIndex: idx
  }))
  
  // 값이 높은 순으로 정렬
  combined.sort((a, b) => b.value - a.value)
  
  // 정렬된 데이터로 분리
  const sortedCategories = combined.map(item => item.category)
  const sortedValues = combined.map(item => item.value)
  const sortedColors = combined.map(item => barColors[item.originalIndex % barColors.length])

  // 최대값 찾기 (스케일링용)
  const maxValue = Math.max(...sortedValues, 5) // 최소 5로 설정

  // Chart.js용 고유 ID
  const chartId = `indicator-chart-${Date.now()}`

  return `
    <div class="space-y-6">
      <!-- 차트 컨테이너 -->
      <div class="w-full bg-transparent md:bg-white/5 rounded-none md:rounded-2xl px-0 md:px-6 py-6 border-0 md:border md:border-wiki-border/50">
        <canvas id="${chartId}" style="max-height: 400px;"></canvas>
      </div>
      
      <!-- 범례 -->
      <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
        ${sortedCategories.map((label, idx) => `
          <div class="flex items-center gap-2">
            <div class="w-4 h-4 rounded-full flex-shrink-0" style="background-color: ${sortedColors[idx]}"></div>
            <span class="text-wiki-text text-sm font-medium">${escapeHtml(label)} ${sortedValues[idx].toFixed(1)}%</span>
          </div>
        `).join('')}
      </div>
      
      <!-- 출처 표시 -->
      <div class="text-center text-xs text-wiki-muted mt-4">
        [자료 : 한국직업정보연구원, 맞춤형취업지원을 위한 직업지표 연구(2020~22)]
      </div>
    </div>
    
    <script>
      (function() {
        const ctx = document.getElementById('${chartId}');
        if (ctx && typeof Chart !== 'undefined') {
          new Chart(ctx, {
            type: 'bar',
            data: {
              labels: ${JSON.stringify(sortedCategories)},
              datasets: [{
                data: ${JSON.stringify(sortedValues)},
                backgroundColor: ${JSON.stringify(sortedColors)},
                borderWidth: 0,
                borderRadius: 8,
                barThickness: 'flex',
                maxBarThickness: 60
              }]
            },
            options: {
              responsive: true,
              maintainAspectRatio: true,
              indexAxis: 'x',
              scales: {
                y: {
                  beginAtZero: true,
                  max: 100,
                  ticks: {
                    color: 'rgba(255, 255, 255, 0.6)',
                    font: {
                      size: 11
                    },
                    callback: function(value) {
                      return value + '%';
                    }
                  },
                  grid: {
                    color: 'rgba(255, 255, 255, 0.1)',
                    drawBorder: false
                  }
                },
                x: {
                  ticks: {
                    color: 'rgba(255, 255, 255, 0.7)',
                    font: {
                      size: 11,
                      weight: '500'
                    },
                    maxRotation: 45,
                    minRotation: 0
                  },
                  grid: {
                    display: false,
                    drawBorder: false
                  }
                }
              },
              plugins: {
                legend: {
                  display: false
                },
                tooltip: {
                  backgroundColor: 'rgba(0, 0, 0, 0.8)',
                  padding: 12,
                  titleFont: {
                    size: 13,
                    weight: 'bold'
                  },
                  bodyFont: {
                    size: 12
                  },
                  callbacks: {
                    label: function(context) {
                      return context.parsed.y.toFixed(1) + '%';
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
      extract: (entry) => entry?.kecoCodes?.map((item) => `${item.code} - ${item.name}`).filter((str): str is string => Boolean(str && safeTrim(str)))
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
      extract: (entry) => entry?.relatedMajors?.map((item) => item.name).filter((name): name is string => Boolean(name && safeTrim(name)))
    },
    { key: 'relatedCertificates', label: '관련 자격증 (추천 자격)', extract: (entry) => entry?.relatedCertificates },
    
    // 관련 정보
    {
      key: 'relatedJobs',
      label: '관련 직업 (유사 직업)',
      extract: (entry) => entry?.relatedJobs?.map((item) => item.name).filter((name): name is string => Boolean(name && safeTrim(name)))
    },
    {
      key: 'relatedOrganizations',
      label: '관련 기관 (관련 단체)',
      extract: (entry) => entry?.relatedOrganizations?.map((item) => item.name).filter((name): name is string => Boolean(name && safeTrim(name)))
    },
    
    // CareerNet 확장 필드들 (배열 데이터)
    {
      key: 'workList',
      label: '세부 업무 목록',
      extract: (entry) => entry?.workList?.map((item) => `${item.workName}: ${item.workDesc}`).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'performList.environment',
      label: '업무 환경 (중요도별)',
      extract: (entry) => entry?.performList?.environment
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'performList.perform',
      label: '업무 수행 능력 (중요도별)',
      extract: (entry) => entry?.performList?.perform
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'performList.knowledge',
      label: '필요 지식 (중요도별)',
      extract: (entry) => entry?.performList?.knowledge
        ?.sort((a, b) => (b.importance || 0) - (a.importance || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (중요도: ${item.importance})`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'abilityList',
      label: '필요 능력 (점수별)',
      extract: (entry) => entry?.abilityList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'aptitudeList',
      label: '필요 적성 (점수별)',
      extract: (entry) => entry?.aptitudeList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'interestList',
      label: '흥미 유형 (점수별)',
      extract: (entry) => entry?.interestList
        ?.sort((a, b) => (b.score || 0) - (a.score || 0))
        .slice(0, 10)
        .map((item) => `${item.name} (${item.score}점)`)
        .filter((str): str is string => Boolean(str && safeTrim(str)))
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
      extract: (entry) => entry?.forecastList?.map((item) => `[${item.period}] ${item.outlook}: ${item.description}`).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'indicatorChart',
      label: '직업 지표',
      extract: (entry) => entry?.indicatorChart?.map((item) => `${item.category}: ${item.value} (${item.description})`).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'relVideoList',
      label: '관련 영상 자료',
      extract: (entry) => entry?.relVideoList?.map((item) => `${item.title} [${item.duration}]`).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'relSolList',
      label: '관련 자료',
      extract: (entry) => entry?.relSolList?.map((item) => item.title).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'relJinsolList',
      label: '진로 상담 자료',
      extract: (entry) => entry?.relJinsolList?.map((item) => item.title).filter((str): str is string => Boolean(str && safeTrim(str)))
    },
    {
      key: 'researchList',
      label: '연구 자료',
      extract: (entry) => entry?.researchList?.map((item) => `${item.title} (${item.author}, ${item.date})`).filter((str): str is string => Boolean(str && safeTrim(str)))
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
    .filter((row) => row && safeTrim(row).length > 0)
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

// ETL 데이터 구조에서 이름 추출 (majorNm, depart_name, name 등 다양한 필드 지원)
const extractEntityName = (entity: any): string => {
  if (!entity) return ''
  if (typeof entity === 'string') return entity
  return safeTrim(entity.name || entity.majorNm || entity.depart_name || entity.jobNm || '')
}

const buildEntityUrl = (entity: JobRelatedEntity | any, type: 'job' | 'major'): string => {
  const entityName = extractEntityName(entity)
  const identifier = entity?.id?.trim()
  if (!identifier && !entityName) return '#'
  const slug = composeDetailSlug(type, entityName, identifier ?? entityName)
  return `/${type}/${encodeURIComponent(slug)}`
}

const renderEntityList = (
  entities: JobRelatedEntity[] | any[] | null | undefined,
  type: 'job' | 'major' = 'job',
  emptyText = '정보 없음'
): string => {
  if (!entities || entities.length === 0) {
    return `<p class="content-text text-wiki-muted">${escapeHtml(emptyText)}</p>`
  }

  return `
    <ul class="space-y-2" role="list">
      ${entities
        .filter((entity) => !!extractEntityName(entity))
        .map((entity) => {
          const name = escapeHtml(extractEntityName(entity))
          const url = buildEntityUrl(entity, type)
          const typeIcon = type === 'job' ? 'fa-briefcase' : 'fa-graduation-cap'
          return `
            <li>
              <a href="${url}" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
                <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
                  <i class="fas ${typeIcon} text-xs" aria-hidden="true"></i>
                </span>
                <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${name}</span>
                <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
              </a>
            </li>
          `
        })
        .join('')}
    </ul>
  `
}

const renderDistributionList = (distribution?: Record<string, string | undefined> | null, labels?: Record<string, string>): string => {
  if (!distribution) {
    return ''
  }

  const entries = Object.entries(distribution)
    .filter(([, value]) => !!value && !!safeTrim(value))
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
          <li class="flex justify-between content-text">
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
  if (!salary || !safeTrim(salary)) {
    return ''
  }

  const raw = safeTrim(salary)
  
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
      return buildCard('임금 정보', 'fa-coins', `<p class="content-text text-wiki-text">${escapeHtml(raw)}</p>`, options ?? {})
    }

    const values = matches
      .map((value) => Number.parseInt(value.replace(/,/g, ''), 10))
      .filter((value) => Number.isFinite(value) && value > 0)

    if (!values.length) {
      return buildCard('임금 정보', 'fa-coins', `<p class="content-text text-wiki-text">${escapeHtml(raw)}</p>`, options ?? {})
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
  // 평균값만 있는 경우 (dataset이 1개)
  const isSingleAverage = dataset.length === 1 && dataset[0].label === '평균'
  
  const barMarkup = dataset
    .map(({ label, value }) => {
      const percent = maxValue === 0 ? 0 : Math.round((value / maxValue) * 100)
      const width = Math.min(100, Math.max(12, percent))
      const isMedian = label === '평균 50%'
      const isAverage = label === '평균'
      // 평균 50% 또는 단일 평균값일 때 강조
      const shouldEmphasize = isMedian || (isSingleAverage && isAverage)
      const textSize = shouldEmphasize ? 'text-base' : 'text-[15px]'
      const textColor = shouldEmphasize ? 'text-white font-bold' : 'text-wiki-muted font-semibold'
      const barHeight = shouldEmphasize ? 'h-3' : 'h-2'
      return `
        <div class="space-y-1" data-cw-telemetry-component="job-salary-bar">
          <div class="flex justify-between ${textSize} ${textColor}">
            <span>${escapeHtml(label)}</span>
            <span>${formatSalaryValue(value)}</span>
          </div>
          <div class="${barHeight} rounded-full bg-wiki-border/40 overflow-hidden">
            <div class="h-full bg-gradient-to-r from-wiki-primary to-wiki-secondary" style="width:${width}%"></div>
          </div>
        </div>
      `
    })
    .join('')

  // 조사년도 추출
  const yearMatch = raw.match(/조사년도\s*[:：]?\s*(\d{4})\s*년?/)
  const yearInfo = yearMatch ? `※ 조사년도: ${yearMatch[1]}년` : ''
  
  // 주석 내용
  const disclaimer = '※ 위의 임금정보는 직업당 평균 30명의 재직자를 대상으로 실시한 설문조사 결과로, 재직자의 자기보고에 근거한 통계치입니다. 재직자의 경력, 근무업체의 규모 등에 따라 실제 임금과 차이가 있을 수 있으니, 직업간 비교를 위한 참고 자료로만 활용하여 주시길 바랍니다.'

  return buildCard(
    '임금 정보',
    'fa-coins',
    `
      <div class="space-y-4" data-cw-telemetry-component="job-salary-card">
        <div class="space-y-2">${barMarkup}</div>
        <div class="space-y-1.5">
          ${yearInfo ? `<p class="text-xs text-wiki-muted leading-relaxed">${escapeHtml(yearInfo)}</p>` : ''}
          <p class="text-xs text-wiki-muted leading-relaxed">${escapeHtml(disclaimer)}</p>
        </div>
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
    .filter(([, value]) => typeof value === 'string' && safeTrim(value).length > 0)

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
          <div class="flex items-center justify-between content-text">
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

// 학력·전공 분포 통합 렌더링 함수
const renderCombinedDistributionCharts = (
  educationDistribution?: Record<string, string | undefined> | null,
  majorDistribution?: Record<string, string | undefined> | null,
  options?: BuildCardOptions
): string => {
  // 데이터 파싱 헬퍼 함수
  const parseDistributionData = (
    distribution: Record<string, string | undefined> | null | undefined,
    labels: Record<string, string>
  ) => {
    if (!distribution) return null

    const entries = Object.entries(distribution)
      .filter(([, value]) => typeof value === 'string' && safeTrim(value).length > 0)

    if (!entries.length) return null

    const parsed = entries.map(([key, value]) => {
      const label = labels[key] ?? key
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
    return numericEntries.length > 0 ? numericEntries : null
  }

  // 학력 데이터 파싱
  const educationData = parseDistributionData(educationDistribution, {
    middleSchoolOrLess: '중학교 이하',
    highSchool: '고등학교',
    college: '전문대',
    university: '대학',
    graduate: '석사 이상',
    doctor: '박사'
  })

  // 전공 데이터 파싱
  const majorData = parseDistributionData(majorDistribution, {
    humanities: '인문계열',
    social: '사회계열',
    education: '교육계열',
    engineering: '공학계열',
    natural: '자연계열',
    medical: '의약계열',
    artsSports: '예체능'
  })

  // 둘 다 데이터가 없으면 빈 문자열 반환
  if (!educationData && !majorData) {
    return ''
  }

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

  // 단일 차트 렌더링 함수
  const renderSingleChart = (
    data: Array<{ label: string; raw: string; numeric: number | null }>,
    title: string,
    chartId: string,
    sortByValue: boolean = false
  ) => {
    // 전공 분포의 경우 높은 순으로 정렬
    const sortedData = sortByValue 
      ? [...data].sort((a, b) => (b.numeric || 0) - (a.numeric || 0))
      : data

    const chartLabels = data.map(e => e.label)
    const chartData = data.map(e => e.numeric)

    return `
      <div class="flex-1 flex flex-col items-center">
        <h3 class="text-lg font-bold text-wiki-secondary mb-4 text-center">${title}</h3>
        <div class="w-full max-w-xs mx-auto mb-4">
          <canvas id="${chartId}"></canvas>
        </div>
        <div class="w-full max-w-xs space-y-2.5">
          ${sortedData.map((entry, idx) => {
            // 원본 데이터에서 인덱스 찾기 (색상 매칭용)
            const originalIdx = data.findIndex(d => d.label === entry.label)
            return `
            <div class="flex items-center justify-between content-text py-1">
              <div class="flex items-center gap-2.5">
                <div class="w-4 h-4 rounded-full flex-shrink-0" style="background-color: ${chartColors[originalIdx % chartColors.length]}"></div>
                <span class="text-wiki-text font-medium">${escapeHtml(entry.label)}</span>
              </div>
              <span class="font-bold text-wiki-primary">${entry.raw.includes('%') ? entry.raw : entry.raw + '%'}</span>
            </div>
          `}).join('')}
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
                  backgroundColor: ${JSON.stringify(chartColors.slice(0, data.length))},
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
                        return label + ': ' + percentage + '%';
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
  }

  const timestamp = Date.now()
  let chartsHtml = ''

  // 두 차트 모두 있을 경우 가로로 배치
  if (educationData && majorData) {
    const educationChartId = `chart-education-${timestamp}`
    const majorChartId = `chart-major-${timestamp}`
    
    chartsHtml = `
      <div class="flex flex-col lg:flex-row gap-8">
        ${renderSingleChart(educationData, '학력 분포', educationChartId, false)}
        ${renderSingleChart(majorData, '전공 분포', majorChartId, true)}
      </div>
    `
  } else if (educationData) {
    // 학력만 있을 경우
    const educationChartId = `chart-education-${timestamp}`
    chartsHtml = renderSingleChart(educationData, '학력 분포', educationChartId, false)
  } else if (majorData) {
    // 전공만 있을 경우
    const majorChartId = `chart-major-${timestamp}`
    chartsHtml = renderSingleChart(majorData, '전공 분포', majorChartId, true)
  }

  return buildCard('학력·전공 분포', 'fa-graduation-cap', chartsHtml, options ?? {})
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
    .filter(([, value]) => typeof value === 'string' && safeTrim(value).length > 0)

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
          <div class="flex justify-between content-text text-wiki-muted">
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
  return (prefix: 'overview' | 'details' | 'characteristics', title: string) => {
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

const renderSectionToc = (sectionKey: 'overview' | 'details' | 'characteristics', heading: string, items: TocItem[]): string => {
  // 항목이 1개 이하면 목차 숨김 (목차가 의미 없음)
  if (items.length <= 1) {
    return ''
  }

  const headingIcon = sectionKey === 'overview' ? 'fa-list-check' : sectionKey === 'characteristics' ? 'fa-chart-pie' : 'fa-layer-group'

  const listMarkup = items
    .map((item, index) => `
        <li data-toc-order="${index + 1}">
          <a
            href="#${escapeHtml(item.id)}"
            class="flex items-center gap-3 rounded-xl border border-transparent bg-wiki-bg/45 px-3 py-2 md:px-4 md:py-3 text-sm text-wiki-muted transition hover:text-white hover:border-wiki-primary/60"
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
      class="glass-card border-0 md:border px-2 py-6 md:px-6 rounded-none md:rounded-2xl md:border-wiki-border/60 bg-wiki-bg/70"
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
        <h3 class="text-base md:text-lg font-bold text-white leading-tight">${escapeHtml(heading)}</h3>
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
  if (!body || !safeTrim(body)) {
    return ''
  }

  return `
    <section class="glass-card border-0 md:border px-3 py-4 md:px-5 md:py-5 rounded-lg md:rounded-2xl space-y-4 bg-transparent md:bg-wiki-bg/30" data-job-sidebar-section>
      <div class="flex items-center gap-2.5 pb-2 border-b border-wiki-border/30 md:border-0 md:pb-0">
        <span class="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-wiki-secondary/15 text-wiki-secondary">
          <i class="fas ${icon} text-sm" aria-hidden="true"></i>
        </span>
        <h3 class="text-base font-bold text-white">${escapeHtml(title)}</h3>
      </div>
      ${body}
    </section>
  `
}

const renderJobSidebar = (profile: UnifiedJobDetail): string => {
  const sections: string[] = []

  // 연관 직업 (ETL 구조화 필드 sidebarJobs 사용)
  const sidebarJobs = profile.sidebarJobs
  if (sidebarJobs?.length) {
    const limit = 5
    // 유효한 이름이 있는 직업만 필터링 + 자기 자신 제외
    const currentJobName = profile.name?.trim().toLowerCase()
    const validJobs = sidebarJobs.filter((entity) => {
      const entityName = extractEntityName(entity)
      if (!entityName) return false
      // 자기 자신 제외 (이름이 같으면 제외)
      if (currentJobName && entityName.trim().toLowerCase() === currentJobName) return false
      return true
    })
    
    if (validJobs.length > 0) {
      const hasMore = validJobs.length > limit
      const visibleJobs = validJobs.slice(0, limit)
      const hiddenJobs = validJobs.slice(limit)
      
      const renderJob = (entity: JobRelatedEntity | any, isHidden: boolean = false) => {
        const name = escapeHtml(extractEntityName(entity))
        const url = buildEntityUrl(entity, 'job')
        return `
          <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
            <a href="${url}" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
              <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
                <i class="fas fa-briefcase text-xs" aria-hidden="true"></i>
              </span>
              <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${name}</span>
              <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
            </a>
          </li>
        `
      }
      
      const jobsList = [
        ...visibleJobs.map(job => renderJob(job, false)),
        ...hiddenJobs.map(job => renderJob(job, true))
      ].join('')
      
      const toggleButton = hasMore ? `
        <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
          <span class="toggle-text">더보기</span>
          <span class="toggle-count text-xs opacity-75">(+${hiddenJobs.length})</span>
          <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
        </button>
      ` : ''
      
      sections.push(
        renderSidebarSection(
          '관련 직업',
          'fa-user-tie',
          `
            <div class="expandable-list">
              <ul class="space-y-2" role="list">${jobsList}</ul>
              ${toggleButton}
            </div>
          `
        )
      )
    }
  }

  // 관련 전공 (ETL 구조화 필드 sidebarMajors 사용)
  const sidebarMajors = profile.sidebarMajors
  if (sidebarMajors?.length) {
    const limit = 5
    // 유효한 이름이 있는 전공만 필터링
    const validMajors = sidebarMajors.filter((m: any) => !!extractEntityName(m))
    
    if (validMajors.length > 0) {
      const hasMore = validMajors.length > limit
      const visibleMajors = validMajors.slice(0, limit)
      const hiddenMajors = validMajors.slice(limit)
      
      const renderMajor = (entity: any, isHidden: boolean = false) => {
        const name = escapeHtml(extractEntityName(entity))
        const url = buildEntityUrl(entity, 'major')
        return `
          <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
            <a href="${url}" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
              <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
                <i class="fas fa-graduation-cap text-xs" aria-hidden="true"></i>
              </span>
              <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${name}</span>
              <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
            </a>
          </li>
        `
      }
      
      const majorsList = [
        ...visibleMajors.map(major => renderMajor(major, false)),
        ...hiddenMajors.map(major => renderMajor(major, true))
      ].join('')
      
      const toggleButton = hasMore ? `
        <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
          <span class="toggle-text">더보기</span>
          <span class="toggle-count text-xs opacity-75">(+${hiddenMajors.length})</span>
          <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
        </button>
      ` : ''
      
      sections.push(
        renderSidebarSection(
          '관련 전공',
          'fa-graduation-cap',
          `
            <div class="expandable-list">
              <ul class="space-y-2" role="list">${majorsList}</ul>
              ${toggleButton}
            </div>
          `
        )
      )
    }
  }

  // 관련 HowTo 섹션 제거 (API 데이터만 표시)
  // const recommendedHowtos = resolveRecommendedHowtos(profile.id)
  // if (recommendedHowtos.length) {
  //   const list = recommendedHowtos
  //     .map(
  //       (item) => `
  //         <li>
  //           <a href="${escapeHtml(item.href)}" class="flex flex-col gap-1 rounded-lg border border-wiki-border/40 md:border-wiki-border/70 bg-wiki-bg/60 px-3 py-2 md:px-4 md:py-3 content-text text-wiki-primary hover:border-wiki-primary hover:text-white transition">
  //             <span class="font-semibold">${escapeHtml(item.label)}</span>
  //             <span class="text-xs text-wiki-muted">CareerWiki HowTo</span>
  //           </a>
  //         </li>
  //       `
  //     )
  //     .join('')
  //   sections.push(
  //     renderSidebarSection(
  //       '관련 HowTo',
  //       'fa-route',
  //       `<ul class="space-y-2" role="list">${list}</ul>`
  //     )
  //   )
  // }

  const organizations = renderOrganizationsList(profile)
  if (organizations) {
    sections.push(renderSidebarSection('관련 기관', 'fa-building', organizations))
  }

  // 관련 자격증 (ETL 구조화 필드 sidebarCerts 사용)
  const sidebarCerts = profile.sidebarCerts
  if (sidebarCerts?.length) {
    const limit = 5
    // sidebarCerts는 { name, url } 객체 배열
    const certificates = sidebarCerts
      .map((item: any) => safeTrim(item?.name || item))
      .filter((item) => !!item)
    if (certificates.length) {
      const hasMore = certificates.length > limit
      const visibleCertificates = certificates.slice(0, limit)
      const hiddenCertificates = certificates.slice(limit)

      const renderCertificate = (label: string, isHidden: boolean = false) => `
        <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
          <div class="flex items-center gap-2.5 px-3 py-2 rounded-lg bg-wiki-bg/40 border border-wiki-border/40 hover:border-wiki-primary/40 hover:bg-wiki-primary/5 transition-all duration-200">
            <span class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-wiki-primary/15 text-wiki-primary">
              <i class="fas fa-certificate text-[9px]" aria-hidden="true"></i>
            </span>
            <span class="text-sm text-wiki-text font-medium">${escapeHtml(label)}</span>
          </div>
        </li>
      `

      const chipsList = [
        ...visibleCertificates.map((cert) => renderCertificate(cert, false)),
        ...hiddenCertificates.map((cert) => renderCertificate(cert, true))
      ].join('')

      const toggleButton = hasMore
        ? `
      <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
        <span class="toggle-text">더보기</span>
        <span class="toggle-count text-xs opacity-75">(+${hiddenCertificates.length})</span>
        <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
      </button>
    `
        : ''

      sections.push(
        renderSidebarSection(
          '추천 자격증',
          'fa-certificate',
          `
            <div class="expandable-list">
              <ul class="space-y-1.5" role="list">${chipsList}</ul>
              ${toggleButton}
            </div>
          `
        )
      )
    }
  }
  
  // 직업 준비 정보 (jobReadyList) - 사이드바에서 제거 (상세정보 탭으로 이동)

  return sections.filter((section) => section && safeTrim(section).length > 0).join('')
}

const renderSourcesCollapsible = (
  profile: UnifiedJobDetail,
  sources?: SourceStatusRecord,
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
): string => {
  const normalizedId = profile.id.replace(/[^a-z0-9]+/gi, '-').toLowerCase() || 'default'
  const panelId = `job-source-panel-${normalizedId}`
  const normalizedSources = Array.isArray(profile.sources) ? profile.sources : []

  const normalizedPartials: Partial<Record<DataSource, UnifiedJobDetail | null>> = {
    ...partials
  }
  const hasCareernetSource = normalizedSources.includes('CAREERNET')
  const hasWork24JobSource = normalizedSources.some((source) =>
    source === 'GOYONG24' || source === 'WORK24_JOB'
  )
  const hasWork24DjobSource = normalizedSources.includes('WORK24_DJOB')

  if (hasCareernetSource && !normalizedPartials.CAREERNET) {
    normalizedPartials.CAREERNET = profile
  }
  if (hasWork24JobSource && !normalizedPartials.GOYONG24) {
    normalizedPartials.GOYONG24 = profile
  }
  if (hasWork24DjobSource && !normalizedPartials.WORK24_DJOB) {
    normalizedPartials.WORK24_DJOB = profile
  }

  const panel = renderSourcesPanel({
    profile,
    sources,
    partials: normalizedPartials,
    labels: DEFAULT_SOURCE_LABELS,
    descriptions: SOURCE_DESCRIPTIONS,
    title: '출처',
    description: '이 페이지에 노출된 주요 데이터 출처를 확인할 수 있습니다.'
  })

  if (!panel || !safeTrim(panel)) {
    return ''
  }

  const activeSourceCountFromSources = normalizedSources.length
  const fallbackSourceCount = Object.values(normalizedPartials || {}).filter((value) => Boolean(value)).length
  const activeSourceCount = activeSourceCountFromSources || fallbackSourceCount
  const badgeLabel = `${activeSourceCount}개`

  const toggleId = `source-toggle-${normalizedId}`
  const iconId = `source-icon-${normalizedId}`

  return `
    <section class="glass-card p-0 rounded-none md:rounded-2xl border border-wiki-border/60 bg-wiki-bg/50" data-source-collapsible>
      <button
        type="button"
        id="${toggleId}"
        class="w-full flex items-center justify-between gap-3 px-3 py-4 md:px-6 md:py-5 content-text font-semibold text-white transition hover:text-wiki-secondary cursor-pointer"
        aria-controls="${panelId}"
        aria-expanded="false"
      >
        <span class="flex items-center gap-3">
          <i class="fas fa-database text-wiki-secondary text-lg" aria-hidden="true"></i>
          <span class="text-base">데이터 출처</span>
        </span>
        <div class="flex items-center gap-3 text-sm text-wiki-muted">
          <span class="inline-flex items-center gap-1.5 rounded-full border border-wiki-secondary/30 bg-wiki-secondary/10 px-3 py-1.5 text-wiki-secondary font-medium">${escapeHtml(badgeLabel)}</span>
          <i id="${iconId}" class="fas fa-chevron-down text-base transition-transform duration-200" aria-hidden="true"></i>
        </div>
      </button>
      <div class="border-t border-wiki-border/60 hidden bg-wiki-bg/45 px-6 py-5" id="${panelId}">
        ${panel}
      </div>
    </section>
    <script>
      (function() {
        const toggle = document.getElementById('${toggleId}');
        const panel = document.getElementById('${panelId}');
        const icon = document.getElementById('${iconId}');
        
        if (toggle && panel && icon) {
          toggle.addEventListener('click', function() {
            const isExpanded = toggle.getAttribute('aria-expanded') === 'true';
            
            if (isExpanded) {
              panel.classList.add('hidden');
              toggle.setAttribute('aria-expanded', 'false');
              icon.classList.remove('fa-chevron-up');
              icon.classList.add('fa-chevron-down');
            } else {
              panel.classList.remove('hidden');
              toggle.setAttribute('aria-expanded', 'true');
              icon.classList.remove('fa-chevron-down');
              icon.classList.add('fa-chevron-up');
            }
          });
        }
      })();
    </script>
  `
}

const buildJobDemoComments = (profile: UnifiedJobDetail): SampleCommentPayload[] => {
  const now = Date.now()
  const hoursAgo = (hours: number) => new Date(now - hours * 60 * 60 * 1000).toISOString()
  const prefix = (profile.id || profile.name || 'job').replace(/[^a-z0-9]+/gi, '-').toLowerCase()

  type CommentSeed = Omit<SampleCommentPayload, 'id' | 'createdAt' | 'likes' | 'dislikes'> & {
    hoursAgo: number
    likes?: number
    dislikes?: number
  }

  const toPayloads = (seeds: CommentSeed[]): SampleCommentPayload[] =>
    seeds.map((seed, index) => {
      const {
        hoursAgo: hoursOffset,
        likes = 0,
        dislikes = 0,
        ...rest
      } = seed
      return {
        ...rest,
        likes,
        dislikes,
        id: `${prefix}-c${String(index + 1).padStart(2, '0')}`,
        createdAt: hoursAgo(hoursOffset)
      }
    })

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
  ].filter((stat) => typeof stat.value === 'string' && safeTrim(stat.value).length > 0)

  if (!stats.length) {
    return ''
  }

  const valueMarkup = (raw: string): string => {
    const trimmed = safeTrim(raw)
    if (!trimmed.length) {
      return ''
    }
    const [primary, ...rest] = trimmed.split(/\n+/)
    const primaryMarkup = `<p class="content-text font-semibold text-white leading-snug" data-stat-value-primary>${escapeHtml(primary)}</p>`
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
      const noteLabel = noteText && safeTrim(noteText).length ? safeTrim(noteText) : ''
      const noteAttr = noteLabel ? ` data-stat-note="${escapeHtml(noteLabel)}"` : ''
      return `
        <article
          class="group relative overflow-hidden rounded-xl md:rounded-2xl border border-wiki-border/50 bg-wiki-bg/80 p-3 md:p-4 lg:p-5 shadow-sm transition hover:border-wiki-primary/50 hover:shadow-lg"
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
              <h3 class="content-text font-semibold text-white leading-tight">${escapeHtml(stat.label)}</h3>
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
          <p class="mt-1 content-text text-wiki-muted">주요 성과 지표를 한눈에 확인하세요.</p>
        </div>
      </header>
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4" data-cw-stat-grid>
        ${items}
      </div>
    </section>
  `
}

const renderOrganizationsList = (profile: UnifiedJobDetail): string => {
  // ETL 구조화 필드 sidebarOrgs 사용
  const sidebarOrgs = profile.sidebarOrgs
  if (!sidebarOrgs || sidebarOrgs.length === 0) return ''
  
  const validOrgs = sidebarOrgs.filter((org) => !!org?.name?.trim())
  if (validOrgs.length === 0) return ''
  
  const limit = 5
  const hasMore = validOrgs.length > limit
  const visibleOrgs = validOrgs.slice(0, limit)
  const hiddenOrgs = validOrgs.slice(limit)
  
  const renderOrg = (org: any, isHidden: boolean = false) => {
    const name = escapeHtml(safeTrim(org.name))
    if (org.url) {
      // URL에 프로토콜이 없으면 https:// 추가
      let fullUrl = safeTrim(org.url)
      if (!/^https?:\/\//i.test(fullUrl)) {
        fullUrl = `https://${fullUrl}`
      }
      return `
        <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
          <a href="${escapeHtml(fullUrl)}" target="_blank" rel="noopener" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
            <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-secondary/10 text-wiki-secondary group-hover:bg-wiki-secondary/20 transition-colors">
              <i class="fas fa-building text-xs" aria-hidden="true"></i>
            </span>
            <span class="flex-1 text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${name}</span>
            <i class="fas fa-external-link-alt text-[10px] text-wiki-muted/50 group-hover:text-wiki-secondary transition-colors" aria-hidden="true"></i>
          </a>
        </li>
      `
    }
    return `
      <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
        <div class="flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40">
          <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-secondary/10 text-wiki-secondary">
            <i class="fas fa-building text-xs" aria-hidden="true"></i>
          </span>
          <span class="text-sm text-wiki-text font-medium">${name}</span>
        </div>
      </li>
    `
  }
  
  const orgsList = [
    ...visibleOrgs.map(org => renderOrg(org, false)),
    ...hiddenOrgs.map(org => renderOrg(org, true))
  ].join('')
  
  const toggleButton = hasMore ? `
    <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
      <span class="toggle-text">더보기</span>
      <span class="toggle-count text-xs opacity-75">(+${hiddenOrgs.length})</span>
      <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
    </button>
  ` : ''
  
  return `
    <div class="expandable-list">
      <ul class="space-y-2" role="list">${orgsList}</ul>
      ${toggleButton}
    </div>
  `
}

const renderKecoCodeList = (profile: UnifiedJobDetail): string => {
  if (!profile.kecoCodes || profile.kecoCodes.length === 0) return ''
  const items = profile.kecoCodes
    .filter((item) => !!item?.code || !!item?.name)
    .map((item) => {
      const code = item.code ? `<span class="text-wiki-muted mr-2">${escapeHtml(item.code)}</span>` : ''
      const name = item.name ? escapeHtml(item.name) : ''
      return `<li class="content-text text-wiki-text">${code}${name}</li>`
    })
  return items.length ? `<ul class="space-y-2">${items.join('')}</ul>` : ''
}



export const renderUnifiedJobDetail = ({ profile, partials, sources, rawApiData }: UnifiedJobDetailTemplateParams): string => {
  // profile은 merged_profile_json에서 파싱된 데이터 (평탄한 구조 + 계층적 구조 병행)
  // ETL에서 기본 필드들을 모두 포함하고 있음
  
  const telemetryVariant = resolveJobTelemetryVariant(profile)
  const telemetryVariantAttr = telemetryVariant ? ` data-cw-telemetry-variant="${escapeHtml(telemetryVariant)}"` : ''
  // Quick Stats removed from hero section
  const quickStats = ''
  /*
  const quickStatsDisabled = renderQuickStats(
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
  */
  // 히어로 섹션 데이터 (ETL에서 병합된 필드 사용)
  const normalizedSources = Array.isArray(profile.sources) ? profile.sources : []
  const hasOnlyWork24DictionarySources =
    normalizedSources.length > 0 &&
    normalizedSources.every((source) => source === 'WORK24_DJOB')

  const heroTitle = profile.heroTitle || profile.name
  const heroDescription =
    profile.heroIntro?.split('\n')[0]?.trim() ||
    profile.summary?.split('\n')[0]?.trim() ||
    profile.work?.summary?.split('\n')[0]?.trim() ||
    profile.duties?.split('\n')[0]?.trim() ||
    rawApiData?.goyong24?.duty?.jobSum?.trim()

  // normalizeBracketLabel 제거됨: ETL에서 이미 정제된 데이터 사용
  const renderWorkMetaCard = (title: string, icon: string, value: string): string => {
    // 파이프(|), 쉼표 끝 등 불필요한 구분자 정리
    const cleaned = safeTrim(value)
      ?.replace(/\|+/g, ', ')  // 파이프를 쉼표로 변환
      .replace(/,\s*,/g, ',')  // 중복 쉼표 제거
      .replace(/,\s*$/g, '')   // 끝 쉼표 제거
      .replace(/^\s*,/g, '')   // 시작 쉼표 제거
      .trim()
    if (!cleaned) return ''
    const formatted = cleaned
      .split(/\n+/)
      .map(line => `<span class="block text-sm text-wiki-text/90 leading-relaxed">${escapeHtml(line)}</span>`)
      .join('')
    return `
      <article class="relative overflow-hidden rounded-2xl border border-wiki-border/50 bg-gradient-to-br from-wiki-primary/10 via-wiki-bg/60 to-wiki-secondary/10 p-4 shadow-sm transition hover:border-wiki-primary/60" data-job-meta-card="${escapeHtml(title)}">
        <div class="pointer-events-none absolute -top-10 -right-8 h-24 w-24 rounded-full bg-wiki-primary/20 blur-3xl opacity-40"></div>
        <div class="pointer-events-none absolute -bottom-12 -left-10 h-28 w-28 rounded-full bg-wiki-secondary/15 blur-3xl opacity-30"></div>
        <div class="relative flex items-start gap-3">
          <span class="flex h-10 w-10 items-center justify-center rounded-xl bg-wiki-bg/70 text-wiki-primary border border-wiki-primary/30 shadow-inner">
            <i class="fas ${icon} text-base" aria-hidden="true"></i>
          </span>
          <div class="space-y-1">
            <h4 class="text-[13px] font-semibold uppercase tracking-widest text-wiki-muted">${escapeHtml(title)}</h4>
            ${formatted}
          </div>
        </div>
      </article>
    `
  }
  
  // 히어로 카테고리 렌더링
  let categoryHtml = ''
  if (profile.heroCategory) {
    if (profile.heroCategory.type === 'breadcrumb') {
      // 브레드크럼 스타일 (pill 배지)
      const breadcrumbParts = [
        profile.heroCategory.large,
        profile.heroCategory.medium,
        profile.heroCategory.small
      ].filter(Boolean)
      
      categoryHtml = `
        <span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-wiki-bg/70 border border-wiki-border/60 text-xs font-medium text-wiki-primary">
          <i class="fas fa-sitemap text-[11px]" aria-hidden="true"></i>
          ${breadcrumbParts.map(part => escapeHtml(part || '')).join(' <span class="text-wiki-muted/60">›</span> ')}
        </span>
      `
    } else if (profile.heroCategory.value) {
      // 단일 값 스타일 (ETL에서 이미 정제된 값 사용)
      const categoryValue = safeTrim(profile.heroCategory.value)
      if (categoryValue) {
        categoryHtml = `
          <span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-wiki-bg/70 border border-wiki-border/60 text-xs font-medium text-wiki-primary">
            <i class="fas fa-sitemap text-[11px]" aria-hidden="true"></i>
            ${escapeHtml(categoryValue)}
          </span>
        `
      }
    }
  }
  
  const lawyerMatrix = renderLawyerFieldMatrix(profile, partials, sources, telemetryVariant)

  const anchorIdFactory = createAnchorIdFactory(profile.id)
  const overviewCards: SectionCardDescriptor[] = []
  const detailCards: SectionCardDescriptor[] = []

  const pushOverviewCard = (title: string, icon: string, body: string) => {
    if (!body || !safeTrim(body)) {
      return
    }
    const anchorId = anchorIdFactory('overview', title)
    const cardMarkup = buildCard(title, icon, body, {
      anchorId,
      telemetryScope: 'job-overview-card',
      telemetryComponent: 'job-overview-card'
    })
    if (safeTrim(cardMarkup)) {
      overviewCards.push({ id: anchorId, label: title, icon, markup: cardMarkup })
    }
  }

  const pushDetailCard = (title: string, icon: string, body: string) => {
    if (!body || !safeTrim(body)) {
      return
    }
    const anchorId = anchorIdFactory('details', title)
    const cardMarkup = buildCard(title, icon, body, {
      anchorId,
      telemetryScope: 'job-detail-card',
      telemetryComponent: 'job-detail-card'
    })
    if (safeTrim(cardMarkup)) {
      detailCards.push({ id: anchorId, label: title, icon, markup: cardMarkup })
    }
  }

  // Type C: 업무 설명 (ETL 구조화 필드 overviewWork 사용)
  const overviewWork = profile.overviewWork
  const workMainDesc = overviewWork?.main
  const workStrong = overviewWork?.workStrong
  const workPlace = overviewWork?.workPlace
  const physicalAct = overviewWork?.physicalAct
  
  if (workMainDesc || workStrong || workPlace || physicalAct) {
    const introBlocks = []
    const workMetaCards: string[] = []
    
    // 주요 업무 설명 (ETL에서 우선순위로 선택된 값)
    if (workMainDesc && typeof workMainDesc === 'string' && safeTrim(workMainDesc)) {
      introBlocks.push(`<div><h4 class="text-base font-semibold text-white mb-2">수행 직무</h4>${renderDutyBulletList(workMainDesc)}</div>`)
    }
    
    // 작업강도
    if (workStrong && safeTrim(workStrong)) {
      workMetaCards.push(renderWorkMetaCard('작업강도', 'fa-dumbbell', workStrong))
    }
    
    // 작업장소
    if (workPlace && safeTrim(workPlace)) {
      workMetaCards.push(renderWorkMetaCard('작업장소', 'fa-location-dot', workPlace))
    }

    // 육체활동
    if (physicalAct && safeTrim(physicalAct)) {
      workMetaCards.push(renderWorkMetaCard('육체활동', 'fa-person-running', physicalAct))
    }

    // 카드가 있으면 그리드로 렌더링 (3개까지 지원)
    if (workMetaCards.length > 0) {
      const gridCols = workMetaCards.length === 3 ? 'sm:grid-cols-3' : 'sm:grid-cols-2'
      introBlocks.push(`
        <div class="mt-6 grid gap-4 ${gridCols}" data-job-work-meta>
          ${workMetaCards.join('')}
        </div>
      `)
    }
    
  if (introBlocks.length > 0) {
    pushOverviewCard('주요 업무', 'fa-rocket', introBlocks.join(''))
  }
  }

  const normalizedWorkMainDesc = normalizeComparableText(workMainDesc)
  const careernetDutyCandidates: string[] = []
  ;[
    rawApiData?.careernet?.summary,
    rawApiData?.careernet?.duties,
    rawApiData?.careernet?.duty,
    rawApiData?.careernet?.work,
    rawApiData?.careernet?.performList,
    rawApiData?.careernet?.encyclopedia?.summary,
    rawApiData?.careernet?.encyclopedia?.performList
  ].forEach((candidate) => {
    collectStringValues(candidate).forEach((text) => careernetDutyCandidates.push(text))
  })
  const overviewUsesCareernetDuty =
    normalizedWorkMainDesc.length > 0 &&
    careernetDutyCandidates.some(
      (candidate) => normalizeComparableText(candidate) === normalizedWorkMainDesc
    )

  // Type B: 전망 (ETL 구조화 필드 overviewProspect 사용)
  const overviewProspect = profile.overviewProspect
  const prospectPrimary = overviewProspect?.main
  
  // 재직자가 생각하는 일자리 전망 데이터
  const jobSumProspect = overviewProspect?.jobSumProspect
  const jobProspectInqYr = jobSumProspect && jobSumProspect.length > 0 
    ? jobSumProspect[0].jobProspectInqYr 
    : null
  
  let prospectChartHtml = ''
  if (jobSumProspect && Array.isArray(jobSumProspect) && jobSumProspect.length > 0) {
    // 전망 레이블 매핑
    const labelMap: Record<string, string> = {
      '증가': '증가',
      '다소 증가': '다소 증가',
      '유지': '유지',
      '다소 감소': '다소 감소',
      '감소': '감소'
    }
    
    // 바 색상 (스크린샷 참고 - 파란색 계열)
    const barColor = 'rgba(59, 130, 246, 0.85)'
    
    // Chart.js용 고유 ID
    const chartId = `prospect-chart-${Date.now()}`
    
    // 데이터 파싱
    const chartData = jobSumProspect.map(item => ({
      label: labelMap[item.jobProspectNm] || item.jobProspectNm,
      value: Number.parseFloat(item.jobProspectRatio) || 0
    }))
    
    const chartLabels = chartData.map(d => d.label)
    const chartValues = chartData.map(d => d.value)
    const maxValue = Math.max(...chartValues, 50)
    
    prospectChartHtml = `
      <div class="bg-transparent md:bg-white/5 rounded-none md:rounded-2xl p-0 md:p-6 border-0 md:border md:border-wiki-border/50">
        <div class="flex items-center justify-between mb-4">
          <h4 class="text-base font-bold text-wiki-secondary">재직자가 생각하는 일자리 전망</h4>
          ${jobProspectInqYr ? `<span class="text-xs text-wiki-muted">&lt;조사년도: ${jobProspectInqYr}년&gt;</span>` : ''}
        </div>
        <canvas id="${chartId}" style="max-height: 300px;"></canvas>
        <p class="text-xs text-wiki-muted mt-3">※ 위의 그래프는 직업당 평균 30명의 재직자가 해당 직업의 향후 5년간 일자리 변화에 대해 응답한 결과입니다. 작업전문가와 재직자들의 입장과 견해에 따라 일자리 전망에 차이가 있으므로, 참고자료로만 활용하시기 바랍니다.</p>
      </div>
      
      <script>
        (function() {
          const ctx = document.getElementById('${chartId}');
          if (ctx && typeof Chart !== 'undefined') {
            new Chart(ctx, {
              type: 'bar',
              data: {
                labels: ${JSON.stringify(chartLabels)},
                datasets: [{
                  data: ${JSON.stringify(chartValues)},
                  backgroundColor: '${barColor}',
                  borderWidth: 0,
                  borderRadius: 4,
                  barThickness: 'flex',
                  maxBarThickness: 50
                }]
              },
              options: {
                responsive: true,
                maintainAspectRatio: true,
                indexAxis: 'x',
                scales: {
                  y: {
                    beginAtZero: true,
                    max: ${maxValue},
                    ticks: {
                      color: 'rgba(255, 255, 255, 0.6)',
                      font: { size: 11 },
                      callback: function(value) {
                        return value;
                      }
                    },
                    grid: {
                      color: 'rgba(255, 255, 255, 0.1)',
                      drawBorder: false
                    },
                    title: {
                      display: true,
                      text: '(단위: %)',
                      color: 'rgba(255, 255, 255, 0.6)',
                      font: { size: 10 },
                      align: 'end'
                    }
                  },
                  x: {
                    ticks: {
                      color: 'rgba(255, 255, 255, 0.7)',
                      font: { size: 11, weight: '500' }
                    },
                    grid: {
                      display: false,
                      drawBorder: false
                    }
                  }
                },
                plugins: {
                  legend: { display: false },
                  tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    padding: 12,
                    titleFont: { size: 13, weight: 'bold' },
                    bodyFont: { size: 12 },
                    callbacks: {
                      label: function(context) {
                        return context.parsed.y + '%';
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
  }
  
  if (prospectPrimary || prospectChartHtml || overviewProspect?.forecastList) {
    let prospectHtml = ''
    
    if (Array.isArray(prospectPrimary) && prospectPrimary.length > 0) {
      // 배열인 경우 각 항목을 블록으로 만들고 첫 단어 들여쓰기
      const prospectBlocks = prospectPrimary
        .map((item: any) => {
          const text = typeof item === 'string' ? item : item.list_content || ''
          if (!safeTrim(text)) return ''
          // 첫 단어 들여쓰기를 위해 <span> 추가
          return `<div class="mb-3 content-text"><span class="inline-block w-4"></span>${escapeHtml(text)}</div>`
        })
        .filter(Boolean)
        .join('')
      // Only show section if prospectBlocks has content
      if (prospectBlocks) {
        prospectHtml = `<div class="space-y-2">${prospectBlocks}</div><p class="text-xs text-wiki-muted mt-4 leading-relaxed">※ 위의 일자리 전망은 직업전문가들이 「중장기인력수급전망」, 「정성적 직업전망조사」, 「KNOW 재직자조사」 등 각종 연구와 조사를 기초로 작성하였습니다.</p>`
      }
    } else if (typeof prospectPrimary === 'string' && safeTrim(prospectPrimary)) {
      // 문자열인 경우 줄바꿈을 블록으로 변환 (실제 내용이 있을 때만)
      const lines = prospectPrimary.split('\n').filter(line => safeTrim(line))
      if (lines.length > 1) {
        prospectHtml = `<div class="space-y-2">${lines.map(line => `<div class="mb-3 content-text"><span class="inline-block w-4"></span>${escapeHtml(line)}</div>`).join('')}</div><p class="text-xs text-wiki-muted mt-4 leading-relaxed">※ 위의 일자리 전망은 직업전문가들이 「중장기인력수급전망」, 「정성적 직업전망조사」, 「KNOW 재직자조사」 등 각종 연구와 조사를 기초로 작성하였습니다.</p>`
      } else if (lines.length === 1) {
        prospectHtml = `${formatRichText(prospectPrimary)}<p class="text-xs text-wiki-muted mt-4 leading-relaxed">※ 위의 일자리 전망은 직업전문가들이 「중장기인력수급전망」, 「정성적 직업전망조사」, 「KNOW 재직자조사」 등 각종 연구와 조사를 기초로 작성하였습니다.</p>`
      }
    }
    
    const structuredForecastItems = Array.isArray(overviewProspect?.forecastList)
      ? overviewProspect.forecastList.filter((item) => hasStructuredForecastData(item))
      : []

    let forecastDetailHtml = ''
    if (structuredForecastItems.length > 0) {
      const forecastItems = structuredForecastItems
        .map(item => {
          const parts: string[] = []
          if (item.period) parts.push(`<span class="font-bold text-wiki-secondary">${escapeHtml(item.period)}</span>`)
          if (item.outlook) parts.push(`<span class="text-white">${escapeHtml(item.outlook)}</span>`)
          if (item.description) parts.push(`<p class="text-sm text-wiki-text mt-1">${escapeHtml(item.description)}</p>`)
          return `<div class="mb-3">${parts.join(' ')}</div>`
        })
        .join('')

      if (forecastItems) {
        forecastDetailHtml = `<div class="mt-6"><h4 class="text-base font-bold text-wiki-secondary mb-3">기간별 전망</h4>${forecastItems}</div>`
      }
    }
    
    // 텍스트가 있으면 먼저 표시, 기간별 전망, 그래프는 뒤에 표시
    const combinedHtml = [
      prospectHtml?.trim() || '',
      forecastDetailHtml?.trim() || '',
      prospectChartHtml?.trim() || ''
    ].filter(Boolean).join('<div class="mt-6"></div>')
    
    // Only add card if combinedHtml has content
    if (safeTrim(combinedHtml)) {
      pushOverviewCard('커리어 전망', 'fa-chart-line', combinedHtml)
    }
  }

  // 한국의 직업지표 (indicatorChart)는 상세정보 탭으로 이동됨

  // Type C: 능력 & 지식 (ETL 구조화 필드 overviewAbilities 사용)
  const overviewAbilities = profile.overviewAbilities
  const abilitiesSimple = overviewAbilities?.abilityList
  
  const abilityBlocks = []
  
  // 능력 섹션 (큼지막한 네모 박스 아이콘 - Lucide)
  if (abilitiesSimple && Array.isArray(abilitiesSimple) && abilitiesSimple.length > 0) {
    const abilityList = abilitiesSimple
      .slice(0, 10)
      .map((item: any) => {
        const label = resolveAbilityLabel(item)
        const text = label || (typeof item === 'string' ? item : JSON.stringify(item))
        const { icon, color } = getAbilityIcon(text)
        return `<div class="flex items-center gap-3">
          <div class="flex-shrink-0 w-14 h-14 rounded-xl bg-wiki-card border border-wiki-border flex items-center justify-center">
            <i data-lucide="${icon}" class="${color}" style="width: 28px; height: 28px;"></i>
          </div>
          <span class="text-wiki-text">${escapeHtml(text)}</span>
        </div>`
      })
      .join('')
    abilityBlocks.push(`<div><h3 class="content-heading">핵심 역량</h3><div class="grid grid-cols-1 md:grid-cols-2 gap-4">${abilityList}</div></div>`)
  }
  
  // 정규교육과정 - 상세정보 탭의 직업 준비하기 섹션으로 이동 (중복 제거)
  
  // 활용 기술 (overviewAbilities.technKnow)
  const technKnow = overviewAbilities?.technKnow
  if (typeof technKnow === 'string' && technKnow?.trim()) {
    abilityBlocks.push(`<div class="mt-6"><h3 class="content-heading">활용 기술</h3>${formatRichText(technKnow)}</div>`)
  }

  const trainingMetaCards: string[] = []
  const eduLevel = overviewAbilities?.eduLevel
  const skillYear = overviewAbilities?.skillYear
  if (typeof eduLevel === 'string' && safeTrim(eduLevel)) {
    trainingMetaCards.push(renderWorkMetaCard('정규교육', 'fa-graduation-cap', eduLevel))
  }
  if (typeof skillYear === 'string' && safeTrim(skillYear)) {
    trainingMetaCards.push(renderWorkMetaCard('숙련기간', 'fa-hourglass-half', skillYear))
  }

  if (trainingMetaCards.length > 0) {
    abilityBlocks.push(`
      <div class="mt-6">
        <h3 class="content-heading">교육 및 숙련도</h3>
        <div class="mt-4 grid gap-4 sm:grid-cols-2">
          ${trainingMetaCards.join('')}
        </div>
      </div>
    `)
  }
  
  if (abilityBlocks.length > 0) {
    pushOverviewCard('핵심 능력·자격', 'fa-bolt', abilityBlocks.join(''))
  }

  // 직업 만족도 먼저 추가 (있을 경우)
  // 직업 만족도 등급 계산 함수
  const getSatisfactionGrade = (satisfaction: string | number | undefined) => {
    if (!satisfaction) return null
    
    const score = typeof satisfaction === 'number' 
      ? satisfaction 
      : Number.parseFloat(String(satisfaction)) || 0
    
    if (score >= 80) {
      return {
        level: '매우 좋음',
        icon: 'fa-face-grin-stars',
        color: 'text-green-400',
        bgColor: 'bg-green-500/20',
        borderColor: 'border-green-500/50'
      }
    } else if (score >= 60) {
      return {
        level: '좋음',
        icon: 'fa-face-smile',
        color: 'text-blue-400',
        bgColor: 'bg-blue-500/20',
        borderColor: 'border-blue-500/50'
      }
    } else if (score >= 40) {
      return {
        level: '보통',
        icon: 'fa-face-meh',
        color: 'text-yellow-400',
        bgColor: 'bg-yellow-500/20',
        borderColor: 'border-yellow-500/50'
      }
    } else if (score >= 20) {
      return {
        level: '별로',
        icon: 'fa-face-frown',
        color: 'text-orange-400',
        bgColor: 'bg-orange-500/20',
        borderColor: 'border-orange-500/50'
      }
    } else {
      return {
        level: '매우 별로',
        icon: 'fa-face-sad-tear',
        color: 'text-red-400',
        bgColor: 'bg-red-500/20',
        borderColor: 'border-red-500/50'
      }
    }
  }

  // 적성 및 흥미 (ETL 구조화 필드 overviewAptitude 사용)
  const overviewAptitude = profile.overviewAptitude
  const traitBlocks: string[] = []
  
  // 직업 만족도 카드 (개선된 UI)
  const satisfactionValue = overviewAptitude?.satisfaction?.value
  if (satisfactionValue) {
    const score = typeof satisfactionValue === 'number' 
      ? satisfactionValue 
      : Number.parseFloat(String(satisfactionValue)) || 0
    const grade = getSatisfactionGrade(satisfactionValue)
    
    if (grade) {
      traitBlocks.push(`
        <div class="flex items-center gap-4 p-5 rounded-2xl border ${grade.borderColor} ${grade.bgColor}">
          <div class="flex-shrink-0 flex h-16 w-16 items-center justify-center rounded-2xl ${grade.bgColor} border ${grade.borderColor}">
            <i class="fas ${grade.icon} text-3xl ${grade.color}"></i>
          </div>
          <div class="flex-1">
            <h3 class="text-sm font-semibold ${grade.color} uppercase tracking-wide mb-1">직업 만족도</h3>
            <div class="flex items-baseline gap-2">
              <span class="text-3xl font-bold text-white">${score.toFixed(1)}%</span>
              <span class="text-lg font-semibold ${grade.color}">${grade.level}</span>
            </div>
          </div>
        </div>
        <p class="text-xs text-wiki-muted mt-3 leading-relaxed">
          ※ 직업만족도는 해당 직업의 일자리 증가 가능성, 발전가능성 및 고용안정에 대해 재직자가 느끼는 생각을 종합하여 100점 만점으로 환산한 값입니다.
        </p>
      `)
    }
  }
  
  // 적성 (aptitudeList 배열에서 텍스트 추출)
  const aptitudeList = overviewAptitude?.aptitudeList
  if (aptitudeList && Array.isArray(aptitudeList) && aptitudeList.length > 0) {
    const aptitudeText = aptitudeList
      .map((item: any) => typeof item === 'string' ? item : (item?.name || item?.aptitude || ''))
      .filter(Boolean)
      .join(', ')
    if (safeTrim(aptitudeText)) {
    const divClass = traitBlocks.length > 0 ? 'mt-6' : ''
      traitBlocks.push(`<div class="${divClass}"><h3 class="content-heading text-wiki-secondary text-base font-bold mb-3">적성</h3>${formatAsBulletList(aptitudeText)}</div>`)
  }
  }
  
  // 흥미 (interestList 배열에서 텍스트 추출)
  const interestList = overviewAptitude?.interestList
  if (interestList && Array.isArray(interestList) && interestList.length > 0) {
    const interestText = interestList
      .map((item: any) => typeof item === 'string' ? item : (item?.name || item?.interest || ''))
      .filter(Boolean)
      .join(', ')
    if (safeTrim(interestText)) {
    const divClass = traitBlocks.length > 0 ? 'mt-6' : ''
      traitBlocks.push(`<div class="${divClass}"><h3 class="content-heading text-wiki-secondary text-base font-bold mb-3">흥미</h3>${formatAsBulletList(interestText)}</div>`)
    }
  }
  
  if (traitBlocks.length) {
    pushOverviewCard('적성 및 흥미', 'fa-heart', traitBlocks.join(''))
  }

  // Type B: 임금 (ETL 구조화 필드 overviewSalary 사용)
  const overviewSalary = profile.overviewSalary
  const salaryPrimary = overviewSalary?.sal || overviewSalary?.wage
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
        ${renderSectionToc('overview', '목차', overviewCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${overviewCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">개요 정보가 준비 중입니다.</p>`

  // ===== 업무특성 탭 시작 (ETL 구조화 필드 char* 사용) =====
  const characteristicsCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushCharacteristicsCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('characteristics', label)
    characteristicsCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id, telemetryScope: 'job-characteristics-card' }) })
  }

  // 지식 (charKnowledge) - 제거됨 (뒤의 고용24 지식 비교 테이블로 대체)
  
  // 근무 환경 (charEnvironment)
  const charEnvironment = profile.charEnvironment
  if (charEnvironment?.jobsEnv && Array.isArray(charEnvironment.jobsEnv) && charEnvironment.jobsEnv.length > 0) {
    const envText = charEnvironment.jobsEnv
      .map((item: any) => typeof item === 'string' ? item : (item?.envNm || item?.name || ''))
      .filter(Boolean)
      .join(', ')
    if (safeTrim(envText)) {
      pushCharacteristicsCard('근무 환경', 'fa-building', formatRichText(envText))
  }
  }

  // 업무 활동 중요도/수준 (charStatus - actv 데이터)
  const charStatus = profile.charStatus
  if (charStatus && (charStatus.jobActvImprtnc || charStatus.jobActvLvl)) {
    const activityBlocks: string[] = []
    
    if (charStatus.jobActvImprtnc && Array.isArray(charStatus.jobActvImprtnc) && charStatus.jobActvImprtnc.length > 0) {
      const impText = charStatus.jobActvImprtnc
        .map((item: any) => typeof item === 'string' ? item : (item?.actvNm || item?.name || ''))
        .filter(Boolean)
        .join(', ')
      if (safeTrim(impText)) {
        activityBlocks.push(`<div><h3 class="content-heading text-wiki-muted uppercase tracking-wide font-semibold mb-2">활동 중요도</h3>${formatRichText(impText)}</div>`)
      }
    }
    
    if (charStatus.jobActvLvl && Array.isArray(charStatus.jobActvLvl) && charStatus.jobActvLvl.length > 0) {
      const lvlText = charStatus.jobActvLvl
        .map((item: any) => typeof item === 'string' ? item : (item?.actvNm || item?.name || ''))
        .filter(Boolean)
        .join(', ')
      if (safeTrim(lvlText)) {
        activityBlocks.push(`<div class="${activityBlocks.length > 0 ? 'mt-4' : ''}"><h3 class="content-heading text-wiki-muted uppercase tracking-wide font-semibold mb-2">활동 수준</h3>${formatRichText(lvlText)}</div>`)
      }
    }
    
    if (activityBlocks.length > 0) {
      pushCharacteristicsCard('업무 수행 지표', 'fa-chart-area', activityBlocks.join(''))
    }
  }

  // 흥미 (charInterest) - 제거됨 (뒤의 고용24 흥미 비교 테이블로 대체)
  
  // 가치관 (charValues) - 제거됨 (뒤의 고용24 가치관 비교 테이블로 대체)

  // 한국의 직업지표 (ETL 구조화 필드 detailIndicators 사용)
  const indicatorChartData = profile.detailIndicators
  if (indicatorChartData && Array.isArray(indicatorChartData) && indicatorChartData.length > 0) {
    const indicatorHtml = renderIndicatorChart(indicatorChartData)
    if (indicatorHtml) {
      pushDetailCard('한국의 직업지표', 'fa-chart-bar', indicatorHtml)
    }
  }

  // 2-3. Type C: 학력·전공 분포 통합 (ETL 구조화 필드 detailEducation 사용) - 파이 차트로 시각화
  const detailEducation = profile.detailEducation
  const educationDistribution = detailEducation?.educationDistribution
  const majorDistribution = detailEducation?.majorDistribution
  const combinedAnchor = anchorIdFactory('details', '학력·전공 분포')
  const combinedCard = renderCombinedDistributionCharts(
    educationDistribution,
    majorDistribution,
    {
      anchorId: combinedAnchor,
      telemetryScope: 'job-detail-card',
      telemetryComponent: 'job-detail-education-major'
    }
  )
  if (combinedCard) {
    detailCards.push({ id: combinedAnchor, label: '학력·전공 분포', icon: 'fa-graduation-cap', markup: combinedCard })
  }
  
  // 4. Type D: 워라밸 & 사회적 기여도 (ETL 구조화 필드 detailWlb 사용)
  const detailWlb = profile.detailWlb
  const wlb = detailWlb?.wlb
  const social = detailWlb?.social
  if (wlb || social) {
    const wlbCards = []
    
    // 워라밸 카드
    if (wlb) {
      wlbCards.push(`
        <div class="flex items-center gap-4 p-5 rounded-2xl border border-purple-500/30 bg-purple-500/5">
          <div class="flex-shrink-0 flex h-16 w-16 items-center justify-center rounded-2xl bg-purple-500/10 border border-purple-500/30">
            <i class="fas fa-balance-scale text-3xl text-purple-400"></i>
          </div>
          <div class="flex-1 min-w-0">
            <h3 class="text-sm font-semibold text-purple-400 uppercase tracking-wide mb-2">워라밸 지수</h3>
            <p class="content-text text-white text-sm leading-relaxed">${escapeHtml(wlb)}</p>
          </div>
        </div>
      `)
    }
    
    // 사회적 기여도 카드
    if (social) {
      wlbCards.push(`
        <div class="flex items-center gap-4 p-5 rounded-2xl border border-green-500/30 bg-green-500/5">
          <div class="flex-shrink-0 flex h-16 w-16 items-center justify-center rounded-2xl bg-green-500/10 border border-green-500/30">
            <i class="fas fa-hands-helping text-3xl text-green-400"></i>
          </div>
          <div class="flex-1 min-w-0">
            <h3 class="text-sm font-semibold text-green-400 uppercase tracking-wide mb-2">사회적 기여도</h3>
            <p class="content-text text-white text-sm leading-relaxed">${escapeHtml(social)}</p>
          </div>
        </div>
      `)
    }
    
    // 그리드 레이아웃: 한 줄에 두 개 (큰 화면), 작은 화면에서는 세로로
    const gridLayout = `<div class="grid grid-cols-1 lg:grid-cols-2 gap-4">${wlbCards.join('')}</div>`
    pushDetailCard('워라밸 & 사회적 평가', 'fa-heart', gridLayout)
  }
  
  // 5-13. 아래 섹션들은 올바른 순서로 재배치됩니다
  
  // 5. Type D: 교육·자격 섹션 및 직업 준비하기 (ETL 구조화 필드 detailReady 사용)
  const detailReady = profile.detailReady
  
  // 필요기술 및 지식은 overviewAbilities.technKnow로 이동됨 (개요 탭에서 표시)
  
  // 5.5. 직업 준비하기
  if (detailReady) {
    const readyBlocks: string[] = []
    
    // 헬퍼: 객체 또는 문자열에서 텍스트 추출
    const extractReadyItem = (item: any, key: string): string => {
      if (typeof item === 'string') return item
      if (item && typeof item === 'object') return item[key] || item.name || item.value || ''
      return ''
    }
    
    // 정규 교육과정 (제일 먼저 표시)
    if (detailReady.curriculum && Array.isArray(detailReady.curriculum) && detailReady.curriculum.length > 0) {
      const currList = detailReady.curriculum
        .map(item => extractReadyItem(item, 'curriculum'))
        .filter(text => !!safeTrim(text))
        .map(text => `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(text)}</span></li>`)
        .join('')
      if (currList) {
        readyBlocks.push(`<div><h3 class="content-heading">정규 교육과정</h3><ul class="space-y-2">${currList}</ul></div>`)
      }
    }
    
    // 채용 정보
    if (detailReady.recruit && Array.isArray(detailReady.recruit) && detailReady.recruit.length > 0) {
      const recruitList = detailReady.recruit
        .map(item => extractReadyItem(item, 'recruit'))
        .filter(text => !!safeTrim(text))
        .map(text => `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(text)}</span></li>`)
        .join('')
      if (recruitList) {
        readyBlocks.push(`<div class="${readyBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">채용 정보</h3><ul class="space-y-2">${recruitList}</ul></div>`)
      }
    }
    
    // 자격증
    if (detailReady.certificate && Array.isArray(detailReady.certificate) && detailReady.certificate.length > 0) {
      const certList = detailReady.certificate
        .map(item => extractReadyItem(item, 'certificate'))
        .filter(text => !!safeTrim(text))
        .map(text => `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(text)}</span></li>`)
        .join('')
      if (certList) {
        readyBlocks.push(`<div class="${readyBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">추가 자격증</h3><ul class="space-y-2">${certList}</ul></div>`)
      }
    }
    
    // 교육/훈련
    if (detailReady.training && Array.isArray(detailReady.training) && detailReady.training.length > 0) {
      const trainingList = detailReady.training
        .map(item => extractReadyItem(item, 'training'))
        .filter(text => !!safeTrim(text))
        .map(text => `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(text)}</span></li>`)
        .join('')
      if (trainingList) {
        readyBlocks.push(`<div class="${readyBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">필요 교육/훈련</h3><ul class="space-y-2">${trainingList}</ul></div>`)
      }
    }
    
    // 진로 탐색 활동
    const researchList = detailReady.researchList
    if (researchList && Array.isArray(researchList) && researchList.length > 0) {
      const bullets = renderResearchBullets(researchList)
      if (bullets) {
        readyBlocks.push(
          `<div class="${readyBlocks.length > 0 ? 'mt-8' : ''}">
            <h3 class="content-heading">진로 탐색 활동</h3>
            ${bullets}
          </div>`
        )
      }
    }
    
    if (readyBlocks.length > 0) {
      pushDetailCard('직업 준비하기', 'fa-clipboard-check', readyBlocks.join(''))
    }
  }

  // 한국의 직업지표는 개요 탭으로 이동 (중복 제거)

  // 1. Type C: 업무수행능력 분석 (고용24 원본 필드 → merged profile)
  const abilityComparison =
    profile.goyong24Only?.workEnvironment ||
    rawApiData?.goyong24?.ablKnwEnv
  const abilityImportance = abilityComparison ? {
    withinJob: abilityComparison.jobAbilCmpr,
    betweenJobs: abilityComparison.jobAbil
  } : null
  const abilityLevel = abilityComparison ? {
    withinJob: abilityComparison.jobAbilLvlCmpr,
    betweenJobs: abilityComparison.jobAbilLvl
  } : null
  
  if (abilityComparison && ((abilityImportance && (abilityImportance.withinJob || abilityImportance.betweenJobs)) ||
      (abilityLevel && (abilityLevel.withinJob || abilityLevel.betweenJobs)))) {
    const abilityBlocks = []
    
    // 업무수행능력 중요도
    if (abilityImportance && (abilityImportance.withinJob || abilityImportance.betweenJobs)) {
      const importanceHtml = renderComparisonTable(
        abilityImportance.withinJob,
        abilityImportance.betweenJobs,
        '업무수행능력',
        'fa-brain',
        'importance'
      )
      if (importanceHtml) {
        abilityBlocks.push(`<div><h3 class="content-heading">업무수행능력 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 업무수행능력 수준
    if (abilityLevel && (abilityLevel.withinJob || abilityLevel.betweenJobs)) {
      const levelHtml = renderComparisonTable(
        abilityLevel.withinJob,
        abilityLevel.betweenJobs,
        '업무수행능력',
        'fa-star-half-alt',
        'level'
      )
      if (levelHtml) {
        abilityBlocks.push(`<div class="${abilityBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">업무수행능력 수준</h3>${levelHtml}</div>`)
      }
    }
    
    if (abilityBlocks.length > 0) {
      pushCharacteristicsCard('업무수행능력', 'fa-brain', abilityBlocks.join(''))
    }
  }

  // 2. Type C: 지식 분석
  const knowledgeComparison = abilityComparison
  const knowledgeImportance = knowledgeComparison ? {
    withinJob: knowledgeComparison.KnwldgCmpr,
    betweenJobs: knowledgeComparison.Knwldg
  } : null
  const knowledgeLevel = knowledgeComparison ? {
    withinJob: knowledgeComparison.KnwldgLvlCmpr,
    betweenJobs: knowledgeComparison.KnwldgLvl
  } : null
  const knowledgeSimpleData = profile.knowledge
  
  // detailedComparison 또는 simple 데이터가 있으면 지식 섹션 표시
  const hasKnowledgeDetailed = (knowledgeImportance && (knowledgeImportance.withinJob || knowledgeImportance.betweenJobs)) ||
                                (knowledgeLevel && (knowledgeLevel.withinJob || knowledgeLevel.betweenJobs))
  const hasKnowledgeSimple = knowledgeSimpleData && Array.isArray(knowledgeSimpleData) && knowledgeSimpleData.length > 0
  
  if (hasKnowledgeDetailed || hasKnowledgeSimple) {
    const knowledgeBlocks = []
    
    // 지식 중요도
    if (knowledgeImportance && (knowledgeImportance.withinJob || knowledgeImportance.betweenJobs)) {
      const importanceHtml = renderComparisonTable(
        knowledgeImportance.withinJob,
        knowledgeImportance.betweenJobs,
        '지식',
        'fa-book',
        'importance'
      )
      if (importanceHtml) {
        knowledgeBlocks.push(`<div><h3 class="content-heading">지식 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 지식 수준
    if (knowledgeLevel && (knowledgeLevel.withinJob || knowledgeLevel.betweenJobs)) {
      const levelHtml = renderComparisonTable(
        knowledgeLevel.withinJob,
        knowledgeLevel.betweenJobs,
        '지식',
        'fa-layer-group',
        'level'
      )
      if (levelHtml) {
        knowledgeBlocks.push(`<div class="${knowledgeBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">지식 수준</h3>${levelHtml}</div>`)
      }
    }
    
    // simple 데이터가 있고 detailed 데이터가 없을 때 simple 데이터를 표로 표시
    if ((!knowledgeImportance || (!knowledgeImportance.withinJob && !knowledgeImportance.betweenJobs)) &&
        (!knowledgeLevel || (!knowledgeLevel.withinJob && !knowledgeLevel.betweenJobs)) &&
        knowledgeSimpleData && Array.isArray(knowledgeSimpleData) && knowledgeSimpleData.length > 0) {
      
      // 커리어넷 지식 데이터를 표로 변환
      const validItems = knowledgeSimpleData
        .map((item: any) => {
          const name = item.knowledge || item.list_content || item.knowledge_name || item.inform || ''
          const importance = item.importance || 0
          if (!safeTrim(name)) return null
          return { name, importance }
        })
        .filter(Boolean)
        .sort((a: any, b: any) => b.importance - a.importance)
      
      if (validItems.length > 0) {
        const tableId = `knowledge-importance`
        const rows = validItems.map((item: any, index: number) => {
          const isHidden = index >= 5
          const hideClass = isHidden ? 'hidden' : ''
          const expandableAttr = isHidden ? 'data-expandable-row="true"' : ''
          
          return `
            <tr class="${hideClass} border-b border-wiki-border/30 hover:bg-wiki-card/30 transition-colors" ${expandableAttr}>
              <td class="px-4 py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">${item.importance}</td>
              <td class="px-4 py-3 font-medium text-wiki-text" style="font-size: 15px;">${escapeHtml(item.name)}</td>
            </tr>
          `
        }).join('')
        
        const toggleIndicator = validItems.length > 5 ? `
          <div class="mt-3 text-center">
            <div 
              onclick="toggleExpandTable('${tableId}')" 
              id="${tableId}-toggle"
              class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-wiki-primary hover:text-wiki-secondary border border-wiki-primary/50 hover:border-wiki-secondary/50 rounded-lg transition-all cursor-pointer"
            >
              <span id="${tableId}-text">전체보기 (${validItems.length - 5}개 항목)</span>
              <i id="${tableId}-icon" class="fas fa-chevron-down transition-transform"></i>
            </div>
          </div>
        ` : ''
        
        const knowledgeTable = `
          <div class="bg-transparent md:bg-white/5 rounded-none md:rounded-2xl px-0 md:px-6 py-6 border-0 md:border md:border-wiki-border/50">
            <div class="overflow-x-auto">
              <table class="w-full" id="${tableId}">
                <thead class="bg-wiki-card/50 border-b-2 border-wiki-primary/30">
                  <tr>
                    <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 120px; font-size: 15px;">중요도</th>
                    <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">지식</th>
                  </tr>
                </thead>
                <tbody>
                  ${rows}
                </tbody>
              </table>
            </div>
            ${toggleIndicator}
          </div>
        `
        knowledgeBlocks.push(`<div><h3 class="content-heading">필수 지식 중요도</h3>${knowledgeTable}</div>`)
      }
    }
    
    if (knowledgeBlocks.length > 0) {
      pushCharacteristicsCard('지식', 'fa-book', knowledgeBlocks.join(''))
    }
  }

  // 3. Type D: 업무환경 분석
  const workEnvironmentData =
    abilityComparison ||
    profile.goyong24Only?.workEnvironment ||
    rawApiData?.goyong24?.ablKnwEnv
  const workContext =
    profile.careernetOnly?.performList?.environment ||
    rawApiData?.careernet?.encyclopedia?.performList?.environment
  
  if ((workEnvironmentData && (workEnvironmentData.jobsEnvCmpr || workEnvironmentData.jobsEnv)) ||
      (workContext && Array.isArray(workContext) && workContext.length > 0)) {
    const workEnvBlocks = []
    
    // 고용24 업무환경 데이터 (직업 내/간 비교)
    if (workEnvironmentData && (workEnvironmentData.jobsEnvCmpr || workEnvironmentData.jobsEnv)) {
      const workEnvHtml = renderComparisonTable(
        workEnvironmentData.jobsEnvCmpr, // 직업 내 비교
        workEnvironmentData.jobsEnv,     // 직업 간 비교
        '업무환경',
        'fa-building'
      )
      if (workEnvHtml) {
        workEnvBlocks.push(`<div><h3 class="content-heading">업무환경 조건</h3>${workEnvHtml}</div>`)
      }
    }
    
    // 커리어넷 업무환경 데이터 (중요도 표)
    if (workContext && Array.isArray(workContext) && workContext.length > 0) {
      // 유효한 데이터만 필터링
      const validItems = workContext
        .map((item) => {
          const name = item.environment || item.inform || ''
          const importance = item.importance || 0
          if (!safeTrim(name)) return null
          return { name, importance }
        })
        .filter(Boolean)
        .sort((a: any, b: any) => b.importance - a.importance)
      
      if (validItems.length > 0) {
        const tableId = `work-env-importance`
        const rows = validItems.map((item: any, index: number) => {
          const isHidden = index >= 5
          const hideClass = isHidden ? 'hidden' : ''
          const expandableAttr = isHidden ? 'data-expandable-row="true"' : ''
          
          return `
            <tr class="${hideClass} border-b border-wiki-border/30 hover:bg-wiki-card/30 transition-colors" ${expandableAttr}>
              <td class="px-4 py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">${item.importance}</td>
              <td class="px-4 py-3 font-medium text-wiki-text" style="font-size: 15px;">${escapeHtml(item.name)}</td>
            </tr>
          `
        }).join('')
        
        const toggleIndicator = validItems.length > 5 ? `
          <div class="mt-3 text-center">
            <div 
              onclick="toggleExpandTable('${tableId}')" 
              id="${tableId}-toggle"
              class="inline-flex items-center gap-2 px-4 py-2 text-sm font-medium text-wiki-primary hover:text-wiki-secondary border border-wiki-primary/50 hover:border-wiki-secondary/50 rounded-lg transition-all cursor-pointer"
            >
              <span id="${tableId}-text">전체보기 (${validItems.length - 5}개 항목)</span>
              <i id="${tableId}-icon" class="fas fa-chevron-down transition-transform"></i>
            </div>
          </div>
        ` : ''
        
        const contextTable = `
          <div class="bg-transparent md:bg-white/5 rounded-none md:rounded-2xl px-0 md:px-6 py-6 border-0 md:border md:border-wiki-border/50">
            <div class="overflow-x-auto">
              <table class="w-full" id="${tableId}">
                <thead class="bg-wiki-card/50 border-b-2 border-wiki-primary/30">
                  <tr>
                    <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="width: 120px; font-size: 15px;">중요도</th>
                    <th class="px-2 py-2 md:px-4 md:py-3 text-center font-semibold text-wiki-text" style="font-size: 15px;">업무환경</th>
                  </tr>
                </thead>
                <tbody>
                  ${rows}
                </tbody>
              </table>
            </div>
            ${toggleIndicator}
          </div>
        `
        workEnvBlocks.push(`<div class="${workEnvBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">업무환경 중요도</h3>${contextTable}</div>`)
      }
    }
    
    if (workEnvBlocks.length > 0) {
      pushCharacteristicsCard('업무환경', 'fa-building', workEnvBlocks.join(''))
    }
  }

  
  // 4. Type D: 고용24 전용 - 성격 특성 비교
  const personalityData =
    profile.goyong24Only?.personality ||
    rawApiData?.goyong24?.chrIntrVals
  if (personalityData && (personalityData.jobChrCmpr || personalityData.jobChr)) {
    const personalityHtml = renderComparisonTable(
      personalityData.jobChrCmpr,
      personalityData.jobChr,
      '성격',
      'fa-user-check'
    )
    if (personalityHtml) {
      pushCharacteristicsCard('성격', 'fa-user-check', personalityHtml)
    }
  }

  // 5. Type D: 고용24 전용 - 흥미 분야 비교
  const interestData =
    profile.goyong24Only?.interest ||
    rawApiData?.goyong24?.chrIntrVals
  if (interestData && (interestData.jobIntrstCmpr || interestData.jobIntrst)) {
    const interestHtml = renderComparisonTable(
      interestData.jobIntrstCmpr,
      interestData.jobIntrst,
      '흥미',
      'fa-heart'
    )
    if (interestHtml) {
      pushCharacteristicsCard('흥미', 'fa-heart', interestHtml)
    }
  }

  // 6. Type D: 고용24 전용 - 가치관 비교
  const valuesData =
    profile.goyong24Only?.values ||
    rawApiData?.goyong24?.chrIntrVals
  if (valuesData && (valuesData.jobValsCmpr || valuesData.jobVals)) {
    const valuesHtml = renderComparisonTable(
      valuesData.jobValsCmpr,
      valuesData.jobVals,
      '가치관',
      'fa-star'
    )
    if (valuesHtml) {
      pushCharacteristicsCard('가치관', 'fa-star', valuesHtml)
    }
  }

  // 7. Type D: 고용24 전용 - 업무활동 분석 (rawApiData 사용)
  const activityData =
    profile.goyong24Only?.activity ||
    rawApiData?.goyong24?.actv
  const activityImportance = activityData ? {
    withinJob: activityData.jobActvImprtncCmpr,
    betweenJobs: activityData.jobActvImprtnc
  } : null
  const activityLevel = activityData ? {
    withinJob: activityData.jobActvLvlCmpr,
    betweenJobs: activityData.jobActvLvl
  } : null
  
  if ((activityImportance && (activityImportance.withinJob || activityImportance.betweenJobs)) ||
      (activityLevel && (activityLevel.withinJob || activityLevel.betweenJobs))) {
    const activityBlocks = []
    
    // 업무활동 중요도
    if (activityImportance && (activityImportance.withinJob || activityImportance.betweenJobs)) {
      const importanceHtml = renderComparisonTable(
        activityImportance.withinJob,
        activityImportance.betweenJobs,
        '업무활동',
        'fa-chart-line',
        'importance'
      )
      if (importanceHtml) {
        activityBlocks.push(`<div><h3 class="content-heading">업무활동 중요도</h3>${importanceHtml}</div>`)
      }
    }
    
    // 업무활동 수준
    if (activityLevel && (activityLevel.withinJob || activityLevel.betweenJobs)) {
      const levelHtml = renderComparisonTable(
        activityLevel.withinJob,
        activityLevel.betweenJobs,
        '업무활동',
        'fa-signal',
        'level'
      )
      if (levelHtml) {
        activityBlocks.push(`<div class="${activityBlocks.length > 0 ? 'mt-8' : ''}"><h3 class="content-heading">업무활동 수준</h3>${levelHtml}</div>`)
      }
    }
    
    if (activityBlocks.length > 0) {
      pushCharacteristicsCard('업무활동', 'fa-tasks', activityBlocks.join(''))
    }
  }

  const characteristicsContent = characteristicsCards.length
    ? `<div class="space-y-6" data-cw-job-characteristics>
        ${renderSectionToc('characteristics', '목차', characteristicsCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${characteristicsCards.map((card) => card.markup).join('')}
      </div>
      <script>
        function toggleExpandTable(tableId) {
          const table = document.getElementById(tableId);
          const toggleButton = document.getElementById(tableId + '-toggle');
          const toggleText = document.getElementById(tableId + '-text');
          const toggleIcon = document.getElementById(tableId + '-icon');
          if (!table || !toggleButton) return;
          
          // data-expandable-row 속성을 가진 행들만 선택 (5개 이후의 행들)
          const expandableRows = table.querySelectorAll('tr[data-expandable-row]');
          if (expandableRows.length === 0) return; // 5개 이하면 토글 필요 없음
          
          const hiddenRows = table.querySelectorAll('tr[data-expandable-row].hidden');
          const isExpanded = hiddenRows.length === 0;
          
          // 펼쳐질 항목 수 (항상 5개는 보이므로 expandable 행들만 카운트)
          const expandableCount = expandableRows.length;
          
          // 전체 항목 수 (고정 5개 + expandable)
          const totalCount = 5 + expandableCount;
          
          if (isExpanded) {
            // 접기 - expandable 행들만 숨기기
            expandableRows.forEach(row => {
              row.classList.add('hidden');
            });
            
            // 버튼 상태 업데이트
            if (toggleText) {
              toggleText.textContent = '전체보기 (' + expandableCount + '개 항목)';
            }
            if (toggleIcon) {
              toggleIcon.classList.remove('fa-chevron-up');
              toggleIcon.classList.add('fa-chevron-down');
            }
            
            // 항목이 10개를 초과하는 경우에만 스크롤 이동
            if (totalCount > 10) {
              // 접기 전에 테이블 컨테이너의 위치를 저장
              let tableContainer = table.closest('div[class*="bg-white"]');
              if (!tableContainer) {
                // 다른 방법으로 컨테이너 찾기
                tableContainer = table.closest('div[class*="rounded"]');
              }
              
              if (tableContainer) {
                const tableRect = tableContainer.getBoundingClientRect();
                const scrollY = window.scrollY || window.pageYOffset;
                const tableY = tableRect.top + scrollY;
                
                // 테이블 시작 위치로 즉시 스크롤 (부드러운 효과 없음)
                window.scrollTo(0, tableY - 120); // 테이블 위치에서 120px 위로 (여유 공간)
              }
            }
          } else {
            // 펼치기 - expandable 행들 보이기
            expandableRows.forEach(row => {
              row.classList.remove('hidden');
            });
            
            // 버튼 상태 업데이트
            if (toggleText) {
              toggleText.textContent = '접기';
            }
            if (toggleIcon) {
              toggleIcon.classList.remove('fa-chevron-down');
              toggleIcon.classList.add('fa-chevron-up');
            }
          }
        }
      </script>`
    : `<p class="text-sm text-wiki-muted">업무특성 정보가 준비 중입니다.</p>`
  // ===== 업무특성 탭 끝 =====

  // 직업 분류 체계 섹션 제거됨 (히어로 섹션 브레드크럼으로 이동)
  // 한국표준직업분류 코드 섹션 제거됨
  // const kecoList = renderKecoCodeList(profile)
  // if (kecoList) {
  //   pushDetailCard('한국표준직업분류 코드', 'fa-layer-group', kecoList)
  // }

  const detailContent = detailCards.length
    ? `<div class="space-y-6" data-cw-job-details>
        ${renderSectionToc('details', '목차', detailCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${detailCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">상세 정보가 준비 중입니다.</p>`

  // 탭이 비어있으면 숨기기 (내용이 없거나 "준비 중" 메시지만 있는 경우)
  const hasOverviewContent = overviewContent && !overviewContent.includes('준비 중') && overviewContent.trim().length > 50
  const hasDetailContent = detailContent && !detailContent.includes('준비 중') && detailContent.trim().length > 50
  const hasCharacteristicsContent = characteristicsContent && !characteristicsContent.includes('준비 중') && characteristicsContent.trim().length > 50
  
  const tabEntries: TabEntry[] = []
  if (hasOverviewContent) {
    tabEntries.push({ id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent })
  }
  if (hasDetailContent) {
    tabEntries.push({ id: 'details', label: '상세정보', icon: 'fa-layer-group', content: detailContent })
  }
  if (hasCharacteristicsContent) {
    tabEntries.push({ id: 'characteristics', label: '업무특성', icon: 'fa-chart-pie', content: characteristicsContent })
  }

  const entitySlug = composeDetailSlug('job', profile.name, profile.id)
  const detailPath = `/job/${encodeURIComponent(entitySlug)}`
  const summarySnippet = heroDescription ?? (profile.summary ? safeTrim(profile.summary).slice(0, 400) : null)
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
    majors: profile.sidebarMajors?.length ?? 0,
    jobs: profile.sidebarJobs?.length ?? 0,
    certificates: profile.sidebarCerts?.length ?? 0
  }
  if (telemetryVariant) {
    detailMetaExtra.telemetryVariant = telemetryVariant
  }

  // Sample comments disabled for production
  const sampleComments: SampleCommentPayload[] = []
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
      emptyLabel: `아직 등록된 댓글이 없습니다.`,
      sampleComments,
      showForm: true  // 익명 사용자도 댓글 작성 가능
    },
    partials,
    sources,
    metaExtra: detailMetaExtra
  })

  const sidebarContent = renderJobSidebar(profile)
  const sourcesCollapsible = renderSourcesCollapsible(profile, sources, partials)
  const heroImage = renderHeroImage(profile.name, { dataAttribute: 'data-job-hero-image', context: 'job' })
  const hasSidebar = safeTrim(sidebarContent).length > 0
  
  // 히어로 태그 렌더링 (ETL에서 병합된 heroTags 사용)
  let heroTagsMarkup = ''
  if (profile.heroTags && Array.isArray(profile.heroTags) && profile.heroTags.length > 0) {
    const tagsHtml = profile.heroTags
      .slice(0, 8)  // 최대 8개만 표시
      .filter(tag => tag && safeTrim(tag).length > 0)
      .map(tag => 
        `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary font-medium border border-wiki-primary/20 hover:bg-wiki-primary/20 transition">
          <i class="fas fa-tag text-[10px]" aria-hidden="true"></i>${escapeHtml(safeTrim(tag))}
        </span>`
      )
      .join('')
    
    if (tagsHtml) {
      heroTagsMarkup = `<div class="flex flex-wrap gap-2 mt-4">${tagsHtml}</div>`
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
    <div class="max-w-[1400px] mx-auto md:px-6 space-y-4 md:space-y-8 md:py-8 md:mt-4" data-job-id="${escapeHtml(profile.id)}">
      <section class="glass-card border-0 md:border px-6 py-8 md:px-8 rounded-none md:rounded-2xl space-y-6 md:space-y-8" data-job-hero${telemetryVariantAttr}>
        <div class="space-y-4">
          <div class="space-y-2">
            ${categoryHtml || (profile.category?.name ? `<span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-wiki-bg/70 border border-wiki-border/60 text-xs font-medium text-wiki-primary"><i class="fas fa-sitemap text-[11px]" aria-hidden="true"></i>${escapeHtml(profile.category.name)}</span>` : '')}
            <div class="flex flex-wrap items-start justify-between gap-4">
              <h1 class="text-[32px] md:text-[34px] lg:text-4xl font-bold text-white leading-tight">${escapeHtml(heroTitle)}</h1>
            <div class="flex items-center gap-2 shrink-0">
              <button 
                type="button" 
                class="px-4 py-2 bg-wiki-secondary text-white rounded-lg text-sm hover:bg-purple-600 transition inline-flex items-center gap-2" 
                data-edit-mode-trigger
                data-entity-type="job"
                data-entity-id="${escapeHtml(profile.id)}"
                data-cw-telemetry-component="job-edit-trigger"
                data-cw-telemetry-action="edit-open"
                aria-label="편집 모드"
                title="이 페이지 편집하기"
                ${telemetryVariantAttr}
              >
                <i class="fas fa-edit" aria-hidden="true"></i>
                편집
              </button>
              <button 
                type="button" 
                class="px-4 py-2 bg-wiki-bg/60 border border-wiki-border/60 text-white rounded-lg text-sm hover:bg-wiki-bg/80 hover:border-wiki-primary/60 transition inline-flex items-center gap-2" 
                data-history-trigger
                data-entity-type="job"
                data-entity-id="${escapeHtml(profile.id)}"
                data-cw-telemetry-component="job-history-trigger"
                data-cw-telemetry-action="history-open"
                aria-label="역사"
                title="이 페이지의 편집 이력 보기"
                ${telemetryVariantAttr}
              >
                <i class="fas fa-history" aria-hidden="true"></i>
                역사
              </button>
              <div class="relative" data-share-root data-cw-telemetry-scope="job-hero-actions">
                <button type="button" class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition inline-flex items-center gap-2" data-share-trigger data-share-path="${escapeHtml(detailPath)}" data-share-title="${escapeHtml(profile.name)}" data-cw-telemetry-component="job-share-trigger" data-cw-telemetry-action="share-open"${telemetryVariantAttr}>
                  <i class="fas fa-share-nodes" aria-hidden="true"></i>
                  공유
                </button>
                <div class="absolute right-0 mt-2 w-72 rounded-xl border border-wiki-border/60 bg-wiki-bg/95 shadow-xl backdrop-blur hidden z-[1001]" data-share-panel data-cw-telemetry-component="job-share-panel" role="dialog" aria-modal="false" aria-label="링크 공유">
                  <div class="flex items-center justify-between px-4 py-3 border-b border-wiki-border/60">
                    <p class="text-sm font-semibold text-white">'${escapeHtml(profile.name)}' 공유하기</p>
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
            </div>
          </div>
          ${
            heroDescription
              ? `<p class="text-[15px] text-wiki-muted leading-relaxed" data-cw-telemetry-component="job-hero-summary">${escapeHtml(heroDescription)}</p>`
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
      <script>
        // _t 파라미터 제거 (캐시 우회 후 URL 정리)
        (function() {
          if (window.location.search.includes('_t=')) {
            const url = new URL(window.location.href);
            url.searchParams.delete('_t');
            window.history.replaceState({}, '', url.toString());
          }
        })();
        
        // Lucide 아이콘 초기화
        if (typeof lucide !== 'undefined') {
          lucide.createIcons();
        }
        
        // 사이드바 접기/펼치기 기능 (연관 직업, 관련 전공)
        (function() {
          const expandButtons = document.querySelectorAll('.expand-toggle');
          
          expandButtons.forEach(button => {
            button.addEventListener('click', function() {
              const container = this.closest('.expandable-list');
              const hiddenItems = container.querySelectorAll('.hidden-item');
              const isExpanded = this.getAttribute('data-expanded') === 'true';
              const toggleText = this.querySelector('.toggle-text');
              const toggleIcon = this.querySelector('.toggle-icon');
              const toggleCount = this.querySelector('.toggle-count');
              
              if (isExpanded) {
                // 접기
                hiddenItems.forEach(item => {
                  item.style.display = 'none';
                });
                toggleText.textContent = '더보기';
                toggleIcon.style.transform = 'rotate(0deg)';
                toggleCount.style.display = '';
                this.setAttribute('data-expanded', 'false');
              } else {
                // 펼치기
                hiddenItems.forEach(item => {
                  item.style.display = '';
                });
                toggleText.textContent = '접기';
                toggleIcon.style.transform = 'rotate(180deg)';
                toggleCount.style.display = 'none';
                this.setAttribute('data-expanded', 'true');
              }
            });
          });
        })();
      </script>
    </div>
  `
}


export const createJobJsonLd = (profile: UnifiedJobDetail, canonicalUrl: string): string => {
  // ETL 구조화 필드 사용
  const overviewWork = profile.overviewWork
  const overviewSalary = profile.overviewSalary
  const detailEducation = profile.detailEducation
  
  const jsonLd = sanitizeJson({
    '@context': 'https://schema.org',
    '@type': 'Occupation',
    name: profile.name,
    description: overviewWork?.main,
    url: canonicalUrl,
    occupationalCategory: profile.heroCategory?.value || profile.heroCategory?.large,
    estimatedSalary: overviewSalary?.sal || overviewSalary?.wage,
    educationRequirements: detailEducation?.majorDistribution
      ? Object.entries(detailEducation.majorDistribution)
          .filter(([, value]) => !!value && !!safeTrim(value))
          .map(([key, value]) => `${key}: ${value}`)
      : undefined,
    skills: profile.overviewAbilities?.abilityList?.map((a: any) => a?.name || a).filter(Boolean),
    qualifications: profile.sidebarCerts?.map((c: any) => c?.name || c).filter(Boolean),
    industry: profile.heroCategory?.large,
    responsibilities: overviewWork?.main,
    occupationalSpecialty: profile.sidebarJobs?.map((job: any) => extractEntityName(job)).filter(Boolean)
  })

  if (!jsonLd) {
    return ''
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003c')
  return `<script type="application/ld+json">${script}</script>`
}
