import type { DataSource, SourceIdentifiers } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'

export const DEFAULT_SOURCE_LABELS: Partial<Record<DataSource, string>> = {
  CAREERNET: '커리어넷 직업백과',
  GOYONG24: '고용24 직업정보',
  WORK24_DJOB: '고용24 직업사전'
}

export const escapeHtml = (value?: string | null | unknown): string => {
  if (!value) return ''
  // 문자열이 아닌 경우 문자열로 변환 시도
  const strValue = typeof value === 'string' ? value : String(value)
  return strValue
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}

// HTML 태그 제거 함수 (고용24 데이터의 HTML 태그 처리용)
const stripHtmlTags = (html: string): string => {
  return html
    .replace(/<[^>]*>/g, '') // 모든 HTML 태그 제거
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .trim()
}

export const formatRichText = (value?: string | null): string => {
  if (!value || !value.trim()) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }

  // HTML 태그가 포함되어 있으면 제거
  let cleanedValue = value.includes('<') || value.includes('>') 
    ? stripHtmlTags(value)
    : value
  
  // 깨진 문자 및 특수 기호 제거 (□, ■, ▢, �, 제어문자 등)
  cleanedValue = cleanedValue
    .replace(/[\u25A0-\u25FF]/g, '')  // 기하학적 도형 (□, ■, ▢ 등)
    .replace(/\uFFFD/g, '')           // Replacement character (�)
    .replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F\u007F]/g, '')  // 제어문자 (탭/개행/CR 제외)
    .replace(/\u00A0/g, ' ')          // Non-breaking space → 일반 공백
    .replace(/[^\S\n]+/g, ' ')        // 연속 공백 정리 (줄바꿈 보존)

  return cleanedValue
    .trim()
    .split(/\n{2,}/)
    .map((paragraph) => {
      const safe = escapeHtml(paragraph.trim()).replace(/\n/g, '<br>')
      return `<p class="content-text leading-relaxed text-wiki-text">${safe}</p>`
    })
    .join('')
}

export const renderChips = (items?: string[] | null, emptyText = '정보 없음'): string => {
  if (!items || items.length === 0) {
    return `<p class="content-text text-wiki-muted">${escapeHtml(emptyText)}</p>`
  }

  return `
    <ul class="space-y-1.5" role="list">
      ${items
        .filter((item) => !!item && !!item.trim())
        .map((item) => `
          <li>
            <div class="flex items-center gap-2.5 px-3 py-2 rounded-lg bg-wiki-bg/40 border border-wiki-border/40 hover:border-wiki-primary/40 hover:bg-wiki-primary/5 transition-all duration-200">
              <span class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-wiki-primary/15 text-wiki-primary">
                <i class="fas fa-certificate text-[9px]" aria-hidden="true"></i>
              </span>
              <span class="text-sm text-wiki-text font-medium">${escapeHtml(item.trim())}</span>
            </div>
          </li>
        `)
        .join('')}
    </ul>
  `
}

export interface BuildCardOptions {
  anchorId?: string
  telemetryScope?: string
  telemetryComponent?: string
  editButton?: EditButtonOptions  // 편집 버튼 옵션
  dataSources?: string[]  // 데이터 출처 목록 (CAREERNET, GOYONG24, WORK24_DJOB 등)
}

interface HeroImageRule {
  keywords: string[]
  url: string
}

const HERO_IMAGE_RULES: HeroImageRule[] = [
  {
    keywords: ['ai', '인공지능', '데이터', 'data'],
    url: 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=1600&q=80'
  },
  {
    keywords: ['marketing', 'growth', '마케팅'],
    url: 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=1600&q=80'
  },
  {
    keywords: ['design', 'ux', 'ui', '디자인'],
    url: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=1600&q=80'
  },
  {
    keywords: ['finance', 'investment', '금융', '재무'],
    url: 'https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?auto=format&fit=crop&w=1600&q=80'
  },
  {
    keywords: ['health', '의료', 'bio', 'medical'],
    url: 'https://images.unsplash.com/photo-1580281657521-93a6c3be1f4c?auto=format&fit=crop&w=1600&q=80'
  }
]

const DEFAULT_HERO_IMAGE = 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=1600&q=80'

export const resolveHeroImageUrl = (title?: string): string => {
  if (!title) return DEFAULT_HERO_IMAGE
  const normalized = title.toLowerCase()
  for (const rule of HERO_IMAGE_RULES) {
    if (rule.keywords.some((keyword) => normalized.includes(keyword))) {
      return rule.url
    }
  }
  return DEFAULT_HERO_IMAGE
}

export const renderHeroImage = (
  title?: string,
  options: { imageUrl?: string; imageAlt?: string; dataAttribute?: string; context?: string; slug?: string } = {}
): string => {
  const imageUrl = options.imageUrl ?? resolveHeroImageUrl(title)
  const imageAlt = options.imageAlt ?? `${escapeHtml(title ?? '')}를 상징하는 대표 이미지`
  const dataAttribute = options.dataAttribute ?? 'data-hero-image'
  const context = options.context ?? 'default'
  const slug = options.slug ?? ''
  const dataAttributeSnippet = `${dataAttribute}="true"`

  return `
    <figure
      class="relative overflow-hidden rounded-3xl border border-wiki-border/60 bg-wiki-bg/60 shadow-lg h-[280px] sm:h-[340px] md:h-[420px] lg:h-[500px] xl:h-[560px]"
      ${dataAttributeSnippet}
      data-hero-context="${escapeHtml(context)}"
      data-hero-url="${escapeHtml(imageUrl)}"
      data-hero-slug="${escapeHtml(slug)}"
      data-cw-telemetry-scope="hero"
      data-cw-telemetry-component="detail-hero-image"
      data-cw-telemetry-action="hero-image"
    >
      <div class="absolute inset-0">
        <img
          src="${escapeHtml(imageUrl)}"
          alt="${escapeHtml(imageAlt)}"
          class="w-full h-full object-cover object-center"
          loading="lazy"
          decoding="async"
          onerror="this.onerror=null; this.src='${DEFAULT_HERO_IMAGE}'; this.alt='${escapeHtml(title ?? '')} 대표 이미지 준비 중';"
        >
        <div class="absolute inset-0 bg-gradient-to-b from-black/35 via-wiki-bg/20 to-wiki-bg/80 mix-blend-multiply"></div>
        <div class="absolute inset-0 bg-gradient-to-tr from-wiki-primary/30 via-transparent to-wiki-secondary/40 mix-blend-screen"></div>
        <div class="absolute inset-6 rounded-2xl border border-white/10 pointer-events-none"></div>
      </div>
      <!-- 관리자용 이미지 재생성 버튼 (클라이언트에서 동적으로 표시) -->
      <div 
        class="absolute top-4 right-4 hidden" 
        data-admin-image-controls
        data-image-type="${context === 'job' ? 'jobs' : 'majors'}"
        data-image-slug="${escapeHtml(slug)}"
        data-image-title="${escapeHtml(title ?? '')}"
      >
        <button 
          type="button"
          class="flex items-center gap-2 px-3 py-2 bg-wiki-bg/90 backdrop-blur-sm rounded-lg border border-wiki-border hover:border-wiki-primary transition-colors text-sm text-wiki-text hover:text-wiki-primary"
          data-action="regenerate-image"
          title="이미지 재생성"
        >
          <i class="fas fa-sync-alt"></i>
          <span>이미지 변경</span>
        </button>
      </div>
      <figcaption class="sr-only">${escapeHtml(imageAlt)}</figcaption>
    </figure>
  `
}

