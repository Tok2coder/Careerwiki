import type { HowtoGuideDetail } from '../types/howto'
import type { CommentPolicyAttributes } from './detailTemplateUtils'
import { renderCommentsPlaceholder, resolveCommentPolicy } from './detailTemplateUtils'

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
    return '<p class="content-text text-wiki-muted">정보가 제공되지 않았습니다.</p>'
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
    .map((item) => `<span class="px-3 py-1.5 rounded-full bg-wiki-bg border border-wiki-border content-text text-wiki-muted" data-cw-telemetry-component="howto-chip">${escapeHtml(item.trim())}</span>`)
  return chips.length ? `<div class="flex flex-wrap gap-2" data-cw-telemetry-component="howto-chip-list">${chips.join('')}</div>` : ''
}


const renderSteps = (steps: HowtoGuideDetail['steps']): string => {
  if (!steps || steps.length === 0) {
    return '<p class="content-text text-wiki-muted">실행 단계가 등록되지 않았습니다.</p>'
  }

  return `
    <div class="space-y-12" data-cw-howto-steps data-cw-telemetry-component="howto-steps">
      ${steps
        .map((step, index) => {
          const header = `
            <header class="mb-6">
              <h2 class="text-2xl md:text-3xl font-bold text-white mb-3 flex items-start gap-3">
                <span class="text-wiki-primary font-bold">${index + 1}.</span>
                <span>${escapeHtml(step.title)}</span>
              </h2>
            </header>
          `
          const body = `
            <div class="space-y-6">
              ${formatRichText(step.description)}
              ${step.keyActions && step.keyActions.length ? `
                <div class="bg-wiki-bg/40 border-l-4 border-wiki-primary rounded-r-lg p-4 space-y-2" data-cw-telemetry-component="howto-step-actions">
                  <h4 class="text-sm font-semibold text-wiki-primary uppercase tracking-wide mb-3">핵심 액션</h4>
                  <ul class="space-y-2 list-disc list-inside text-base text-wiki-text" role="list">
                    ${step.keyActions.map((action) => `<li role="listitem">${escapeHtml(action)}</li>`).join('')}
                  </ul>
                </div>
              ` : ''}
              ${step.expectedOutcome ? `
                <div class="bg-wiki-secondary/10 border border-wiki-secondary/30 rounded-lg p-4 text-base text-wiki-text" aria-label="예상 산출물" data-cw-telemetry-component="howto-step-outcome">
                  <span class="font-semibold text-wiki-secondary">💡 예상 산출물: </span>${escapeHtml(step.expectedOutcome)}
                </div>
              ` : ''}
            </div>
          `
          return `<section id="${escapeHtml(step.id)}" class="py-6 border-b border-wiki-border/40 last:border-b-0" data-cw-telemetry-component="howto-step">${header}${body}</section>`
        })
        .join('')}
    </div>
  `
}

