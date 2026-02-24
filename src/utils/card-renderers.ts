import type { Context } from 'hono'
import type { Bindings, Variables } from '../types/app'
import type { DataSource } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import { type CacheState, formatTimestamp, secondsToHuman } from '../services/cacheService'
import { composeDetailSlug } from './slug'
import { renderUnifiedJobDetail, createJobJsonLd } from '../templates/unifiedJobDetail'
import { renderUnifiedMajorDetail, createMajorJsonLd } from '../templates/unifiedMajorDetail'
import { renderHowtoGuideDetail } from '../templates/howtoDetail'
import {
  getSampleJobDetail,
  getSampleMajorDetail,
  listSampleJobSummaries,
  listSampleMajorSummaries,
  getSampleHowtoGuide
} from '../data/sampleRegistry'
import {
  escapeHtml,
  buildCanonicalUrl,
  createMetaDescription,
  SOURCE_LABEL_MAP,
  formatEmploymentRate,
  renderLayoutWithContext,
} from './shared-helpers'

// ============================================================================
// 카드 렌더링 공통 함수 (SSR + API 공유)
// ============================================================================

// 만족도 등급 계산 (직업/전공 공통)
export const getSatisfactionGrade = (satisfaction: string | undefined) => {
  if (!satisfaction) return null
  const score = parseFloat(satisfaction) || 0

  if (score >= 80) {
    return { level: '매우 좋음', bg: 'bg-green-500/10', border: 'border-green-500/20', iconColor: 'text-green-400', textColor: 'text-green-300', textMuted: 'text-green-300/80' }
  } else if (score >= 60) {
    return { level: '좋음', bg: 'bg-sky-500/10', border: 'border-sky-500/20', iconColor: 'text-sky-400', textColor: 'text-sky-300', textMuted: 'text-sky-300/80' }
  } else if (score >= 40) {
    return { level: '보통', bg: 'bg-yellow-500/10', border: 'border-yellow-500/20', iconColor: 'text-yellow-400', textColor: 'text-yellow-300', textMuted: 'text-yellow-300/80' }
  } else if (score >= 20) {
    return { level: '별로', bg: 'bg-orange-500/10', border: 'border-orange-500/20', iconColor: 'text-orange-400', textColor: 'text-orange-300', textMuted: 'text-orange-300/80' }
  } else {
    return { level: '매우 별로', bg: 'bg-red-500/10', border: 'border-red-500/20', iconColor: 'text-red-400', textColor: 'text-red-300', textMuted: 'text-red-300/80' }
  }
}

// 직업 요약 텍스트 포맷
export const formatJobSummaryText = (value?: string | null): string => {
  const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 직업 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
  if (!value) return fallback
  const normalized = value.replace(/\s+/g, ' ').trim()
  if (!normalized) return fallback
  return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
}

// 전공 요약 텍스트 포맷
export const formatMajorSummaryText = (value?: string | null): string => {
  const fallback = '고용24와 커리어넷 데이터를 통합하여 제공하는 학과 정보입니다. 상세 페이지에서 자세한 내용을 확인하세요.'
  if (!value) return fallback
  const normalized = value.replace(/\s+/g, ' ').trim()
  if (!normalized) return fallback
  return normalized.length > 220 ? `${normalized.slice(0, 217)}…` : normalized
}

// 숙련기간 포맷팅: 단위가 같을 때 앞 단위 제거 (예: "1년~2년" → "1~2년")
export const formatSkillYear = (value?: string | null): string => {
  if (!value) return ''
  let trimmed = String(value).trim()
  if (!trimmed) return ''

  // "초과", "이하" 제거
  trimmed = trimmed
    .replace(/\s*초과\s*/g, ' ')
    .replace(/\s*이하\s*/g, '')
    .replace(/\s+/g, ' ')
    .trim()

  // "~" 또는 "-"로 구분된 범위 형식인지 확인 (공백 무시)
  const rangeMatch = trimmed.match(/^(.+?)\s*([~-])\s*(.+)$/)
  if (!rangeMatch) return trimmed // 범위 형식이 아니면 그대로 반환

  const [, start, separator, end] = rangeMatch

  // 단위 추출 (년, 개월 등) - 앞뒤 공백 제거
  const startTrimmed = start.trim()
  const unitMatch = startTrimmed.match(/(\d+)\s*(년|개월|월)$/)
  if (!unitMatch) return trimmed // 단위가 없으면 그대로 반환

  const [, startNum, unit] = unitMatch

  // 끝 부분에서 같은 단위가 있는지 확인 - 앞뒤 공백 제거
  const endTrimmed = end.trim()
  const endMatch = endTrimmed.match(/^(\d+)\s*(년|개월|월)$/)
  if (!endMatch) return trimmed // 끝 부분에 단위가 없으면 그대로 반환

  const [, endNum, endUnit] = endMatch

  // 단위가 같으면 앞 단위 제거
  if (unit === endUnit) {
    return `${startNum}${separator}${endNum}${unit}`
  }

  // 단위가 다르면 그대로 반환
  return trimmed
}