export const buildCard = (title: string, icon: string, body: string, options: BuildCardOptions = {}): string => {
  if (!body || !body.trim()) {
    return ''
  }

  const { anchorId, telemetryScope, telemetryComponent, dataSources } = options
  const className = `glass-card border px-6 py-6 md:px-6 rounded-xl space-y-3${anchorId ? ' scroll-mt-28' : ''}`
  const attributeParts: string[] = [`class="${className}"`, 'data-cw-detail-card']

  if (anchorId) {
    const normalizedAnchor = escapeHtml(anchorId)
    attributeParts.push(`id="${normalizedAnchor}"`)
    attributeParts.push(`data-card-anchor="${normalizedAnchor}"`)
  }

  if (telemetryScope) {
    attributeParts.push(`data-cw-telemetry-scope="${escapeHtml(telemetryScope)}"`)
  }

  if (telemetryComponent) {
    attributeParts.push(`data-cw-telemetry-component="${escapeHtml(telemetryComponent)}"`)
  }

  // 데이터 출처 속성 추가 (하이라이트 기능용)
  if (dataSources && dataSources.length > 0) {
    attributeParts.push(`data-source="${dataSources.map(s => escapeHtml(s)).join(',')}"`)
  }

  const editButtonHtml = options.editButton
    ? renderEditButton(options.editButton)
    : ''

  return `
    <article ${attributeParts.join(' ')}>
      <h3 class="section-title flex items-center justify-between mb-5">
        <div class="flex items-center gap-3">
        <span class="flex items-center justify-center w-8 h-8 rounded-lg bg-gradient-to-br from-wiki-primary/20 to-wiki-secondary/20 border border-wiki-primary/30">
          <i class="fas ${icon} text-wiki-secondary text-sm"></i>
        </span>
        <span>${escapeHtml(title)}</span>
        </div>
        ${editButtonHtml ? `<div class="flex items-center">${editButtonHtml}</div>` : ''}
      </h3>
      ${body}
    </article>
  `
}

/**
 * 편집 버튼 렌더링
 * 
 * @param options 편집 버튼 옵션
 * @returns 편집 버튼 HTML
 */
export interface EditButtonOptions {
  entityType: 'job' | 'major' | 'howto'
  entityId: string
  field: string  // 'summary', 'duties', 'salary' 등
  label?: string  // 버튼 라벨 (기본: '편집')
  enabled?: boolean  // 편집 가능 여부 (기본: true)
  dataSource?: 'api' | 'user' | 'admin'  // 데이터 출처
}

export const renderEditButton = (options: EditButtonOptions): string => {
  const {
    entityType,
    entityId,
    field,
    label = '편집',
    enabled = true,
    dataSource
  } = options

  const buttonId = `edit-btn-${entityType}-${entityId}-${field}`
  const buttonClass = enabled
    ? 'edit-btn inline-flex items-center gap-1.5 px-3 py-2 min-h-[36px] sm:min-h-[32px] text-xs sm:text-xs font-medium text-wiki-primary hover:text-wiki-secondary hover:bg-wiki-primary/10 rounded-lg transition-colors border border-wiki-primary/30 hover:border-wiki-primary/50'
    : 'edit-btn inline-flex items-center gap-1.5 px-3 py-2 min-h-[36px] sm:min-h-[32px] text-xs sm:text-xs font-medium text-wiki-muted cursor-not-allowed opacity-50 rounded-lg border border-wiki-border/30'

  const badgeClass = dataSource === 'api'
    ? 'bg-blue-500/20 text-blue-400 border-blue-500/30'
    : dataSource === 'user'
    ? 'bg-green-500/20 text-green-400 border-green-500/30'
    : dataSource === 'admin'
    ? 'bg-purple-500/20 text-purple-400 border-purple-500/30'
    : ''

  const badgeLabel = dataSource === 'api'
    ? 'API'
    : dataSource === 'user'
    ? '사용자'
    : dataSource === 'admin'
    ? '관리자'
    : ''

  return `
    <button
      id="${escapeHtml(buttonId)}"
      class="${buttonClass}"
      data-edit-button
      data-entity-type="${escapeHtml(entityType)}"
      data-entity-id="${escapeHtml(entityId)}"
      data-field="${escapeHtml(field)}"
      ${enabled ? '' : 'disabled'}
      aria-label="${escapeHtml(label)} (${escapeHtml(field)})"
      title="${enabled ? `${escapeHtml(label)} (${escapeHtml(field)})` : '편집 불가'}"
    >
      <i class="fas fa-edit text-xs" aria-hidden="true"></i>
      <span>${escapeHtml(label)}</span>
      ${badgeLabel ? `<span class="ml-1 px-1.5 py-0.5 text-[10px] font-semibold rounded border ${badgeClass}">${escapeHtml(badgeLabel)}</span>` : ''}
    </button>
  `
}

export type TabEntry = { 
  id: string
  label: string
  icon: string
  content: string
  /** 아이콘만 표시 (탭 오른쪽 끝으로 밀림, 호버 시 라벨 표시) */
  iconOnly?: boolean
}
export type DetailComponentEntityType = 'job' | 'major' | 'guide'

export interface TabsetOptions {
  entityType: DetailComponentEntityType
  entityId: string
  entries: TabEntry[]
  fallback?: {
    title: string
    icon: string
    message: string
  }
}