const renderResources = (resources?: HowtoGuideDetail['resources']): string => {
  if (!resources || resources.length === 0) {
    return '<p class="content-text text-wiki-muted">추천 리소스가 준비 중입니다.</p>'
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
              <p class="content-text font-semibold text-white">${escapeHtml(action.label)}</p>
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
        <p class="content-text text-wiki-muted">연관된 HowTo 가이드를 정리하는 중입니다. 관심 있는 주제를 팀에 알려주세요.</p>
        <a class="inline-flex items-center gap-2 px-4 py-2 border border-wiki-border rounded-lg content-text text-wiki-muted hover:text-wiki-primary hover:border-wiki-primary transition" href="/survey/howto-feedback" data-cw-telemetry-action="related-feedback">
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


const renderRelatedJobOrMajor = (action: HowtoGuideDetail['nextActions'][0]): string => {
  if (!action.href) return ''
  const icon = action.type === 'job' ? 'fa-briefcase' : action.type === 'major' ? 'fa-graduation-cap' : ''
  if (!icon) return ''
  
  return `
    <li>
      <a href="${escapeHtml(action.href)}" class="flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200" data-cw-telemetry-action="sidebar-related-click">
        <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary">
          <i class="fas ${icon} text-xs" aria-hidden="true"></i>
        </span>
        <div class="flex-1 min-w-0">
          <span class="text-sm text-wiki-text hover:text-white font-medium block">${escapeHtml(action.label)}</span>
          ${action.description ? `<span class="text-xs text-wiki-muted mt-0.5 block line-clamp-2">${escapeHtml(action.description)}</span>` : ''}
        </div>
        <i class="fas fa-chevron-right text-[10px] text-wiki-muted/50" aria-hidden="true"></i>
      </a>
    </li>
  `
}

const renderSidebarSection = (title: string, icon: string, body: string): string => {
  if (!body || !body.trim()) {
    return ''
  }

  return `
    <section class="glass-card border-0 md:border px-3 py-4 md:px-5 md:py-5 rounded-lg md:rounded-2xl space-y-4 bg-transparent md:bg-wiki-bg/30" data-howto-sidebar-section>
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

const renderSidebar = (
  guide: HowtoGuideDetail,
  relatedItems: Array<Required<NonNullable<HowtoGuideDetail['relatedContent']>[number]>>
): string => {
  const relatedJobs = guide.nextActions?.filter(action => action.type === 'job') || []
  const relatedMajors = guide.nextActions?.filter(action => action.type === 'major') || []
  
  const sections: string[] = []
  
  if (relatedJobs.length) {
    sections.push(
      renderSidebarSection(
        '연관 직업',
        'fa-briefcase',
        `<ul class="space-y-2" role="list">${relatedJobs.map(action => renderRelatedJobOrMajor(action)).join('')}</ul>`
      )
    )
  }

  if (relatedMajors.length) {
    sections.push(
      renderSidebarSection(
        '연관 전공',
        'fa-graduation-cap',
        `<ul class="space-y-2" role="list">${relatedMajors.map(action => renderRelatedJobOrMajor(action)).join('')}</ul>`
      )
    )
  }

  if (relatedItems.length) {
    const relatedHowtoList = relatedItems
      .map((item) => `
        <li>
          <a href="/howto/${escapeHtml(encodeURIComponent(item.slug))}" class="flex flex-col gap-1 rounded-lg border border-wiki-border/40 md:border-wiki-border/70 bg-wiki-bg/60 px-3 py-2 md:px-4 md:py-3 content-text text-wiki-primary hover:border-wiki-primary hover:text-white transition" data-cw-telemetry-action="related-click">
            <span class="font-semibold">${escapeHtml(item.title)}</span>
            ${item.summary ? `<span class="text-xs text-wiki-muted">${escapeHtml(item.summary)}</span>` : ''}
          </a>
        </li>
      `)
      .join('')
    
    sections.push(
      renderSidebarSection(
        '관련 HowTo',
        'fa-route',
        `<ul class="space-y-2" role="list">${relatedHowtoList}</ul>`
      )
    )
  }

  return sections.filter(section => section && section.trim().length > 0).join('')
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

const renderSourcesCollapsible = (guide: HowtoGuideDetail): string => {
  const normalizedId = guide.telemetryId.replace(/[^a-z0-9]+/gi, '-').toLowerCase() || 'default'
  const toggleId = `howto-source-toggle-${normalizedId}`
  const panelId = `howto-source-panel-${normalizedId}`

  // 리소스를 출처 섹션으로 변환
  const resources = guide.resources || []
  if (resources.length === 0) {
    return ''
  }

  const resourcesList = resources
    .map((resource) => `
      <li class="p-3 border border-wiki-border rounded-lg bg-wiki-bg/60 transition" data-source-entry="resource">
        <div class="flex items-start gap-3">
          <i class="fas fa-link text-wiki-secondary mt-1" aria-hidden="true"></i>
          <div class="space-y-1">
            <a href="${escapeHtml(resource.url)}" target="_blank" rel="noopener" class="text-sm font-semibold text-wiki-primary hover:text-wiki-secondary transition">
              ${escapeHtml(resource.label)}
            </a>
            ${resource.description ? `<p class="text-xs text-wiki-muted">${escapeHtml(resource.description)}</p>` : ''}
          </div>
        </div>
      </li>
    `)
    .join('')

  const panel = `
    <div class="space-y-3">
      <p class="text-sm text-wiki-muted">이 가이드에서 참고한 리소스와 출처입니다.</p>
      <ul class="space-y-2" role="list">
        ${resourcesList}
      </ul>
    </div>
  `

  const iconId = `howto-source-icon-${normalizedId}`
  const badgeLabel = `${resources.length}개 리소스`

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

export const renderHowtoGuideDetail = (guide: HowtoGuideDetail): string => {

  const prerequisites = guide.prerequisites?.length
    ? `
        <section class="bg-wiki-bg/30 border-l-4 border-wiki-primary rounded-r-lg p-5 space-y-3" aria-label="필수 준비 사항" data-cw-telemetry-component="howto-prerequisites-inline">
          <h3 class="text-lg font-semibold text-white mb-3">📋 필수 준비 사항</h3>
          <ul class="space-y-2 list-disc list-inside text-base text-wiki-text" role="list">
            ${guide.prerequisites.map((item) => `<li role="listitem">${escapeHtml(item)}</li>`).join('')}
          </ul>
        </section>
      `
    : ''

  const checkpoints = guide.checkpoints?.length
    ? `
        <section class="space-y-4" aria-label="체크포인트" data-cw-telemetry-component="howto-checkpoints">
          <h3 class="text-xl font-semibold text-white mb-4">✅ 체크포인트</h3>
          <div class="grid gap-3 md:grid-cols-2">
            ${guide.checkpoints
              .map(
                (checkpoint) => `
                  <div class="border border-wiki-border rounded-lg p-4 bg-wiki-bg/40 hover:bg-wiki-bg/60 transition" data-cw-telemetry-component="howto-checkpoint">
                    <h4 class="text-sm font-semibold text-white mb-1">${escapeHtml(checkpoint.title)}</h4>
                    <p class="text-sm text-wiki-muted">${escapeHtml(checkpoint.description)}</p>
                  </div>
                `
              )
              .join('')}
          </div>
        </section>
      `
    : ''

  // 블로그 형태: 모든 내용을 하나의 글로 쭉쭉 나열
  const blogContent = `
    <article class="prose prose-invert max-w-none space-y-10" data-cw-telemetry-component="howto-blog-content">
      <!-- 서론 -->
      <section class="space-y-4">
        ${formatRichText(guide.summary)}
        ${guide.sampleNote ? `<p class="content-text text-amber-300 bg-amber-500/10 border border-amber-400/40 rounded-lg p-3" role="note">${escapeHtml(guide.sampleNote)}</p>` : ''}
      </section>

      <!-- 필수 준비 사항 (있는 경우) -->
      ${prerequisites}

      <!-- 체크포인트 (있는 경우) -->
      ${checkpoints}

      <!-- 본문: 단계별 가이드 -->
      ${guide.steps && guide.steps.length > 0 ? `
        <section class="space-y-8" data-cw-telemetry-component="howto-steps">
          ${renderSteps(guide.steps)}
        </section>
      ` : ''}


      <!-- 마무리 (다음 액션은 사이드바로 이동했으므로 제거) -->
    </article>
  `

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
  const sidebarContent = renderSidebar(guide, relatedItems)
  const sourcesCollapsible = renderSourcesCollapsible(guide)
  const hasSidebar = sidebarContent.trim().length > 0

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
    tabs: [],
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

  const mainColumn = `<div class="space-y-6 min-w-0">${blogContent}</div>`
  const sidebarMarkup = hasSidebar
    ? `<aside class="space-y-6 lg:sticky lg:top-28 lg:h-fit lg:self-start" data-howto-sidebar>${sidebarContent}</aside>`
    : ''

  const layoutBlock = hasSidebar
    ? `
        <div class="grid gap-8 lg:grid-cols-[minmax(0,3fr)_minmax(260px,1fr)] lg:items-start" data-howto-layout>
          ${mainColumn}
          ${sidebarMarkup}
        </div>
      `
    : `<div class="space-y-6" data-howto-layout>${blogContent}</div>`

  const sourcesBlock = sourcesCollapsible ? `<div data-howto-sources>${sourcesCollapsible}</div>` : ''
  const communityBlock = `<div data-howto-community>${commentsPlaceholder}</div>`

  const canonicalPath = `/howto/${encodeURIComponent(guide.slug)}`

  return `
    <div class="max-w-[1400px] mx-auto md:px-6 space-y-4 md:space-y-8 md:py-8 md:mt-4">
      <!-- 목록으로 버튼 -->
      <div class="flex items-center">
        <a href="/howto" class="inline-flex items-center gap-2 px-4 py-2 text-sm text-wiki-muted hover:text-wiki-primary transition" data-cw-telemetry-action="howto-back">
          <i class="fas fa-arrow-left" aria-hidden="true"></i>
          <span>목록으로</span>
        </a>
      </div>

      <section class="glass-card border-0 md:border px-6 py-8 md:px-8 rounded-none md:rounded-2xl space-y-6 md:space-y-8" data-howto-hero>
        <div class="space-y-5">
          <!-- 태그 -->
          ${guide.tags.length ? `<div class="flex flex-wrap gap-2" aria-label="주요 태그" data-cw-telemetry-component="howto-hero-tags">${guide.tags
            .map((tag) => `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary font-medium border border-wiki-primary/20 hover:bg-wiki-primary/20 transition"><i class="fas fa-tag text-[10px]" aria-hidden="true"></i>${escapeHtml(tag)}</span>`)
            .join('')}</div>` : ''}
          
          <!-- 제목과 공유 버튼 -->
          <div class="flex flex-wrap items-start justify-between gap-4">
            <h1 class="text-[32px] md:text-[34px] lg:text-4xl font-bold text-white leading-tight" id="${titleId}">
              ${escapeHtml(guide.title)}
            </h1>
            <div class="relative shrink-0" data-share-root data-cw-telemetry-scope="howto-hero-actions">
              <button type="button" class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition inline-flex items-center gap-2" data-share-trigger data-share-path="${escapeHtml(canonicalPath)}" data-share-title="${escapeHtml(guide.title)}" data-cw-telemetry-component="howto-share-trigger" data-cw-telemetry-action="share-open">
                <i class="fas fa-share-nodes" aria-hidden="true"></i>
                공유
              </button>
              <div class="absolute right-0 mt-2 w-72 rounded-xl border border-wiki-border/60 bg-wiki-bg/95 shadow-xl backdrop-blur hidden z-[1001]" data-share-panel data-cw-telemetry-component="howto-share-panel" role="dialog" aria-modal="false" aria-label="링크 공유">
                <div class="flex items-center justify-between px-4 py-3 border-b border-wiki-border/60">
                  <p class="text-sm font-semibold text-white">'${escapeHtml(guide.title)}' 공유하기</p>
                  <button type="button" class="text-xs text-wiki-muted hover:text-white transition" data-share-close aria-label="닫기">
                    <i class="fas fa-times" aria-hidden="true"></i>
                  </button>
                </div>
                <div class="p-4 space-y-3">
                  <div class="flex items-center gap-2">
                    <input type="text" class="flex-1 px-3 py-2 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-xs text-white focus:outline-none" value="${escapeHtml(canonicalPath)}" readonly data-share-url>
                    <button type="button" class="px-3 py-2 bg-wiki-primary text-white text-xs rounded-md hover:bg-blue-600 transition" data-share-copy data-cw-telemetry-component="howto-share-copy" data-cw-telemetry-action="share-copy">
                      <i class="fas fa-copy mr-1" aria-hidden="true"></i>복사
                    </button>
                  </div>
                  <p class="text-[11px] text-wiki-muted">복사 버튼을 누르면 링크가 클립보드에 저장됩니다.</p>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 작성일 및 작성자 -->
          <div class="flex items-center gap-4 text-sm text-wiki-muted">
            <span>${escapeHtml(guide.updatedAt)}</span>
            <span class="text-wiki-border">·</span>
            <span>CareerWiki</span>
          </div>
          
          <!-- 요약 설명 -->
          ${guide.summary ? `<p class="text-[15px] text-wiki-muted leading-relaxed" data-cw-telemetry-component="howto-hero-summary">${escapeHtml(guide.summary)}</p>` : ''}
        </div>
      </section>

      ${layoutBlock}
      ${sourcesBlock}
      ${communityBlock}

      ${metaScript}
    </div>
  `
}
