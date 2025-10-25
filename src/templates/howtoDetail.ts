import type { HowtoGuideDetail } from '../types/howto'
import type { CtaLinkOption, TabEntry, CommentPolicyAttributes } from './detailTemplateUtils'
import { buildCommentGovernanceItems, renderCtaGroup, renderCommentsPlaceholder, renderTabset, resolveCommentPolicy } from './detailTemplateUtils'

const escapeHtml = (value?: string | null): string => {
  if (!value) return ''
  return value
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
}

const formatRichText = (value?: string | null): string => {
  if (!value || !value.trim()) {
    return '<p class="text-sm text-wiki-muted">정보가 제공되지 않았습니다.</p>'
  }

  return value
    .trim()
    .split(/\n{2,}/)
    .map((paragraph) => {
      const safe = escapeHtml(paragraph.trim()).replace(/\n/g, '<br>')
      return `<p class="text-base leading-relaxed text-wiki-text">${safe}</p>`
    })
    .join('')
}

const renderChips = (items?: string[] | null): string => {
  if (!items || items.length === 0) return ''
  const chips = items
    .filter((item) => !!item && item.trim().length > 0)
    .map((item) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted" data-cw-telemetry-component="howto-chip">${escapeHtml(item.trim())}</span>`)
  return chips.length ? `<div class="flex flex-wrap gap-2" data-cw-telemetry-component="howto-chip-list">${chips.join('')}</div>` : ''
}

const renderKeyMetrics = (metrics?: Array<{ label: string; value: string; hint?: string }>): string => {
  if (!metrics || metrics.length === 0) return ''
  return `
    <section class="grid grid-cols-1 sm:grid-cols-3 gap-4" aria-label="핵심 지표" data-cw-telemetry-component="howto-metrics">
      ${metrics
        .map(
          (metric) => `
            <article class="bg-wiki-bg/60 border border-wiki-border rounded-xl p-4" data-cw-detail-card data-cw-telemetry-component="howto-metric-card">
              <p class="text-xs text-wiki-muted uppercase tracking-wide">${escapeHtml(metric.label)}</p>
              <p class="text-lg font-semibold text-white mt-1">${escapeHtml(metric.value)}</p>
              ${metric.hint ? `<p class="text-[10px] text-wiki-muted mt-2">${escapeHtml(metric.hint)}</p>` : ''}
            </article>
          `
        )
        .join('')}
    </section>
  `
}

const renderSteps = (steps: HowtoGuideDetail['steps']): string => {
  if (!steps || steps.length === 0) {
    return '<p class="text-sm text-wiki-muted">실행 단계가 등록되지 않았습니다.</p>'
  }

  return `
    <ol class="space-y-8" data-cw-howto-steps data-cw-telemetry-component="howto-steps" role="list">
      ${steps
        .map((step, index) => {
          const header = `
            <header class="flex items-start gap-3">
              <div class="w-10 h-10 rounded-full bg-wiki-primary/15 text-wiki-primary flex items-center justify-center font-semibold" aria-hidden="true">${index + 1}</div>
              <div>
                <h3 class="text-xl font-semibold text-white">${escapeHtml(step.title)}</h3>
                <p class="text-xs text-wiki-muted mt-1">${escapeHtml(step.id)}</p>
              </div>
            </header>
          `
          const body = `
            <div class="mt-4 space-y-5">
              ${formatRichText(step.description)}
              ${step.keyActions && step.keyActions.length ? `
                <section data-cw-telemetry-component="howto-step-actions">
                  <h4 class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">핵심 액션</h4>
                  <ul class="space-y-2 list-disc list-inside text-sm text-wiki-text" role="list">
                    ${step.keyActions.map((action) => `<li role="listitem">${escapeHtml(action)}</li>`).join('')}
                  </ul>
                </section>
              ` : ''}
              ${step.expectedOutcome ? `
                <aside class="border border-wiki-border rounded-lg p-3 bg-wiki-bg/70 text-sm text-wiki-muted" aria-label="예상 산출물" data-cw-telemetry-component="howto-step-outcome">
                  <span class="font-semibold text-wiki-secondary">예상 산출물 · </span>${escapeHtml(step.expectedOutcome)}
                </aside>
              ` : ''}
            </div>
          `
          return `<li id="${escapeHtml(step.id)}" class="glass-card p-6 rounded-2xl space-y-4" data-cw-detail-card data-cw-telemetry-component="howto-step" role="listitem">${header}${body}</li>`
        })
        .join('')}
    </ol>
  `
}

const renderResources = (resources?: HowtoGuideDetail['resources']): string => {
  if (!resources || resources.length === 0) {
    return '<p class="text-sm text-wiki-muted">추천 리소스가 준비 중입니다.</p>'
  }

  return `
    <ul class="space-y-4" role="list" data-cw-telemetry-component="howto-resources">
      ${resources
        .map((resource) => `
          <li class="border border-wiki-border rounded-xl p-4 bg-wiki-bg/60" data-cw-detail-card data-cw-telemetry-component="howto-resource" role="listitem">
            <div class="flex items-start gap-3">
              <i class="fas fa-link text-wiki-secondary mt-1" aria-hidden="true"></i>
              <div>
                <a href="${escapeHtml(resource.url)}" target="_blank" rel="noopener" class="text-base font-semibold text-wiki-primary hover:text-wiki-secondary transition" data-cw-telemetry-action="resource-click">
                  ${escapeHtml(resource.label)}
                </a>
                ${resource.description ? `<p class="text-xs text-wiki-muted mt-1">${escapeHtml(resource.description)}</p>` : ''}
              </div>
            </div>
          </li>
        `)
        .join('')}
    </ul>
  `
}

const renderNextActions = (nextActions?: HowtoGuideDetail['nextActions']): string => {
  if (!nextActions || nextActions.length === 0) return ''
  return `
    <div class="space-y-4" data-cw-telemetry-component="howto-next-actions">
      ${nextActions
        .map((action) => `
          <div class="glass-card p-4 rounded-xl flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4" data-cw-detail-card data-cw-telemetry-component="howto-next-action">
            <div>
              <p class="text-sm font-semibold text-white">${escapeHtml(action.label)}</p>
              <p class="text-xs text-wiki-muted mt-1">${escapeHtml(action.description)}</p>
            </div>
            ${action.href ? `<a href="${escapeHtml(action.href)}" class="px-4 py-2 text-xs border border-wiki-border rounded-lg text-wiki-muted hover:text-wiki-primary hover:border-wiki-primary transition" data-cw-telemetry-action="next-action-click">${escapeHtml(action.label)} 바로가기</a>` : ''}
          </div>
        `)
        .join('')}
    </div>
  `
}

const normalizeSlug = (value: string): string => {
  if (!value) return ''
  return typeof value.normalize === 'function' ? value.normalize('NFKC') : value
}

const computeBadgePriority = (badge?: string | null): number => {
  if (!badge) return 2
  const normalized = normalizeSlug(badge).toLowerCase()
  if (/[b\s]*est/.test(normalized) || normalized.includes('핵심')) {
    return 0
  }
  return 1
}

const sanitizeRelatedContent = (items?: HowtoGuideDetail['relatedContent']) => {
  if (!Array.isArray(items) || items.length === 0) {
    return [] as Array<Required<NonNullable<HowtoGuideDetail['relatedContent']>[number]>>
  }

  const collator = new Intl.Collator('ko', { sensitivity: 'base', numeric: true })
  const seen = new Set<string>()

  const sanitized = items
    .filter((item): item is NonNullable<HowtoGuideDetail['relatedContent']>[number] => Boolean(item && item.slug?.trim()))
    .map((item) => {
      const slug = item.slug.trim()
      const normalizedSlug = normalizeSlug(slug)
      return {
        title: item.title,
        slug,
        summary: item.summary,
        category: item.category,
        badge: item.badge,
        normalizedSlug,
        badgePriority: computeBadgePriority(item.badge)
      }
    })
    .filter((item) => {
      const key = item.normalizedSlug.toLowerCase()
      if (seen.has(key)) {
        return false
      }
      seen.add(key)
      return true
    })
    .sort((a, b) => {
      if (a.badgePriority !== b.badgePriority) {
        return a.badgePriority - b.badgePriority
      }
      const titleCompare = collator.compare(normalizeSlug(a.title ?? a.normalizedSlug), normalizeSlug(b.title ?? b.normalizedSlug))
      if (titleCompare !== 0) {
        return titleCompare
      }
      return collator.compare(a.normalizedSlug, b.normalizedSlug)
    })

  return sanitized.map(({ normalizedSlug, badgePriority, ...rest }) => rest)
}

const renderRecommendedSection = (
  items: Array<Required<NonNullable<HowtoGuideDetail['relatedContent']>[number]>>
): string => {
  if (!items.length) {
    return `
      <section class="glass-card p-6 rounded-xl space-y-3" data-cw-telemetry-component="howto-related-empty" aria-live="polite">
        <h3 class="text-lg font-semibold text-wiki-text">관련 가이드</h3>
        <p class="text-sm text-wiki-muted">연관된 HowTo 가이드를 정리하는 중입니다. 관심 있는 주제를 팀에 알려주세요.</p>
        <a class="inline-flex items-center gap-2 px-4 py-2 border border-wiki-border rounded-lg text-xs text-wiki-muted hover:text-wiki-primary hover:border-wiki-primary transition" href="/survey/howto-feedback" data-cw-telemetry-action="related-feedback">
          <i class="fas fa-paper-plane"></i>
          관심 주제 제안하기
        </a>
      </section>
    `
  }

  return `
    <section class="glass-card p-6 rounded-xl space-y-4" data-cw-telemetry-component="howto-related" aria-labelledby="howto-related-heading">
      <div class="flex items-center justify-between">
        <h3 id="howto-related-heading" class="text-lg font-semibold text-wiki-text">추천 콘텐츠</h3>
        <span class="text-[11px] text-wiki-muted">총 ${items.length}건</span>
      </div>
      <ul class="space-y-3" role="list">
        ${items
          .map((item, index) => {
            const normalizedSlug = normalizeSlug(item.slug)
            const badgeLabel = item.badge ? `<span class="inline-flex items-center gap-2 text-[11px] font-semibold uppercase tracking-wide text-wiki-secondary">${escapeHtml(item.badge)}</span>` : ''
            return `
              <li role="listitem" data-cw-telemetry-component="howto-related-card" data-related-slug="${escapeHtml(normalizedSlug)}" data-related-index="${index}">
                <article class="glass-card p-5 rounded-xl space-y-2 border border-transparent hover:border-wiki-primary/60 transition" data-cw-detail-card>
                  ${badgeLabel}
                  <a href="/howto/${escapeHtml(encodeURIComponent(item.slug))}" class="text-base font-semibold text-white hover:text-wiki-primary transition" data-cw-telemetry-action="related-click">${escapeHtml(item.title)}</a>
                  ${item.summary ? `<p class="text-xs text-wiki-muted leading-relaxed">${escapeHtml(item.summary)}</p>` : ''}
                  ${item.category ? `<p class="text-[11px] text-wiki-muted">카테고리 · ${escapeHtml(item.category)}</p>` : ''}
                </article>
              </li>
            `
          })
          .join('')}
      </ul>
    </section>
  `
}

const resolveHowtoCtaIcon = (type?: string | null): string => {
  const normalized = (type ?? '').toLowerCase()
  if (normalized === 'ai') return 'fa-robot'
  if (normalized === 'job') return 'fa-briefcase'
  if (normalized === 'major') return 'fa-graduation-cap'
  return 'fa-arrow-up-right-from-square'
}

const mapHowtoCtas = (guide: HowtoGuideDetail): CtaLinkOption[] => {
  const links = guide.ctaLinks?.length
    ? guide.ctaLinks
    : [
        { label: 'AI 커리어 분석 실행', href: '/analyzer?from=howto', type: 'ai' },
        { label: '그로스 직업 정보 보기', href: '/job/growth-marketing-director', type: 'job' }
      ]

  return links.map((link, index) => ({
    href: link.href,
    label: link.label,
    icon: resolveHowtoCtaIcon(link.type),
    ctaType: link.type ?? 'external',
    variant: (link.type ?? 'external') === 'ai' || index === 0 ? 'primary' : 'secondary'
  }))
}

const renderCtas = (guide: HowtoGuideDetail): string => {
  const normalizedLinks = mapHowtoCtas(guide)
  return renderCtaGroup({
    entityType: 'guide',
    entityId: guide.telemetryId,
    links: normalizedLinks
  })
}

const renderGovernanceCard = (policy?: Required<CommentPolicyAttributes> | null): string => {
  if (!policy) {
    return ''
  }

  const items = buildCommentGovernanceItems(policy)
  if (!items.length) {
    return ''
  }

  return `
    <section class="glass-card p-6 rounded-xl space-y-3" aria-label="커뮤니티 운영 정책" data-cw-telemetry-component="howto-governance-summary">
      <h3 class="text-lg font-semibold text-wiki-text">커뮤니티 운영 정책</h3>
      <ul class="list-disc list-inside space-y-1 text-xs text-wiki-muted">
        ${items.map((item) => `<li>${escapeHtml(item)}</li>`).join('')}
      </ul>
    </section>
  `
}

const renderSidebar = (
  guide: HowtoGuideDetail,
  relatedItems: Array<Required<NonNullable<HowtoGuideDetail['relatedContent']>[number]>>,
  policy: Required<CommentPolicyAttributes> | null
): string => {
  const prerequisitesSection = guide.prerequisites?.length
    ? `
      <section class="glass-card p-6 rounded-xl space-y-3" aria-label="준비 체크리스트" data-cw-telemetry-component="howto-prerequisites">
        <h3 class="text-lg font-semibold text-wiki-text">준비 체크리스트</h3>
        ${renderChips(guide.prerequisites)}
      </section>
    `
    : ''

  const tagsSection = guide.tags.length
    ? `
      <section class="glass-card p-6 rounded-xl space-y-3" aria-label="키워드" data-cw-telemetry-component="howto-tags">
        <h3 class="text-lg font-semibold text-wiki-text">키워드</h3>
        ${renderChips(guide.tags)}
      </section>
    `
    : ''

  const recommendedSection = renderRecommendedSection(relatedItems)
  const governanceCard = renderGovernanceCard(policy)

  return `
    ${prerequisitesSection}
    ${tagsSection}
    ${governanceCard}
    ${recommendedSection}
  `
}

const buildCommentCopy = (): {
  config: {
    title: string
    description: string
    feedbackLabel: string
    notifyLabel: string
    emptyLabel: string
  }
  policy: Required<CommentPolicyAttributes>
} => {
  const policy = resolveCommentPolicy({
    requiresAuth: true,
    bestLikeThreshold: 8,
    reportBlindThreshold: 5,
    dailyVoteLimit: 5,
    voteWindowHours: 24,
    ipDisplayMode: 'masked',
    moderatorIpBlockEnabled: true,
    moderatorRoles: ['super-admin', 'operator']
  })

  return {
    policy,
    config: {
      title: '커뮤니티 피드백',
      description: '로그인 기반 댓글과 BEST·신고 정책이 적용됩니다. 신고 5회 이상 시 자동 블라인드 처리됩니다.',
      feedbackLabel: '우선 적용 의견 보내기',
      notifyLabel: '업데이트 알림 받기',
      emptyLabel: '가장 먼저 의견을 남겨주세요.'
    }
  }
}

const serializeForScript = (value: unknown): string =>
  JSON.stringify(value)
    .replace(/</g, '\\u003c')
    .replace(/>/g, '\\u003e')
    .replace(/&/g, '\\u0026')

export const renderHowtoGuideDetail = (guide: HowtoGuideDetail): string => {
  const keyMetrics = renderKeyMetrics(guide.keyMetrics)

  const heroMetaItems: Array<{ label: string; value: string }> = []
  if (guide.difficulty) {
    heroMetaItems.push({ label: '난이도', value: guide.difficulty })
  }
  if (guide.estimatedDuration) {
    heroMetaItems.push({ label: '예상 기간', value: guide.estimatedDuration })
  }
  if (guide.audience) {
    heroMetaItems.push({ label: '대상', value: guide.audience })
  }
  const heroMeta = heroMetaItems.length
    ? `
      <dl class="flex flex-wrap gap-3 text-xs text-wiki-muted" data-cw-telemetry-component="howto-hero-meta" aria-label="가이드 메타 정보">
        ${heroMetaItems
          .map(
            (item) => `
              <div class="px-3 py-1 border border-wiki-border rounded-lg bg-wiki-bg/40">
                <dt class="sr-only">${escapeHtml(item.label)}</dt>
                <dd>${escapeHtml(item.label)} · ${escapeHtml(item.value)}</dd>
              </div>
            `
          )
          .join('')}
      </dl>
    `
    : ''

  const prerequisites = guide.prerequisites?.length
    ? `
        <section aria-label="필수 준비 사항" data-cw-telemetry-component="howto-prerequisites-inline">
          <h3 class="text-base font-semibold text-wiki-text mb-2">필수 준비 사항</h3>
          <ul class="list-disc list-inside text-sm text-wiki-muted space-y-1" role="list">
            ${guide.prerequisites.map((item) => `<li role="listitem">${escapeHtml(item)}</li>`).join('')}
          </ul>
        </section>
      `
    : ''

  const checkpoints = guide.checkpoints?.length
    ? `
        <section class="space-y-3" aria-label="체크포인트" data-cw-telemetry-component="howto-checkpoints">
          <h3 class="text-base font-semibold text-wiki-text">체크포인트</h3>
          ${guide.checkpoints
            .map(
              (checkpoint) => `
                <article class="border border-wiki-border rounded-lg p-3 bg-wiki-bg/70" data-cw-detail-card data-cw-telemetry-component="howto-checkpoint">
                  <h4 class="text-sm text-white font-semibold">${escapeHtml(checkpoint.title)}</h4>
                  <p class="text-xs text-wiki-muted mt-1">${escapeHtml(checkpoint.description)}</p>
                </article>
              `
            )
            .join('')}
        </section>
      `
    : ''

  const overviewContent = `
    <article class="glass-card p-8 rounded-2xl space-y-5" data-cw-detail-card data-cw-telemetry-component="howto-overview">
      <header class="space-y-4">
        <h2 class="text-2xl font-semibold text-white">개요</h2>
        ${formatRichText(guide.summary)}
        ${guide.sampleNote ? `<p class="text-sm text-amber-300 bg-amber-500/10 border border-amber-400/40 rounded-lg p-3" role="note">${escapeHtml(guide.sampleNote)}</p>` : ''}
      </header>
      <div class="grid gap-6 md:grid-cols-2">
        ${prerequisites}
        ${checkpoints}
      </div>
    </article>
  `

  const playbookContent = `
    <section data-cw-detail-card data-cw-telemetry-component="howto-playbook">
      ${renderSteps(guide.steps)}
    </section>
  `

  const resourcesContent = `
    <div class="space-y-6" data-cw-telemetry-component="howto-resources-block">
      <article class="glass-card p-6 rounded-2xl space-y-4" data-cw-detail-card>
        <h2 class="text-xl font-semibold text-white">추천 리소스</h2>
        ${renderResources(guide.resources)}
      </article>
      ${guide.nextActions?.length ? `
        <article class="glass-card p-6 rounded-2xl space-y-4" data-cw-detail-card>
          <h2 class="text-xl font-semibold text-white">다음 액션</h2>
          ${renderNextActions(guide.nextActions)}
        </article>
      ` : ''}
    </div>
  `

  const tabEntries: TabEntry[] = [
    { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent },
    { id: 'playbook', label: '실행 플레북', icon: 'fa-route', content: playbookContent },
    { id: 'resources', label: '리소스', icon: 'fa-toolbox', content: resourcesContent }
  ]

  const tabLayout = renderTabset({
    entityType: 'guide',
    entityId: guide.telemetryId,
    entries: tabEntries
  })

  const ctaBlock = renderCtas(guide)

  const { config: commentConfig, policy: commentPolicy } = buildCommentCopy()

  const commentsPlaceholder = renderCommentsPlaceholder({
    entityType: 'guide',
    entityId: guide.telemetryId,
    entitySlug: guide.slug,
    entityName: guide.title,
    entitySummary: guide.summary,
    title: commentConfig.title,
    description: commentConfig.description,
    feedbackLabel: commentConfig.feedbackLabel,
    notifyLabel: commentConfig.notifyLabel,
    emptyLabel: commentConfig.emptyLabel,
    policy: commentPolicy
  })

  const relatedItems = sanitizeRelatedContent(guide.relatedContent)
  const sidebarContent = renderSidebar(guide, relatedItems, commentPolicy)

  const detailMeta = {
    entity: {
      type: 'howto',
      id: guide.telemetryId,
      slug: guide.slug,
      name: guide.title,
      category: null,
      summary: guide.summary,
      sources: [] as string[]
    },
    tabs: tabEntries.map((entry) => entry.id),
    recommendations: relatedItems.map((item) => normalizeSlug(item.slug)),
    sourceStatus: [] as string[],
    partials: [] as string[],
    extra: {
      comments: {
        ...commentConfig,
        policy: commentPolicy
      }
    }
  }

  const metaScript = `<script type="application/json" id="cw-detail-meta">${serializeForScript(detailMeta)}</script>`

  const titleId = `howto-title-${escapeHtml(guide.telemetryId)}`

  return `
    <article class="max-w-6xl mx-auto space-y-10" data-cw-detail-root data-cw-detail-kind="howto" aria-labelledby="${titleId}">
      <header class="glass-card p-8 rounded-2xl space-y-6" data-cw-detail-hero data-cw-telemetry-component="howto-hero" data-cw-telemetry-scope="howto-hero">
        <div class="space-y-4">
          <div class="flex flex-wrap items-center gap-3">
            ${guide.tags.length ? `<div class="flex gap-2" aria-label="주요 태그" data-cw-telemetry-component="howto-hero-tags">${guide.tags
              .map((tag) => `<span class="px-3 py-1 rounded-full bg-wiki-secondary/10 text-xs text-wiki-secondary">${escapeHtml(tag)}</span>`)
              .join('')}</div>` : ''}
            <span class="px-3 py-1 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary">HowTo 샘플</span>
          </div>
          <h1 class="text-4xl font-bold text-white flex flex-wrap items-center gap-3" id="${titleId}">
            ${guide.heroIcon ? `<i class="fas ${escapeHtml(guide.heroIcon)} text-wiki-secondary" aria-hidden="true"></i>` : ''}
            <span>${escapeHtml(guide.title)}</span>
          </h1>
          <p class="text-sm text-wiki-muted">업데이트: ${escapeHtml(guide.updatedAt)}</p>
        </div>
        ${heroMeta}
        ${ctaBlock}
        ${keyMetrics ? `<div class="pt-4 border-t border-wiki-border/60 space-y-6">${keyMetrics}</div>` : ''}
        <div class="flex gap-3" role="group" aria-label="세부 페이지 보조 액션" data-cw-telemetry-component="howto-hero-actions">
          <a href="/howto" class="px-4 py-2 border border-wiki-border rounded-lg text-sm text-wiki-muted hover:border-wiki-primary hover:text-wiki-primary transition" data-cw-telemetry-action="howto-back">
            <i class="fas fa-arrow-left mr-2" aria-hidden="true"></i>목록으로
          </a>
          <button class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition" data-share="true" data-entity-type="guide" data-entity-id="${escapeHtml(guide.telemetryId)}" data-cw-telemetry-component="howto-share">
            <i class="fas fa-share-alt mr-2" aria-hidden="true"></i>공유
          </button>
          <a href="#cw-comments" class="px-4 py-2 border border-wiki-border rounded-lg text-sm text-wiki-muted hover:border-wiki-primary hover:text-wiki-primary transition" data-cw-telemetry-component="howto-hero-actions" data-cw-telemetry-action="hero-comment-anchor" data-entity-id="${escapeHtml(guide.telemetryId)}" data-entity-type="guide">
            <i class="fas fa-comments mr-2" aria-hidden="true"></i>커뮤니티 피드백 보기
          </a>
        </div>
      </header>

      <div class="grid lg:grid-cols-[2fr,1fr] gap-8 items-start">
        <main class="space-y-8" id="cw-detail-main" data-cw-telemetry-scope="howto-main" data-cw-telemetry-component="howto-main">
          ${tabLayout}
          ${commentsPlaceholder}
        </main>
        <aside class="space-y-6" aria-labelledby="cw-detail-sidebar-heading" role="complementary" data-cw-telemetry-scope="howto-sidebar" data-cw-telemetry-component="howto-sidebar">
          <h2 id="cw-detail-sidebar-heading" class="text-lg font-semibold text-wiki-text sr-only">추천 및 보조 정보</h2>
          ${sidebarContent}
        </aside>
      </div>

      ${metaScript}
    </article>
  `
}