export const renderTabset = ({ entityType, entityId, entries, fallback }: TabsetOptions): string => {
  if (!entries.length) {
    return buildCard(
      fallback?.title ?? '데이터 준비 중',
      fallback?.icon ?? 'fa-circle-info',
      `<p class="content-text text-wiki-muted">${escapeHtml(
        fallback?.message ?? '상세 정보가 수집되는 대로 탭이 활성화됩니다.'
      )}</p>`
    )
  }

  const tabsetLabel =
    entityType === 'job'
      ? '직업 상세 정보 탭'
      : entityType === 'major'
        ? '전공 상세 정보 탭'
        : 'HowTo 가이드 탭'
  const normalizedBase = `${entityType}-${entityId}`
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')
  const tabsetId = normalizedBase ? `cw-${normalizedBase}-tabset` : `cw-${entityType}-tabset`
  const statusId = `${tabsetId}-status`
  const tablistId = `${tabsetId}-tablist`
  const instructionsId = `${tabsetId}-instructions`
  const totalTabs = entries.length

  // 일반 탭과 아이콘 전용 탭 분리
  const regularEntries = entries.filter(e => !e.iconOnly)
  const iconOnlyEntries = entries.filter(e => e.iconOnly)

  const renderTabButton = (entry: TabEntry, index: number, isIconOnly: boolean) => {
    const isActive = index === 0
    const baseClasses = isIconOnly
      ? 'px-3 py-3 text-sm font-semibold transition border-b-2 rounded-t-none md:rounded-t-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-wiki-primary/70'
      : 'px-4 md:px-4 py-3 md:py-3 text-sm md:text-sm font-semibold transition border-b-2 rounded-t-none md:rounded-t-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-wiki-primary/70'
    const activeClasses = isActive
      ? 'text-white border-wiki-primary bg-transparent md:bg-wiki-border/30'
      : 'text-wiki-muted border-transparent hover:text-white hover:border-wiki-border'
    
    // 아이콘 전용 탭: 아이콘만 표시, title로 호버 시 라벨 표시
    const buttonContent = isIconOnly
      ? `<i class="fas ${entry.icon} text-base" aria-hidden="true"></i>
         <span class="sr-only">${escapeHtml(entry.label)}</span>`
      : `<i class="fas ${entry.icon} mr-2 text-base md:text-sm" aria-hidden="true"></i>
         <span class="tab-label">${escapeHtml(entry.label)}</span>`
    
    const titleAttr = isIconOnly ? `title="${escapeHtml(entry.label)}"` : ''
    const iconOnlyAttr = isIconOnly ? 'data-icon-only="true"' : ''
    
    return `
      <li role="presentation" class="flex" data-cw-tab-item>
        <button
          type="button"
          id="cw-tab-${entry.id}"
          role="tab"
          aria-selected="${isActive ? 'true' : 'false'}"
          aria-controls="cw-tab-panel-${entry.id}"
          aria-describedby="${statusId} ${instructionsId}"
          aria-keyshortcuts="ArrowLeft ArrowRight Home End"
          aria-setsize="${totalTabs}"
          aria-posinset="${index + 1}"
          aria-label="${isIconOnly ? escapeHtml(entry.label) : ''}"
          tabindex="${isActive ? '0' : '-1'}"
          class="${baseClasses} ${activeClasses}"
          ${titleAttr}
          ${iconOnlyAttr}
          data-cw-tab-trigger
          data-tab-id="${entry.id}"
          data-tab-index="${index}"
          data-entity-type="${entityType}"
          data-entity-id="${escapeHtml(entityId)}"
          data-cw-telemetry-action="tab-trigger"
          data-cw-telemetry-component="tab-trigger"
        >
          ${buttonContent}
        </button>
      </li>
    `
  }

  // 일반 탭 버튼
  const regularTabButtons = regularEntries
    .map((entry, idx) => {
      const originalIndex = entries.indexOf(entry)
      return renderTabButton(entry, originalIndex, false)
    })
    .join('')
  
  // 아이콘 전용 탭 버튼 (오른쪽 끝에 배치)
  const iconOnlyTabButtons = iconOnlyEntries.length > 0
    ? `<li class="flex-grow"></li>` + iconOnlyEntries
        .map((entry) => {
          const originalIndex = entries.indexOf(entry)
          return renderTabButton(entry, originalIndex, true)
        })
        .join('')
    : ''
  
  const tabButtons = regularTabButtons + iconOnlyTabButtons

  const tabPanels = entries
    .map((entry, index) => {
      const isActive = index === 0
      return `
        <section
          id="cw-tab-panel-${entry.id}"
          role="tabpanel"
          aria-labelledby="cw-tab-${entry.id}"
          aria-hidden="${isActive ? 'false' : 'true'}"
          aria-describedby="${statusId} ${instructionsId}"
          tabindex="${isActive ? '0' : '-1'}"
          class="cw-tab-panel space-y-6 ${isActive ? 'is-active' : 'is-hidden'}"
          data-cw-tab-panel
          data-tab-id="${entry.id}"
          data-tab-index="${index}"
          data-cw-telemetry-scope="tab-panel"
          data-cw-telemetry-component="tab-panel"
        >
          ${entry.content}
        </section>
      `
    })
    .join('')

  return `
    <section
      id="${tabsetId}"
      class="glass-card border p-0 rounded-2xl overflow-hidden"
      data-cw-tabset
      data-tabset-id="${tabsetId}"
      data-entity-type="${entityType}"
      data-tab-default="${entries[0].id}"
      data-active-tab="${entries[0].id}"
      data-cw-tab-count="${totalTabs}"
      data-cw-telemetry-scope="tabset"
      data-cw-telemetry-component="tabset"
      data-cw-telemetry-action="tabset-render"
      role="region"
      aria-roledescription="콘텐츠 탭 영역"
      aria-labelledby="${tabsetId}-label"
      aria-describedby="${statusId} ${instructionsId}"
    >
      <header class="sr-only">
        <h2 id="${tabsetId}-label">${escapeHtml(tabsetLabel)}</h2>
        <p id="${instructionsId}">방향키로 탭을 이동하고 Enter 키로 선택할 수 있습니다. Home/End 키로 처음과 마지막 탭으로 이동합니다.</p>
      </header>
      <div
        class="flex flex-wrap gap-2 px-2 md:px-4 pt-3 md:pt-4 bg-transparent md:bg-wiki-bg/70 border-b border-wiki-border/50 md:border-wiki-border"
        data-cw-tablist-container
      >
        <ul
          class="flex flex-wrap gap-2 w-full"
          id="${tablistId}"
          role="tablist"
          aria-label="${escapeHtml(tabsetLabel)}"
          aria-describedby="${statusId} ${instructionsId}"
          aria-orientation="horizontal"
          data-cw-tablist
          data-cw-tablist-items
          data-cw-telemetry-scope="tablist"
          data-cw-telemetry-component="tablist"
        >
          ${tabButtons}
        </ul>
      </div>
      <p class="sr-only" id="${statusId}" role="status" aria-live="polite" aria-atomic="true" data-cw-tab-status></p>
      <div class="px-0 md:px-6 py-6 space-y-6" data-cw-tab-panels data-cw-telemetry-scope="tab-panels" data-cw-telemetry-component="tab-panels">
        ${tabPanels}
      </div>
    </section>
  `
}

export interface CtaLinkOption {
  href: string
  label: string
  icon: string
  ctaType: string
  variant?: 'primary' | 'secondary'
}

export interface CtaGroupOptions {
  entityType: DetailComponentEntityType
  entityId: string
  links: CtaLinkOption[]
}

const CTA_VARIANT_CLASSES: Record<NonNullable<CtaLinkOption['variant']>, string> = {
  primary:
    'px-5 py-3 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white text-sm font-semibold rounded-xl shadow-lg hover:shadow-xl transition',
  secondary:
    'px-5 py-3 border border-wiki-border text-sm text-wiki-muted rounded-xl hover:border-wiki-primary hover:text-wiki-primary transition'
}

const resolveCtaClasses = (variant: CtaLinkOption['variant'] = 'primary'): string => CTA_VARIANT_CLASSES[variant]

