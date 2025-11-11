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

const renderSectionToc = (sectionKey: 'overview' | 'curriculum' | 'career' | 'universities' | 'network' | 'details', heading: string, items: TocItem[]): string => {
  if (!items.length) {
    return ''
  }

  const headingIcon = sectionKey === 'overview' ? 'fa-list-check' : sectionKey === 'details' ? 'fa-layer-group' : sectionKey === 'curriculum' ? 'fa-book-open' : sectionKey === 'career' ? 'fa-chart-line' : sectionKey === 'universities' ? 'fa-building-columns' : 'fa-diagram-project'

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
  // categoryName 정리: 쉼표가 2개 이상이면 관련 학과명 리스트로 판단
  const cleanCategoryName = profile.categoryName && profile.categoryName.split(',').length <= 2
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

  // 졸업 후 진출 분야 (enterField) - 개요로 이동
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
      pushOverviewCard('졸업 후 진출 분야', 'fa-door-open', enterItems)
    }
  }

  // 핵심 지표 - 개요로 이동
  if (profile.salaryAfterGraduation || profile.employmentRate) {
    const metaItems: string[] = []
    
    if (profile.salaryAfterGraduation) {
      // HTML 태그 제거 및 연봉 포맷팅
      let salaryText = profile.salaryAfterGraduation.replace(/<[^>]*>/g, '').trim()
      // 숫자만 있는 경우 만원 단위 추가
      if (/^\d+(\.\d+)?$/.test(salaryText)) {
        salaryText = `${salaryText}만원`
      }
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 연봉</span><span class="text-wiki-text font-semibold">${escapeHtml(salaryText)}</span></li>`)
    }
    
    if (profile.employmentRate) {
      // HTML 태그를 실제 렌더링으로 변경
      const rateText = profile.employmentRate.replace(/<strong>([^<]+)<\/strong>/g, '<strong class="text-white font-bold">$1</strong>')
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${rateText}</span></li>`)
    }
    
    pushOverviewCard('핵심 지표', 'fa-gauge-high', `<ul class="space-y-2">${metaItems.join('')}</ul>`)
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
    pushOverviewCard('적성 프로필', 'fa-brain', aptitudeItems.join(''))
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
      pushOverviewCard('가치관', 'fa-heart', valItems)
    }
  }

  const learningCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushLearningCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('curriculum', label)
    learningCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }
  
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
      pushLearningCard('고교 추천 교과목', 'fa-school', subjectItems)
    }
  }
  
  if (profile.mainSubjects?.length) {
    pushLearningCard('주요 교과목', 'fa-book-open', renderChips(profile.mainSubjects, '교과목 정보가 없습니다.'))
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
      pushLearningCard('대학 주요 교과목 상세', 'fa-book', mainSubjItems)
    }
  }
  
  if (profile.whatStudy?.trim()) {
    pushLearningCard('무엇을 배우나요?', 'fa-graduation-cap', formatRichText(profile.whatStudy))
  }
  if (profile.howPrepare?.trim()) {
    pushLearningCard('어떻게 준비하나요?', 'fa-route', formatRichText(profile.howPrepare))
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
      pushLearningCard('진로 탐색 활동', 'fa-compass', actItems)
    }
  }
  
  if (profile.licenses?.length) {
    pushLearningCard('추천 자격증', 'fa-certificate', renderChips(profile.licenses, '관련 자격증 정보가 없습니다.'))
  }

  const learningContent = learningCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('curriculum', '목차', learningCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${learningCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">커리큘럼 정보가 준비 중입니다.</p>`

  const careerCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushCareerCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('career', label)
    careerCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }

  if (profile.jobProspect?.trim()) {
    pushCareerCard('진로 전망', 'fa-chart-line', formatRichText(profile.jobProspect))
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
      pushCareerCard('통계 정보', 'fa-chart-area', chartSections.join(''))
    }
  }

  const careerContent = careerCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('career', '목차', careerCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${careerCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">진로 정보가 준비 중입니다.</p>`

  const universityCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushUniversityCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('universities', label)
    universityCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }

  const universitiesContent = renderUniversities(profile.universities)
  if (universitiesContent) {
    pushUniversityCard('개설 대학', 'fa-building-columns', universitiesContent)
  }
  const recruitmentContent = renderRecruitmentTable(profile.recruitmentStatus)
  if (recruitmentContent) {
    pushUniversityCard('모집 정원 & 지원 현황', 'fa-users', recruitmentContent)
  }

  const universityContent = universityCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('universities', '목차', universityCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${universityCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">개설 대학 정보가 준비 중입니다.</p>`

  const networkCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushNetworkCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('network', label)
    networkCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }

  if (profile.relatedMajors?.length) {
    pushNetworkCard('추천 유사 전공', 'fa-diagram-project', renderChips(profile.relatedMajors))
  }

  const networkContent = networkCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('network', '목차', networkCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${networkCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">연결 정보가 준비 중입니다.</p>`

  // 상세정보 탭: 커리큘럼 + 진로·전망 + 연결정보 통합
  const detailCards: Array<{ id: string; label: string; icon: string; markup: string }> = []

  // 커리큘럼 카드들을 details ID로 다시 빌드
  learningCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    // markup에서 body 추출은 불가능하므로, 원본 markup에서 id만 교체
    // 더 나은 방법: markup을 anchorId를 제외한 부분만 저장했다가 다시 빌드
    // 하지만 여기서는 간단하게 기존 카드 구조를 재사용
    const newMarkup = card.markup
      .replace(/id="[^"]+"/g, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/g, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  // 진로·전망 카드들을 details ID로 다시 빌드
  careerCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    const newMarkup = card.markup
      .replace(/id="[^"]+"/g, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/g, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  // 연결정보 카드들을 details ID로 다시 빌드
  networkCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    const newMarkup = card.markup
      .replace(/id="[^"]+"/g, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/g, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  const detailContent = detailCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('details', '목차', detailCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${detailCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">상세 정보가 준비 중입니다.</p>`

  const tabEntries: TabEntry[] = [
    { id: 'overview', label: '개요', icon: 'fa-circle-info', content: overviewContent },
    { id: 'details', label: '상세정보', icon: 'fa-layer-group', content: detailContent },
    { id: 'universities', label: '개설 대학', icon: 'fa-building-columns', content: universityContent }
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

  // 사이드바 구성 (직업 템플릿과 동일한 구조)
  const renderSidebarSection = (title: string, icon: string, body: string): string => {
    return `
      <section class="glass-card border-0 md:border px-3 py-4 md:px-5 md:py-5 rounded-lg md:rounded-2xl space-y-4 bg-transparent md:bg-wiki-bg/30" data-major-sidebar-section>
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

  const sidebarSections: string[] = []
  
  // 기본 정보 제거 (사이드바에서 제거)

  // 관련 직업
  if (profile.relatedJobs?.length) {
    const jobsList = profile.relatedJobs
      .map(jobName => `
        <li>
          <a href="/search?q=${encodeURIComponent(jobName)}&type=job" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
            <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
              <i class="fas fa-briefcase text-xs" aria-hidden="true"></i>
            </span>
            <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${escapeHtml(jobName)}</span>
            <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
          </a>
        </li>
      `)
      .join('')
    sidebarSections.push(renderSidebarSection('관련 직업', 'fa-briefcase', `<ul class="space-y-2" role="list">${jobsList}</ul>`))
  }

  // 관련 HowTo (샘플 데이터)
  const sampleHowtos = [
    { label: `${profile.name} 입학 가이드`, href: '#' },
    { label: `${profile.name} 취업 준비 방법`, href: '#' }
  ]
  const howtoList = sampleHowtos
    .map(item => `
      <li>
        <a href="${escapeHtml(item.href)}" class="flex flex-col gap-1 rounded-lg border border-wiki-border/40 bg-wiki-bg/60 px-3 py-2 md:px-4 md:py-3 text-sm text-wiki-primary hover:border-wiki-primary hover:text-white transition">
          <span class="font-semibold">${escapeHtml(item.label)}</span>
          <span class="text-xs text-wiki-muted">CareerWiki HowTo</span>
        </a>
      </li>
    `)
    .join('')
  sidebarSections.push(renderSidebarSection('관련 HowTo', 'fa-route', `<ul class="space-y-2" role="list">${howtoList}</ul>`))
  
  const hasSidebar = sidebarSections.length > 0
  const sidebarContent = sidebarSections.join('')

  // 데이터 출처 collapsible (직업 템플릿과 동일)
  const sourcesCollapsible = renderMajorSourcesCollapsible(profile, sources, partials)

  const sourcesBlock = sourcesCollapsible
    ? `<div data-major-sources>${sourcesCollapsible}</div>`
    : ''

  const communityBlock = `<div data-major-community>${commentsPlaceholder}</div>`

  // 히어로 태그: relatedMajors 필드 활용 (관련 학과명)
  const heroTags = profile.relatedMajors && profile.relatedMajors.length > 0
    ? profile.relatedMajors.slice(0, 5)
    : []

  const heroTagsMarkup = heroTags.length > 0
    ? `<div class="flex flex-wrap gap-2 mt-4">${heroTags.map(tag => `<span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 border border-wiki-primary/20 text-xs text-wiki-primary font-medium"><i class="fas fa-graduation-cap text-[10px]"></i>${escapeHtml(tag)}</span>`).join('')}</div>`
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

