import type { DataSource, UnifiedMajorDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import {
  TabEntry,
  buildCard,
  buildDetailScaffold,
  DEFAULT_SOURCE_LABELS,
  escapeHtml,
  formatRichText,
  renderChips,
  renderHeroImage,
  renderSourceBadges,
  renderSourcesPanel,
  sanitizeJson
} from './detailTemplateUtils'
import { composeDetailSlug } from '../utils/slug'

export interface UnifiedMajorDetailTemplateParams {
  profile: UnifiedMajorDetail
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
  sources?: SourceStatusRecord
}

const SOURCE_LABELS: Record<DataSource, string> = {
  ...DEFAULT_SOURCE_LABELS
}

const SOURCE_DESCRIPTIONS: Record<DataSource, string> = {
  CAREERNET: '교육부 산하 진로·진학 정보 플랫폼',
  GOYONG24: '고용노동부 고용24 학과 정보'
}

const renderUniversities = (universities?: UnifiedMajorDetail['universities']): string => {
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
        <div class="bg-wiki-bg/60 border border-wiki-border rounded-lg px-2 py-4 md:px-4">
          <div class="flex items-center justify-between">
            <h4 class="content-text font-semibold text-wiki-text">${name}</h4>
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

  return `<div class="grid gap-4 sm:grid-cols-2">${items.join('')}</div>`
}

const renderRecruitmentTable = (stats?: UnifiedMajorDetail['recruitmentStatus']): string => {
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
      <table class="min-w-full divide-y divide-wiki-border content-text">
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
            <div class="bg-wiki-bg/60 border border-wiki-border rounded-xl px-2 py-4 md:px-4">
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
  const heroDescription = profile.summary?.split('\n')[0]?.trim()
  const metaHighlights = renderMetaHighlights(profile)
  const heroImage = renderHeroImage(profile.name, { dataAttribute: 'data-major-hero-image', context: 'major' })

  const overviewCards: string[] = []
  if (profile.summary?.trim()) {
    overviewCards.push(buildCard('전공 개요', 'fa-circle-info', formatRichText(profile.summary)))
  }
  if (profile.aptitude?.trim()) {
    overviewCards.push(buildCard('이 전공에 어울리는 사람', 'fa-user-check', formatRichText(profile.aptitude)))
  }

  const learningCards: string[] = []
  if (profile.mainSubjects?.length) {
    learningCards.push(buildCard('주요 교과목', 'fa-book-open', renderChips(profile.mainSubjects, '교과목 정보가 없습니다.')))
  }
  if (profile.whatStudy?.trim()) {
    learningCards.push(buildCard('무엇을 배우나요?', 'fa-graduation-cap', formatRichText(profile.whatStudy)))
  }
  if (profile.howPrepare?.trim()) {
    learningCards.push(buildCard('어떻게 준비하나요?', 'fa-route', formatRichText(profile.howPrepare)))
  }
  if (profile.licenses?.length) {
    learningCards.push(buildCard('추천 자격증', 'fa-certificate', renderChips(profile.licenses, '관련 자격증 정보가 없습니다.')))
  }

  const careerCards: string[] = []
  if (profile.jobProspect?.trim()) {
    careerCards.push(buildCard('진로 전망', 'fa-chart-line', formatRichText(profile.jobProspect)))
  }
  if (profile.relatedJobs?.length) {
    careerCards.push(buildCard('관련 직업', 'fa-briefcase', renderChips(profile.relatedJobs, '연관 직업 정보가 없습니다.')))
  }
  if (profile.salaryAfterGraduation || profile.employmentRate) {
    const metaItems = [
      profile.salaryAfterGraduation ? `<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 연봉</span><span class="text-wiki-text">${escapeHtml(profile.salaryAfterGraduation)}</span></li>` : '',
      profile.employmentRate ? `<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${escapeHtml(profile.employmentRate)}</span></li>` : ''
    ].join('')
    careerCards.push(buildCard('핵심 지표', 'fa-gauge-high', `<ul class="space-y-2">${metaItems}</ul>`))
  }

  const universityCards: string[] = []
  const universitiesContent = renderUniversities(profile.universities)
  if (universitiesContent) {
    universityCards.push(buildCard('개설 대학', 'fa-building-columns', universitiesContent))
  }
  const recruitmentContent = renderRecruitmentTable(profile.recruitmentStatus)
  if (recruitmentContent) {
    universityCards.push(buildCard('모집 정원 & 지원 현황', 'fa-users', recruitmentContent))
  }

  const networkCards: string[] = []
  if (profile.relatedMajors?.length) {
    networkCards.push(buildCard('추천 유사 전공', 'fa-diagram-project', renderChips(profile.relatedMajors)))
  }
  if (profile.sources?.length) {
    networkCards.push(buildCard('데이터 출처 요약', 'fa-database', renderChips(profile.sources.map((src) => SOURCE_LABELS[src] ?? src))))
  }

  const tabEntries: TabEntry[] = [
    { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewCards.join('') },
    { id: 'curriculum', label: '커리큘럼', icon: 'fa-book-open', content: learningCards.join('') },
    { id: 'career', label: '진로 · 전망', icon: 'fa-chart-line', content: careerCards.join('') },
    { id: 'universities', label: '개설 대학', icon: 'fa-building-columns', content: universityCards.join('') },
    { id: 'network', label: '연결 정보', icon: 'fa-diagram-project', content: networkCards.join('') }
  ].filter((entry) => entry.content && entry.content.trim().length > 0)

  const entitySlug = composeDetailSlug('major', profile.name, profile.id)
  const summarySnippet = heroDescription ?? (profile.summary ? profile.summary.trim().slice(0, 400) : null)
  const detailMetaExtra: Record<string, unknown> = {}
  if (profile.categoryId) {
    detailMetaExtra.categoryId = profile.categoryId
  }
  if (profile.categoryName) {
    detailMetaExtra.categoryName = profile.categoryName
  }
  if (heroDescription) {
    detailMetaExtra.heroDescription = heroDescription
  }

  const { tabLayout, ctaBlock, commentsPlaceholder, metaScript } = buildDetailScaffold({
    entityType: 'major',
    entityId: profile.id,
    entitySlug,
    entityName: profile.name,
    entitySummary: summarySnippet,
    entityCategory: profile.categoryName ?? null,
    entitySources: profile.sources,
    tabs: tabEntries,
    tabFallback: {
      title: '데이터 준비 중',
      icon: 'fa-circle-info',
      message: '이 전공은 아직 상세 정보가 충분하지 않습니다. 데이터가 수집되는 대로 탭이 활성화됩니다.'
    },
    ctaLinks: [
      {
        href: `/analyzer/major?from=major-detail&major=${encodeURIComponent(profile.id)}`,
        label: 'AI 전공 추천 받기',
        icon: 'fa-brain',
        ctaType: 'ai',
        variant: 'primary'
      },
      {
        href: `/howto?from=major-detail&major=${encodeURIComponent(profile.id)}`,
        label: '학습 HowTo 살펴보기',
        icon: 'fa-route',
        ctaType: 'howto',
        variant: 'secondary'
      }
    ],
    comments: {
      title: '재학생 · 졸업생 의견 (Phase 1 준비 중)',
      description: '댓글, 리액션, 신고 기능이 곧 제공됩니다. 우선 적용을 원하시면 의견을 남겨주세요.',
      feedbackLabel: '우선 적용 의견 보내기',
      notifyLabel: '알림 받기',
      emptyLabel: `아직 등록된 댓글이 없습니다. ${profile.name}에 대한 경험을 공유해주세요.`
    },
    partials,
    sources,
    metaExtra: Object.keys(detailMetaExtra).length ? detailMetaExtra : undefined
  })

  const infoItems: string[] = []
  if (profile.categoryName) {
    infoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">계열/분야</span><span class="text-wiki-text">${escapeHtml(profile.categoryName)}</span></li>`)
  }
  if (profile.employmentRate) {
    infoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${escapeHtml(profile.employmentRate)}</span></li>`)
  }
  if (profile.salaryAfterGraduation) {
    infoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 연봉</span><span class="text-wiki-text">${escapeHtml(profile.salaryAfterGraduation)}</span></li>`)
  }

  const infoCard = infoItems.length
    ? `
      <div class="glass-card border-0 md:border px-2 py-6 md:px-6 rounded-none md:rounded-xl">
        <h3 class="text-lg font-semibold text-wiki-text mb-3">기본 정보</h3>
        <ul class="space-y-2">${infoItems.join('')}</ul>
      </div>
    `
    : ''

  const sidebarSections = [
    infoCard,
    renderSourcesPanel({
      profile,
      sources,
      partials,
      labels: SOURCE_LABELS,
      descriptions: SOURCE_DESCRIPTIONS,
      title: '출처',
      description: '이 페이지에 표시된 데이터 출처를 확인할 수 있습니다.'
    })
  ]
    .filter((section) => !!section && section.trim().length > 0)
    .join('')

  return `
    <div class="max-w-[1400px] mx-auto">
      <div class="glass-card border-0 md:border px-2 py-8 md:px-8 rounded-none md:rounded-2xl mb-8 space-y-6">
        <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
          <div>
            <div class="flex items-center gap-3 mb-3">
              <span class="px-3 py-1 rounded-full bg-wiki-secondary/10 text-xs text-wiki-secondary font-semibold">CareerWiki 전공 위키</span>
              ${profile.categoryName ? `<span class="px-3 py-1 rounded-full bg-wiki-primary/10 text-xs text-wiki-primary">${escapeHtml(profile.categoryName)}</span>` : ''}
            </div>
            <h1 class="text-4xl font-bold text-white mb-3">${escapeHtml(profile.name)}</h1>
            <div class="mt-4 flex flex-wrap gap-3 items-center">
              ${renderSourceBadges(profile.sources)}
            </div>
            ${ctaBlock}
          </div>
          <div class="flex gap-3">
            <a href="/major" class="px-4 py-2 border border-wiki-border rounded-lg content-text text-wiki-muted hover:border-wiki-primary hover:text-wiki-primary transition"><i class="fas fa-arrow-left mr-2"></i>목록으로</a>
            <button class="px-4 py-2 bg-wiki-primary text-white rounded-lg content-text hover:bg-blue-600 transition" data-share="true" data-entity-type="major" data-entity-id="${escapeHtml(profile.id)}"><i class="fas fa-share-alt mr-2"></i>공유</button>
          </div>
        </div>
        ${heroImage}
        ${metaHighlights}
      </div>

      <div class="grid lg:grid-cols-[2fr,1fr] gap-6">
        <div class="space-y-6">
          ${tabLayout}
          ${commentsPlaceholder}
        </div>
        <aside class="space-y-6">
          ${sidebarSections}
        </aside>
      </div>

      ${metaScript}
    </div>
  `
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
    provider: profile.universities && profile.universities.length > 0
      ? {
          '@type': 'CollegeOrUniversity',
          name: profile.universities[0].name,
          url: profile.universities[0].url
        }
      : undefined,
    occupationalCategory: profile.relatedJobs,
    numberOfCredits: undefined
  })

  if (!jsonLd) {
    return ''
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003c')
  return `<script type="application/ld+json">${script}</script>`
}