export const renderCtaGroup = ({ entityType, entityId, links }: CtaGroupOptions): string => {
  if (!links.length) {
    return ''
  }

  const normalizedBase = `${entityType}-${entityId}`
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')

  const navLabel =
    entityType === 'job'
      ? '직업 상세 주요 행동'
      : entityType === 'major'
        ? '전공 상세 주요 행동'
        : 'HowTo 가이드 주요 행동'
  const navId = normalizedBase ? `cw-${normalizedBase}-cta` : `cw-${entityType}-cta`
  const noteId = `${navId}-note`
  const instructionsId = `${navId}-instructions`

  const buttons = links
    .map((link, index) => `
      <li class="flex" role="listitem" data-cw-cta-item data-cta-index="${index}">
        <a
          href="${escapeHtml(link.href)}"
          class="${resolveCtaClasses(link.variant)}"
          data-cw-cta
          data-cw-telemetry-action="cta"
          data-cw-telemetry-component="cta-link"
          data-cta-index="${index}"
          data-cta-type="${escapeHtml(link.ctaType)}"
          data-cta-variant="${link.variant ?? 'primary'}"
          data-cta-label="${escapeHtml(link.label)}"
          data-entity-id="${escapeHtml(entityId)}"
          data-entity-type="${entityType}"
          aria-describedby="${noteId} ${instructionsId}"
          aria-label="${escapeHtml(link.label)}"
        >
          <i class="fas ${link.icon} mr-2" aria-hidden="true"></i>
          <span class="cta-label">${escapeHtml(link.label)}</span>
        </a>
      </li>
    `)
    .join('')

  return `
    <nav
      class="mt-6"
      data-cw-cta-group
      data-cw-telemetry-scope="cta-group"
      data-cw-telemetry-component="cta-group"
      data-cw-telemetry-action="cta-group-render"
      data-cta-count="${links.length}"
      data-entity-type="${entityType}"
      data-entity-id="${escapeHtml(entityId)}"
      aria-labelledby="${navId}-label"
      aria-describedby="${noteId} ${instructionsId}"
      aria-roledescription="주요 행동 내비게이션"
      role="navigation"
    >
      <div class="sr-only">
        <h2 id="${navId}-label">${escapeHtml(navLabel)}</h2>
        <p id="${noteId}">CareerWiki 주요 전환 행동 모음입니다.</p>
        <p id="${instructionsId}">각 버튼은 Enter 또는 Space 키로 실행할 수 있으며, 링크는 새 탭에서 열릴 수 있습니다.</p>
      </div>
      <ul class="flex flex-wrap gap-3" role="list" data-cw-telemetry-component="cta-list">
        ${buttons}
      </ul>
    </nav>
  `
}

export interface CommentPolicyAttributes {
  requiresAuth?: boolean
  bestLikeThreshold?: number
  bestLimit?: number
  reportBlindThreshold?: number
  dailyVoteLimit?: number
  voteWindowHours?: number
  ipDisplayMode?: 'hash' | 'masked' | 'hidden'
  moderatorIpBlockEnabled?: boolean
  moderatorRoles?: string[]
}

export interface SampleCommentPayload {
  id: string
  author: string
  content: string
  likes: number
  dislikes: number
  createdAt: string
  role?: 'user' | 'expert' | 'operator'
  badge?: string
}

const COMMENT_POLICY_DEFAULTS: Required<CommentPolicyAttributes> = {
  requiresAuth: false,
  bestLikeThreshold: 5,
  bestLimit: 10,
  reportBlindThreshold: 3,
  dailyVoteLimit: 5,
  voteWindowHours: 24,
  ipDisplayMode: 'masked',
  moderatorIpBlockEnabled: true,
  moderatorRoles: ['super-admin', 'operator']
}

export const resolveCommentPolicy = (policy?: CommentPolicyAttributes): Required<CommentPolicyAttributes> => {
  const moderatorRoles = Array.isArray(policy?.moderatorRoles) && policy.moderatorRoles.length
    ? Array.from(
        new Set(
          policy.moderatorRoles
            .map((role) => (typeof role === 'string' ? role.trim() : ''))
            .filter((role) => role.length)
        )
      )
    : COMMENT_POLICY_DEFAULTS.moderatorRoles

  return {
    requiresAuth: policy?.requiresAuth ?? COMMENT_POLICY_DEFAULTS.requiresAuth,
    bestLikeThreshold: policy?.bestLikeThreshold ?? COMMENT_POLICY_DEFAULTS.bestLikeThreshold,
    bestLimit: policy?.bestLimit ?? COMMENT_POLICY_DEFAULTS.bestLimit,
    reportBlindThreshold: policy?.reportBlindThreshold ?? COMMENT_POLICY_DEFAULTS.reportBlindThreshold,
    dailyVoteLimit: policy?.dailyVoteLimit ?? COMMENT_POLICY_DEFAULTS.dailyVoteLimit,
    voteWindowHours: policy?.voteWindowHours ?? COMMENT_POLICY_DEFAULTS.voteWindowHours,
    ipDisplayMode: policy?.ipDisplayMode ?? COMMENT_POLICY_DEFAULTS.ipDisplayMode,
    moderatorIpBlockEnabled: policy?.moderatorIpBlockEnabled ?? COMMENT_POLICY_DEFAULTS.moderatorIpBlockEnabled,
    moderatorRoles: moderatorRoles.length ? [...moderatorRoles] : [...COMMENT_POLICY_DEFAULTS.moderatorRoles]
  }
}

export const buildCommentGovernanceItems = (policy: Required<CommentPolicyAttributes>): string[] => {
  const governanceItems: string[] = []
  governanceItems.push('로그인 없이도 댓글을 작성할 수 있습니다. 익명 작성 시 4자리 숫자 비밀번호가 필요합니다.')
  governanceItems.push('익명 사용자는 하루 최대 5개의 댓글을 작성할 수 있습니다.')
  governanceItems.push('댓글은 최대 500자까지 작성 가능하며, 최대 3단계까지 답글을 달 수 있습니다.')
  governanceItems.push(`좋아요 ${policy.bestLikeThreshold}개 이상 댓글은 BEST로 강조됩니다.`)
  governanceItems.push('BEST 댓글은 목록 상단에 고정됩니다.')
  governanceItems.push(`신고 ${policy.reportBlindThreshold}회 이상 시 자동으로 블라인드 처리됩니다.`)
  governanceItems.push('여러 댓글에 공감/비공감을 표시하는 것은 제한이 없습니다.')
  governanceItems.push('단, 한 댓글에는 공감 또는 비공감 중 하나만 선택할 수 있습니다.')
  if (policy.ipDisplayMode === 'masked') {
    governanceItems.push('IP는 마스킹된 형태로만 노출됩니다.')
  } else if (policy.ipDisplayMode === 'hash') {
    governanceItems.push('IP는 해시값으로 저장되며 원본은 노출되지 않습니다.')
  } else if (policy.ipDisplayMode === 'hidden') {
    governanceItems.push('IP는 사용자에게 노출되지 않습니다.')
  }
  if (policy.moderatorIpBlockEnabled) {
    governanceItems.push('모더레이터는 신고 누적 IP를 차단할 수 있습니다.')
  }
  if (policy.moderatorRoles.length) {
    governanceItems.push(`모더레이터 역할 계층: ${policy.moderatorRoles.join(' > ')}`)
  }
  return governanceItems
}

export interface CommentsPlaceholderOptions {
  entityType: DetailComponentEntityType
  entityId: string
  entitySlug: string
  entityName: string
  entitySummary?: string | null
  title: string
  description: string
  feedbackLabel: string
  notifyLabel: string
  emptyLabel?: string
  policy?: CommentPolicyAttributes
  sampleComments?: SampleCommentPayload[]
  showForm?: boolean
}

