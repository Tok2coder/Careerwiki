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

const formatDate = (dateString?: string | null): string => {
  if (!dateString) return ''
  try {
    const date = new Date(dateString)
    if (isNaN(date.getTime())) return dateString
    const year = date.getFullYear()
    const month = date.getMonth() + 1
    const day = date.getDate()
    return `${year}년 ${month}월 ${day}일`
  } catch {
    return dateString
  }
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
        summary: item.summary ?? '',
        category: item.category ?? '',
        badge: item.badge ?? '',
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


const renderRelatedJobOrMajor = (action: NonNullable<HowtoGuideDetail['nextActions']>[number]): string => {
  if (!action.href) return ''
  const icon = action.type === 'job' ? 'fa-briefcase' : action.type === 'major' ? 'fa-graduation-cap' : ''
  if (!icon) return ''
  
  return `
    <li>
      <a href="${escapeHtml(action.href)}" class="flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200" data-cw-telemetry-action="sidebar-related-click">
        <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary">
          <i class="fas ${icon} text-xs" aria-hidden="true"></i>
        </span>
        <span class="flex-1 min-w-0 text-sm text-wiki-text hover:text-white font-medium">${escapeHtml(action.label)}</span>
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
    <section class="glass-card border px-4 py-4 md:px-5 md:py-5 rounded-lg md:rounded-2xl space-y-4 bg-wiki-bg/30" data-howto-sidebar-section>
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
        '관련 직업',
        'fa-briefcase',
        `<ul class="space-y-2" role="list">${relatedJobs.map(action => renderRelatedJobOrMajor(action)).join('')}</ul>`
      )
    )
  }

  if (relatedMajors.length) {
    sections.push(
      renderSidebarSection(
        '관련 전공',
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

  // 각주 데이터 사용 (URL 여부와 관계없이 모든 각주 포함)
  const footnotes = guide.footnotes || []
  if (footnotes.length === 0) {
    return ''
  }

  const footnotesList = footnotes
    .map((fn) => `
      <li class="footnote-item p-3 border border-wiki-border rounded-lg bg-wiki-bg/60 transition cursor-pointer hover:border-wiki-primary/50 hover:bg-wiki-bg/80" data-source-entry="footnote" id="fn-${fn.id}" data-back-to="fnref-${fn.id}">
        <div class="flex items-start gap-3">
          <span class="footnote-id flex-shrink-0 w-6 h-6 rounded-full bg-wiki-secondary/20 text-wiki-secondary text-xs font-bold flex items-center justify-center">${fn.id}</span>
          <div class="flex-1 min-w-0 footnote-text text-sm text-wiki-text">
            ${fn.url 
              ? `<span>${escapeHtml(fn.text)}</span>, <a href="${escapeHtml(fn.url)}" target="_blank" rel="noopener" class="text-wiki-primary hover:text-wiki-secondary transition break-all" style="word-break: break-all; overflow-wrap: anywhere;" onclick="event.stopPropagation()">${escapeHtml(fn.url)}</a>`
              : `<span>${escapeHtml(fn.text)}</span>`
            }
          </div>
        </div>
      </li>
    `)
    .join('')

  const panel = `
    <div class="space-y-3">
      <p class="text-sm text-wiki-muted">이 가이드에서 참고한 출처 목록입니다.</p>
      <ol class="space-y-2" role="list">
        ${footnotesList}
      </ol>
    </div>
  `

  const iconId = `howto-source-icon-${normalizedId}`
  const badgeLabel = `${footnotes.length}개`

  return `
    <section class="glass-card p-0 rounded-2xl border border-wiki-border/60 bg-wiki-bg/50" data-source-collapsible data-sources-accordion>
      <button
        type="button"
        id="${toggleId}"
        class="w-full flex items-center justify-between gap-3 px-4 py-4 md:px-6 md:py-5 content-text font-semibold text-white transition hover:text-wiki-secondary cursor-pointer"
        aria-controls="${panelId}"
        aria-expanded="false"
      >
        <span class="flex items-center gap-3">
          <i class="fas fa-book-open text-wiki-secondary text-lg" aria-hidden="true"></i>
          <span class="text-base">출처</span>
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

export interface HowtoDetailOptions {
  currentUserId?: number | null
  currentUserRole?: string | null
  authorId?: number | null
  pageId?: number | null
  isBlinded?: boolean
  blindReason?: string | null
  isDraftPublished?: boolean
}

export const renderHowtoGuideDetail = (guide: HowtoGuideDetail, options: HowtoDetailOptions = {}): string => {
  const { currentUserId, currentUserRole, authorId, pageId, isBlinded, blindReason, isDraftPublished } = options
  const isAuthor = currentUserId && authorId && currentUserId === authorId
  const isAdmin = currentUserRole === 'admin'
  const canEdit = isAuthor || isAdmin

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

  // 각주 섹션 렌더링 (sourcesCollapsible에서 통합 렌더링하므로 본문 내 섹션은 제거)
  const footnotesSection = ''

  // 블로그 형태: 모든 내용을 하나의 글로 쭉쭉 나열
  const blogContent = `
    <article class="prose prose-invert max-w-none space-y-10 overflow-x-hidden" data-cw-telemetry-component="howto-blog-content" style="min-width: 0; overflow-x: hidden; word-break: break-word;">
      <!-- 샘플 노트 (있는 경우) -->
      ${guide.sampleNote ? `
        <section class="space-y-4">
          <p class="content-text text-amber-300 bg-amber-500/10 border border-amber-400/40 rounded-lg p-3" role="note">${escapeHtml(guide.sampleNote)}</p>
        </section>
      ` : ''}

      <!-- 필수 준비 사항 (있는 경우) -->
      ${prerequisites}

      <!-- 체크포인트 (있는 경우) -->
      ${checkpoints}

      <!-- 본문: 자유 형식 HTML 또는 단계별 가이드 -->
      ${guide.rawHtml ? `
        <section class="howto-user-content" data-cw-telemetry-component="howto-rawhtml">
          ${guide.rawHtml}
        </section>
      ` : guide.steps && guide.steps.length > 0 ? `
        <section class="space-y-8" data-cw-telemetry-component="howto-steps">
          ${renderSteps(guide.steps)}
        </section>
      ` : ''}

      <!-- 각주/출처 -->
      ${footnotesSection}

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

  const mainColumn = `<div class="space-y-6 min-w-0 break-words overflow-x-hidden" style="min-width: 0; overflow-x: hidden;">${blogContent}</div>`
  const sidebarMarkup = hasSidebar
    ? `<aside class="space-y-6 lg:sticky lg:top-28 lg:h-fit lg:self-start overflow-x-hidden" data-howto-sidebar style="min-width: 0; overflow-x: hidden;">${sidebarContent}</aside>`
    : ''

  const layoutBlock = hasSidebar
    ? `
        <div class="grid gap-6 sm:gap-8 grid-cols-1 lg:grid-cols-[minmax(0,3fr)_minmax(260px,1fr)] lg:items-start overflow-x-hidden" data-howto-layout style="min-width: 0; overflow-x: hidden;">
          ${mainColumn}
          ${sidebarMarkup}
        </div>
      `
    : `<div class="space-y-6 overflow-x-hidden" data-howto-layout style="min-width: 0; overflow-x: hidden;">${blogContent}</div>`

  const sourcesBlock = sourcesCollapsible ? `<div data-howto-sources class="overflow-x-hidden" style="min-width: 0; overflow-x: hidden;">${sourcesCollapsible}</div>` : ''
  const communityBlock = `<div data-howto-community class="overflow-x-hidden" style="min-width: 0; overflow-x: hidden;">${commentsPlaceholder}</div>`

  const canonicalPath = `/howto/${encodeURIComponent(guide.slug)}`

  // HowTo 본문 콘텐츠용 스타일 (분리된 CSS 파일 사용)
  const contentStyles = '<link rel="stylesheet" href="/static/howto-content.css">'
  
  const clientScript = `
    <script>
      // 프로토콜 없는 외부 링크 자동 수정
      document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.howto-user-content a').forEach(function(a) {
          var href = a.getAttribute('href');
          if (!href) return;
          // www.로 시작하면 https:// 추가
          if (href.startsWith('www.')) {
            a.setAttribute('href', 'https://' + href);
          }
          // 프로토콜 없고, /나 #으로 시작 안하고, .이 포함되면 외부 링크로 판단
          else if (!href.startsWith('http') && !href.startsWith('/') && !href.startsWith('#') && !href.startsWith('mailto:') && href.includes('.')) {
            a.setAttribute('href', 'https://' + href);
          }
        });
        
        // 각주 클릭 시 출처 섹션 펼치고 스크롤 이동
        document.querySelectorAll('.footnote-ref a[data-footnote-id]').forEach(function(a) {
          a.addEventListener('click', function(e) {
            e.preventDefault();
            var fnId = this.getAttribute('data-footnote-id');
            var targetEl = document.getElementById('fn-' + fnId);
            if (!targetEl) return;
            
            // 출처 섹션 찾기 (data-source-collapsible)
            var sourceSection = document.querySelector('[data-source-collapsible]');
            if (sourceSection) {
              var toggle = sourceSection.querySelector('button[aria-controls]');
              var panelId = toggle ? toggle.getAttribute('aria-controls') : null;
              var panel = panelId ? document.getElementById(panelId) : null;
              var icon = toggle ? toggle.querySelector('.fa-chevron-down, .fa-chevron-up') : null;
              
              // 출처가 접혀있으면 펼치기
              if (toggle && toggle.getAttribute('aria-expanded') === 'false') {
                if (panel) panel.classList.remove('hidden');
                toggle.setAttribute('aria-expanded', 'true');
                if (icon) {
                  icon.classList.remove('fa-chevron-down');
                  icon.classList.add('fa-chevron-up');
                }
              }
            }
            
            // 약간의 딜레이 후 스크롤 (애니메이션 완료 대기)
            setTimeout(function() {
              targetEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
              // 하이라이트 효과
              targetEl.classList.add('ring-2', 'ring-wiki-primary');
              setTimeout(function() {
                targetEl.classList.remove('ring-2', 'ring-wiki-primary');
              }, 2000);
            }, 150);
          });
        });
        
        // 출처 항목 클릭 시 본문의 각주로 돌아가기
        document.querySelectorAll('[data-back-to]').forEach(function(item) {
          item.addEventListener('click', function() {
            var backToId = this.getAttribute('data-back-to');
            var targetEl = document.getElementById(backToId);
            if (targetEl) {
              targetEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
              // 하이라이트 효과
              var parent = targetEl.closest('.footnote-ref') || targetEl;
              parent.classList.add('bg-wiki-primary/20');
              setTimeout(function() {
                parent.classList.remove('bg-wiki-primary/20');
              }, 2000);
            }
          });
        });
        
        // 체크리스트 인터랙션 - 클릭 시 체크/해제 + strikethrough
        document.querySelectorAll('.howto-user-content ul[data-type="taskList"] li, .howto-user-content .task-list li, .howto-user-content .task-item').forEach(function(li) {
          var checkbox = li.querySelector('input[type="checkbox"]');
          var textDiv = li.querySelector('div') || li.querySelector('span');
          
          if (checkbox) {
            // 초기 상태 적용
            var isChecked = checkbox.checked || li.getAttribute('data-checked') === 'true';
            if (isChecked) {
              checkbox.checked = true;
              li.setAttribute('data-checked', 'true');
              if (textDiv) {
                textDiv.style.textDecoration = 'line-through';
                textDiv.style.color = 'rgba(255, 255, 255, 0.5)';
              }
            }
            
            // 체크박스 클릭 이벤트
            checkbox.addEventListener('change', function() {
              var checked = this.checked;
              li.setAttribute('data-checked', checked ? 'true' : 'false');
              if (textDiv) {
                if (checked) {
                  textDiv.style.textDecoration = 'line-through';
                  textDiv.style.color = 'rgba(255, 255, 255, 0.5)';
                } else {
                  textDiv.style.textDecoration = 'none';
                  textDiv.style.color = '';
                }
              }
            });
          }
        });
      });
    </script>
  `
  
  return `
    ${contentStyles}
    ${clientScript}
    <style>
      /* 모든 HowTo 페이지에서 스크롤바 숨김 */
      [data-howto-hero] {
        overflow: hidden !important;
        scrollbar-width: none !important;
        -ms-overflow-style: none !important;
      }
      [data-howto-hero]::-webkit-scrollbar {
        display: none !important;
        width: 0 !important;
        height: 0 !important;
      }
      [data-howto-hero] > div {
        overflow: hidden !important;
        scrollbar-width: none !important;
        -ms-overflow-style: none !important;
      }
      [data-howto-hero] > div::-webkit-scrollbar {
        display: none !important;
      }
      .howto-action-buttons {
        overflow: hidden !important;
        scrollbar-width: none !important;
        -ms-overflow-style: none !important;
      }
      .howto-action-buttons::-webkit-scrollbar {
        display: none !important;
        width: 0 !important;
        height: 0 !important;
      }
      
      @media (max-width: 640px) {
        body { overflow-x: hidden; }
        [data-howto-layout] { overflow-x: hidden; }
        [data-howto-hero] { overflow-x: hidden; }
        [data-howto-sidebar] { overflow-x: hidden; }
        .howto-user-content { overflow-x: hidden; max-width: 100%; }
      }
    </style>
    <div class="max-w-[1400px] mx-auto px-3 sm:px-4 md:px-6 space-y-4 md:space-y-8 py-4 md:py-8 md:mt-4" style="overflow-x: hidden;">
      <!-- 블라인드 알림 -->
      ${isBlinded ? `
        <div class="bg-red-500/10 border border-red-500/30 rounded-xl p-4 text-red-400">
          <div class="flex items-center gap-3">
            <i class="fas fa-eye-slash text-lg"></i>
            <div>
              <p class="font-semibold">이 글은 블라인드 처리되었습니다</p>
              ${blindReason ? `<p class="text-sm mt-1">사유: ${escapeHtml(blindReason)}</p>` : ''}
            </div>
          </div>
        </div>
      ` : ''}
      
      <section class="glass-card border px-4 sm:px-6 py-6 sm:py-8 md:px-8 rounded-2xl space-y-4 sm:space-y-6 overflow-x-hidden" data-howto-hero style="min-width: 0;">
        <!-- 목록으로 버튼 (히어로 섹션 내부, 제목 위) -->
        <div class="flex items-center justify-between">
          <a href="/howto" class="inline-flex items-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary transition group" data-cw-telemetry-action="howto-back">
            <i class="fas fa-arrow-left group-hover:-translate-x-0.5 transition-transform" aria-hidden="true"></i>
            <span>목록으로</span>
          </a>
          
          <!-- 블라인드 버튼 (관리자용) -->
          ${isAdmin && pageId ? `
            <button type="button" 
                    class="inline-flex items-center gap-2 px-3 py-1.5 text-sm text-wiki-muted hover:text-amber-400 transition"
                    data-admin-blind-trigger
                    data-howto-slug="${escapeHtml(guide.slug)}"
                    data-is-blinded="${isBlinded ? 'true' : 'false'}">
              <i class="fas ${isBlinded ? 'fa-eye' : 'fa-eye-slash'} text-xs"></i>
              <span>${isBlinded ? '블라인드 해제' : '블라인드'}</span>
            </button>
          ` : ''}
        </div>
        
        <!-- 제목 (모바일: 제목 + 점세개 메뉴, 데스크탑: 제목 + 버튼) -->
        <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3 sm:gap-4" style="min-width: 0;">
          <div class="flex items-center gap-2 sm:gap-3 flex-1 min-w-0">
            <h1 class="text-2xl sm:text-[32px] md:text-[36px] lg:text-[40px] font-bold text-white leading-tight tracking-tight break-words flex-1 min-w-0" id="${titleId}" style="word-break: break-word; overflow-wrap: anywhere;">
              ${escapeHtml(guide.title)}
            </h1>
            ${isDraftPublished ? `
              <span class="px-2 sm:px-3 py-1 bg-purple-500/20 text-purple-400 border border-purple-500/40 rounded-full text-xs sm:text-sm font-medium whitespace-nowrap shrink-0">
                <i class="fas fa-eye-slash mr-1 sm:mr-1.5"></i>임시 발행
              </span>
            ` : ''}
            
            <!-- 모바일: 점 세개 버튼 (제목 옆) -->
            <button type="button" 
                    id="mobile-more-btn"
                    class="sm:hidden p-2 min-h-[40px] min-w-[40px] inline-flex items-center justify-center bg-wiki-card border border-wiki-border/60 text-wiki-text rounded-lg hover:text-wiki-primary hover:border-wiki-primary/50 transition shrink-0"
                    aria-label="더보기"
                    aria-expanded="false"
                    aria-haspopup="true">
              <i class="fas fa-ellipsis-v text-sm"></i>
            </button>
          </div>
          
          <!-- 액션 버튼들 (데스크탑: 제목 옆, 모바일: 날짜/닉네임/조회수 아래) -->
          <div class="howto-action-buttons hidden sm:flex items-center gap-1.5 sm:gap-2 shrink-0 flex-wrap" style="overflow: hidden; scrollbar-width: none; -ms-overflow-style: none;">
            <!-- 발행 버튼 (임시 발행 상태에서 작성자/관리자만) -->
            ${isDraftPublished && canEdit ? `
              <button type="button" id="btn-publish-page"
                 class="px-3 sm:px-4 py-2 min-h-[40px] inline-flex items-center justify-center bg-green-600 hover:bg-green-700 text-white rounded-lg text-xs sm:text-sm transition"
                 aria-label="발행"
                 title="정식 발행하기">
                <i class="fas fa-globe mr-1 sm:mr-1.5"></i><span class="hidden sm:inline">발행</span>
              </button>
            ` : ''}
            <!-- 편집 버튼 (작성자/관리자만) -->
            ${canEdit ? `
              <a href="/howto/${escapeHtml(guide.slug)}/edit" 
                 class="px-3 sm:px-4 py-2 min-h-[40px] inline-flex items-center justify-center gap-1 bg-wiki-card border border-wiki-border/60 text-wiki-text rounded-lg text-xs sm:text-sm hover:text-wiki-primary hover:border-wiki-primary/50 transition"
                 aria-label="편집"
                 title="편집하기">
                <i class="fas fa-edit"></i>
                <span class="hidden sm:inline">편집</span>
              </a>
            ` : ''}
            <!-- 공유 버튼 -->
            <div class="relative" data-share-root data-cw-telemetry-scope="howto-hero-actions">
              <button type="button" class="px-3 sm:px-4 py-2 min-h-[40px] bg-wiki-primary text-white rounded-lg text-xs sm:text-sm hover:bg-blue-600 transition inline-flex items-center gap-1.5" data-share-trigger data-share-path="${escapeHtml(canonicalPath)}" data-share-title="${escapeHtml(guide.title)}" data-cw-telemetry-component="howto-share-trigger" data-cw-telemetry-action="share-open">
                <i class="fas fa-share-nodes text-xs sm:text-sm" aria-hidden="true"></i>
                <span class="hidden sm:inline">공유</span>
              </button>
              <div class="absolute right-0 mt-2 w-[calc(100vw-2rem)] sm:w-72 max-w-[320px] rounded-xl border border-wiki-border/60 bg-wiki-bg/95 shadow-xl backdrop-blur hidden z-[1001]" data-share-panel data-cw-telemetry-component="howto-share-panel" role="dialog" aria-modal="false" aria-label="링크 공유">
                <div class="flex items-center justify-between px-4 py-3 border-b border-wiki-border/60">
                  <p class="text-sm font-semibold text-white truncate">'${escapeHtml(guide.title)}' 공유하기</p>
                  <button type="button" class="text-xs text-wiki-muted hover:text-white transition shrink-0" data-share-close aria-label="닫기">
                    <i class="fas fa-times" aria-hidden="true"></i>
                  </button>
                </div>
                <div class="p-4 space-y-3">
                  <div class="flex items-center gap-2">
                    <input type="text" class="flex-1 px-3 py-2 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-xs text-white focus:outline-none min-w-0" value="${escapeHtml(canonicalPath)}" readonly data-share-url>
                    <button type="button" class="px-3 py-2 bg-wiki-primary text-white text-xs rounded-md hover:bg-blue-600 transition shrink-0" data-share-copy data-cw-telemetry-component="howto-share-copy" data-cw-telemetry-action="share-copy">
                      <i class="fas fa-copy mr-1" aria-hidden="true"></i>복사
                    </button>
                  </div>
                  <p class="text-[11px] text-wiki-muted">복사 버튼을 누르면 링크가 클립보드에 저장됩니다.</p>
                </div>
              </div>
            </div>
            
            <!-- 신고 버튼 -->
            <button type="button" 
                    class="p-2 sm:p-2.5 min-h-[40px] min-w-[40px] inline-flex items-center justify-center bg-wiki-card border border-wiki-border/60 text-wiki-text rounded-lg text-xs sm:text-sm hover:text-red-400 hover:border-red-400/50 transition"
                    data-report-trigger
                    data-howto-slug="${escapeHtml(guide.slug)}"
                    aria-label="신고"
                    title="신고하기">
              <i class="fas fa-flag text-xs sm:text-sm"></i>
            </button>
            
            <!-- 저장 버튼 (저장 횟수 포함) -->
            <button 
              type="button" 
              class="px-2.5 sm:px-3 py-2 min-h-[40px] inline-flex items-center gap-1 sm:gap-1.5 bg-wiki-card border border-wiki-border/60 text-wiki-text rounded-lg text-xs sm:text-sm hover:text-amber-400 hover:border-amber-400/50 transition"
              data-bookmark-btn
              data-bookmark-type="howto"
              data-bookmark-slug="${escapeHtml(guide.slug)}"
              data-bookmark-title="${escapeHtml(guide.title)}"
              aria-label="저장"
              title="저장함에 추가"
            >
              <span class="text-xs sm:text-sm" data-bookmark-count>${guide.bookmarkCount || 0}</span>
              <i class="fas fa-bookmark text-xs sm:text-sm"></i>
            </button>
          </div>
        </div>
        
        <!-- 작성일, 작성자, 조회수 (모바일: 한 줄, 조회수 오른쪽) -->
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 sm:gap-4 -mt-2 text-sm sm:text-[15px]">
          <div class="flex flex-wrap items-center gap-3 sm:gap-4 flex-1">
            <div class="flex items-center gap-2">
              <i class="far fa-calendar-alt text-wiki-primary text-xs sm:text-sm"></i>
              <span class="text-white/80 font-medium">${formatDate(guide.updatedAt)}</span>
            </div>
            <div class="flex items-center gap-2">
              ${guide.authorPictureUrl 
                ? `<img src="${escapeHtml(guide.authorPictureUrl)}" alt="${escapeHtml(guide.authorName || 'CareerWiki')}" class="w-4 h-4 sm:w-5 sm:h-5 rounded-full object-cover" />`
                : `<i class="far fa-user text-wiki-secondary text-xs sm:text-sm"></i>`}
              <span class="text-white/80 font-medium">${escapeHtml(guide.authorName || 'CareerWiki')}</span>
            </div>
            <!-- 모바일: 조회수도 같은 줄에 -->
            <div class="flex sm:hidden items-center gap-2 ml-auto">
              <span class="text-white/80 font-medium">조회 ${guide.viewCount || 0}</span>
            </div>
          </div>
          <!-- 데스크탑: 조회수 오른쪽 -->
          <div class="hidden sm:flex items-center gap-2">
            <span class="text-white/80 font-medium">조회 ${guide.viewCount || 0}</span>
          </div>
        </div>
        
        
        <!-- 요약 설명 (흰색으로 변경) -->
        ${guide.summary ? `<p class="text-[16px] text-white/90 leading-relaxed" data-cw-telemetry-component="howto-hero-summary">${escapeHtml(guide.summary)}</p>` : ''}
        
        <!-- 썸네일 이미지 -->
        ${guide.thumbnailUrl ? `
          <div class="mt-2" data-cw-telemetry-component="howto-hero-thumbnail">
            <img src="${escapeHtml(guide.thumbnailUrl)}" alt="${escapeHtml(guide.title)}" class="w-full max-h-[500px] object-contain rounded-xl border border-wiki-border/20 shadow-lg bg-wiki-bg/30" />
          </div>
        ` : ''}
        
        <!-- 태그 (이미지 밑에 배치) -->
        ${guide.tags.length ? `
          <div class="flex flex-wrap gap-2 pt-2" aria-label="주요 태그" data-cw-telemetry-component="howto-hero-tags">
            ${guide.tags.map((tag) => `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/15 text-xs text-wiki-primary font-medium border border-wiki-primary/25 hover:bg-wiki-primary/25 transition cursor-default"><i class="fas fa-tag text-[10px] opacity-70" aria-hidden="true"></i>${escapeHtml(tag)}</span>`).join('')}
          </div>
        ` : ''}
      </section>

      ${layoutBlock}
      ${sourcesBlock}
      ${communityBlock}

      ${metaScript}
      
      <!-- 모바일 더보기 오버레이 메뉴 -->
      <div id="mobile-action-overlay" class="fixed inset-0 z-[2000] hidden sm:hidden" role="dialog" aria-modal="true">
        <div class="fixed inset-0 bg-black/60" id="mobile-action-backdrop"></div>
        <div class="fixed bottom-0 left-0 right-0 bg-wiki-bg border-t border-wiki-border/60 rounded-t-2xl p-4 pb-8 space-y-1" id="mobile-action-menu">
          <!-- 발행 버튼 (임시 발행 상태에서 작성자/관리자만) -->
          ${isDraftPublished && canEdit ? `
            <button type="button" 
                    id="btn-publish-page-mobile"
                    class="w-full px-4 py-3 flex items-center gap-3 text-left text-sm text-green-400 hover:bg-wiki-card/50 transition rounded-lg">
              <i class="fas fa-globe w-5 text-center"></i>
              <span>정식 발행</span>
            </button>
          ` : ''}
          <!-- 편집 버튼 (작성자/관리자만) -->
          ${canEdit ? `
            <a href="/howto/${escapeHtml(guide.slug)}/edit" 
               class="w-full px-4 py-3 flex items-center gap-3 text-left text-sm text-wiki-text hover:text-wiki-primary hover:bg-wiki-card/50 transition rounded-lg">
              <i class="fas fa-edit w-5 text-center"></i>
              <span>편집</span>
            </a>
          ` : ''}
          <!-- 공유 버튼 -->
          <button type="button" 
                  id="mobile-share-btn"
                  class="w-full px-4 py-3 flex items-center gap-3 text-left text-sm text-wiki-text hover:text-wiki-primary hover:bg-wiki-card/50 transition rounded-lg">
            <i class="fas fa-share-nodes w-5 text-center"></i>
            <span>공유</span>
          </button>
          <!-- 신고 버튼 -->
          <button type="button" 
                  id="mobile-report-btn"
                  class="w-full px-4 py-3 flex items-center gap-3 text-left text-sm text-wiki-text hover:text-red-400 hover:bg-wiki-card/50 transition rounded-lg">
            <i class="fas fa-flag w-5 text-center"></i>
            <span>신고</span>
          </button>
          <!-- 저장 버튼 -->
          <button type="button" 
                  id="mobile-bookmark-btn-overlay"
                  class="w-full px-4 py-3 flex items-center gap-3 text-left text-sm text-wiki-text hover:text-amber-400 hover:bg-wiki-card/50 transition rounded-lg"
                  data-bookmark-btn
                  data-bookmark-type="howto"
                  data-bookmark-slug="${escapeHtml(guide.slug)}"
                  data-bookmark-title="${escapeHtml(guide.title)}">
            <i class="fas fa-bookmark w-5 text-center"></i>
            <span>저장</span>
          </button>
          <!-- 닫기 버튼 -->
          <button type="button" 
                  id="mobile-action-close"
                  class="w-full px-4 py-3 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-white transition rounded-lg mt-2 border-t border-wiki-border/40 pt-4">
            <i class="fas fa-times"></i>
            <span>닫기</span>
          </button>
        </div>
      </div>
      
      <!-- 신고 모달 -->
      <div id="report-modal" class="fixed inset-0 z-[2000] hidden" role="dialog" aria-modal="true" aria-labelledby="report-modal-title">
        <div class="fixed inset-0 bg-black/60 backdrop-blur-sm" data-report-backdrop></div>
        <div class="fixed inset-0 flex items-center justify-center p-4">
          <div class="bg-wiki-bg border border-wiki-border/60 rounded-2xl shadow-2xl w-full max-w-md">
            <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border/60">
              <h3 id="report-modal-title" class="text-lg font-semibold text-white">게시글 신고</h3>
              <button type="button" class="text-wiki-muted hover:text-white transition" data-report-close>
                <i class="fas fa-times"></i>
              </button>
            </div>
            <form id="report-form" class="p-6 space-y-4">
              <div>
                <label class="block text-sm font-medium text-wiki-text mb-2">신고 사유 *</label>
                <select name="reasonType" required class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/60 rounded-lg text-white focus:border-wiki-primary outline-none">
                  <option value="">선택해주세요</option>
                  <option value="defamation">명예훼손</option>
                  <option value="obscene">음란물</option>
                  <option value="spam">스팸/광고</option>
                  <option value="copyright">저작권 침해</option>
                  <option value="false_info">허위정보</option>
                  <option value="other">기타</option>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-wiki-text mb-2">상세 사유 (선택)</label>
                <textarea name="reasonDetail" rows="3" maxlength="500"
                          class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:border-wiki-primary outline-none resize-none"
                          placeholder="추가 설명이 있으면 작성해주세요"></textarea>
              </div>
              <div class="flex gap-3 pt-2">
                <button type="button" data-report-close
                        class="flex-1 px-4 py-2.5 border border-wiki-border/60 text-wiki-muted hover:text-white rounded-lg transition">
                  취소
                </button>
                <button type="submit"
                        class="flex-1 px-4 py-2.5 bg-red-500 hover:bg-red-600 text-white font-medium rounded-lg transition">
                  신고하기
                </button>
              </div>
              <div id="report-message" class="hidden"></div>
            </form>
          </div>
        </div>
      </div>
      
      <!-- 관리자 블라인드 모달 -->
      ${isAdmin ? `
      <div id="blind-modal" class="fixed inset-0 z-[2000] hidden" role="dialog" aria-modal="true">
        <div class="fixed inset-0 bg-black/60 backdrop-blur-sm" data-blind-backdrop></div>
        <div class="fixed inset-0 flex items-center justify-center p-4">
          <div class="bg-wiki-bg border border-wiki-border/60 rounded-2xl shadow-2xl w-full max-w-md">
            <div class="flex items-center justify-between px-6 py-4 border-b border-wiki-border/60">
              <h3 class="text-lg font-semibold text-white">블라인드 처리</h3>
              <button type="button" class="text-wiki-muted hover:text-white transition" data-blind-close>
                <i class="fas fa-times"></i>
              </button>
            </div>
            <form id="blind-form" class="p-6 space-y-4">
              <div>
                <label class="block text-sm font-medium text-wiki-text mb-2">블라인드 사유 *</label>
                <textarea name="reason" rows="3" required
                          class="w-full px-4 py-2.5 bg-wiki-card/50 border border-wiki-border/60 rounded-lg text-white placeholder-wiki-muted focus:border-wiki-primary outline-none resize-none"
                          placeholder="블라인드 사유를 입력해주세요"></textarea>
              </div>
              <div class="flex gap-3 pt-2">
                <button type="button" data-blind-close
                        class="flex-1 px-4 py-2.5 border border-wiki-border/60 text-wiki-muted hover:text-white rounded-lg transition">
                  취소
                </button>
                <button type="submit"
                        class="flex-1 px-4 py-2.5 bg-amber-500 hover:bg-amber-600 text-white font-medium rounded-lg transition">
                  블라인드 처리
                </button>
              </div>
              <div id="blind-message" class="hidden"></div>
            </form>
          </div>
        </div>
      </div>
      ` : ''}
      
      <script>
        (function() {
          const slug = '${escapeHtml(guide.slug)}';
          const pageId = ${pageId || 'null'};
          const isDraftPublished = ${isDraftPublished ? 'true' : 'false'};
          const canonicalPath = '${escapeHtml(canonicalPath)}';
          const guideTitle = '${escapeHtml(guide.title).replace(/'/g, "\\'")}';
          
          // 모바일 오버레이 메뉴 핸들러
          function initMobileOverlay() {
            const mobileMoreBtn = document.getElementById('mobile-more-btn');
            const overlay = document.getElementById('mobile-action-overlay');
            const backdrop = document.getElementById('mobile-action-backdrop');
            const closeBtn = document.getElementById('mobile-action-close');
            
            if (!mobileMoreBtn || !overlay) return;
            
            function openOverlay() {
              overlay.classList.remove('hidden');
              document.body.style.overflow = 'hidden';
            }
            
            function closeOverlay() {
              overlay.classList.add('hidden');
              document.body.style.overflow = '';
            }
            
            // 버튼 클릭 시 열기
            mobileMoreBtn.addEventListener('click', function(e) {
              e.preventDefault();
              e.stopPropagation();
              openOverlay();
            });
            
            // 배경 클릭 시 닫기
            if (backdrop) {
              backdrop.addEventListener('click', closeOverlay);
            }
            
            // 닫기 버튼
            if (closeBtn) {
              closeBtn.addEventListener('click', closeOverlay);
            }
            
            // 모바일 공유 버튼
            const mobileShareBtn = document.getElementById('mobile-share-btn');
            if (mobileShareBtn) {
              mobileShareBtn.addEventListener('click', async function(e) {
                e.preventDefault();
                closeOverlay();
                
                const shareUrl = window.location.origin + canonicalPath;
                
                if (navigator.share) {
                  try {
                    await navigator.share({ title: guideTitle, url: shareUrl });
                  } catch (err) {
                    if (err.name !== 'AbortError') {
                      await navigator.clipboard.writeText(shareUrl);
                      alert('링크가 복사되었습니다.');
                    }
                  }
                } else {
                  try {
                    await navigator.clipboard.writeText(shareUrl);
                    alert('링크가 복사되었습니다.');
                  } catch (err) {
                    alert('링크 복사에 실패했습니다: ' + shareUrl);
                  }
                }
              });
            }
            
            // 모바일 신고 버튼
            const mobileReportBtn = document.getElementById('mobile-report-btn');
            if (mobileReportBtn) {
              mobileReportBtn.addEventListener('click', function(e) {
                e.preventDefault();
                closeOverlay();
                openReportModal();
              });
            }
          }
          
          // DOM이 준비되면 초기화
          if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initMobileOverlay);
          } else {
            initMobileOverlay();
          }
          
          // 발행 버튼 핸들러 (임시 발행 상태에서만) - 데스크탑
          const publishBtn = document.getElementById('btn-publish-page');
          // 발행 버튼 핸들러 - 모바일
          const publishBtnMobile = document.getElementById('btn-publish-page-mobile');
          
          const handlePublish = async function(btn) {
            if (!confirm('이 가이드를 정식 발행하시겠습니까?\\n발행하면 목록에 공개됩니다.')) return;
            
            btn.disabled = true;
            const originalHtml = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            
            try {
              const res = await fetch('/api/howto/' + pageId + '/publish-final', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' }
              });
              const data = await res.json();
              
              if (data.success) {
                alert('정식 발행되었습니다!');
                location.reload();
              } else {
                throw new Error(data.error || '발행 실패');
              }
            } catch (err) {
              alert('오류: ' + err.message);
              btn.disabled = false;
              btn.innerHTML = originalHtml;
            }
          };
          
          if (publishBtn && isDraftPublished) {
            publishBtn.addEventListener('click', () => handlePublish(publishBtn));
          }
          if (publishBtnMobile && isDraftPublished) {
            publishBtnMobile.addEventListener('click', () => handlePublish(publishBtnMobile));
          }
          
          // 신고 모달 핸들러
          const reportModal = document.getElementById('report-modal');
          const reportForm = document.getElementById('report-form');
          const reportTriggers = document.querySelectorAll('[data-report-trigger]');
          const reportCloseButtons = document.querySelectorAll('[data-report-close], [data-report-backdrop]');
          
          function openReportModal() {
            reportModal?.classList.remove('hidden');
            document.body.style.overflow = 'hidden';
          }
          
          function closeReportModal() {
            reportModal?.classList.add('hidden');
            document.body.style.overflow = '';
            reportForm?.reset();
            const msg = document.getElementById('report-message');
            if (msg) msg.classList.add('hidden');
          }
          
          reportTriggers.forEach(btn => btn.addEventListener('click', openReportModal));
          reportCloseButtons.forEach(btn => btn.addEventListener('click', closeReportModal));
          
          reportForm?.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const submitBtn = e.target.querySelector('button[type="submit"]');
            const msg = document.getElementById('report-message');
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>처리 중...';
            
            try {
              const res = await fetch('/api/howto/' + encodeURIComponent(slug) + '/report', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                  reasonType: formData.get('reasonType'),
                  reasonDetail: formData.get('reasonDetail')
                })
              });
              
              const result = await res.json();
              
              if (result.success) {
                msg.className = 'p-3 bg-green-500/10 border border-green-500/30 rounded-lg text-green-400 text-sm';
                msg.innerHTML = '<i class="fas fa-check-circle mr-2"></i>' + result.message;
                msg.classList.remove('hidden');
                setTimeout(closeReportModal, 2000);
              } else {
                throw new Error(result.error || '신고 처리 실패');
              }
            } catch (err) {
              msg.className = 'p-3 bg-red-500/10 border border-red-500/30 rounded-lg text-red-400 text-sm';
              msg.innerHTML = '<i class="fas fa-exclamation-circle mr-2"></i>' + err.message;
              msg.classList.remove('hidden');
            } finally {
              submitBtn.disabled = false;
              submitBtn.innerHTML = '신고하기';
            }
          });
          
          // 관리자 블라인드 모달 핸들러
          const blindModal = document.getElementById('blind-modal');
          const blindForm = document.getElementById('blind-form');
          const blindTrigger = document.querySelector('[data-admin-blind-trigger]');
          const blindCloseButtons = document.querySelectorAll('[data-blind-close], [data-blind-backdrop]');
          
          if (blindTrigger && blindModal) {
            const isBlinded = blindTrigger.dataset.isBlinded === 'true';
            
            function openBlindModal() {
              blindModal.classList.remove('hidden');
              document.body.style.overflow = 'hidden';
            }
            
            function closeBlindModal() {
              blindModal.classList.add('hidden');
              document.body.style.overflow = '';
              blindForm?.reset();
            }
            
            blindTrigger.addEventListener('click', () => {
              if (isBlinded) {
                // 블라인드 해제
                if (confirm('블라인드를 해제하시겠습니까?')) {
                  fetch('/api/admin/howto/' + encodeURIComponent(slug) + '/unblind', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                  }).then(res => res.json()).then(result => {
                    if (result.success) {
                      alert('블라인드가 해제되었습니다.');
                      location.reload();
                    } else {
                      alert(result.error || '처리 실패');
                    }
                  });
                }
              } else {
                openBlindModal();
              }
            });
            
            blindCloseButtons.forEach(btn => btn.addEventListener('click', closeBlindModal));
            
            blindForm?.addEventListener('submit', async (e) => {
              e.preventDefault();
              const formData = new FormData(e.target);
              const submitBtn = e.target.querySelector('button[type="submit"]');
              const msg = document.getElementById('blind-message');
              
              submitBtn.disabled = true;
              submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>처리 중...';
              
              try {
                const res = await fetch('/api/admin/howto/' + encodeURIComponent(slug) + '/blind', {
                  method: 'POST',
                  headers: { 'Content-Type': 'application/json' },
                  body: JSON.stringify({ reason: formData.get('reason') })
                });
                
                const result = await res.json();
                
                if (result.success) {
                  alert('블라인드 처리되었습니다.');
                  location.reload();
                } else {
                  throw new Error(result.error || '처리 실패');
                }
              } catch (err) {
                msg.className = 'p-3 bg-red-500/10 border border-red-500/30 rounded-lg text-red-400 text-sm';
                msg.innerHTML = '<i class="fas fa-exclamation-circle mr-2"></i>' + err.message;
                msg.classList.remove('hidden');
              } finally {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '블라인드 처리';
              }
            });
          }
        })();
      </script>
    </div>
  `
}
