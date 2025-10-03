import type { DataSource, MajorRecruitmentStat, MajorUniversityInfo, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'

export interface UnifiedMajorDetailTemplateParams {
  profile: UnifiedMajorDetail
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
  sources?: SourceStatusRecord
}

const SOURCE_LABELS: Record<DataSource, string> = {
  CAREERNET: '커리어넷',
  GOYONG24: '고용24'
}

const SOURCE_DESCRIPTIONS: Record<DataSource, string> = {
  CAREERNET: '교육부 산하 진로·진학 정보 플랫폼',
  GOYONG24: '고용노동부 고용24 학과 정보'
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

const renderUniversities = (universities?: MajorUniversityInfo[] | null): string => {
  if (!universities || universities.length === 0) {
    return ''
  }

  const items = universities
    .filter((uni) => !!uni?.name?.trim())
    .map((uni) => {
      const name = escapeHtml(uni.name!.trim())
      const department = uni.department ? `<p class="text-xs text-wiki-muted mt-1">${escapeHtml(uni.department)}</p>` : ''
      const type = uni.universityType ? `<span class="px-2 py-1 text-[10px] rounded bg-wiki-primary/10 text-wiki-primary">${escapeHtml(uni.universityType)}</span>` : ''
      const link = uni.url
        ? `<a href="${escapeHtml(uni.url)}" target="_blank" rel="noopener" class="text-xs text-wiki-primary hover:text-wiki-secondary mt-2 flex items-center gap-1">웹사이트<i class="fas fa-arrow-up-right-from-square"></i></a>`
        : ''
      return `
        <div class="bg-wiki-bg/60 border border-wiki-border rounded-lg p-4">
          <div class="flex items-center justify-between">
            <h4 class="text-sm font-semibold text-wiki-text">${name}</h4>
            ${type}
          </div>
          ${department}
          ${link}
        </div>
      `
    })

  if (items.length === 0) {
    return ''
  }

  return `
    <div class="grid gap-4 sm:grid-cols-2">
      ${items.join('')}
    </div>
  `
}

const renderRecruitmentTable = (stats?: MajorRecruitmentStat[] | null): string => {
  if (!stats || stats.length === 0) {
    return ''
  }

  const rows = stats.map((row) => `
    <tr>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.year ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.universityType ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.enrollmentQuota ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.applicants ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.graduates ?? '-')}</td>
    </tr>
  `)

  if (rows.length === 0) {
    return ''
  }

  return `
    <div class="overflow-x-auto rounded-lg border border-wiki-border">
      <table class="min-w-full divide-y divide-wiki-border text-sm">
        <thead class="bg-wiki-bg/80 text-xs uppercase tracking-wide text-wiki-muted">
          <tr>
            <th class="px-4 py-3 text-left">연도</th>
            <th class="px-4 py-3 text-left">대학 유형</th>
            <th class="px-4 py-3 text-left">정원</th>
            <th class="px-4 py-3 text-left">지원자</th>
            <th class="px-4 py-3 text-left">졸업자</th>
          </tr>
        </thead>
        <tbody class="divide-y divide-wiki-border/70">
          ${rows.join('')}
        </tbody>
      </table>
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
  profile: UnifiedMajorDetail,
  sources?: SourceStatusRecord,
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
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
        <p class="text-xs text-wiki-muted mt-1">CareerWiki 통합 파이프라인에서 수집한 전공 정보를 보여줍니다.</p>
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

const renderMetaHighlights = (profile: UnifiedMajorDetail): string => {
  const highlights = [
    profile.employmentRate ? { label: '취업률', value: profile.employmentRate, icon: 'fa-briefcase', accent: 'text-green-400' } : null,
    profile.salaryAfterGraduation ? { label: '졸업 후 평균 연봉', value: profile.salaryAfterGraduation, icon: 'fa-coins', accent: 'text-yellow-300' } : null,
    profile.categoryName ? { label: '계열/분야', value: profile.categoryName, icon: 'fa-layer-group', accent: 'text-wiki-secondary' } : null
  ].filter(Boolean) as Array<{ label: string; value: string; icon: string; accent: string }>

  if (highlights.length === 0) return ''

  return `
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-6">
      ${highlights
        .map(
          (item) => `
            <div class="bg-wiki-bg/60 border border-wiki-border rounded-xl p-4">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-full bg-wiki-border/40 flex items-center justify-center">
                  <i class="fas ${item.icon} ${item.accent}"></i>
                </div>
                <div>
                  <p class="text-xs text-wiki-muted">${item.label}</p>
                  <p class="text-base font-semibold text-wiki-text">${escapeHtml(item.value)}</p>
                </div>
              </div>
            </div>
          `
        )
        .join('')}
    </div>
  `
}

export const renderUnifiedMajorDetail = ({ profile, partials, sources }: UnifiedMajorDetailTemplateParams): string => {
  const overviewSection = `
    <div class="glass-card p-6 rounded-xl">
      <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-circle-info mr-2 text-wiki-secondary"></i>전공 개요</h2>
      ${formatRichText(profile.summary)}
    </div>
  `

  const aptitudeSection = profile.aptitude || profile.relatedMajors?.length
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-user-check mr-2 text-wiki-secondary"></i>적성 & 연관 전공</h2>
        ${profile.aptitude ? `<div class="mb-4">${formatRichText(profile.aptitude)}</div>` : ''}
        ${profile.relatedMajors?.length ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">추천 유사 전공</p>${renderChips(profile.relatedMajors)}</div>` : ''}
      </div>
    `
    : ''

  const curriculumSection = profile.mainSubjects?.length
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-book-open mr-2 text-wiki-secondary"></i>주요 교과목</h2>
        ${renderChips(profile.mainSubjects, '교과목 정보가 없습니다.')}
      </div>
    `
    : ''

  const licenseSection = profile.licenses?.length
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-certificate mr-2 text-wiki-secondary"></i>추천 자격증</h2>
        ${renderChips(profile.licenses, '관련 자격증 정보가 없습니다.')}
      </div>
    `
    : ''

  const studyPlanSection = profile.whatStudy || profile.howPrepare
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-graduation-cap mr-2 text-wiki-secondary"></i>학습 전략</h2>
        ${profile.whatStudy ? `<div class="mb-4"><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">무엇을 배우나요?</p>${formatRichText(profile.whatStudy)}</div>` : ''}
        ${profile.howPrepare ? `<div><p class="text-sm font-semibold text-wiki-muted uppercase tracking-wide mb-2">어떻게 준비하나요?</p>${formatRichText(profile.howPrepare)}</div>` : ''}
      </div>
    `
    : ''

  const outlookSection = profile.jobProspect
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-chart-line mr-2 text-wiki-secondary"></i>진로 전망</h2>
        ${formatRichText(profile.jobProspect)}
      </div>
    `
    : ''

  const relatedJobsSection = profile.relatedJobs?.length
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-briefcase mr-2 text-wiki-secondary"></i>관련 직업</h2>
        ${renderChips(profile.relatedJobs, '연관 직업 정보가 없습니다.')}
      </div>
    `
    : ''

  const universitiesContent = renderUniversities(profile.universities)
  const universitySection = universitiesContent
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-building-columns mr-2 text-wiki-secondary"></i>개설 대학</h2>
        ${universitiesContent}
      </div>
    `
    : ''

  const recruitmentContent = renderRecruitmentTable(profile.recruitmentStatus)
  const recruitmentSection = recruitmentContent
    ? `
      <div class="glass-card p-6 rounded-xl">
        <h2 class="text-xl font-semibold text-wiki-text mb-4"><i class="fas fa-users mr-2 text-wiki-secondary"></i>모집 정원 & 지원 현황</h2>
        ${recruitmentContent}
      </div>
    `
    : ''

  const sidebarSections = [
    renderSourcesPanel(profile, sources, partials)
  ].join('')

  const heroDescription = profile.summary?.split('\n')[0]?.trim()

  return `
    <div class="max-w-6xl mx-auto">
      <div class="glass-card p-8 rounded-2xl mb-8">
        <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
          <div>
            <div class="flex items-center gap-3 mb-3">
              <span class="px-3 py-1 rounded-full bg-wiki-secondary/10 text-xs text-wiki-secondary font-semibold">CareerWiki 전공 위키</span>
              ${profile.categoryName ? `<span class="px-3 py-1 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary">${escapeHtml(profile.categoryName)}</span>` : ''}
            </div>
            <h1 class="text-4xl font-bold text-white mb-3">${escapeHtml(profile.name)}</h1>
            ${heroDescription ? `<p class="text-sm text-wiki-muted max-w-2xl">${escapeHtml(heroDescription)}</p>` : ''}
            <div class="mt-4">${renderSourceBadges(profile.sources)}</div>
          </div>
          <div class="flex gap-3">
            <a href="/major" class="px-4 py-2 border border-wiki-border rounded-lg text-sm text-wiki-muted hover:border-wiki-primary hover:text-wiki-primary transition"><i class="fas fa-arrow-left mr-2"></i>목록으로</a>
            <button class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition" data-share="true"><i class="fas fa-share-alt mr-2"></i>공유</button>
          </div>
        </div>
        ${renderMetaHighlights(profile)}
      </div>

      <div class="grid lg:grid-cols-[2fr,1fr] gap-6">
        <div class="space-y-6">
          ${overviewSection}
          ${aptitudeSection}
          ${curriculumSection}
          ${licenseSection}
          ${studyPlanSection}
          ${outlookSection}
          ${relatedJobsSection}
          ${universitySection}
          ${recruitmentSection}
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

export const createMajorJsonLd = (profile: UnifiedMajorDetail, canonicalUrl: string): string => {
  const jsonLd = sanitizeJson({
    '@context': 'https://schema.org',
    '@type': 'EducationalOccupationalProgram',
    name: profile.name,
    description: profile.summary,
    url: canonicalUrl,
    programType: profile.categoryName,
    educationalCredentialAwarded: profile.licenses,
    dayOfWeek: undefined,
    provider: profile.universities && profile.universities.length > 0
      ? {
          '@type': 'CollegeOrUniversity',
          name: profile.universities[0].name,
          url: profile.universities[0].url
        }
      : undefined,
    occupationalCategory: profile.relatedJobs,
    applicationDeadline: undefined,
    numberOfCredits: undefined
  })

  if (!jsonLd) {
    return ''
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003c')
  return `<script type="application/ld+json">${script}</script>`
}