export const renderCommentsPlaceholder = ({
  entityType,
  entityId,
  entitySlug,
  entityName,
  entitySummary,
  title,
  description,
  feedbackLabel,
  notifyLabel,
  emptyLabel,
  policy,
  sampleComments,
  showForm
}: CommentsPlaceholderOptions): string => {
  const normalizedBase = `${entityType}-${entityId}`
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')

  const nicknameId = `${normalizedBase}-nickname`
  const contentId = `${normalizedBase}-content`
  const authMessageId = `${normalizedBase}-auth`
  const statusMessageId = `${normalizedBase}-status`
  const instructionsId = `${normalizedBase}-instructions`
  const srTitleId = `${normalizedBase}-sr-title`
  const policyLinkId = `${normalizedBase}-policy-link`
  const bestTabId = `${normalizedBase}-tab-best`
  const allTabId = `${normalizedBase}-tab-all`
  const bestPanelId = `${normalizedBase}-panel-best`
  const allPanelId = `${normalizedBase}-panel-all`
  const sortLatestId = `${normalizedBase}-sort-latest`
  const sortLikesId = `${normalizedBase}-sort-likes`

  const policySnapshot = resolveCommentPolicy(policy)

  const policyAttributes = [
    `data-comment-requires-auth="${policySnapshot.requiresAuth ? 'true' : 'false'}"`,
    `data-comment-best-threshold="${policySnapshot.bestLikeThreshold}"`,
    `data-comment-best-limit="${policySnapshot.bestLimit}"`,
    `data-comment-report-threshold="${policySnapshot.reportBlindThreshold}"`,
    `data-comment-vote-limit="${policySnapshot.dailyVoteLimit}"`,
    `data-comment-vote-window="${policySnapshot.voteWindowHours}"`,
    `data-comment-ip-visibility="${policySnapshot.ipDisplayMode}"`,
    `data-comment-moderator-block="${policySnapshot.moderatorIpBlockEnabled ? 'true' : 'false'}"`,
    `data-comment-moderator-roles="${escapeHtml(policySnapshot.moderatorRoles.join(','))}"`
  ].join(' ')

  const policyJsonAttr = escapeHtml(JSON.stringify(policySnapshot))
  const srTitle = title?.trim().length ? escapeHtml(title.trim()) : ''
  const helpCenterHref = '/help/community-guidelines'
  const visibleHeading = '커뮤니티 댓글'
  const sanitizedDescription = description && description.trim().length ? escapeHtml(description.trim()) : ''
  const sampleJson = sampleComments && sampleComments.length ? escapeHtml(JSON.stringify(sampleComments)) : ''
  const sampleAttributes = sampleJson ? ` data-comment-sample="${sampleJson}" data-comment-demo="true"` : ''
  const composerEnabled = showForm !== false

  const resolvedBestThreshold = Number.isFinite(policySnapshot.bestLikeThreshold)
    ? policySnapshot.bestLikeThreshold
    : COMMENT_POLICY_DEFAULTS.bestLikeThreshold
  const resolvedReportThreshold = Number.isFinite(policySnapshot.reportBlindThreshold)
    ? policySnapshot.reportBlindThreshold
    : COMMENT_POLICY_DEFAULTS.reportBlindThreshold
  const bestScoreboardMessage = escapeHtml(`좋아요 ${resolvedBestThreshold}개 이상 댓글은 BEST로 승격됩니다.`)
  const moderationScoreboardMessage = escapeHtml(`신고 ${resolvedReportThreshold}회 이상 시 자동으로 블라인드 처리됩니다.`)
  const bestEmptyMessage = escapeHtml('아직 BEST 댓글이 없습니다.')
  const allEmptyMessage = escapeHtml(emptyLabel ?? '가장 먼저 의견을 남겨보세요.')

  // 로그인 CTA 제거 - 익명 사용자도 댓글 작성 가능
  const loginCtaBlock = ''

  const passwordId = `${normalizedBase}-password`

  const composerBlock = composerEnabled
    ? `
    <form class="space-y-1.5" data-cw-comment-form data-cw-telemetry-scope="comment-form" data-cw-telemetry-component="comment-form" novalidate aria-describedby="${statusMessageId}">
      <div class="flex flex-col sm:flex-row sm:items-start sm:gap-3">
        <div class="flex-1 space-y-3">
            <div class="flex flex-col sm:flex-row gap-3 items-start sm:items-center justify-start">
            <div class="flex-1" data-cw-comment-nickname-wrapper>
              <label class="sr-only" for="${escapeHtml(nicknameId)}">닉네임</label>
                <div class="flex items-center gap-2 pl-2">
                <div class="w-6 h-6 rounded-full bg-wiki-card flex items-center justify-center flex-shrink-0 hidden" data-cw-comment-author-avatar>
                  <i class="fas fa-user-circle text-sm text-wiki-muted"></i>
                </div>
                <span class="hidden text-xs px-2 py-1 rounded-full bg-red-500/15 text-red-200 font-semibold" data-cw-comment-admin-badge aria-label="관리자">관리자</span>
                <span class="hidden text-sm text-wiki-text" data-cw-comment-nickname-display></span>
                <span class="hidden text-xs text-wiki-muted" data-cw-comment-ip-display></span>
                <input
                  id="${escapeHtml(nicknameId)}"
                  name="nickname"
                  type="text"
                  maxlength="40"
                  placeholder="닉네임"
                  autocomplete="nickname"
                  class="w-full px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none text-sm"
                  data-cw-comment-nickname
                />
              </div>
            </div>
            <div class="flex items-center gap-2 flex-shrink-0" data-cw-comment-anonymous-label hidden>
              <div class="w-6 h-6 rounded-full bg-wiki-card flex items-center justify-center flex-shrink-0" data-cw-comment-anon-avatar>
                <i class="fas fa-user-circle text-sm text-wiki-muted"></i>
              </div>
              <span class="text-sm text-wiki-text whitespace-nowrap" data-cw-comment-anonymous-number>익명</span>
              <span class="text-xs text-wiki-muted" data-cw-comment-current-ip></span>
              <label class="sr-only" for="${escapeHtml(passwordId)}">비밀번호 (익명 필수)</label>
              <input
                id="${escapeHtml(passwordId)}"
                name="password"
                type="password"
                maxlength="4"
                pattern="[0-9]{4}"
                placeholder="비밀번호 (4자리 숫자)"
                autocomplete="new-password"
                style="width: 175px;"
                class="px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none text-sm"
                data-cw-comment-password
              />
              <span class="text-xs text-red-400" data-cw-comment-password-warning hidden></span>
            </div>
          </div>
          <div class="flex items-center gap-2 text-xs text-wiki-muted cursor-pointer" data-cw-comment-reply-indicator hidden>
            <span class="px-2 py-1 rounded bg-wiki-border/40 text-wiki-text" data-cw-comment-reply-label></span>
          </div>
          <div>
            <label class="sr-only" for="${escapeHtml(contentId)}">댓글 작성</label>
            <textarea
              id="${escapeHtml(contentId)}"
              name="content"
              rows="4"
              maxlength="500"
              required
              placeholder="타인의 권리를 침해하거나 명예를 훼손하거나, 욕설, 음란, 광고·홍보성 댓글은 운영원칙 및 관련 법률에 제재를 받을 수 있습니다. 그 외의 의견을 자유롭게 게시해보세요!"
              class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none resize-y text-sm"
              aria-required="true"
              aria-describedby="${statusMessageId}"
              data-cw-comment-content
            ></textarea>
          </div>
        </div>
      </div>
      <div class="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between" data-cw-comments-toolbar data-cw-telemetry-component="comments-toolbar">
        <div class="flex items-start gap-3 text-xs text-wiki-muted pl-4 leading-none">
          <div class="leading-none" data-cw-comment-char-count>0 / 500자</div>
          <div id="${statusMessageId}" data-cw-comment-status role="status" aria-live="polite" aria-atomic="true"></div>
        </div>
        <button
          type="submit"
          class="inline-flex items-center justify-center gap-2 px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm font-semibold hover:bg-blue-600 transition"
          data-cw-comment-submit
          data-cw-telemetry-action="comment-submit"
          data-cw-telemetry-component="comment-submit"
        >
          <i class="fas fa-paper-plane" aria-hidden="true"></i>
          <span>등록</span>
        </button>
      </div>
    </form>
    <div class="border-t border-wiki-border/60 my-4"></div>
    `
    : `
    <div class="text-xs text-wiki-muted" id="${statusMessageId}" data-cw-comment-status role="status" aria-live="polite" aria-atomic="true"></div>
    `

  return `
  <section
    class="glass-card border px-6 py-6 md:px-6 rounded-2xl space-y-4 md:space-y-6"
    id="cw-comments"
    data-cw-comments
    data-cw-telemetry-scope="comments"
    data-cw-telemetry-component="comments"
    data-cw-telemetry-action="comments-placeholder"
    data-comments-status="scheduled"
    data-entity-type="${entityType}"
    data-entity-id="${escapeHtml(entityId)}"
    data-entity-slug="${escapeHtml(entitySlug)}"
    data-entity-name="${escapeHtml(entityName)}"
    ${entitySummary ? `data-entity-summary="${escapeHtml(entitySummary)}"` : ''}
    ${policyAttributes}
    data-comment-policy-json="${policyJsonAttr}"
    data-cw-comment-governance-version="1"
    aria-labelledby="${normalizedBase}-title"
    aria-describedby="${authMessageId} ${statusMessageId} ${instructionsId} ${policyLinkId}"
    aria-roledescription="댓글 상호작용 영역"
    role="complementary"${sampleAttributes}
  >
        <header class="flex items-center justify-between gap-3" data-cw-comments-header data-cw-telemetry-scope="comments-header" data-cw-telemetry-component="comments-header">
          <div class="flex items-center gap-3">
            <i class="fas fa-comments text-wiki-secondary text-xl" aria-hidden="true"></i>
            <div class="space-y-1">
              <h2 class="text-lg font-semibold text-wiki-text" id="${normalizedBase}-title">${visibleHeading}</h2>
              ${srTitle ? `<p class="sr-only" id="${srTitleId}">${srTitle}</p>` : ''}
              ${sanitizedDescription ? `<p class="sr-only">${sanitizedDescription}</p>` : ''}
            </div>
          </div>
          <div class="text-xs text-wiki-muted flex items-center" id="${policyLinkId}">
            <a href="${helpCenterHref}" class="text-wiki-primary hover:text-wiki-secondary transition whitespace-nowrap" data-cw-comment-policy-link>커뮤니티 이용 정책</a>
          </div>
        </header>
    <p class="sr-only" id="${instructionsId}">댓글 목록을 볼 수 있으며, 로그인 여부와 관계없이 댓글 작성이 가능합니다.</p>
    <div class="text-xs text-wiki-muted" id="${authMessageId}" data-cw-comment-auth aria-live="polite" aria-atomic="true"></div>
    ${loginCtaBlock}
    ${composerBlock}
    <div class="space-y-6" data-cw-comments-body data-cw-telemetry-component="comments-body" role="region" aria-live="polite" aria-atomic="false" aria-busy="false">
      <div class="flex items-center gap-3 text-sm text-wiki-muted" data-cw-comments-loading hidden>
        <i class="fas fa-spinner fa-spin" aria-hidden="true"></i>
        <span>댓글을 불러오는 중...</span>
      </div>
      <div class="space-y-4" data-comment-toolbar>
        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <!-- 탭: 전체 댓글 / BEST -->
          <div
            class="flex items-center gap-1 rounded-full border border-wiki-border/80 bg-wiki-bg/80 p-1 w-full sm:w-auto"
            role="tablist"
            aria-label="댓글 보기 유형"
            data-comment-tablist
          >
            <button
              type="button"
              class="comment-tab-btn flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] rounded-full text-sm font-semibold transition border border-wiki-primary/50 bg-wiki-primary text-white shadow-sm"
              data-comment-tab="all"
              role="tab"
              aria-selected="true"
              id="${allTabId}"
              aria-controls="${allPanelId}"
            >전체 댓글</button>
            <button
              type="button"
              class="comment-tab-btn flex-1 sm:flex-none px-4 py-2.5 min-h-[44px] rounded-full text-sm font-semibold transition border border-transparent text-gray-300 hover:text-white hover:bg-wiki-primary/60"
              data-comment-tab="best"
              role="tab"
              aria-selected="false"
              id="${bestTabId}"
              aria-controls="${bestPanelId}"
            >BEST</button>
          </div>
          <!-- 정렬: 최신순 / 공감순 -->
          <div class="flex items-center justify-between sm:justify-end gap-3 text-xs text-wiki-muted" data-comment-sort-toolbar>
            <span class="uppercase tracking-wide text-[11px]">정렬</span>
            <div class="flex flex-1 sm:flex-none rounded-lg border border-wiki-border/70 bg-wiki-bg/70 p-1" role="group" data-comment-sort-group>
              <button
                type="button"
                class="comment-sort-btn flex-1 sm:flex-none px-3 sm:px-4 py-2 min-h-[40px] rounded-md text-xs font-semibold transition border border-wiki-primary/60 bg-wiki-primary text-white shadow-sm"
                data-comment-sort="latest"
                aria-pressed="true"
                id="${sortLatestId}"
              >최신순</button>
              <button
                type="button"
                class="comment-sort-btn flex-1 sm:flex-none px-3 sm:px-4 py-2 min-h-[40px] rounded-md text-xs font-semibold transition border border-transparent text-gray-300 hover:text-white hover:bg-wiki-border/50"
                data-comment-sort="likes"
                aria-pressed="false"
                id="${sortLikesId}"
              >공감순</button>
            </div>
          </div>
        </div>
        <p class="text-xs text-wiki-muted" data-cw-comment-guidance hidden></p>
      </div>
      <section id="${bestPanelId}" class="space-y-3" role="tabpanel" aria-labelledby="${bestTabId}" data-comment-panel="best" hidden>
        <h3 class="sr-only">BEST 댓글</h3>
        <ul class="space-y-4" data-comment-list="best" role="list"></ul>
        <div class="flex flex-col items-center justify-center gap-3 rounded-xl border border-dashed border-wiki-border/60 bg-wiki-bg/40 px-6 py-10 text-center text-sm text-wiki-muted" data-comment-empty="best">
          <i class="fas fa-sparkles text-lg text-wiki-secondary" aria-hidden="true"></i>
          <p class="leading-relaxed">${bestEmptyMessage}</p>
        </div>
      </section>
      <section id="${allPanelId}" class="space-y-3" role="tabpanel" aria-labelledby="${allTabId}" data-comment-panel="all">
        <h3 class="sr-only">전체 댓글</h3>
        <ul class="space-y-4" data-comment-list="all" role="list"></ul>
        <div class="flex flex-col items-center justify-center gap-3 rounded-xl border border-dashed border-wiki-border/60 bg-wiki-bg/40 px-6 py-10 text-center text-sm text-wiki-muted" data-comment-empty="all">
          <i class="fas fa-comment-dots text-lg text-wiki-secondary" aria-hidden="true"></i>
          <p class="leading-relaxed">${allEmptyMessage}</p>
        </div>
      </section>
      <div class="hidden" aria-hidden="true">
        <div data-cw-comments-empty></div>
        <ul data-cw-comments-list></ul>
      </div>
    </div>
    <!-- 댓글 신고 모달 -->
    <div class="fixed inset-0 z-[2000] hidden" data-cw-comment-report-modal role="dialog" aria-modal="true" aria-labelledby="${normalizedBase}-comment-report-title">
      <div class="fixed inset-0 bg-black/60 backdrop-blur-sm" data-cw-comment-report-backdrop></div>
      <div class="fixed inset-0 flex items-center justify-center px-4">
        <div class="w-full max-w-md rounded-2xl bg-wiki-bg border border-wiki-border shadow-2xl" data-cw-comment-report-dialog>
          <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border">
            <h3 id="${normalizedBase}-comment-report-title" class="text-lg font-semibold text-white">댓글 신고</h3>
            <button type="button" class="text-wiki-muted hover:text-white transition" data-cw-comment-report-close aria-label="닫기">
              <i class="fas fa-times"></i>
            </button>
          </div>
          <form class="p-6 space-y-4" data-cw-comment-report-form>
            <div class="space-y-2">
              <label class="text-sm font-semibold text-white">신고 사유 *</label>
              <select class="w-full rounded-lg border border-wiki-border bg-wiki-bg px-3 py-2 text-sm text-white focus:border-wiki-primary focus:outline-none" data-cw-comment-report-reason required>
                <option value="">선택해주세요</option>
                <option value="defamation">명예훼손</option>
                <option value="obscene">음란물</option>
                <option value="spam">스팸/광고</option>
                <option value="copyright">저작권 침해</option>
                <option value="false_info">허위정보</option>
                <option value="other">기타</option>
              </select>
            </div>
            <div class="space-y-2">
              <label class="text-sm font-semibold text-white">상세 사유 (선택)</label>
              <textarea class="w-full rounded-lg border border-wiki-border bg-wiki-bg px-3 py-2 text-sm text-white min-h-[96px] resize-none focus:border-wiki-primary focus:outline-none" maxlength="300" placeholder="추가 설명이 있다면 작성해주세요 (최대 300자)" data-cw-comment-report-detail></textarea>
            </div>
            <div class="flex items-center justify-between gap-3 pt-2">
              <button type="button" class="flex-1 px-4 py-2 rounded-lg border border-wiki-border text-sm text-wiki-muted hover:text-white hover:border-wiki-primary transition" data-cw-comment-report-close>
                취소
              </button>
              <button type="submit" class="flex-1 px-4 py-2 rounded-lg bg-rose-600 hover:bg-rose-500 text-sm font-semibold text-white transition" data-cw-comment-report-submit>
                신고하기
              </button>
            </div>
            <div class="text-sm" data-cw-comment-report-message role="alert" aria-live="polite"></div>
          </form>
        </div>
      </div>
    </div>
  </section>
`
}