// 직업 카드 HTML 렌더링
export const renderJobCard = (entry: { profile: any; display?: any }): string => {
  const job = entry.profile
  const display = entry.display ?? {}
  const jobSlug = composeDetailSlug('job', job.name, job.id)
  const jobUrl = `/job/${encodeURIComponent(jobSlug)}`
  const summary = escapeHtml(formatJobSummaryText(display.summary))
  // categoryName이 객체일 수 있으므로 문자열 추출
  const rawCategoryName = display.categoryName || job.category?.name
  const normalizeCategory = (value: any): string => {
    let cat =
      typeof value === 'string'
        ? value
        : (value?.value || value?.large || value?.name || value?.medium || value?.small || '')
    if (cat.includes('›')) cat = cat.split('›')[0].trim()
    else if (cat.includes('>')) cat = cat.split('>')[0].trim()
    return cat
  }
  const categoryName = normalizeCategory(rawCategoryName)

  const satisfactionGrade = getSatisfactionGrade(display.satisfaction)

  // 메트릭 박스 생성 (우선순위: 평균 연봉 > 만족도 > 워라벨 > 작업 강도 > 숙련기간)
  type MetricBox = { html: string; mobileHtml: string; priority: number }
  const metricBoxes: MetricBox[] = []

  // 1. 평균 연봉 (최우선)
  if (display.salary) {
    const salaryText = display.salary.replace(/평균\s*/g, '')
    metricBoxes.push({
      priority: 1,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 연봉</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${escapeHtml(salaryText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-won-sign text-[10px]"></i>
          <span>평균 연봉: ${escapeHtml(salaryText)}</span>
        </span>
      `
    })
  }

  // 2. 만족도
  if (display.satisfaction && satisfactionGrade) {
    metricBoxes.push({
      priority: 2,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span>
          <span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full ${satisfactionGrade.bg} border ${satisfactionGrade.border} ${satisfactionGrade.textColor} text-xs font-medium whitespace-nowrap">
          <i class="fas fa-smile text-[10px]"></i>
          <span>만족도: ${escapeHtml(satisfactionGrade.level)}</span>
        </span>
      `
    })
  }

  // 3. 워라벨
  if (display.wlb) {
    metricBoxes.push({
      priority: 3,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-balance-scale text-purple-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">워라벨</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight">${escapeHtml(display.wlb)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-balance-scale text-[10px]"></i>
          <span>워라벨: ${escapeHtml(display.wlb)}</span>
        </span>
      `
    })
  }

  // 4. 작업 강도 (직업사전)
  if (display.workStrong) {
    metricBoxes.push({
      priority: 4,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-amber-500/10 backdrop-blur-sm border border-amber-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-dumbbell text-amber-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-amber-300/70">작업 강도</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-amber-300 text-center leading-tight">${escapeHtml(display.workStrong)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-amber-500/10 border border-amber-500/20 text-amber-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-dumbbell text-[10px]"></i>
          <span>작업 강도: ${escapeHtml(display.workStrong)}</span>
        </span>
      `
    })
  }

  // 5. 숙련기간 (직업사전)
  if (display.skillYear) {
    const formattedSkillYear = formatSkillYear(display.skillYear)
    metricBoxes.push({
      priority: 5,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-cyan-500/10 backdrop-blur-sm border border-cyan-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-clock text-cyan-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-cyan-300/70">숙련기간</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-cyan-300 text-center leading-tight">${escapeHtml(formattedSkillYear)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/20 text-cyan-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-clock text-[10px]"></i>
          <span>숙련기간: ${escapeHtml(formattedSkillYear)}</span>
        </span>
      `
    })
  }

  // 우선순위 정렬
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority)

  // 데스크톱용 메트릭 박스 HTML (최대 3개, 3번째 박스는 모바일에서 숨김)
  const desktopBoxes = sortedBoxes.slice(0, 3)
  const metricsHtml = desktopBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')

  // 모바일용 메트릭 태그 HTML (모든 메트릭 표시)
  const mobileMetricsHtml = sortedBoxes.map(box => box.mobileHtml).join('')

  // 썸네일 이미지 URL (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
  const imageUrl = display.imageUrl
  const thumbnailHtml = imageUrl
    ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30">
         <img src="${escapeHtml(imageUrl)}" alt="${escapeHtml(job.name)}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-briefcase text-3xl\\'></i></div>'" />
       </div>`
    : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-primary/10 to-wiki-secondary/10 border border-wiki-border/30 flex items-center justify-center">
         <i class="fas fa-briefcase text-3xl text-wiki-muted" aria-hidden="true"></i>
       </div>`

  return `
    <article class="group relative">
        <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
          <!-- 배경 그라데이션 글로우 -->
        <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none">
            <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
            <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
          </div>

        <!-- 클릭 가능한 링크 영역 -->
        <a href="${jobUrl}" class="block">
          <div class="relative flex gap-3 sm:gap-4 items-center">
            <!-- 썸네일 (데스크톱: 왼쪽, 중간 정렬) -->
            <div class="hidden sm:block flex-shrink-0 self-center">
            ${thumbnailHtml}
            </div>

            <!-- 직업 정보 -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 sm:max-w-[60%] pr-[84px] sm:pr-0">
              <!-- 헤더: 카테고리 + 직업명 -->
              <div class="space-y-1.5 sm:space-y-2">
                ${categoryName ? `
                  <div class="flex items-center gap-2">
                    <span class="inline-flex items-center gap-1 sm:gap-1.5 px-1.5 sm:px-2 py-0.5 sm:py-0.5 rounded-md sm:rounded-md rounded-full sm:rounded-md text-[9px] sm:text-[10px] text-xs sm:text-[10px] font-semibold sm:font-semibold font-medium sm:font-semibold uppercase tracking-wider bg-wiki-secondary/10 text-wiki-secondary/80 border border-wiki-secondary/20">
                      <i class="fas fa-folder text-[7px] sm:text-[8px] text-[10px] sm:text-[8px]"></i>
                      ${escapeHtml(categoryName)}
                    </span>
                  </div>
                ` : ''}

                <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                  ${escapeHtml(job.name)}
                </h2>
              </div>

              <!-- 설명 -->
              <p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">
                ${summary}
              </p>
            </div>

            <!-- 썸네일 (모바일: 오른쪽, 태그 영역 제외한 중간 정렬) -->
            <div class="sm:hidden absolute right-0 top-1/2 -translate-y-1/2 flex-shrink-0" style="transform: translateY(-50%);">
              ${thumbnailHtml}
            </div>

            <!-- 데스크톱: 오른쪽 메트릭 박스들 (최대 3개) -->
            ${metricsHtml ? `
              <div class="hidden sm:flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
        </div>
      </a>

        <!-- 모바일: 메트릭 태그들 가로 스크롤 (a 태그 바깥) -->
        ${mobileMetricsHtml ? `
          <div class="sm:hidden mt-3 overflow-x-auto" style="-webkit-overflow-scrolling: touch; scrollbar-width: none;">
            <div class="flex gap-2 w-max">
              ${mobileMetricsHtml}
            </div>
          </div>
        ` : ''}
      </div>
    </article>
  `
}

// 전공 카드 HTML 렌더링
export const renderMajorCard = (entry: { profile: any; display?: any }): string => {
  const major = entry.profile
  const display = entry.display ?? {}
  const majorSlug = composeDetailSlug('major', major.name, major.id)
  const majorUrl = `/major/${encodeURIComponent(majorSlug)}`
  const summary = escapeHtml(formatMajorSummaryText(display.summary))
  // 계열 이름: 객체일 수 있으므로 문자열 추출, 콤마가 2개 이하인 경우에만 표시
  const rawCategoryName = typeof display.categoryName === 'string'
    ? display.categoryName
    : (display.categoryName?.value || display.categoryName?.large || display.categoryName?.name || '')
  const categoryName = rawCategoryName && rawCategoryName.split(',').length <= 2
    ? rawCategoryName
    : undefined

  const satisfactionGrade = getSatisfactionGrade(display.firstJobSatisfaction)

  // 메트릭 박스 생성 (우선순위: 취업률 > 첫직장월급 > 만족도 > 계열)
  type MetricBox = { html: string; mobileHtml: string; priority: number }
  const metricBoxes: MetricBox[] = []

  // 1. 취업률 (최우선)
  if (display.employmentRate) {
    const rateText = formatEmploymentRate(display.employmentRate) || ''
    metricBoxes.push({
      priority: 1,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-blue-500/10 backdrop-blur-sm border border-blue-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-chart-line text-blue-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-blue-300/70">취업률</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-blue-300 text-center leading-tight px-1">${escapeHtml(rateText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-chart-line text-[10px]"></i>
          <span>취업률: ${escapeHtml(rateText)}</span>
        </span>
      `
    })
  }

  // 2. 평균 월급
  if (display.firstJobSalary) {
    const salaryText = display.firstJobSalary.includes('만원') ? display.firstJobSalary : `${display.firstJobSalary}만원`
    metricBoxes.push({
      priority: 2,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-emerald-500/10 backdrop-blur-sm border border-emerald-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-won-sign text-emerald-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-emerald-300/70">평균 월급</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-emerald-300 text-center leading-tight px-1">${escapeHtml(salaryText)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-won-sign text-[10px]"></i>
          <span>평균 월급: ${escapeHtml(salaryText)}</span>
        </span>
      `
    })
  }

  // 3. 만족도
  if (display.firstJobSatisfaction && satisfactionGrade) {
    metricBoxes.push({
      priority: 3,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg ${satisfactionGrade.bg} backdrop-blur-sm border ${satisfactionGrade.border} w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-smile ${satisfactionGrade.iconColor} text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium ${satisfactionGrade.textMuted}">만족도</span>
          <span class="text-[11px] sm:text-[13px] font-bold ${satisfactionGrade.textColor}">${escapeHtml(satisfactionGrade.level)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full ${satisfactionGrade.bg} border ${satisfactionGrade.border} ${satisfactionGrade.textColor} text-xs font-medium whitespace-nowrap">
          <i class="fas fa-smile text-[10px]"></i>
          <span>만족도: ${escapeHtml(satisfactionGrade.level)}</span>
        </span>
      `
    })
  }

  // 4. 계열
  if (categoryName) {
    metricBoxes.push({
      priority: 4,
      html: `
        <div class="flex flex-col items-center justify-center gap-1 p-2.5 rounded-lg bg-purple-500/10 backdrop-blur-sm border border-purple-500/20 w-[84px] h-[76px] sm:w-[100px] sm:h-[92px] flex-shrink-0">
          <i class="fas fa-graduation-cap text-purple-400 text-base sm:text-lg"></i>
          <span class="text-[9px] sm:text-[10px] font-medium text-purple-300/70">계열</span>
          <span class="text-[11px] sm:text-[13px] font-bold text-purple-300 text-center leading-tight px-1">${escapeHtml(categoryName.length > 10 ? categoryName.substring(0, 10) + '...' : categoryName)}</span>
        </div>
      `,
      mobileHtml: `
        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-300 text-xs font-medium whitespace-nowrap">
          <i class="fas fa-graduation-cap text-[10px]"></i>
          <span>계열: ${escapeHtml(categoryName)}</span>
        </span>
      `
    })
  }

  // 우선순위 정렬
  const sortedBoxes = metricBoxes.sort((a, b) => a.priority - b.priority)

  // 데스크톱용 메트릭 박스 HTML (최대 3개, 3번째 박스는 모바일에서 숨김)
  const desktopBoxes = sortedBoxes.slice(0, 3)
  const metricsHtml = desktopBoxes.map((box, index) => {
    if (index === 2) {
      return `<div class="hidden sm:flex">${box.html}</div>`
    }
    return box.html
  }).join('')

  // 모바일용 메트릭 태그 HTML (모든 메트릭 표시)
  const mobileMetricsHtml = sortedBoxes.map(box => box.mobileHtml).join('')

  // 썸네일 이미지 URL (메트릭 박스와 같거나 큰 크기, 수직 중앙 정렬)
  const imageUrl = display.imageUrl
  const thumbnailHtml = imageUrl
    ? `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl overflow-hidden bg-wiki-card/60 border border-wiki-border/30">
         <img src="${escapeHtml(imageUrl)}" alt="${escapeHtml(major.name)}" class="w-full h-full object-cover" loading="lazy" onerror="this.parentElement.innerHTML='<div class=\\'flex items-center justify-center w-full h-full text-wiki-muted\\' aria-hidden=\\'true\\'><i class=\\'fas fa-graduation-cap text-3xl\\'></i></div>'" />
       </div>`
    : `<div class="flex-shrink-0 self-center w-[76px] h-[76px] sm:w-[92px] sm:h-[92px] rounded-xl bg-gradient-to-br from-wiki-secondary/10 to-wiki-primary/10 border border-wiki-border/30 flex items-center justify-center">
         <i class="fas fa-graduation-cap text-3xl text-wiki-muted" aria-hidden="true"></i>
       </div>`

  return `
    <article class="group relative">
      <div class="relative overflow-hidden rounded-2xl bg-gradient-to-br from-wiki-card/40 via-wiki-card/60 to-wiki-card/40 backdrop-blur-xl border border-wiki-border/40 p-4 sm:p-6 transition-all duration-500 ease-out hover:border-wiki-primary/40 hover:shadow-xl hover:shadow-wiki-primary/5 hover:-translate-y-1">
        <!-- 배경 그라데이션 글로우 -->
        <div class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none">
          <div class="absolute -top-24 -right-24 w-48 h-48 bg-wiki-primary/10 rounded-full blur-3xl"></div>
          <div class="absolute -bottom-24 -left-24 w-48 h-48 bg-wiki-secondary/10 rounded-full blur-3xl"></div>
        </div>

        <!-- 클릭 가능한 링크 영역 -->
        <a href="${majorUrl}" class="block">
          <div class="relative flex gap-3 sm:gap-4 items-center">
            <!-- 썸네일 (데스크톱: 왼쪽, 중간 정렬) -->
            <div class="hidden sm:block flex-shrink-0 self-center">
              ${thumbnailHtml}
            </div>

            <!-- 전공 정보 -->
            <div class="flex-1 space-y-3 sm:space-y-4 min-w-0 sm:max-w-[60%] pr-[84px] sm:pr-0">
              <!-- 헤더: 전공명 -->
              <div class="space-y-1.5 sm:space-y-2">
                <h2 class="text-lg sm:text-xl font-bold text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-wiki-primary group-hover:to-wiki-secondary group-hover:bg-clip-text transition-all duration-300">
                  ${escapeHtml(major.name)}
                </h2>
              </div>

              <!-- 설명 -->
              <p class="text-[13px] sm:text-[15px] leading-relaxed text-wiki-muted/90 line-clamp-2">
                ${summary}
              </p>
            </div>

            <!-- 썸네일 (모바일: 오른쪽, 수직 중앙 정렬) -->
            <div class="sm:hidden absolute right-0 top-1/2 -translate-y-1/2 flex-shrink-0" style="transform: translateY(-50%);">
              ${thumbnailHtml}
            </div>

            <!-- 데스크톱: 오른쪽 메트릭 박스들 (최대 3개) -->
            ${metricsHtml ? `
              <div class="hidden sm:flex gap-2 sm:gap-2.5 items-center justify-end flex-shrink-0 ml-auto">
                ${metricsHtml}
              </div>
            ` : ''}
          </div>
        </a>

        <!-- 모바일: 메트릭 태그 가로 스크롤 (카드 패딩 내부) -->
        ${mobileMetricsHtml ? `
          <div class="sm:hidden mt-3 overflow-x-auto" style="-webkit-overflow-scrolling: touch; scrollbar-width: none;">
            <div class="flex gap-2 w-max">
              ${mobileMetricsHtml}
            </div>
          </div>
        ` : ''}
      </div>
    </article>
  `
}

export const renderDetailFallback = (options: {
  icon: string
  title: string
  description: string
  ctaHref: string
  ctaLabel: string
  iconColor?: string
  note?: string
}): string => {
  const { icon, title, description, ctaHref, ctaLabel, iconColor = 'text-wiki-muted', note } = options
  return `
    <div class="max-w-3xl mx-auto text-center py-20">
      <div class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-wiki-border/30 mb-6">
        <i class="fas ${icon} ${iconColor} text-3xl"></i>
      </div>
      <h1 class="text-3xl font-bold mb-4 text-white">${escapeHtml(title)}</h1>
      <p class="text-wiki-muted mb-6">${escapeHtml(description)}</p>
      ${note ? `<p class="text-xs text-wiki-muted mb-6">${escapeHtml(note)}</p>` : ''}
      <a href="${escapeHtml(ctaHref)}" class="inline-flex items-center gap-2 px-6 py-3 bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition">
        <i class="fas fa-arrow-left"></i><span>${escapeHtml(ctaLabel)}</span>
      </a>
    </div>
  `
}

export type SampleHighlight = {
  slug: string
  title: string
  snippet: string
  keywords: string[]
}

export const renderSampleHighlightBadges = (keywords: string[] | undefined): string => {
  if (!keywords || keywords.length === 0) return ''
  const chips = keywords
    .slice(0, 6)
    .map((keyword) => `<span class="px-3 py-1 rounded-full bg-wiki-bg border border-wiki-border text-xs text-wiki-muted">${escapeHtml(keyword)}</span>`)
    .join('')
  return `<div class="flex flex-wrap gap-2">${chips}</div>`
}

export const renderSampleHighlightCards = (
  samples: SampleHighlight[],
  basePath: 'job' | 'major',
  notice: { title: string; description: string; badge: string }
): string => {
  if (!samples.length) {
    return `
      <div class="glass-card p-12 rounded-2xl text-center">
        <i class="fas fa-lightbulb text-4xl text-wiki-secondary mb-4"></i>
        <h2 class="text-2xl font-semibold text-white mb-2">${escapeHtml(notice.title)}</h2>
        <p class="text-sm text-wiki-muted">${escapeHtml(notice.description)}</p>
      </div>
    `
  }

  const cards = samples
    .map((sample) => {
      const href = `/${basePath}/${encodeURIComponent(sample.slug)}`
      const badges = renderSampleHighlightBadges(sample.keywords)
      return `
        <article class="glass-card h-full p-6 rounded-2xl border border-wiki-border/60 bg-wiki-bg/70">
          <div class="flex flex-col h-full gap-4">
            <div>
              <h3 class="text-xl font-semibold text-white">
                <a href="${href}" class="hover:text-wiki-secondary transition">${escapeHtml(sample.title)}</a>
              </h3>
              <p class="text-xs text-wiki-muted uppercase tracking-wide mt-1">${escapeHtml(notice.badge)}</p>
            </div>
            <p class="text-sm text-wiki-muted leading-relaxed flex-1">${escapeHtml(sample.snippet)}</p>
            ${badges}
            <div class="pt-2">
              <a href="${href}" class="inline-flex items-center gap-2 text-sm text-wiki-primary hover:text-wiki-secondary transition">
                자세히 보기<i class="fas fa-arrow-right"></i>
              </a>
            </div>
          </div>
        </article>
      `
    })
    .join('')

  return `
    <section class="space-y-6">
      <div class="glass-card p-8 rounded-2xl border border-wiki-border/60 bg-wiki-bg/60 text-center">
        <h2 class="text-2xl font-semibold text-white mb-2">${escapeHtml(notice.title)}</h2>
        <p class="text-sm text-wiki-muted">${escapeHtml(notice.description)}</p>
      </div>
      <div class="grid gap-4 md:grid-cols-3">${cards}</div>
    </section>
  `
}

export const renderSampleJobHighlights = (limit = 3): string =>
  renderSampleHighlightCards(listSampleJobSummaries().slice(0, limit), 'job', {
    title: 'Phase 1 샘플 직업 살펴보기',
    description: 'Careerwiki 통합 데이터가 준비되는 동안 합성 직업 샘플을 참고해 주세요.',
    badge: 'Phase 1 Synthetic Sample'
  })

export const renderSampleMajorHighlights = (limit = 3): string =>
  renderSampleHighlightCards(listSampleMajorSummaries().slice(0, limit), 'major', {
    title: 'Phase 1 샘플 전공 미리보기',
    description: 'Careerwiki가 제공할 전공 데이터를 Phase 1 합성 샘플로 먼저 확인해 보세요.',
    badge: 'Phase 1 Synthetic Sample'
  })

export const describeSkipReason = (reason?: string): string => {
  switch (reason) {
    case 'missing-id':
      return '식별자 정보가 부족해 호출되지 않았습니다.'
    case 'missing-params':
      return '필수 파라미터가 부족해 호출되지 않았습니다.'
    case 'keyword-required':
      return '키워드가 없어 호출되지 않았습니다.'
    case 'excluded':
      return '요청한 데이터 소스에서 제외되었습니다.'
    default:
      return reason ? `호출되지 않음 (${reason})` : '호출되지 않았습니다.'
  }
}

export const renderSourceStatusSummary = (
  sources?: SourceStatusRecord,
  options?: { id?: string }
): string => {
  const idAttr = options?.id ? ` id="${escapeHtml(options.id)}"` : ''
  if (!sources) {
    return options?.id ? `<div${idAttr}></div>` : ''
  }
  const entries = Object.entries(sources) as Array<[DataSource, SourceStatusRecord[DataSource]]>
  const rows = entries
    .map(([source, status]) => {
      const label = SOURCE_LABEL_MAP[source] ?? source
      let message: string
      if (status?.error) {
        message = `오류: ${status.error}`
      } else if (typeof status?.count === 'number' && status.count > 0) {
        message = `데이터 ${status.count}건 수신`
      } else if (status?.attempted) {
        message = '호출되었으나 제공 가능한 데이터가 없습니다.'
      } else {
        message = describeSkipReason(status?.skippedReason)
      }
      return `
        <li class="flex items-start justify-between gap-4">
          <span class="text-sm font-semibold text-wiki-text">${escapeHtml(label)}</span>
          <span class="text-xs text-wiki-muted text-right">${escapeHtml(message)}</span>
        </li>
      `
    })
    .join('')
  if (!rows) {
    return options?.id ? `<div${idAttr}></div>` : ''
  }
  return `
    <div${idAttr} class="glass-card p-6 rounded-xl mt-8">
      <h2 class="text-lg font-semibold text-wiki-text mb-3">데이터 수집 상태</h2>
      <ul class="space-y-2">${rows}</ul>
    </div>
  `
}

export const renderCacheNotice = (
  state?: CacheState,
  options?: { staleSeconds: number; maxAgeSeconds: number }
): string => {
  if (!state || state.status === 'bypass') return ''

  const statusLabels: Record<CacheState['status'], string> = {
    miss: 'Cloudflare KV에 새로 저장된 데이터',
    hit: 'Cloudflare KV 캐시 적중',
    revalidated: '캐시 재검증 완료',
    stale: '임시 캐시 데이터 제공',
    bypass: '캐시 미사용'
  }

  const accentClasses: Record<CacheState['status'], string> = {
    miss: 'text-wiki-secondary',
    hit: 'text-wiki-secondary',
    revalidated: 'text-green-400',
    stale: 'text-yellow-300',
    bypass: 'text-wiki-muted'
  }

  const statusLabel = statusLabels[state.status] ?? '캐시 상태'
  const accent = accentClasses[state.status] ?? 'text-wiki-muted'

  const detailText = [
    `캐시 생성: ${formatTimestamp(state.cachedAt)}`,
    `재검증 예정: ${formatTimestamp(state.staleAt)}`,
    `만료 예정: ${formatTimestamp(state.expiresAt)}`
  ].join(' · ')

  const durationText = options
    ? `재검증 주기 ${secondsToHuman(options.staleSeconds)}, 최대 보존 ${secondsToHuman(options.maxAgeSeconds)}`
    : undefined

  return `
    <div class="glass-card p-4 rounded-xl mb-6 border border-wiki-border/70 bg-wiki-bg/70">
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <div>
          <p class="text-sm font-semibold ${accent}"><i class="fas fa-cloud mr-2"></i>${escapeHtml(statusLabel)}</p>
          <p class="text-xs text-wiki-muted mt-1">${escapeHtml(detailText)}</p>
        </div>
        ${durationText ? `<p class="text-xs text-wiki-muted">${escapeHtml(durationText)}</p>` : ''}
      </div>
    </div>
  `
}

export const createKeywordsMetaTag = (keywords?: string[]): string => {
  if (!keywords || keywords.length === 0) {
    return ''
  }
  return `<meta name="keywords" content="${escapeHtml(keywords.join(', '))}">`
}

export const createArticleModifiedMeta = (updatedAt?: string): string => {
  if (!updatedAt) {
    return ''
  }
  return `<meta property="article:modified_time" content="${escapeHtml(updatedAt)}">`
}

export function renderSampleJobDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleJobDetail>>
) {
  return renderSampleJobDetailPageWithRawData(c, sample, undefined)
}

export function renderSampleJobDetailPageWithRawData(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleJobDetail>>,
  rawApiData?: { careernet?: any; goyong24?: any }
) {
  const canonicalSlug = sample.meta?.canonicalSlug ?? composeDetailSlug('job', sample.profile.name, sample.profile.id)
  const canonicalPath = `/job/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.profile.name} 직업 정보 - Careerwiki`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.profile.summary,
    sample.profile.prospect,
    sample.snippet
  )
  const extraHead = [
    createJobJsonLd(sample.profile, canonicalUrl),
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt)
  ].filter(Boolean).join('\n')

  const content = renderUnifiedJobDetail({
    profile: sample.profile,
    partials: sample.partials ?? {},
    sources: sample.sources,
    rawApiData // Pass rawApiData even for sample pages
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        ogType: 'article',
        extraHead
      }
    )
  )
}

export function renderSampleMajorDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleMajorDetail>>
) {
  const canonicalSlug = sample.meta?.canonicalSlug ?? composeDetailSlug('major', sample.profile.name, sample.profile.id)
  const canonicalPath = `/major/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.profile.name} 전공 정보 - Careerwiki`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.profile.summary,
    sample.profile.jobProspect,
    sample.snippet
  )
  const extraHead = [
    createMajorJsonLd(sample.profile, canonicalUrl),
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt)
  ].filter(Boolean).join('\n')

  const content = renderUnifiedMajorDetail({
    profile: sample.profile,
    partials: sample.partials ?? {},
    sources: sample.sources
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        ogType: 'article',
        extraHead
      }
    )
  )
}

export function renderSampleHowtoDetailPage(
  c: Context<{ Bindings: Bindings; Variables: Variables }>,
  sample: NonNullable<ReturnType<typeof getSampleHowtoGuide>>
) {
  const authUser = c.get('user')  // User 타입 (id: number)
  const canonicalSlug = sample.meta?.canonicalSlug ?? sample.slug
  const canonicalPath = `/howto/${encodeURIComponent(canonicalSlug)}`
  const canonicalUrl = buildCanonicalUrl(c.req.url, canonicalPath)
  const title = sample.meta?.title ?? `${sample.guide.title} - Careerwiki HowTo`
  const description = createMetaDescription(
    sample.meta?.description,
    sample.guide.summary,
    sample.snippet
  )
  const extraHead = [
    createKeywordsMetaTag(sample.meta?.keywords),
    createArticleModifiedMeta(sample.meta?.updatedAt),
    createHowtoJsonLd(sample.guide, canonicalUrl)
  ].filter(Boolean).join('\n')

  // 샘플 데이터는 DB 페이지가 없으므로 편집 불가, 신고만 가능
  const content = renderHowtoGuideDetail(sample.guide, {
    currentUserId: authUser?.id ?? null,
    currentUserRole: authUser?.role ?? null,
    authorId: null,  // 샘플 데이터는 작성자 없음
    pageId: null,    // 샘플 데이터는 DB ID 없음
    isBlinded: false,
    blindReason: null
  })

  return c.html(
    renderLayoutWithContext(c,
      content,
      escapeHtml(title),
      escapeHtml(description),
      false,
      {
        canonical: canonicalUrl,
        ogUrl: canonicalUrl,
        ogType: 'article',
        extraHead
      }
    )
  )
}

export function createHowtoJsonLd(
  guide: NonNullable<ReturnType<typeof getSampleHowtoGuide>>['guide'],
  canonicalUrl: string
): string {
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'HowTo',
    name: guide.title,
    description: guide.summary,
    url: canonicalUrl,
    totalTime: guide.estimatedDuration,
    difficulty: guide.difficulty,
    audience: guide.audience,
    supply: guide.prerequisites?.map((item) => ({
      '@type': 'HowToSupply',
      name: item
    })),
    tool: guide.resources?.map((resource) => ({
      '@type': 'HowToTool',
      name: resource.label,
      url: resource.url
    })),
    step: guide.steps?.map((step) => ({
      '@type': 'HowToStep',
      name: step.title,
      url: `${canonicalUrl}#${encodeURIComponent(step.id)}`,
      text: step.description,
      itemListElement: step.keyActions?.map((action) => ({
        '@type': 'HowToDirection',
        text: action
      }))
    }))
  }

  const script = JSON.stringify(jsonLd).replace(/</g, '\\u003C')
  return `<script type="application/ld+json">${script}</script>`
}
