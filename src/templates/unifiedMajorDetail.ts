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

/**
 * 안전한 trim 함수 - undefined/null 체크
 */
const safeTrim = (value: any): string => {
  if (value === null || value === undefined) return ''
  if (typeof value !== 'string') return String(value).trim()
  return value.trim()
}

// 목차 렌더링 함수
type TocItem = { id: string; label: string; icon: string }

const renderSectionToc = (sectionKey: 'overview' | 'curriculum' | 'career' | 'universities' | 'network', heading: string, items: TocItem[]): string => {
  if (!items.length) {
    return ''
  }

  const headingIcon = sectionKey === 'overview' ? 'fa-list-check' : sectionKey === 'curriculum' ? 'fa-book-open' : sectionKey === 'career' ? 'fa-chart-line' : sectionKey === 'universities' ? 'fa-building-columns' : 'fa-diagram-project'

  const listMarkup = items
    .map((item, index) => `
        <li data-toc-order="${index + 1}">
          <a
            href="#${escapeHtml(item.id)}"
            class="flex items-center gap-3 rounded-xl border border-transparent bg-wiki-bg/45 px-3 py-2 md:px-4 md:py-3 text-sm text-wiki-muted transition hover:text-white hover:border-wiki-primary/60"
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

// anchor ID 생성 팩토리
const anchorIdFactory = (sectionKey: string, label: string): string => {
  const normalized = label.toLowerCase().replace(/[^a-z0-9가-힣]+/g, '-').replace(/(^-|-$)/g, '')
  return `${sectionKey}-${normalized}`
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

const renderMajorSourcesCollapsible = (
  profile: UnifiedMajorDetail,
  sources?: SourceStatusRecord,
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
): string => {
  const normalizedId = profile.id.replace(/[^a-z0-9]+/gi, '-').toLowerCase() || 'default'
  const panelId = `major-source-panel-${normalizedId}`

  const panel = renderSourcesPanel({
    profile,
    sources,
    partials,
    labels: SOURCE_LABELS,
    descriptions: SOURCE_DESCRIPTIONS,
    title: '출처',
    description: '이 페이지에 노출된 주요 데이터 출처를 확인할 수 있습니다.'
  })

  if (!panel || !safeTrim(panel)) {
    return ''
  }

  const activeSourceCount = partials ? Object.values(partials).filter((value) => Boolean(value)).length : 0
  const badgeLabel = activeSourceCount > 0 ? `${activeSourceCount}개 출처` : '확인하기'

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

export const renderUnifiedMajorDetail = ({ profile, partials, sources }: UnifiedMajorDetailTemplateParams): string => {
  // categoryName 정리: 50자 이상이면 관련 학과명이 잘못 들어간 것
  const cleanCategoryName = profile.categoryName && profile.categoryName.length < 50
    ? profile.categoryName
    : undefined

  const heroDescription = profile.summary?.split('\n')[0]?.trim()
  const heroImage = renderHeroImage(profile.name, { dataAttribute: 'data-major-hero-image', context: 'major' })

  const overviewCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushOverviewCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('overview', label)
    overviewCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }

  if (profile.summary?.trim()) {
    pushOverviewCard('전공 개요', 'fa-circle-info', formatRichText(profile.summary))
  }
  
  // 전공 특성 (property)
  if (profile.property?.trim()) {
    pushOverviewCard('전공 특성', 'fa-star', formatRichText(profile.property))
  }
  
  if (profile.aptitude?.trim()) {
    pushOverviewCard('이 전공에 어울리는 사람', 'fa-user-check', formatRichText(profile.aptitude))
  }

  const overviewContent = overviewCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('overview', '목차', overviewCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${overviewCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">개요 정보가 준비 중입니다.</p>`
  
  // 적성 리스트 (lstMiddleAptd, lstHighAptd)
  const aptitudeItems: string[] = []
  if (profile.lstMiddleAptd && Array.isArray(profile.lstMiddleAptd) && profile.lstMiddleAptd.length > 0) {
    const middleAptItems = profile.lstMiddleAptd
      .filter(item => item && (item.name || item.aptd_name))
      .slice(0, 10)
      .map(item => {
        const name = item.name || item.aptd_name || ''
        const score = item.score || item.aptd_score
        if (score !== undefined) {
          const barWidth = Math.min(parseFloat(score) || 0, 100)
          return `
            <div class="flex items-center gap-3 mb-2">
              <span class="text-sm text-wiki-text min-w-[100px]">${escapeHtml(name)}</span>
              <div class="flex-1 bg-wiki-border/30 rounded-full h-2 overflow-hidden">
                <div class="bg-purple-500 h-full rounded-full transition-all" style="width: ${barWidth}%"></div>
              </div>
              <span class="text-xs text-wiki-muted min-w-[40px] text-right">${parseFloat(score).toFixed(1)}</span>
            </div>
          `
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (middleAptItems) {
      aptitudeItems.push(`<div><h4 class="text-sm font-bold text-wiki-secondary mb-3">중학생 적성</h4>${middleAptItems}</div>`)
    }
  }
  
  if (profile.lstHighAptd && Array.isArray(profile.lstHighAptd) && profile.lstHighAptd.length > 0) {
    const highAptItems = profile.lstHighAptd
      .filter(item => item && (item.name || item.aptd_name))
      .slice(0, 10)
      .map(item => {
        const name = item.name || item.aptd_name || ''
        const score = item.score || item.aptd_score
        if (score !== undefined) {
          const barWidth = Math.min(parseFloat(score) || 0, 100)
          return `
            <div class="flex items-center gap-3 mb-2">
              <span class="text-sm text-wiki-text min-w-[100px]">${escapeHtml(name)}</span>
              <div class="flex-1 bg-wiki-border/30 rounded-full h-2 overflow-hidden">
                <div class="bg-indigo-500 h-full rounded-full transition-all" style="width: ${barWidth}%"></div>
              </div>
              <span class="text-xs text-wiki-muted min-w-[40px] text-right">${parseFloat(score).toFixed(1)}</span>
            </div>
          `
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (highAptItems) {
      aptitudeItems.push(`<div class="${aptitudeItems.length > 0 ? 'mt-4' : ''}"><h4 class="text-sm font-bold text-wiki-secondary mb-3">고등학생 적성</h4>${highAptItems}</div>`)
    }
  }
  
  if (aptitudeItems.length > 0) {
    overviewCards.push(buildCard('적성 프로필', 'fa-brain', aptitudeItems.join('')))
  }
  
  // 가치관 리스트 (lstVals)
  if (profile.lstVals && Array.isArray(profile.lstVals) && profile.lstVals.length > 0) {
    const valItems = profile.lstVals
      .filter(item => item && (item.name || item.val_name))
      .slice(0, 10)
      .map(item => {
        const name = item.name || item.val_name || ''
        const score = item.score || item.val_score
        if (score !== undefined) {
          const barWidth = Math.min(parseFloat(score) || 0, 100)
          return `
            <div class="flex items-center gap-3 mb-2">
              <span class="text-sm text-wiki-text min-w-[100px]">${escapeHtml(name)}</span>
              <div class="flex-1 bg-wiki-border/30 rounded-full h-2 overflow-hidden">
                <div class="bg-pink-500 h-full rounded-full transition-all" style="width: ${barWidth}%"></div>
              </div>
              <span class="text-xs text-wiki-muted min-w-[40px] text-right">${parseFloat(score).toFixed(1)}</span>
            </div>
          `
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (valItems) {
      overviewCards.push(buildCard('가치관', 'fa-heart', valItems))
    }
  }

  const learningCards: string[] = []
  
  // 관련 고교 교과목 (relateSubject)
  if (profile.relateSubject && Array.isArray(profile.relateSubject) && profile.relateSubject.length > 0) {
    const subjectItems = profile.relateSubject
      .filter(item => item && (item.subject_name || item.SUBJECT_NM))
      .map(item => {
        const name = item.subject_name || item.SUBJECT_NM || ''
        const desc = item.subject_description || item.SUBJECT_SUMRY || ''
        if (desc) {
          return `<div class="mb-3"><span class="font-semibold text-wiki-text">${escapeHtml(name)}</span><p class="text-sm text-wiki-muted mt-1">${escapeHtml(desc)}</p></div>`
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (subjectItems) {
      learningCards.push(buildCard('고교 추천 교과목', 'fa-school', subjectItems))
    }
  }
  
  if (profile.mainSubjects?.length) {
    learningCards.push(buildCard('주요 교과목', 'fa-book-open', renderChips(profile.mainSubjects, '교과목 정보가 없습니다.')))
  }
  
  // 대학 주요 교과목 상세 (mainSubject - 배열 버전)
  if (profile.mainSubject && Array.isArray(profile.mainSubject) && profile.mainSubject.length > 0) {
    const mainSubjItems = profile.mainSubject
      .filter(item => item && (item.SBJECT_NM || item.subject_name))
      .map(item => {
        const name = item.SBJECT_NM || item.subject_name || ''
        const desc = item.SBJECT_SUMRY || item.subject_description || ''
        if (desc) {
          return `<div class="mb-3"><span class="font-semibold text-wiki-text">${escapeHtml(name)}</span><p class="text-sm text-wiki-muted mt-1">${escapeHtml(desc)}</p></div>`
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (mainSubjItems) {
      learningCards.push(buildCard('대학 주요 교과목 상세', 'fa-book', mainSubjItems))
    }
  }
  
  if (profile.whatStudy?.trim()) {
    learningCards.push(buildCard('무엇을 배우나요?', 'fa-graduation-cap', formatRichText(profile.whatStudy)))
  }
  if (profile.howPrepare?.trim()) {
    learningCards.push(buildCard('어떻게 준비하나요?', 'fa-route', formatRichText(profile.howPrepare)))
  }
  
  // 진로 탐색 활동 (careerAct)
  if (profile.careerAct && Array.isArray(profile.careerAct) && profile.careerAct.length > 0) {
    const actItems = profile.careerAct
      .filter(item => item && (item.act_name || item.ACT_NM))
      .map(item => {
        const name = item.act_name || item.ACT_NM || ''
        const desc = item.act_description || item.ACT_SUMRY || ''
        if (desc) {
          return `<div class="mb-3"><span class="font-semibold text-wiki-text">${escapeHtml(name)}</span><p class="text-sm text-wiki-muted mt-1">${escapeHtml(desc)}</p></div>`
        }
        return `<li class="text-sm text-wiki-text">• ${escapeHtml(name)}</li>`
      })
      .join('')
    if (actItems) {
      learningCards.push(buildCard('진로 탐색 활동', 'fa-compass', actItems))
    }
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
  
  // 졸업 후 진출 분야 (enterField)
  if (profile.enterField && Array.isArray(profile.enterField) && profile.enterField.length > 0) {
    const enterItems = profile.enterField
      .filter(item => item && (item.gradeuate || item.field_name))
      .map(item => {
        const name = item.gradeuate || item.field_name || ''
        const desc = item.description || item.field_description || ''
        if (desc) {
          return `<div class="mb-3"><span class="font-semibold text-wiki-text">${escapeHtml(name)}</span><p class="text-sm text-wiki-muted mt-1">${escapeHtml(desc)}</p></div>`
        }
        return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-sm text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
      })
      .join('')
    if (enterItems) {
      careerCards.push(buildCard('졸업 후 진출 분야', 'fa-door-open', enterItems))
    }
  }
  
  if (profile.salaryAfterGraduation || profile.employmentRate) {
    const metaItems = [
      profile.salaryAfterGraduation ? `<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 연봉</span><span class="text-wiki-text">${escapeHtml(profile.salaryAfterGraduation)}</span></li>` : '',
      profile.employmentRate ? `<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${escapeHtml(profile.employmentRate)}</span></li>` : ''
    ].join('')
    careerCards.push(buildCard('핵심 지표', 'fa-gauge-high', `<ul class="space-y-2">${metaItems}</ul>`))
  }
  
  // 통계 차트 데이터 (chartData)
  if (profile.chartData) {
    const chartSections: string[] = []
    
    // 지원자 추이 차트
    if (profile.chartData.applicant && Array.isArray(profile.chartData.applicant) && profile.chartData.applicant.length > 0) {
      const chartId = `applicant-chart-${Date.now()}`
      const chartLabels = profile.chartData.applicant.map(item => item.name || '')
      const chartValues = profile.chartData.applicant.map(item => parseFloat(item.data || '0'))
      
      chartSections.push(`
        <div class="mb-6">
          <h4 class="text-base font-bold text-wiki-secondary mb-3">지원자 추이</h4>
          <canvas id="${chartId}" style="max-height: 250px;"></canvas>
          <script>
            (function() {
              const ctx = document.getElementById('${chartId}');
              if (ctx && typeof Chart !== 'undefined') {
                new Chart(ctx, {
                  type: 'line',
                  data: {
                    labels: ${JSON.stringify(chartLabels)},
                    datasets: [{
                      data: ${JSON.stringify(chartValues)},
                      borderColor: 'rgba(59, 130, 246, 0.85)',
                      backgroundColor: 'rgba(59, 130, 246, 0.1)',
                      borderWidth: 2,
                      fill: true,
                      tension: 0.4
                    }]
                  },
                  options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    scales: {
                      y: {
                        beginAtZero: true,
                        ticks: { color: 'rgba(255, 255, 255, 0.6)', font: { size: 11 } },
                        grid: { color: 'rgba(255, 255, 255, 0.1)', drawBorder: false }
                      },
                      x: {
                        ticks: { color: 'rgba(255, 255, 255, 0.7)', font: { size: 11 } },
                        grid: { display: false, drawBorder: false }
                      }
                    },
                    plugins: {
                      legend: { display: false },
                      tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12
                      }
                    }
                  }
                });
              }
            })();
          </script>
        </div>
      `)
    }
    
    // 취업률 추이 차트
    if (profile.chartData.employment_rate && Array.isArray(profile.chartData.employment_rate) && profile.chartData.employment_rate.length > 0) {
      const chartId = `employment-chart-${Date.now()}`
      const chartLabels = profile.chartData.employment_rate.map(item => item.name || '')
      const chartValues = profile.chartData.employment_rate.map(item => parseFloat(item.data || '0'))
      
      chartSections.push(`
        <div class="mb-6">
          <h4 class="text-base font-bold text-wiki-secondary mb-3">취업률 추이</h4>
          <canvas id="${chartId}" style="max-height: 250px;"></canvas>
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
                      backgroundColor: 'rgba(16, 185, 129, 0.85)',
                      borderRadius: 4
                    }]
                  },
                  options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    scales: {
                      y: {
                        beginAtZero: true,
                        max: 100,
                        ticks: { color: 'rgba(255, 255, 255, 0.6)', font: { size: 11 }, callback: v => v + '%' },
                        grid: { color: 'rgba(255, 255, 255, 0.1)', drawBorder: false }
                      },
                      x: {
                        ticks: { color: 'rgba(255, 255, 255, 0.7)', font: { size: 11 } },
                        grid: { display: false, drawBorder: false }
                      }
                    },
                    plugins: {
                      legend: { display: false },
                      tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        callbacks: { label: ctx => ctx.parsed.y + '%' }
                      }
                    }
                  }
                });
              }
            })();
          </script>
        </div>
      `)
    }
    
    if (chartSections.length > 0) {
      careerCards.push(buildCard('통계 정보', 'fa-chart-area', chartSections.join('')))
    }
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

  const tabEntries: TabEntry[] = [
    { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent },
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
  if (cleanCategoryName) {
    detailMetaExtra.categoryName = cleanCategoryName
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
    entityCategory: cleanCategoryName ?? null,
    entitySources: profile.sources,
    tabs: tabEntries,
    tabFallback: {
      title: '데이터 준비 중',
      icon: 'fa-circle-info',
      message: '이 전공은 아직 상세 정보가 충분하지 않습니다. 데이터가 수집되는 대로 탭이 활성화됩니다.'
    },
    ctaLinks: [],
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

  // 사이드바 구성
  const sidebarSections: string[] = []
  
  // 기본 정보
  const basicInfoItems: string[] = []
  if (cleanCategoryName) {
    basicInfoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">계열/분야</span><span class="text-wiki-text font-medium">${escapeHtml(cleanCategoryName)}</span></li>`)
  }
  if (profile.employmentRate) {
    basicInfoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text font-medium">${escapeHtml(profile.employmentRate)}</span></li>`)
  }
  if (profile.salaryAfterGraduation) {
    basicInfoItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 연봉</span><span class="text-wiki-text font-medium">${escapeHtml(profile.salaryAfterGraduation)}</span></li>`)
  }
  
  if (basicInfoItems.length > 0) {
    sidebarSections.push(`
      <div class="glass-card border-0 md:border px-2 py-6 md:px-6 rounded-none md:rounded-xl">
        <h3 class="text-lg font-semibold text-white mb-4">기본 정보</h3>
        <ul class="space-y-3">${basicInfoItems.join('')}</ul>
      </div>
    `)
  }
  
  const hasSidebar = sidebarSections.length > 0
  const sidebarContent = sidebarSections.join('')

  // 데이터 출처 collapsible (직업 템플릿과 동일)
  const sourcesCollapsible = renderMajorSourcesCollapsible(profile, sources, partials)

  const sourcesBlock = sourcesCollapsible
    ? `<div data-major-sources>${sourcesCollapsible}</div>`
    : ''

  const communityBlock = `<div data-major-community>${commentsPlaceholder}</div>`

  // 히어로 태그: aptitude 필드 활용 (적성/흥미)
  const heroTags = profile.aptitude && profile.aptitude.length < 200
    ? profile.aptitude.split(',').map(tag => tag.trim()).filter(Boolean).slice(0, 5)
    : []

  const heroTagsMarkup = heroTags.length > 0
    ? `<div class="flex flex-wrap gap-2 mt-4">${heroTags.map(tag => `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 border border-wiki-primary/20 text-xs text-wiki-primary font-medium"><i class="fas fa-tag text-[10px]"></i>${escapeHtml(tag)}</span>`).join('')}</div>`
    : ''

  const mainColumn = `<div class="space-y-6 min-w-0">${tabLayout}</div>`
  const sidebarMarkup = hasSidebar
    ? `<aside class="space-y-6 lg:sticky lg:top-28 lg:h-fit lg:self-start" data-major-sidebar>${sidebarContent}</aside>`
    : ''

  const layoutBlock = hasSidebar
    ? `
        <div class="grid gap-8 lg:grid-cols-[minmax(0,3fr)_minmax(260px,1fr)] lg:items-start" data-major-layout>
          ${mainColumn}
          ${sidebarMarkup}
        </div>
      `
    : `<div class="space-y-6" data-major-layout>${tabLayout}</div>`

  return `
    <div class="max-w-[1400px] mx-auto md:px-6 space-y-4 md:space-y-8 md:py-8 md:mt-4">
      <section class="glass-card border-0 md:border px-6 py-8 md:px-8 rounded-none md:rounded-2xl space-y-6 md:space-y-8" data-major-hero>
        <div class="space-y-5">
          ${cleanCategoryName ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-primary/15 text-xs text-wiki-primary font-semibold"><i class="fas fa-layer-group"></i>${escapeHtml(cleanCategoryName)}</span>` : ''}
          <div class="flex flex-wrap items-start justify-between gap-4">
            <h1 class="text-[32px] md:text-[34px] lg:text-4xl font-bold text-white leading-tight">${escapeHtml(profile.name)}</h1>
            <button type="button" class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition inline-flex items-center gap-2 shrink-0" data-share="true" data-entity-type="major" data-entity-id="${escapeHtml(profile.id)}">
              <i class="fas fa-share-nodes"></i>
              공유
            </button>
          </div>
          ${heroDescription ? `<p class="text-[15px] text-wiki-muted leading-relaxed">${escapeHtml(heroDescription)}</p>` : ''}
          ${heroImage}
          ${heroTagsMarkup}
        </div>
      </section>

      ${layoutBlock}
      ${sourcesBlock}
      ${communityBlock}

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