export interface DetailMetaPayload {
  entity: {
    type: 'job' | 'major'
    id: string
    slug: string
    name: string
    category: string | null
    summary: string | null
    sources: DataSource[]
  }
  tabs: string[]
  sourceStatus: string[]
  partials: string[]
  extra?: Record<string, unknown>
}

export interface DetailScaffoldOptions {
  entityType: 'job' | 'major'
  entityId: string
  entitySlug: string
  entityName: string
  entitySummary?: string | null
  entityCategory?: string | null
  entitySources?: DataSource[] | null
  tabs: TabEntry[]
  tabFallback?: TabsetOptions['fallback']
  ctaLinks: CtaLinkOption[]
  comments: {
    title: string
    description: string
    feedbackLabel: string
    notifyLabel: string
    emptyLabel?: string
    policy?: CommentPolicyAttributes
    sampleComments?: SampleCommentPayload[]
    showForm?: boolean
  }
  partials?: Partial<Record<DataSource, unknown | null>>
  sources?: SourceStatusRecord
  metaExtra?: Record<string, unknown>
}

export interface DetailScaffoldResult {
  tabLayout: string
  ctaBlock: string
  commentsPlaceholder: string
  metaScript: string
  meta: DetailMetaPayload
}

export const buildDetailScaffold = ({
  entityType,
  entityId,
  entitySlug,
  entityName,
  entitySummary,
  entityCategory,
  entitySources,
  tabs,
  tabFallback,
  ctaLinks,
  comments,
  partials,
  sources,
  metaExtra
}: DetailScaffoldOptions): DetailScaffoldResult => {
  const tabLayout = renderTabset({
    entityType,
    entityId,
    entries: tabs,
    fallback: tabFallback
  })

  const ctaBlock = renderCtaGroup({
    entityType,
    entityId,
    links: ctaLinks
  })

  const commentPolicy = resolveCommentPolicy(comments.policy)

  const commentsPlaceholder = renderCommentsPlaceholder({
    entityType,
    entityId,
    entitySlug,
    entityName,
    entitySummary,
    title: comments.title,
    description: comments.description,
    feedbackLabel: comments.feedbackLabel,
    notifyLabel: comments.notifyLabel,
    emptyLabel: comments.emptyLabel,
    policy: commentPolicy,
    sampleComments: comments.sampleComments,
    showForm: comments.showForm
  })

  const normalizedSources = Array.isArray(entitySources)
    ? entitySources.filter((source): source is DataSource => typeof source === 'string' && source.length > 0)
    : []

  const meta: DetailMetaPayload = {
    entity: {
      type: entityType,
      id: entityId,
      slug: entitySlug,
      name: entityName,
      category: entityCategory ?? null,
      summary: entitySummary ?? null,
      sources: normalizedSources
    },
    tabs: tabs.map((entry) => entry.id),
    sourceStatus: sources ? Object.keys(sources) : [],
    partials: partials
      ? (Object.entries(partials) as Array<[DataSource, unknown]>).
          filter(([, value]) => Boolean(value)).
          map(([key]) => key)
      : []
  }

  const combinedExtra: Record<string, unknown> = { ...(metaExtra ?? {}) }
  const baseComments =
    typeof combinedExtra.comments === 'object' && combinedExtra.comments !== null && !Array.isArray(combinedExtra.comments)
      ? (combinedExtra.comments as Record<string, unknown>)
      : {}
  combinedExtra.comments = {
    ...baseComments,
    title: comments.title,
    description: comments.description,
    feedbackLabel: comments.feedbackLabel,
    notifyLabel: comments.notifyLabel,
    emptyLabel: comments.emptyLabel ?? null,
    policy: commentPolicy,
    sampleCount: comments.sampleComments?.length ?? 0,
    showForm: comments.showForm !== false
  }

  if (Object.keys(combinedExtra).length > 0) {
    meta.extra = combinedExtra
  }

  const metaScript = createDetailMetaScript(meta)

  return {
    tabLayout,
    ctaBlock,
    commentsPlaceholder,
    metaScript,
    meta
  }
}

