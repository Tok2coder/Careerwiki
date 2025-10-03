import type { DataSource, JobRelatedEntity, UnifiedJobDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'

export interface UnifiedJobDetailTemplateParams {
  profile: UnifiedJobDetail
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  sources?: SourceStatusRecord
}

const SOURCE_LABELS: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24'
}

const SOURCE_DESCRIPTIONS: Record<DataSource, string> = {
  CAREERNET: '교육부 산하 진로·진학 정보 플랫폼',
  GOYONG24: '고용노동부 고용24 직업 정보'
}

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
      return `<p class="text-sm leading-relaxed text-wiki-text">${safe}</p>`
    })
    .join('')
}

const renderChips = (items?: string[] | null, emptyText = '정보 없음'): string => {
  if (!items || items.length === 0) {
    return `<p class="text-sm text-wiki-muted">${emptyText}</p>`
  }

  return `
    <div class="flex flex-wrap gap-2">
      ${items
        .filter((item) => !!item && !!item.trim())
        .map((item) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(item.trim())}</span>`)
        .join('')}
    </div>
  `
}

const buildEntityUrl = (entity: JobRelatedEntity, type: 'job' | 'major'): string => {
  if (!entity?.id) return '#'
  return `/${type}/${encodeURIComponent(entity.id)}`
}

const renderEntityList = (entities?: JobRelatedEntity[] | null, type: 'job' | 'major', emptyText = '정보 없음'): string => {
  if (!entities || entities.length === 0) {
    return `<p class="text-sm text-wiki-muted">${emptyText}</p>`
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

const renderQuickStats = (profile: UnifiedJobDetail): string => {
  const stats = [
    { label: '평균 연봉', value: profile.salary, icon: 'fa-coins', accent: 'text-green-400' },
    { label: '직업 전망', value: profile.prospect, icon: 'fa-chart-line', accent: 'text-wiki-secondary' },
    { label: '직무 만족도', value: profile.satisfaction, icon: 'fa-face-smile', accent: 'text-yellow-400' },
    { label: '고용 형태', value: profile.status, icon: 'fa-briefcase', accent: 'text-wiki-primary' }
  ].filter((stat) => !!stat.value && !!stat.value.trim())

  if (stats.length === 0) return ''

  return `
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
      ${stats
        .map(
          (stat) => `
            <div class="bg-wiki-bg/60 border border-wiki-border rounded-xl p-4">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-wiki-border/40 flex items-center justify-center">
                  <i class="fas ${stat.icon} ${stat.accent}"></i>
                </div>
                <div>
                  <p class="text-xs text-wiki-muted">${stat.label}</p>
                  <p class="text-base font-semibold text-wiki-text">${escapeHtml(stat.value!.trim())}</p>
                </div>
              </div>
            </div>
          `
        )
        .join('')}
    </div>
  `
}

const renderSourceBadges = (sources?: DataSource[]): string => {
  if (!sources || sources.length === 0) return ''
  return `
    <div class="flex flex-wrap gap-2">
      ${sources
        .map((source) => `
          <span class="px-3 py-1 rounded-full bg-wiki-primary/10 border border-wiki-primary/40 text-xs text-wiki-primary">
            <i class="fas fa-database mr-1"></i>${SOURCE_LABELS[source] ?? source}
          </span>
        `)
        .join('')}
    </div>
  `
}

const renderSourcesPanel = (
  profile: UnifiedJobDetail,
  sources?: SourceStatusRecord,
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
): string => {
  const entries = (Object.keys(SOURCE_LABELS) as DataSource[]).map((source) => {
    const status = sources?.[source]
    const hasData = !!partials?.[source]
    const attempted = status?.attempted
    const icon = hasData
      ? 'fa-circle-check text-green-400'
      : attempted && !status?.error
        ? 'fa-circle text-wiki-secondary'
        : 'fa-circle-xmark text-red-400'
    const subline = hasData
      ? '통합 데이터에 포함되었습니다.'
      : status?.error
        ? status.error
        : status?.skippedReason === 'keyword-required'
          ? '검색어가 필요하여 호출되지 않았습니다.'
          : attempted
            ? '호출되었으나 데이터가 없습니다.'
            : '해당 소스는 호출되지 않았습니다.'

    return `
      <li class="p-3 border border-wiki-border rounded-lg bg-wiki-bg/60">
        <div class="flex items-start gap-3">
          <i class="fas ${icon} mt-1"></i>
          <div>
            <p class="text-sm font-semibold text-wiki-text">${SOURCE_LABELS[source]}</p>
            <p class="text-xs text-wiki-muted">${SOURCE_DESCRIPTIONS[source]}</p>
            <p class="text-xs text-wiki-muted mt-1">${escapeHtml(subline)}</p>
          </div>
        </div>
      </li>
    `
  })

  return `
    <div class="glass-card p-6 rounded-xl space-y-4">
      <div>
        <h3 class="text-lg font-semibold text-wiki-text">데이터 출처</h3>
        <p class="text-xs text-wiki-muted mt-1">CareerWiki 통합 파이프라인에서 수집한 직업 정보를 보여줍니다.</p>
      </div>
      <ul class="space-y-3">${entries.join('')}</ul>
      ${profile.sourceIds.careernet || profile.sourceIds.goyong24 ? `
        <div class="border-t border-wiki-border pt-3 text-xs text-wiki-muted">
          <p class="font-semibold text-wiki-text mb-1">Source IDs</p>
          ${profile.sourceIds.careernet ? `<p>커리어넷: ${escapeHtml(profile.sourceIds.careernet)}</p>` : ''}
          ${profile.sourceIds.goyong24 ? `<p>고용24: ${escapeHtml(profile.sourceIds.goyong24)}</p>` : ''}
        </div>
      ` : ''}
    </div>
  `
}

const renderOrganizations = (profile: UnifiedJobDetail): string => {
  if (!profile.relatedOrganizations || profile.relatedOrganizations.length === 0) return ''
  return `
    <div class="glass-card p-6 rounded-xl">
      <h3 class="text-lg font-semibold text-wiki-text mb-3">관련 기관 및 협회</h3>
      <ul class="space-y-2 text-sm">
        ${profile.relatedOrganizations
          .filter((org) => !!org?.name?.trim())
          .map((org) => {
            const name = escapeHtml(org.name.trim())
            if (org.url) {
              return `<li><a href="${escapeHtml(org.url)}" target="_blank" rel="noopener" class="text-wiki-primary hover:text-wiki-secondary">${name}</a></li>`
            }
            return `<li class="text-wiki-text">${name}</li>`
          })
          .join('')}
      </ul>
    </div>
  `
}

const renderKecoCodes = (profile: UnifiedJobDetail): string => {
  if (!profile.kecoCodes || profile.kecoCodes.length === 0) return ''
  return `
    <div class="glass-card p-6 rounded-xl">
      <h3 class="text-lg font-semibold text-wiki-text mb-3">한국표준직업분류</h3>
      <ul class="space-y-2 text-sm text-wiki-text">
        ${profile.kecoCodes
          .filter((item) => !!item?.code || !!item?.name)
          .map((item) => {
            const code = item.code ? `<span class="text-wiki-muted mr-2">${escapeHtml(item.code)}</span>` : ''
            const name = item.name ? escapeHtml(item.name) : ''
            return `<li>${code}${name}</li>`
          })
          .join('')}
      </ul>
    </div>
  `
}

export const renderUnifiedJobDetail = ({ profile, partials, sources }: UnifiedJobDetailTemplateParams): string => {
  const quickStats = renderQuickStats(profile)
  const summarySection = `
    <div class="glass-card p-6 rounded-xl">
      <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-circle-info mr-2 text-wiki-secondary"></i>직업 소개</h2>
      ${formatRichText(profile.summary)}
    </div>
  `

  const dutySection = profile.duties || profile.way
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-list-check mr-2 text-wiki-secondary"></i>주요 업무 & 업무 방식</h2>
        ${profile.duties ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">주요 업무</p>${formatRichText(profile.duties)}</div>` : ''}
        ${profile.way ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">업무 환경</p>${formatRichText(profile.way)}</div>` : ''}
      </div>
    `
    : ''

  const competencySection = profile.abilities || profile.knowledge || profile.technKnow || profile.activitiesImportance || profile.activitiesLevels
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-brain mr-2 text-wiki-secondary"></i>역량 & 지식</h2>
        ${profile.abilities ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">필요 역량</p>${formatRichText(profile.abilities)}</div>` : ''}
        ${profile.knowledge ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">필수 지식</p>${formatRichText(profile.knowledge)}</div>` : ''}
        ${profile.technKnow ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">기술/지식</p>${formatRichText(profile.technKnow)}</div>` : ''}
        ${profile.activitiesImportance ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">활동 중요도</p>${formatRichText(profile.activitiesImportance)}</div>` : ''}
        ${profile.activitiesLevels ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">활동 수준</p>${formatRichText(profile.activitiesLevels)}</div>` : ''}
      </div>
    `
    : ''

  const personalitySection = profile.personality || profile.interests || profile.values
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-user-astronaut mr-2 text-wiki-secondary"></i>인성 & 흥미</h2>
        ${profile.personality ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">성격 특성</p>${formatRichText(profile.personality)}</div>` : ''}
        ${profile.interests ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">흥미</p>${formatRichText(profile.interests)}</div>` : ''}
        ${profile.values ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">가치관</p>${formatRichText(profile.values)}</div>` : ''}
      </div>
    `
    : ''

  const relationSection = profile.relatedMajors?.length || profile.relatedJobs?.length || profile.relatedCertificates?.length
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-diagram-project mr-2 text-wiki-secondary"></i>연관 네트워크</h2>
        ${profile.relatedMajors?.length ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">관련 전공</p>${renderEntityList(profile.relatedMajors, 'major')}</div>` : ''}
        ${profile.relatedJobs?.length ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">연관 직업</p>${renderEntityList(profile.relatedJobs, 'job')}</div>` : ''}
        ${profile.relatedCertificates?.length ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">추천 자격증</p>${renderChips(profile.relatedCertificates)}</div>` : ''}
      </div>
    `
    : ''

  const environmentSection = profile.environment
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-city mr-2 text-wiki-secondary"></i>근무 환경</h2>
        ${formatRichText(profile.environment)}
      </div>
    `
    : ''

  const distributions = [
    {
      title: '학력 분포',
      icon: 'fa-user-graduate',
      content: renderDistributionList(profile.educationDistribution, {
        middleSchoolOrLess: '중학교 이하',
        highSchool: '고등학교',
        college: '전문대',
        university: '대학',
        graduate: '석사 이상',
        doctor: '박사'
      })
    },
    {
      title: '전공 분포',
      icon: 'fa-book-open-reader',
      content: renderDistributionList(profile.majorDistribution, {
        humanities: '인문계열',
        social: '사회계열',
        education: '교육계열',
        engineering: '공학계열',
        natural: '자연계열',
        medical: '의약계열',
        artsSports: '예체능'
      })
    }
  ]
    .map((box) => {
      if (!box.content) return ''
      return `
        <div class="glass-card p-6 rounded-xl">
          <h3 class="text-lg font-semibold text-wiki-text mb-3"><i class="fas ${box.icon} mr-2 text-wiki-secondary"></i>${box.title}</h3>
          ${box.content}
        </div>
      `
    })
    .join('')

  const classifications = profile.classifications && (profile.classifications.large || profile.classifications.medium || profile.classifications.small)
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h3 class="text-lg font-semibold text-wiki-text mb-3">직업 분류</h3>
        <ul class="space-y-2 text-sm">
          ${profile.classifications.large ? `<li><span class="text-wiki-muted mr-2">대분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.large)}</span></li>` : ''}
          ${profile.classifications.medium ? `<li><span class="text-wiki-muted mr-2">중분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.medium)}</span></li>` : ''}
          ${profile.classifications.small ? `<li><span class="text-wiki-muted mr-2">소분류</span><span class="text-wiki-text">${escapeHtml(profile.classifications.small)}</span></li>` : ''}
        </ul>
      </div>
    `
    : ''

  const sidebarSections = [
    renderSourcesPanel(profile, sources, partials),
    classifications,
    renderOrganizations(profile),
    renderKecoCodes(profile),
    distributions
  ]
    .filter((section) => !!section && section.trim().length > 0)
    .join('')

  const heroDescription = profile.summary?.split('\n')[0]?.trim()

  return `
    <div class="max-w-6xl mx-auto">
      <div class="glass-card p-8 rounded-2xl mb-8">
        <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
          <div>
            <div class="flex items-center gap-3 mb-3">
              <span class="px-3 py-1 rounded-full bg-wiki-secondary/10 text-xs text-wiki-secondary font-semibold">CareerWiki 직업 위키</span>
              ${profile.category?.name ? `<span class="px-3 py-1 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary">${escapeHtml(profile.category.name)}</span>` : ''}
            </div>
            <h1 class="text-4xl font-bold text-white mb-3">${escapeHtml(profile.name)}</h1>
            ${heroDescription ? `<p class="text-sm text-wiki-muted max-w-2xl">${escapeHtml(heroDescription)}</p>` : ''}
            <div class="mt-4">${renderSourceBadges(profile.sources)}</div>
          </div>
          <div class="flex gap-3">
            <a href="/job" class="px-4 py-2 border border-wiki-border rounded-lg text-sm text-wiki-muted hover:border-wiki-primary hover:text-wiki-primary transition"><i class="fas fa-arrow-left mr-2"></i>목록으로</a>
            <button class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition" data-share="true"><i class="fas fa-share-alt mr-2"></i>공유</button>
          </div>
        </div>
        ${quickStats ? `<div class="mt-8">${quickStats}</div>` : ''}
      </div>

      <div class="grid lg:grid-cols-[2fr,1fr] gap-6">
        <div class="space-y-6">
          ${summarySection}
          ${dutySection}
          ${competencySection}
          ${personalitySection}
          ${environmentSection}
          ${relationSection}
        </div>
        <aside class="space-y-6">
          ${sidebarSections}
        </aside>
      </div>
    </div>
  `
}

const sanitizeJson = (value: unknown): unknown => {
  if (Array.isArray(value)) {
    return value.map((item) => sanitizeJson(item)).filter((item) => item !== undefined && item !== null)
  }
  if (value && typeof value === 'object') {
    const result: Record<string, unknown> = {}
    Object.entries(value).forEach(([key, val]) => {
      const sanitized = sanitizeJson(val)
      if (sanitized !== undefined && sanitized !== null && !(typeof sanitized === 'string' && sanitized.trim() === '')) {
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
