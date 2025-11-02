import type { DataSource, SourceIdentifiers } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'

export const DEFAULT_SOURCE_LABELS: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24'
}

export const escapeHtml = (value?: string | null): string => {
  if (!value) return ''
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}

export const formatRichText = (value?: string | null): string => {
  if (!value || !value.trim()) {
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }

  return value
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
    <div class="flex flex-wrap gap-2">
      ${items
        .filter((item) => !!item && !!item.trim())
        .map((item) => `<span class="px-3 py-1.5 rounded-full bg-wiki-bg border border-wiki-border content-text text-wiki-muted">${escapeHtml(item.trim())}</span>`)
        .join('')}
    </div>
  `
}

export interface BuildCardOptions {
  anchorId?: string
  telemetryScope?: string
  telemetryComponent?: string
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

export const resolveHeroImageUrl = (title: string): string => {
  const normalized = title.toLowerCase()
  for (const rule of HERO_IMAGE_RULES) {
    if (rule.keywords.some((keyword) => normalized.includes(keyword))) {
      return rule.url
    }
  }
  return DEFAULT_HERO_IMAGE
}

export const renderHeroImage = (
  title: string,
  options: { imageUrl?: string; dataAttribute?: string; context?: string } = {}
): string => {
  const imageUrl = options.imageUrl ?? resolveHeroImageUrl(title)
  const dataAttribute = options.dataAttribute ?? 'data-hero-image'
  const context = options.context ?? 'default'
  const dataAttributeSnippet = `${dataAttribute}="true"`

  return `
    <figure
      class="relative overflow-hidden rounded-3xl border border-wiki-border/60 bg-wiki-bg/60 shadow-lg h-[200px] sm:h-[240px] md:h-[280px] lg:h-[320px] xl:h-[360px]"
      ${dataAttributeSnippet}
      data-hero-context="${escapeHtml(context)}"
      data-hero-url="${escapeHtml(imageUrl)}"
      data-cw-telemetry-scope="hero"
      data-cw-telemetry-component="detail-hero-image"
      data-cw-telemetry-action="hero-image"
    >
      <div class="absolute inset-0">
        <img
          src="${escapeHtml(imageUrl)}"
          alt="${escapeHtml(title)}를 상징하는 대표 이미지"
          class="w-full h-full object-cover object-center"
          loading="lazy"
          decoding="async"
        >
        <div class="absolute inset-0 bg-gradient-to-b from-black/35 via-wiki-bg/20 to-wiki-bg/80 mix-blend-multiply"></div>
        <div class="absolute inset-0 bg-gradient-to-tr from-wiki-primary/30 via-transparent to-wiki-secondary/40 mix-blend-screen"></div>
        <div class="absolute inset-6 rounded-2xl border border-white/10 pointer-events-none"></div>
      </div>
      <figcaption class="sr-only">${escapeHtml(title)}를 상징하는 이미지</figcaption>
    </figure>
  `
}

export const buildCard = (title: string, icon: string, body: string, options: BuildCardOptions = {}): string => {
  if (!body || !body.trim()) {
    return ''
  }

  const { anchorId, telemetryScope, telemetryComponent } = options
  const className = `glass-card px-2 py-6 md:px-6 rounded-none md:rounded-xl space-y-3${anchorId ? ' scroll-mt-28' : ''}`
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

  return `
    <article ${attributeParts.join(' ')}>
      <h3 class="section-title flex items-center gap-3 mb-5">
        <span class="flex items-center justify-center w-8 h-8 rounded-lg bg-gradient-to-br from-wiki-primary/20 to-wiki-secondary/20 border border-wiki-primary/30">
          <i class="fas ${icon} text-wiki-secondary text-sm"></i>
        </span>
        <span>${escapeHtml(title)}</span>
      </h3>
      ${body}
    </article>
  `
}

export type TabEntry = { id: string; label: string; icon: string; content: string }
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

  const tabButtons = entries
    .map((entry, index) => {
      const isActive = index === 0
      const baseClasses = 'px-4 py-3 text-sm font-semibold transition border-b-2 rounded-t-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-wiki-primary/70'
      const activeClasses = isActive
        ? 'text-white border-wiki-primary bg-wiki-border/30'
        : 'text-wiki-muted border-transparent hover:text-white hover:border-wiki-border'
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
            tabindex="${isActive ? '0' : '-1'}"
            class="${baseClasses} ${activeClasses}"
            data-cw-tab-trigger
            data-tab-id="${entry.id}"
            data-tab-index="${index}"
            data-entity-type="${entityType}"
            data-entity-id="${escapeHtml(entityId)}"
            data-cw-telemetry-action="tab-trigger"
            data-cw-telemetry-component="tab-trigger"
          >
            <i class="fas ${entry.icon} mr-2" aria-hidden="true"></i>
            <span class="tab-label">${escapeHtml(entry.label)}</span>
          </button>
        </li>
      `
    })
    .join('')

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
      class="glass-card p-0 rounded-2xl overflow-hidden"
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
        class="flex flex-wrap gap-2 px-4 pt-4 bg-wiki-bg/70 border-b border-wiki-border"
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
      <div class="px-2 py-6 md:px-6 space-y-6" data-cw-tab-panels data-cw-telemetry-scope="tab-panels" data-cw-telemetry-component="tab-panels">
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
  requiresAuth: true,
  bestLikeThreshold: 8,
  bestLimit: 10,
  reportBlindThreshold: 5,
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
  if (policy.requiresAuth) {
    governanceItems.push('로그인한 사용자만 댓글을 작성할 수 있습니다.')
  } else {
    governanceItems.push('로그인하지 않아도 댓글을 작성할 수 있습니다.')
  }
  governanceItems.push(`좋아요 ${policy.bestLikeThreshold}개 이상 댓글은 BEST로 강조됩니다.`)
  governanceItems.push('BEST 댓글은 목록 상단에 고정됩니다.')
  governanceItems.push(`신고 ${policy.reportBlindThreshold}회 이상 시 자동으로 블라인드 처리됩니다.`)
  if (policy.dailyVoteLimit > 0) {
    const windowLabel = policy.voteWindowHours === 24 ? '24시간' : `${policy.voteWindowHours}시간`
    governanceItems.push(`${windowLabel} 내 공감/비공감은 ${policy.dailyVoteLimit}회로 제한됩니다.`)
  }
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
  const bestEmptyMessage = escapeHtml(`좋아요 ${resolvedBestThreshold}개 이상을 받은 댓글이 등록되면 BEST 영역이 활성화됩니다.`)
  const allEmptyMessage = escapeHtml(emptyLabel ?? '가장 먼저 의견을 남겨보세요.')

  const loginCtaBlock = policySnapshot.requiresAuth
    ? `
    <div class="text-xs text-amber-300 bg-amber-500/10 border border-amber-500/30 rounded-lg p-3 flex flex-wrap items-center gap-3" data-cw-comment-auth-cta role="alert" aria-live="assertive">
      <span>로그인 후 댓글 작성 및 상호작용이 가능합니다.</span>
      <div class="flex flex-wrap gap-2">
        <a href="/login" class="px-3 py-1 bg-amber-400/20 border border-amber-500/60 rounded-md text-amber-200 hover:bg-amber-400/30 transition" data-cw-comment-login-intent data-auth-target="login">로그인</a>
        <a href="/signup" class="px-3 py-1 border border-amber-500/40 rounded-md text-amber-200 hover:bg-amber-400/20 transition" data-cw-comment-signup-intent data-auth-target="signup">회원가입</a>
      </div>
    </div>
    `
    : ''

  const composerBlock = composerEnabled
    ? `
    <form class="space-y-3" data-cw-comment-form data-cw-telemetry-scope="comment-form" data-cw-telemetry-component="comment-form" novalidate aria-describedby="${statusMessageId} ${authMessageId}">
      <div class="flex flex-col sm:flex-row sm:items-center sm:gap-3">
        <label class="sr-only" for="${escapeHtml(nicknameId)}">닉네임 (선택)</label>
        <input
          id="${escapeHtml(nicknameId)}"
          name="nickname"
          type="text"
          maxlength="40"
          placeholder="닉네임 (선택)"
          autocomplete="nickname"
          class="w-full sm:w-auto flex-1 px-4 py-2 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none"
        />
      </div>
      <div>
        <label class="sr-only" for="${escapeHtml(contentId)}">댓글 작성</label>
        <textarea
          id="${escapeHtml(contentId)}"
          name="content"
          rows="3"
          required
          placeholder="${escapeHtml(entityName)}에 대한 의견을 남겨주세요."
          class="w-full px-4 py-3 bg-wiki-bg border border-wiki-border rounded-lg focus:border-wiki-primary focus:outline-none resize-y"
          aria-required="true"
          aria-describedby="${statusMessageId} ${authMessageId}"
        ></textarea>
      </div>
      <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between" data-cw-comments-toolbar data-cw-telemetry-component="comments-toolbar">
        <div class="text-xs text-wiki-muted" id="${statusMessageId}" data-cw-comment-status role="status" aria-live="polite" aria-atomic="true"></div>
        <button
          type="submit"
          class="inline-flex items-center justify-center gap-2 px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm font-semibold hover:bg-blue-600 transition"
          data-cw-comment-submit
          data-cw-telemetry-action="comment-submit"
          data-cw-telemetry-component="comment-submit"
        >
          <i class="fas fa-paper-plane" aria-hidden="true"></i>
          <span>댓글 남기기</span>
        </button>
      </div>
    </form>
    `
    : `
    <div class="text-xs text-wiki-muted" id="${statusMessageId}" data-cw-comment-status role="status" aria-live="polite" aria-atomic="true"></div>
    `

  return `
  <section
    class="glass-card px-2 py-6 md:px-6 rounded-none md:rounded-2xl space-y-4 md:space-y-6"
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
    <header class="flex items-start gap-3" data-cw-comments-header data-cw-telemetry-scope="comments-header" data-cw-telemetry-component="comments-header">
      <i class="fas fa-comments text-wiki-secondary text-xl mt-1" aria-hidden="true"></i>
      <div class="space-y-1">
        <h2 class="text-lg font-semibold text-wiki-text" id="${normalizedBase}-title">${visibleHeading}</h2>
        ${srTitle ? `<p class="sr-only" id="${srTitleId}">${srTitle}</p>` : ''}
        ${sanitizedDescription ? `<p class="sr-only">${sanitizedDescription}</p>` : ''}
      </div>
    </header>
    <p class="sr-only" id="${instructionsId}">로그인 여부와 관계없이 댓글 목록을 볼 수 있으며, 로그인 후에만 작성과 상호작용이 가능합니다.</p>
    <div class="text-xs text-wiki-muted" id="${authMessageId}" data-cw-comment-auth aria-live="polite" aria-atomic="true"></div>
    ${loginCtaBlock}
    <div class="text-xs text-wiki-muted" id="${policyLinkId}">
      <a href="${helpCenterHref}" class="text-wiki-primary hover:text-wiki-secondary transition" data-cw-comment-policy-link>커뮤니티 이용 정책 보기</a>
    </div>
    <div class="space-y-6" data-cw-comments-body data-cw-telemetry-component="comments-body" role="region" aria-live="polite" aria-atomic="false" aria-busy="false">
      <div class="flex items-center gap-3 text-sm text-wiki-muted" data-cw-comments-loading hidden>
        <i class="fas fa-spinner fa-spin" aria-hidden="true"></i>
        <span>댓글을 불러오는 중...</span>
      </div>
      <div class="space-y-4" data-comment-toolbar>
        <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
          <div
            class="inline-flex items-center gap-1 rounded-full border border-wiki-border/80 bg-wiki-bg/80 p-1"
            role="tablist"
            aria-label="댓글 보기 유형"
            data-comment-tablist
          >
            <button
              type="button"
              class="comment-tab-btn px-4 py-2 rounded-full text-xs font-semibold transition border border-wiki-primary/50 bg-wiki-primary text-white shadow-sm"
              data-comment-tab="all"
              role="tab"
              aria-selected="true"
              id="${allTabId}"
              aria-controls="${allPanelId}"
            >전체 댓글</button>
            <button
              type="button"
              class="comment-tab-btn px-4 py-2 rounded-full text-xs font-semibold transition border border-transparent text-wiki-muted hover:text-white hover:bg-wiki-primary/60"
              data-comment-tab="best"
              role="tab"
              aria-selected="false"
              id="${bestTabId}"
              aria-controls="${bestPanelId}"
            >BEST</button>
          </div>
          <div class="flex flex-wrap items-center gap-3 text-xs text-wiki-muted" data-comment-sort-toolbar>
            <span class="uppercase tracking-wide text-[11px]">정렬</span>
            <div class="inline-flex rounded-lg border border-wiki-border/70 bg-wiki-bg/70 p-1" role="group" data-comment-sort-group>
              <button
                type="button"
                class="comment-sort-btn px-3 py-1.5 rounded-md text-xs font-semibold transition border border-wiki-primary/60 bg-wiki-primary text-white shadow-sm"
                data-comment-sort="latest"
                aria-pressed="true"
                id="${sortLatestId}"
              >최신순</button>
              <button
                type="button"
                class="comment-sort-btn px-3 py-1.5 rounded-md text-xs font-semibold transition border border-transparent text-wiki-muted hover:text-wiki-primary hover:border-wiki-primary/50"
                data-comment-sort="likes"
                aria-pressed="false"
                id="${sortLikesId}"
              >공감순</button>
            </div>
          </div>
        </div>
        <div class="grid gap-3 sm:grid-cols-2" data-cw-comment-scoreboard>
          <div class="flex items-center gap-3 rounded-xl border border-wiki-border/60 bg-wiki-bg/50 px-4 py-3 text-xs text-wiki-muted" data-cw-comment-scorecard="best">
            <i class="fas fa-star text-wiki-secondary" aria-hidden="true"></i>
            <span data-cw-comment-scorecard-count="best">${bestScoreboardMessage}</span>
          </div>
          <div class="flex items-center gap-3 rounded-xl border border-wiki-border/60 bg-wiki-bg/50 px-4 py-3 text-xs text-wiki-muted" data-cw-comment-scorecard="moderation">
            <i class="fas fa-shield-halved text-amber-300" aria-hidden="true"></i>
            <span data-cw-comment-scorecard-count="moderation">${moderationScoreboardMessage}</span>
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
    ${composerBlock}
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

export const renderSourceBadges = (
  sources?: DataSource[] | null,
  labels: Record<DataSource, string> = DEFAULT_SOURCE_LABELS
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
  labels?: Record<DataSource, string>
  descriptions?: Record<DataSource, string>
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

      return `
        <li
          class="p-3 border border-wiki-border rounded-lg bg-wiki-bg/60 transition"
          data-source-entry="${escapeHtml(source)}"
          data-source-has-data="${hasData ? 'true' : 'false'}"
        >
          <div class="flex items-start gap-3">
            <i class="fas ${icon} mt-1" aria-hidden="true"></i>
            <div class="space-y-1">
              <p class="text-sm font-semibold text-wiki-text">${escapeHtml(labels[source] ?? source)}</p>
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