/**
 * 광고 슬롯 플레이스홀더
 * 출처 섹션과 댓글 섹션 사이에 배치되는 광고 영역
 * 실제 광고가 로드되지 않으면 빈 상태로 collapse됨
 */
export const renderAdSlot = (options: {
  entityType: 'job' | 'major' | 'howto'
  position?: 'content-bottom'
}): string => {
  const { entityType, position = 'content-bottom' } = options
  return `
    <div class="ad-slot-container"
         data-ad-slot="${position}"
         data-ad-entity-type="${entityType}"
         data-ad-status="pending"
         style="min-height: 0; transition: min-height 0.3s ease;">
      <div class="ad-slot-inner hidden" data-ad-inner>
        <div class="max-w-3xl mx-auto py-4">
          <div class="text-center">
            <div class="inline-block px-2 py-0.5 text-[10px] text-wiki-muted/50 uppercase tracking-wider mb-1">ad</div>
            <div class="ad-slot-content rounded-xl border border-wiki-border/20 bg-wiki-card/30 overflow-hidden"
                 data-ad-content
                 style="min-height: 90px;">
              <!-- 광고 콘텐츠가 여기에 삽입됩니다 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  `
}

export const renderSourceBadges = (
  sources?: DataSource[] | null,
  labels: Partial<Record<DataSource, string>> = DEFAULT_SOURCE_LABELS
): string => {
  if (!sources || sources.length === 0) return ''
  return `
    <div class="flex flex-wrap gap-2">
      ${sources
        .map((source) => `
          <span class="px-3 py-1 rounded-full bg-wiki-primary/10 border border-wiki-primary/40 text-xs text-wiki-primary">
            <i class="fas fa-database mr-1"></i>${escapeHtml(labels[source] ?? source)}
          </span>
        `)
        .join('')}
    </div>
  `
}

export interface SourcesPanelOptions {
  profile: { sourceIds: SourceIdentifiers }
  sources?: SourceStatusRecord
  partials?: Partial<Record<DataSource, unknown | null>>
  labels?: Partial<Record<DataSource, string>>
  descriptions?: Partial<Record<DataSource, string>>
  title: string
  description?: string
  annotations?: Array<{ label?: string; content: string }>
}

export const renderSourcesPanel = ({
  profile: _profile,
  sources,
  partials,
  labels = DEFAULT_SOURCE_LABELS,
  descriptions,
  title,
  description,
  annotations
}: SourcesPanelOptions): string => {
  const entries = (Object.keys(labels) as DataSource[])
    .map((source) => {
      const status = sources?.[source]
      const hasData = Boolean(partials?.[source])
      const note = hasData ? '통합 데이터에 포함되었습니다.' : status?.error ?? null

      if (!hasData && !status?.error) {
        return ''
      }

      const icon = hasData ? 'fa-circle-check text-green-400' : 'fa-circle-exclamation text-amber-300'
      const descriptionLine = descriptions?.[source]
        ? `<p class="text-xs text-wiki-muted">${escapeHtml(descriptions[source] ?? '')}</p>`
        : ''
      const noteLine = note ? `<p class="text-xs text-wiki-muted">${escapeHtml(note)}</p>` : ''

      // 데이터가 있는 출처만 클릭 가능 (하이라이트 기능)
      const clickableClass = hasData ? 'cursor-pointer hover:border-wiki-primary/60 hover:bg-wiki-primary/5' : ''
      const clickableHint = hasData ? `<span class="text-[10px] text-wiki-muted/70 ml-2">(클릭하여 표시)</span>` : ''
      
      return `
        <li
          class="p-3 border border-wiki-border rounded-lg bg-wiki-bg/60 transition ${clickableClass}"
          data-source-entry="${escapeHtml(source)}"
          data-source-has-data="${hasData ? 'true' : 'false'}"
        >
          <div class="flex items-start gap-3">
            <i class="fas ${icon} mt-1" aria-hidden="true"></i>
            <div class="space-y-1">
              <p class="text-sm font-semibold text-wiki-text">${escapeHtml(labels[source] ?? source)}${clickableHint}</p>
              ${descriptionLine}
              ${noteLine}
            </div>
          </div>
        </li>
      `
    })
    .filter((entry) => entry && entry.trim().length > 0)
    .join('')

  const annotationsMarkup = annotations?.length
    ? `
      <div class="border-t border-wiki-border/60 pt-4 space-y-3" data-source-annotations>
        ${annotations
          .map(
            (annotation, index) => `
              <article class="rounded-lg border border-wiki-border/40 bg-wiki-bg/50 p-3 text-xs leading-relaxed text-wiki-muted" data-source-note data-note-index="${index}">
                ${annotation.label ? `<p class="text-wiki-text font-semibold mb-1">${escapeHtml(annotation.label)}</p>` : ''}
                <p>${escapeHtml(annotation.content)}</p>
              </article>
            `
          )
          .join('')}
      </div>
    `
    : ''

  if (!entries && !annotationsMarkup) {
    return ''
  }

  const descriptionMarkup = description ? `<p class="text-xs text-wiki-muted">${escapeHtml(description)}</p>` : ''

  return `
    <div class="space-y-4" data-source-panel-root>
      <div class="space-y-1">
        <h3 class="text-lg font-semibold text-wiki-text">${escapeHtml(title)}</h3>
        ${descriptionMarkup}
      </div>
      ${entries ? `<ul class="space-y-3">${entries}</ul>` : ''}
      ${annotationsMarkup}
    </div>
  `
}

export const serializeForScript = (value: unknown): string =>
  JSON.stringify(value)
    .replace(/</g, '\\u003c')
    .replace(/>/g, '\\u003e')
    .replace(/&/g, '\\u0026')

export const createDetailMetaScript = (detailMeta: unknown): string =>
  `<script type="application/json" id="cw-detail-meta">${serializeForScript(detailMeta)}</script>`

export const sanitizeJson = (value: unknown): unknown => {
  if (Array.isArray(value)) {
    return value
      .map((item) => sanitizeJson(item))
      .filter((item) => item !== undefined && item !== null)
  }
  if (value && typeof value === 'object') {
    const result: Record<string, unknown> = {}
    Object.entries(value).forEach(([key, val]) => {
      const sanitized = sanitizeJson(val)
      if (
        sanitized !== undefined &&
        sanitized !== null &&
        !(typeof sanitized === 'string' && sanitized.trim() === '')
      ) {
        result[key] = sanitized
      }
    })
    return Object.keys(result).length ? result : undefined
  }
  if (typeof value === 'string') {
    const trimmed = value.trim()
    return trimmed.length ? trimmed : undefined
  }
  return value ?? undefined
}

