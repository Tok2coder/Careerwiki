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
import { renderKoreaMap, normalizeRegionName, type RegionData } from '../components/koreaMap'
import { inferRegionFromUniversityName } from '../utils/universityRegionMapper'

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
  // 항목이 1개 이하면 목차 숨김 (목차가 의미 없음)
  if (items.length <= 1) {
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

/**
 * 대학 유형 정규화 (고용24 우선, 없으면 기타 로직 사용)
 */
const normalizeUniversityType = (type?: string): '대학교' | '전문대학' | '기타' => {
  if (!type) return '기타'
  
  const normalized = type.trim()
  
  // 정확한 매칭 (고용24 + 커리어넷)
  if (normalized === '4년제' || normalized === '일반대' || normalized === '대학교') return '대학교'
  if (normalized === '전문대' || normalized === '전문대학' || normalized === '2년제') return '전문대학'
  
  // 패턴 매칭
  const lower = normalized.toLowerCase()
  if (lower.includes('4년') || lower.includes('일반')) return '대학교'
  if (lower.includes('전문') || lower.includes('2년')) return '전문대학'
  
  // 기타
  return '기타'
}

/**
 * 지역별 + 유형별 대학 집계
 */
interface UniversityByRegionAndType {
  universities: UnifiedMajorDetail['universities']
  regular: UnifiedMajorDetail['universities']  // 대학교(4년제)
  college: UnifiedMajorDetail['universities']  // 전문대학
  regionCounts: Record<string, { regular: number; college: number }>
}

const aggregateUniversitiesByRegion = (universities?: UnifiedMajorDetail['universities']): UniversityByRegionAndType => {
  const result: UniversityByRegionAndType = {
    universities: universities || [],
    regular: [],
    college: [],
    regionCounts: {}
  }
  
  if (!universities || universities.length === 0) {
    return result
  }
  
  let skippedCount = 0
  let processedCount = 0
  
  universities.forEach(uni => {
    // Area가 없는 대학은 제외
    if (!uni.area) {
      skippedCount++
      return
    }
    
    processedCount++
    
    const uniType = normalizeUniversityType(uni.universityType)
    const region = normalizeRegionName(uni.area)
    
    if (!region) return
    
    // 지역별 카운트 초기화
    if (!result.regionCounts[region]) {
      result.regionCounts[region] = { regular: 0, college: 0 }
    }
    
    // 유형별 분류
    if (uniType === '대학교') {
      if (result.regular) result.regular.push(uni)
      result.regionCounts[region].regular++
    } else if (uniType === '전문대학') {
      if (result.college) result.college.push(uni)
      result.regionCounts[region].college++
    }
  })
  
  return result
}

/**
 * 대학 목록 렌더링 (단일 카드)
 */
const renderUniversityList = (universities: UnifiedMajorDetail['universities'], emptyMessage?: string): string => {
  if (!universities || universities.length === 0) {
    return `<p class="text-sm text-wiki-muted text-center py-8">${emptyMessage || '개설 대학 정보가 없습니다.'}</p>`
  }
  
  const items = universities
    .filter((uni) => !!uni?.name?.trim())
    .map((uni) => {
      const name = escapeHtml(uni.name!.trim())
      const area = uni.area ? `<span class="text-[10px] text-wiki-muted">${escapeHtml(normalizeRegionName(uni.area))}</span>` : ''
      const department = uni.department ? `<p class="text-xs text-wiki-muted mt-1">${escapeHtml(uni.department)}</p>` : ''
      const type = uni.universityType ? `<span class="px-2 py-1 text-[10px] rounded bg-wiki-primary/10 text-wiki-primary">${escapeHtml(uni.universityType)}</span>` : ''
      const link = uni.url
        ? `<a href="${escapeHtml(uni.url)}" target="_blank" rel="noopener" class="text-xs text-wiki-primary hover:text-wiki-secondary flex items-center gap-1">웹사이트<i class="fas fa-arrow-up-right-from-square"></i></a>`
        : ''
      // 지역 정규화: area가 있으면 정규화, 없으면 대학명에서 추론
      let regionName = normalizeRegionName(uni.area)
      if (!regionName && uni.name) {
        regionName = inferRegionFromUniversityName(uni.name) || ''
      }
      // 여전히 없으면 "기타" (지도에 표시되지 않지만 필터링은 작동)
      const finalRegion = regionName || '기타'
      
      return `
        <div class="bg-wiki-bg/60 border border-wiki-border rounded-lg px-3 py-4 md:px-4 university-card hover:border-wiki-primary/40 hover:bg-wiki-bg/80 transition-all duration-200" data-region="${escapeHtml(finalRegion)}">
          <div class="flex items-center justify-between gap-2 mb-2">
            <div class="flex items-center gap-2 flex-wrap">
              <h4 class="content-text font-semibold text-wiki-text">${name}</h4>
              ${area}
            </div>
            ${type}
          </div>
          ${department}
          ${link ? `<div class="mt-2">${link}</div>` : ''}
        </div>
      `
    })
  
  if (items.length === 0) {
    return `<p class="text-sm text-wiki-muted text-center py-8">${emptyMessage || '개설 대학 정보가 없습니다.'}</p>`
  }
  
  return `<div class="grid gap-4 sm:grid-cols-2">${items.join('')}</div>`
}

/**
 * 메인 개설 대학 렌더링 (탭 + 지도 + 목록)
 */
const renderUniversities = (universities?: UnifiedMajorDetail['universities']): string => {
  if (!universities || universities.length === 0) {
    return ''
  }
  
  const aggregated = aggregateUniversitiesByRegion(universities)
  
  // 지역 데이터 생성 (지도용)
  const regularRegions: RegionData[] = Object.entries(aggregated.regionCounts)
    .map(([id, counts]) => ({ id, name: id, count: counts.regular }))
  
  const collegeRegions: RegionData[] = Object.entries(aggregated.regionCounts)
    .map(([id, counts]) => ({ id, name: id, count: counts.college }))
  
  // 대학교 탭 컨텐츠
  const regularMapHtml = renderKoreaMap({ regions: regularRegions })
  const regularListHtml = renderUniversityList(aggregated.regular, '4년제 대학 정보가 없습니다.')
  
  const regularTabContent = `
    <div class="space-y-6">
      <!-- 지역별 분포 지도 -->
      <div class="bg-wiki-bg/30 border border-wiki-border/50 rounded-xl p-4 md:p-6 shadow-lg">
        <h4 class="text-sm md:text-base font-bold text-wiki-text mb-4 flex items-center gap-2">
          <i class="fas fa-map text-wiki-primary text-base"></i>
          지역별 분포
        </h4>
        ${regularMapHtml}
        <div class="flex items-center justify-center gap-2 mt-4 px-2">
          <i class="fas fa-info-circle text-wiki-primary/60 text-xs"></i>
          <p class="text-xs text-wiki-muted text-center">지역을 클릭하면 해당 지역의 대학만 표시됩니다</p>
        </div>
        <div class="flex justify-center mt-3">
          <button type="button" class="reset-region-filter px-4 py-2 text-xs bg-wiki-primary/10 text-wiki-primary rounded-lg hover:bg-wiki-primary/20 transition-all duration-200 flex items-center gap-2" style="display: none;">
            <i class="fas fa-times"></i>
            <span>필터 해제</span>
          </button>
        </div>
      </div>
      
      <!-- 대학 목록 -->
      <div class="university-list-container" data-tab-type="regular">
        ${regularListHtml}
      </div>
    </div>
  `
  
  // 전문대학 탭 컨텐츠
  const collegeMapHtml = renderKoreaMap({ regions: collegeRegions })
  const collegeListHtml = renderUniversityList(aggregated.college, '전문대학 정보가 없습니다.')
  
  const collegeTabContent = `
    <div class="space-y-6">
      <!-- 지역별 분포 지도 -->
      <div class="bg-wiki-bg/30 border border-wiki-border/50 rounded-xl p-4 md:p-6 shadow-lg">
        <h4 class="text-sm md:text-base font-bold text-wiki-text mb-4 flex items-center gap-2">
          <i class="fas fa-map text-wiki-primary text-base"></i>
          지역별 분포
        </h4>
        ${collegeMapHtml}
        <div class="flex items-center justify-center gap-2 mt-4 px-2">
          <i class="fas fa-info-circle text-wiki-primary/60 text-xs"></i>
          <p class="text-xs text-wiki-muted text-center">지역을 클릭하면 해당 지역의 대학만 표시됩니다</p>
        </div>
        <div class="flex justify-center mt-3">
          <button type="button" class="reset-region-filter px-4 py-2 text-xs bg-wiki-primary/10 text-wiki-primary rounded-lg hover:bg-wiki-primary/20 transition-all duration-200 flex items-center gap-2" style="display: none;">
            <i class="fas fa-times"></i>
            <span>필터 해제</span>
          </button>
        </div>
      </div>
      
      <!-- 대학 목록 -->
      <div class="university-list-container" data-tab-type="college">
        ${collegeListHtml}
      </div>
    </div>
  `
  
  // 서브탭 UI
  const hasRegular = (aggregated.regular?.length ?? 0) > 0
  const hasCollege = (aggregated.college?.length ?? 0) > 0
  
  if (!hasRegular && !hasCollege) {
    return `<p class="text-sm text-wiki-muted">개설 대학 정보가 없습니다.</p>`
  }
  
  // 공통 스타일과 스크립트
  const commonStyleAndScript = `
    <style>
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .university-card {
        animation: fadeIn 0.3s ease-in-out;
      }
      
      @media (max-width: 640px) {
        .korea-map-container svg {
          max-width: 100%;
        }
      }
    </style>
    
    <script>
      (function() {
        // 서브탭 전환
        const tabButtons = document.querySelectorAll('.uni-subtab-btn');
        const tabContents = document.querySelectorAll('.uni-subtab-content');
        
        tabButtons.forEach(btn => {
          btn.addEventListener('click', function() {
            const targetTab = this.getAttribute('data-subtab');
            
            // 모든 버튼/컨텐츠 비활성화
            tabButtons.forEach(b => {
              b.classList.remove('border-wiki-primary', 'text-wiki-text');
              b.classList.add('border-transparent', 'text-wiki-muted');
              b.setAttribute('aria-selected', 'false');
              // 배지 색상도 변경
              const badge = b.querySelector('span');
              if (badge) {
                badge.classList.remove('bg-wiki-primary/20', 'text-wiki-primary');
                badge.classList.add('bg-wiki-border/40', 'text-wiki-muted');
              }
            });
            tabContents.forEach(c => c.classList.add('hidden'));
            
            // 선택된 탭 활성화
            this.classList.remove('border-transparent', 'text-wiki-muted');
            this.classList.add('border-wiki-primary', 'text-wiki-text');
            this.setAttribute('aria-selected', 'true');
            // 배지 색상 변경
            const activeBadge = this.querySelector('span');
            if (activeBadge) {
              activeBadge.classList.remove('bg-wiki-border/40', 'text-wiki-muted');
              activeBadge.classList.add('bg-wiki-primary/20', 'text-wiki-primary');
            }
            
            const targetContent = document.querySelector('[data-subtab-content="' + targetTab + '"]');
            if (targetContent) {
              targetContent.classList.remove('hidden');
            }
          });
        });
        
        // 지역 클릭 필터링 (모든 경우 처리: 탭 1개 또는 2개)
        document.querySelectorAll('[data-korea-map]').forEach(mapWrapper => {
          // 항상 .uni-subtab-content 안에 있으므로 이것을 찾음
          const container = mapWrapper.closest('.uni-subtab-content');
          if (!container) return;
          
          const listContainer = container.querySelector('.university-list-container');
          const resetBtn = container.querySelector('.reset-region-filter');
          if (!listContainer || !resetBtn) return;
          
          let activeRegion = null;
          
          mapWrapper.querySelectorAll('.region li a').forEach(regionLink => {
            const region = regionLink.getAttribute('data-region');
            if (!region) return;
            
            regionLink.addEventListener('click', function(e) {
              e.preventDefault();
              
              // 데이터 없는 지역은 클릭 무시
              if (this.classList.contains('no-data')) return;
              
              // "전체" 버튼 클릭 시
              if (region === 'ALL') {
                activeRegion = null;
                resetBtn.style.display = 'none';
                mapWrapper.querySelectorAll('.region li a').forEach(link => {
                  link.classList.remove('active');
                });
                listContainer.querySelectorAll('.university-card').forEach(card => {
                  card.style.display = '';
                  card.style.animation = 'fadeIn 0.3s ease-in-out';
                });
                return;
              }
              
              // 같은 지역 재클릭 시
              if (activeRegion === region) {
                activeRegion = null;
                resetBtn.style.display = 'none';
                mapWrapper.querySelectorAll('.region li a').forEach(link => {
                  link.classList.remove('active');
                });
                listContainer.querySelectorAll('.university-card').forEach(card => {
                  card.style.display = '';
                  card.style.animation = 'fadeIn 0.3s ease-in-out';
                });
                return;
              }
              
              // 새 지역 선택
              activeRegion = region;
              resetBtn.style.display = 'block';
              
              mapWrapper.querySelectorAll('.region li a').forEach(link => {
                link.classList.remove('active');
              });
              this.classList.add('active');
              
              // 대학 카드 필터링
              listContainer.querySelectorAll('.university-card').forEach(card => {
                const cardRegion = card.getAttribute('data-region');
                if (cardRegion === region) {
                  card.style.display = '';
                  card.style.animation = 'fadeIn 0.3s ease-in-out';
                } else {
                  card.style.display = 'none';
                }
              });
            });
          });
          
          resetBtn.addEventListener('click', function() {
            activeRegion = null;
            this.style.display = 'none';
            mapWrapper.querySelectorAll('.region li a').forEach(link => {
              link.classList.remove('active');
            });
            listContainer.querySelectorAll('.university-card').forEach(card => {
              card.style.display = '';
              card.style.animation = 'fadeIn 0.3s ease-in-out';
            });
          });
        });
      })();
    </script>
  `
  
  // 전문대학만 있을 때: 전문대학 탭만 표시
  if (!hasRegular && hasCollege) {
    return `
      <div class="university-tabs-wrapper w-full">
        <!-- 서브 탭 네비게이션 -->
        <div class="flex gap-2 border-b border-wiki-border/50 mb-6" role="tablist">
          <button
            type="button"
            class="uni-subtab-btn w-full px-4 py-3 text-sm font-semibold text-wiki-text border-b-2 border-wiki-primary transition"
            data-subtab="college"
            role="tab"
            aria-selected="true"
          >
            <i class="fas fa-building mr-2"></i>
            전문대학
            <span class="ml-2 px-2 py-0.5 text-xs rounded-full bg-wiki-primary/20 text-wiki-primary">${aggregated.college?.length ?? 0}</span>
          </button>
        </div>
        
        <!-- 전문대학 탭 컨텐츠 -->
        <div class="uni-subtab-content" data-subtab-content="college">
          ${collegeTabContent}
        </div>
      </div>
      ${commonStyleAndScript}
    `
  }
  
  // 대학교만 있을 때: 대학교 탭만 표시
  if (hasRegular && !hasCollege) {
    return `
      <div class="university-tabs-wrapper w-full">
        <!-- 서브 탭 네비게이션 -->
        <div class="flex gap-2 border-b border-wiki-border/50 mb-6" role="tablist">
          <button
            type="button"
            class="uni-subtab-btn w-full px-4 py-3 text-sm font-semibold text-wiki-text border-b-2 border-wiki-primary transition"
            data-subtab="regular"
            role="tab"
            aria-selected="true"
          >
            <i class="fas fa-university mr-2"></i>
            대학교
            <span class="ml-2 px-2 py-0.5 text-xs rounded-full bg-wiki-primary/20 text-wiki-primary">${aggregated.regular?.length ?? 0}</span>
          </button>
        </div>
        
        <!-- 대학교 탭 컨텐츠 -->
        <div class="uni-subtab-content" data-subtab-content="regular">
          ${regularTabContent}
        </div>
      </div>
      ${commonStyleAndScript}
    `
  }
  
  // 둘 다 있을 때: 두 탭을 균등하게 나눔 (flex-1)
  return `
    <div class="university-tabs-wrapper w-full">
      <!-- 서브 탭 네비게이션 -->
      <div class="flex gap-2 border-b border-wiki-border/50 mb-6" role="tablist">
        <button
          type="button"
          class="uni-subtab-btn flex-1 px-4 py-3 text-sm font-semibold text-wiki-text border-b-2 border-wiki-primary transition"
          data-subtab="regular"
          role="tab"
          aria-selected="true"
        >
          <i class="fas fa-university mr-2"></i>
          대학교
          <span class="ml-2 px-2 py-0.5 text-xs rounded-full bg-wiki-primary/20 text-wiki-primary">${aggregated.regular?.length ?? 0}</span>
        </button>
        <button
          type="button"
          class="uni-subtab-btn flex-1 px-4 py-3 text-sm font-semibold text-wiki-muted border-b-2 border-transparent hover:text-wiki-text transition"
          data-subtab="college"
          role="tab"
          aria-selected="false"
        >
          <i class="fas fa-building mr-2"></i>
          전문대학
          <span class="ml-2 px-2 py-0.5 text-xs rounded-full bg-wiki-border/40 text-wiki-muted">${aggregated.college?.length ?? 0}</span>
        </button>
      </div>
      
      <!-- 대학교 탭 컨텐츠 -->
      <div class="uni-subtab-content" data-subtab-content="regular">
        ${regularTabContent}
      </div>
      
      <!-- 전문대학 탭 컨텐츠 -->
      <div class="uni-subtab-content hidden" data-subtab-content="college">
        ${collegeTabContent}
      </div>
    </div>
    ${commonStyleAndScript}
  `
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
    profile.salaryAfterGraduation ? { label: '졸업 후 평균 월봉', value: profile.salaryAfterGraduation, icon: 'fa-coins', accent: 'text-yellow-300' } : null,
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

  // 1. 히어로 요약: 커리어넷 우선, 없으면 고용24 사용
  const careernetSummary = partials?.CAREERNET?.summary
  const goyong24Summary = partials?.GOYONG24?.summary
  const heroDescription = (careernetSummary || goyong24Summary || profile.summary)?.split('\n')[0]?.trim()
  
  const heroImage = renderHeroImage(profile.name, { dataAttribute: 'data-major-hero-image', context: 'major' })

  const overviewCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushOverviewCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('overview', label)
    overviewCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }

  // 1. 전공 개요: 고용24만 사용, 둘 다 있으면 개요에만 표시 (히어로와 중복 방지)
  const hasCareernetOnly = careernetSummary && !goyong24Summary
  const hasGoyong24Only = goyong24Summary && !careernetSummary
  const hasBothSummaries = careernetSummary && goyong24Summary
  
  if (goyong24Summary?.trim()) {
    pushOverviewCard('전공 개요', 'fa-circle-info', formatRichText(goyong24Summary))
  } else if (hasCareernetOnly && profile.summary?.trim()) {
    // 커리어넷만 있으면 이미 히어로에 표시되었으므로 개요에는 표시하지 않음
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
      .filter(item => item && (item.gradeuate || (item as any).field_name))
      .map(item => {
        const itemAny = item as any
        const name = item.gradeuate || itemAny.field_name || ''
        const desc = item.description || itemAny.field_description || ''
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

  // 4. 핵심 지표 - salary, employment, salaryAfterGraduation, employmentRate
  // 일부 필드는 타입 정의에 없지만 실제 데이터에 존재할 수 있음
  const profileAny = profile as any
  const careernetSalary = (partials?.CAREERNET as any)?.salary
  const goyong24Salary = (partials?.GOYONG24 as any)?.salary
  const careernetEmployment = (partials?.CAREERNET as any)?.employment
  const goyong24Employment = (partials?.GOYONG24 as any)?.employment
  
  const hasAnyMetrics = profileAny.salary || profile.salaryAfterGraduation || profileAny.employment || profile.employmentRate
  
  if (hasAnyMetrics) {
    const metaItems: string[] = []
    
    // salary와 salaryAfterGraduation 비교하여 같으면 salary만 표시
    const salaryValue = profileAny.salary
    const salaryAfterValue = profile.salaryAfterGraduation
    
    const isSameSalary = salaryValue && salaryAfterValue && 
      salaryValue.replace(/<[^>]*>/g, '').trim() === salaryAfterValue.replace(/<[^>]*>/g, '').trim()
    
    if (salaryValue && !isSameSalary) {
      let salaryText = salaryValue.replace(/<[^>]*>/g, '').trim()
      if (/^\d+(\.\d+)?$/.test(salaryText)) {
        salaryText = `${salaryText}만원`
      }
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 첫 직장 평균 임금(월)</span><span class="text-wiki-text font-semibold">${escapeHtml(salaryText)}</span></li>`)
    }
    
    if (salaryAfterValue && (!salaryValue || !isSameSalary)) {
      let salaryText = salaryAfterValue.replace(/<[^>]*>/g, '').trim()
      if (/^\d+(\.\d+)?$/.test(salaryText)) {
        salaryText = `${salaryText}만원`
      }
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 평균 월봉</span><span class="text-wiki-text font-semibold">${escapeHtml(salaryText)}</span></li>`)
    }
    
    if (isSameSalary && salaryValue) {
      let salaryText = salaryValue.replace(/<[^>]*>/g, '').trim()
      if (/^\d+(\.\d+)?$/.test(salaryText)) {
        salaryText = `${salaryText}만원`
      }
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">졸업 후 첫 직장 평균 임금(월)</span><span class="text-wiki-text font-semibold">${escapeHtml(salaryText)}</span></li>`)
    }
    
    if (profileAny.employment) {
      const empText = profileAny.employment.replace(/<strong>([^<]+)<\/strong>/g, '<strong class="text-white font-bold">$1</strong>')
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${empText}</span></li>`)
    }
    
    if (profile.employmentRate && profile.employmentRate !== profileAny.employment) {
      const rateText = profile.employmentRate.replace(/<strong>([^<]+)<\/strong>/g, '<strong class="text-white font-bold">$1</strong>')
      metaItems.push(`<li class="flex justify-between content-text"><span class="text-wiki-muted">취업률</span><span class="text-wiki-text">${rateText}</span></li>`)
    }
    
    if (metaItems.length > 0) {
      pushOverviewCard('핵심 지표', 'fa-gauge-high', `<ul class="space-y-2">${metaItems.join('')}</ul>`)
    }
  }

  const overviewContent = overviewCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('overview', '목차', overviewCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${overviewCards.map((card) => card.markup).join('')}
      </div>`
    : `<p class="text-sm text-wiki-muted">개요 정보가 준비 중입니다.</p>`
  
  // 2. 적성 리스트 (lstMiddleAptd, lstHighAptd) 제거됨 - 사용자 요청
  
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

  // 5. 상세정보 탭 순서 재구성
  const learningCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushLearningCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('curriculum', label)
    learningCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }
  
  // 1) 하는 공부 (whatStudy)
  if (profile.whatStudy?.trim()) {
    pushLearningCard('하는 공부', 'fa-graduation-cap', formatRichText(profile.whatStudy))
  }
  
  // 2) 준비 방법 (howPrepare)
  if (profile.howPrepare?.trim()) {
    pushLearningCard('준비 방법', 'fa-route', formatRichText(profile.howPrepare))
  }
  
  // 3) 주요 교과목 (mainSubjects - 기초/심화 구분)
  const subjectSections: string[] = []
  
  // 기초과목과 심화과목 분리 (mainSubjects가 있는 경우에만)
  if (profile.mainSubjects?.length) {
    let basicSubjects: string[] = []
    let advancedSubjects: string[] = []
    
    // ‡ 구분자가 있는 뭉텅이 데이터 파싱
    const firstSubject = profile.mainSubjects[0]
    if (firstSubject && firstSubject.includes('‡')) {
      const sections = firstSubject.split('‡').filter(s => s.trim())
      
      sections.forEach(section => {
        if (section.includes('기초과목')) {
          // "기초과목 : 심리학, 해부학, ..." 형식에서 과목들 추출
          const subjects = section.replace(/^.*?기초과목\s*[:：]\s*/i, '')
            .split(/[,、]\s*/)
            .map(s => s.trim())
            .filter(s => s && s !== '등')
          basicSubjects.push(...subjects)
        } else if (section.includes('심화과목')) {
          // "심화과목 : 임상미생물학, ..." 형식에서 과목들 추출
          const subjects = section.replace(/^.*?심화과목\s*[:：]\s*/i, '')
            .split(/[,、]\s*/)
            .map(s => s.trim())
            .filter(s => s && s !== '등')
          advancedSubjects.push(...subjects)
        }
      })
    } else {
      // 기존 로직: 배열로 들어온 경우
      basicSubjects = profile.mainSubjects.filter(s => s && (s.includes('기초') || s.includes('입문')))
      advancedSubjects = profile.mainSubjects.filter(s => s && !(s.includes('기초') || s.includes('입문')))
    }
    
    if (basicSubjects.length > 0) {
      subjectSections.push(`
        <div class="mb-6">
          <h4 class="text-base font-bold text-wiki-secondary mb-3 flex items-center gap-2">
            <span class="flex h-8 w-8 items-center justify-center rounded-full bg-blue-500/15 text-blue-400">
              <i class="fas fa-seedling text-xs"></i>
            </span>
            기초 과목
          </h4>
          <div class="flex flex-wrap gap-2">
            ${basicSubjects.map(subj => `<span class="inline-flex items-center gap-1.5 px-3 py-2 bg-blue-500/10 border border-blue-500/20 rounded-lg text-sm text-blue-300 font-medium">${escapeHtml(subj)}</span>`).join('')}
          </div>
        </div>
      `)
    }
    
    if (advancedSubjects.length > 0) {
      subjectSections.push(`
        <div class="mb-6">
          <h4 class="text-base font-bold text-wiki-secondary mb-3 flex items-center gap-2">
            <span class="flex h-8 w-8 items-center justify-center rounded-full bg-purple-500/15 text-purple-400">
              <i class="fas fa-rocket text-xs"></i>
            </span>
            심화 과목
          </h4>
          <div class="flex flex-wrap gap-2">
            ${advancedSubjects.map(subj => `<span class="inline-flex items-center gap-1.5 px-3 py-2 bg-purple-500/10 border border-purple-500/20 rounded-lg text-sm text-purple-300 font-medium">${escapeHtml(subj)}</span>`).join('')}
          </div>
        </div>
      `)
    }
  }
  
  // 서브섹션: 대학 주요 교과목 상세 (독립적으로 체크)
  // JSON 문자열인 경우 파싱 (카멜케이스와 스네이크케이스 모두 지원)
  let mainSubjectArray = profile.mainSubject || (profile as any).main_subject
  if (typeof mainSubjectArray === 'string') {
    try {
      mainSubjectArray = JSON.parse(mainSubjectArray)
    } catch (e) {
      mainSubjectArray = []
    }
  }
  
  if (mainSubjectArray && Array.isArray(mainSubjectArray) && mainSubjectArray.length > 0) {
      const detailItems = mainSubjectArray
        .filter(item => item && (item.SBJECT_NM || item.subject_name || item.SUBJECT_NM))
        .map(item => {
          const name = item.SBJECT_NM || item.subject_name || item.SUBJECT_NM || ''
          const desc = item.SBJECT_SUMRY || item.subject_description || item.SUBJECT_SUMRY || ''
          return `
            <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-primary/40 transition-colors">
              <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
                <i class="fas fa-book-open text-wiki-primary text-xs"></i>
                ${escapeHtml(name)}
              </h5>
              ${desc ? `<p class="text-sm text-wiki-muted leading-relaxed">${escapeHtml(desc)}</p>` : ''}
            </div>
          `
        })
        .join('')
      
      if (detailItems) {
        subjectSections.push(`
          <div class="mt-6">
            <h4 class="text-base font-bold text-wiki-secondary mb-4 flex items-center gap-2">
              <span class="flex h-8 w-8 items-center justify-center rounded-full bg-wiki-primary/15 text-wiki-primary">
                <i class="fas fa-graduation-cap text-xs"></i>
              </span>
              대학 주요 교과목 상세
            </h4>
            <div class="grid gap-3">
              ${detailItems}
            </div>
          </div>
        `)
      }
    }
    
  // 서브섹션: 고교 추천 교과목 (독립적으로 체크)
  // JSON 문자열인 경우 파싱 (카멜케이스와 스네이크케이스 모두 지원)
  let relateSubjectArray = profile.relateSubject || (profile as any).relate_subject
  if (typeof relateSubjectArray === 'string') {
    try {
      relateSubjectArray = JSON.parse(relateSubjectArray)
    } catch (e) {
      relateSubjectArray = []
    }
  }
  
  if (relateSubjectArray && Array.isArray(relateSubjectArray) && relateSubjectArray.length > 0) {
    const highSchoolItems = relateSubjectArray
      .filter(item => item && (item.subject_name || item.SUBJECT_NM))
      .map(item => {
        const name = item.subject_name || item.SUBJECT_NM || ''
        let desc = item.subject_description || item.SUBJECT_SUMRY || ''
        
        // 고교 추천 교과목: <br>을 줄바꿈(\n)으로 변환 후 formatRichText 적용
        if (desc) {
          desc = desc
            .replace(/<br\s*\/?>/gi, '\n')  // <br> → 줄바꿈
            .replace(/&lt;br\s*\/?&gt;/gi, '\n')  // &lt;br&gt; → 줄바꿈
        }
        
        return `
          <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-secondary/40 transition-colors">
            <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
              <i class="fas fa-school text-wiki-secondary text-xs"></i>
              ${escapeHtml(name)}
            </h5>
            ${desc ? `<p class="text-sm text-wiki-muted leading-relaxed">${formatRichText(desc)}</p>` : ''}
          </div>
        `
      })
      .join('')
    
    if (highSchoolItems) {
      subjectSections.push(`
        <div class="mt-6">
          <h4 class="text-base font-bold text-wiki-secondary mb-4 flex items-center gap-2">
            <span class="flex h-8 w-8 items-center justify-center rounded-full bg-wiki-secondary/15 text-wiki-secondary">
              <i class="fas fa-school text-xs"></i>
            </span>
            고교 추천 교과목
          </h4>
          <div class="grid gap-3">
            ${highSchoolItems}
          </div>
        </div>
      `)
    }
  }
  
  // 주요 교과목 카드 생성 (서브섹션이 하나라도 있으면)
  if (subjectSections.length > 0) {
    pushLearningCard('주요 교과목', 'fa-book-open', subjectSections.join(''))
  }
  
  // 6) 진로 전망 (jobProspect) - 상세정보 탭으로 이동
  if (profile.jobProspect?.trim()) {
    pushLearningCard('진로 전망', 'fa-chart-line', formatRichText(profile.jobProspect))
  }
  
  // 7) 진로 탐색 활동 (careerAct)
  // JSON 문자열인 경우 파싱 (카멜케이스와 스네이크케이스 모두 지원)
  let careerActArray = profile.careerAct || (profile as any).career_act
  if (typeof careerActArray === 'string') {
    try {
      careerActArray = JSON.parse(careerActArray)
    } catch (e) {
      careerActArray = []
    }
  }
  
  if (careerActArray && Array.isArray(careerActArray) && careerActArray.length > 0) {
    const actItems = careerActArray
      .filter(item => item && (item.act_name || item.ACT_NM))
      .map(item => {
        let name = item.act_name || item.ACT_NM || ''
        let desc = item.act_description || item.ACT_SUMRY || ''
        
        // 진로 탐색 활동: name과 desc 모두 <br> 태그 제거
        if (name) {
          name = name
            .replace(/<br\s*\/?>/gi, ' ')  // <br>, <br/>, <br /> 제거
            .replace(/&lt;br\s*\/?&gt;/gi, ' ')  // &lt;br&gt; 제거
            .replace(/\s+/g, ' ')  // 연속된 공백 하나로
            .trim()
        }
        
        if (desc) {
          desc = desc
            .replace(/<br\s*\/?>/gi, ' ')  // <br>, <br/>, <br /> 제거
            .replace(/&lt;br\s*\/?&gt;/gi, ' ')  // &lt;br&gt; 제거
            .replace(/\s+/g, ' ')  // 연속된 공백 하나로
            .trim()
        }
        
        return `
          <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-primary/40 transition-colors">
            <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
              <i class="fas fa-compass text-wiki-primary text-xs"></i>
              ${escapeHtml(name)}
            </h5>
            ${desc ? `<p class="text-sm text-wiki-muted leading-relaxed">${escapeHtml(desc)}</p>` : ''}
          </div>
        `
      })
      .join('')
    if (actItems) {
      pushLearningCard('진로 탐색 활동', 'fa-compass', `<div class="grid gap-3">${actItems}</div>`)
    }
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

  // jobProspect는 상세정보 탭으로 이동됨
  
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
    pushUniversityCard('대학정보', 'fa-building-columns', universitiesContent)
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

  // 추천 유사 전공은 히어로 태그로 이동됨 - 상세정보에서 제거

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
    { id: 'universities', label: '대학정보', icon: 'fa-building-columns', content: universityContent }
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

  // 관련 직업 (5개 이상일 때 접기/펼치기)
  if (profile.relatedJobs?.length) {
    const limit = 5
    const hasMore = profile.relatedJobs.length > limit
    const visibleJobs = profile.relatedJobs.slice(0, limit)
    const hiddenJobs = profile.relatedJobs.slice(limit)
    
    const renderJob = (jobName: string, isHidden: boolean = false) => `
      <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
        <a href="/search?q=${encodeURIComponent(jobName)}&type=job" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
          <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
            <i class="fas fa-briefcase text-xs" aria-hidden="true"></i>
          </span>
          <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${escapeHtml(jobName)}</span>
          <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
        </a>
      </li>
    `
    
    const jobsList = [
      ...visibleJobs.map(job => renderJob(job, false)),
      ...hiddenJobs.map(job => renderJob(job, true))
    ].join('')
    
    const toggleButton = hasMore ? `
      <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
        <span class="toggle-text">더보기</span>
        <span class="toggle-count text-xs opacity-75">(+${hiddenJobs.length})</span>
        <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
      </button>
    ` : ''
    
    sidebarSections.push(renderSidebarSection('관련 직업', 'fa-briefcase', `
      <div class="expandable-list">
        <ul class="space-y-2" role="list">${jobsList}</ul>
        ${toggleButton}
      </div>
    `))
  }

  // 7. 추천 자격증 (계층 구조로 표시)
  const careernetLicenses = partials?.CAREERNET?.licenses || profile.licenses || []
  const goyong24Licenses = partials?.GOYONG24?.licenses || []
  
  // 병합 및 자격증 파싱 (계층 구조 유지, 중복 제거)
  const allLicenses = [...careernetLicenses, ...goyong24Licenses]
  const licenseMap = new Map<string, string[]>() // name -> subLicenses
  
  // '등'과 같은 불필요한 접미사를 필터링하는 함수
  const isValidLicense = (text: string): boolean => {
    if (!text || !text.trim()) return false
    const trimmed = text.trim()
    // '등', '등등' 같은 일반적인 접미사 필터링
    if (/^등+$/.test(trimmed)) return false
    return true
  }
  
  allLicenses.forEach(license => {
    if (!license || typeof license !== 'string' || !license.trim()) return
    
    let text = license.trim()
    
    // "국가자격 :", "민간자격 :" 등의 prefix 제거
    text = text.replace(/^(국가자격|민간자격|공인자격|기타자격)\s*[:：]\s*/i, '')
    
    // 괄호가 있는 항목 처리: "전문간호사(A, B, C)" → { name: "전문간호사", subLicenses: ["A", "B", "C"] }
    const bracketMatches = text.match(/([^(,]+)\(([^)]+)\)/g)
    if (bracketMatches) {
      bracketMatches.forEach(match => {
        const [, prefix, inner] = match.match(/([^(]+)\(([^)]+)\)/) || []
        if (prefix?.trim() && isValidLicense(prefix.trim())) {
          const name = prefix.trim()
          const subLicenses = inner
            ? inner.split(/[,、]/).map(s => s.trim()).filter(s => isValidLicense(s))
            : []
          
          // 중복 처리: 이미 있으면 서브 자격증 병합
          if (licenseMap.has(name)) {
            const existing = licenseMap.get(name) || []
            const merged = Array.from(new Set([...existing, ...subLicenses]))
            licenseMap.set(name, merged)
          } else {
            licenseMap.set(name, subLicenses)
          }
        }
        // 원본에서 제거
        text = text.replace(match, '')
      })
    }
    
    // 나머지를 쉼표로 분리 (서브 자격증 없음)
    text.split(/[,、]/).forEach(item => {
      const trimmed = item.trim()
      if (isValidLicense(trimmed) && !licenseMap.has(trimmed)) {
        licenseMap.set(trimmed, [])
      }
    })
  })
  
  // Map을 배열로 변환
  const parsedLicenses = Array.from(licenseMap.entries()).map(([name, subLicenses]) => ({
    name,
    subLicenses: subLicenses.length > 0 ? subLicenses : undefined
  }))
  
  if (parsedLicenses.length > 0) {
    const limit = 5
    const hasMore = parsedLicenses.length > limit
    const visibleLicenses = parsedLicenses.slice(0, limit)
    const hiddenLicenses = parsedLicenses.slice(limit)
    
    const renderLicense = (licenseItem: { name: string; subLicenses?: string[] }, isHidden: boolean = false) => {
      const hasSubs = licenseItem.subLicenses && licenseItem.subLicenses.length > 0
      const subLimit = 3
      const visibleSubs = hasSubs ? licenseItem.subLicenses!.slice(0, subLimit) : []
      const hiddenSubs = hasSubs ? licenseItem.subLicenses!.slice(subLimit) : []
      const hasMoreSubs = hiddenSubs.length > 0
      
      const mainItem = `
        <div class="flex items-center gap-2.5 px-3 py-2 rounded-lg bg-wiki-bg/40 border border-wiki-border/40 hover:border-wiki-primary/40 hover:bg-wiki-primary/5 transition-all duration-200">
          <span class="flex h-5 w-5 shrink-0 items-center justify-center rounded-full bg-wiki-primary/15 text-wiki-primary">
            <i class="fas fa-certificate text-[9px]" aria-hidden="true"></i>
          </span>
          <span class="text-sm text-wiki-text font-medium">${escapeHtml(licenseItem.name)}</span>
        </div>
      `
      
      let subItems = ''
      if (hasSubs) {
        const subList = visibleSubs.map(sub => `
          <li class="sub-license-item">
            <div class="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-wiki-bg/20 border border-wiki-border/30 hover:border-wiki-secondary/30 hover:bg-wiki-secondary/5 transition-all duration-200">
              <span class="flex h-4 w-4 shrink-0 items-center justify-center rounded-full bg-wiki-secondary/10 text-wiki-secondary">
                <i class="fas fa-circle text-[6px]" aria-hidden="true"></i>
              </span>
              <span class="text-xs text-wiki-muted font-medium">${escapeHtml(sub)}</span>
            </div>
          </li>
        `).join('')
        
        const hiddenSubList = hiddenSubs.map(sub => `
          <li class="sub-license-item hidden-sub-item" style="display: none;">
            <div class="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-wiki-bg/20 border border-wiki-border/30 hover:border-wiki-secondary/30 hover:bg-wiki-secondary/5 transition-all duration-200">
              <span class="flex h-4 w-4 shrink-0 items-center justify-center rounded-full bg-wiki-secondary/10 text-wiki-secondary">
                <i class="fas fa-circle text-[6px]" aria-hidden="true"></i>
              </span>
              <span class="text-xs text-wiki-muted font-medium">${escapeHtml(sub)}</span>
            </div>
          </li>
        `).join('')
        
        const subToggle = hasMoreSubs ? `
          <button class="sub-expand-toggle ml-7 mt-1 px-2 py-1 rounded text-xs text-wiki-secondary hover:text-wiki-secondary/80 transition-colors flex items-center gap-1" data-expanded="false">
            <span class="sub-toggle-text">+${hiddenSubs.length}개 더보기</span>
            <i class="fas fa-chevron-down text-[8px] sub-toggle-icon transition-transform"></i>
          </button>
        ` : ''
        
        subItems = `
          <ul class="ml-7 mt-1.5 space-y-1" role="list">
            ${subList}
            ${hiddenSubList}
          </ul>
          ${subToggle}
        `
      }
      
      return `
        <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
          ${mainItem}
          ${subItems}
        </li>
      `
    }
    
    const licensesList = [
      ...visibleLicenses.map(lic => renderLicense(lic, false)),
      ...hiddenLicenses.map(lic => renderLicense(lic, true))
    ].join('')
    
    const toggleButton = hasMore ? `
      <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
        <span class="toggle-text">더보기</span>
        <span class="toggle-count text-xs opacity-75">(+${hiddenLicenses.length})</span>
        <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
      </button>
    ` : ''
    
    sidebarSections.push(renderSidebarSection('추천 자격증', 'fa-certificate', `
      <div class="expandable-list">
        <ul class="space-y-2" role="list">${licensesList}</ul>
        ${toggleButton}
      </div>
    `))
  }

  const hasSidebar = sidebarSections.length > 0
  const sidebarContent = sidebarSections.join('')

  // 데이터 출처 collapsible (직업 템플릿과 동일)
  const sourcesCollapsible = renderMajorSourcesCollapsible(profile, sources, partials)

  const sourcesBlock = sourcesCollapsible
    ? `<div data-major-sources>${sourcesCollapsible}</div>`
    : ''

  const communityBlock = `<div data-major-community>${commentsPlaceholder}</div>`

  // 6. 히어로 태그: 추천 유사 전공 (department + relatedMajors 병합, 중복 제거)
  const careernetRelated = partials?.CAREERNET?.relatedMajors || []
  const goyong24Related = partials?.GOYONG24?.relatedMajors || []
  
  // department 필드 추출 (universities에서)
  const allDepartments: string[] = []
  if (profile.universities && Array.isArray(profile.universities)) {
    profile.universities.forEach(uni => {
      if (uni.department && typeof uni.department === 'string' && uni.department.trim().length > 0) {
        allDepartments.push(uni.department.trim())
      }
    })
  }
  
  // 병합 및 중복 제거 (department + relatedMajors)
  const allRelatedMajors = [
    ...allDepartments,
    ...careernetRelated,
    ...goyong24Related,
    ...(profile.relatedMajors || [])
  ]
  const uniqueRelatedMajors = Array.from(new Set(
    allRelatedMajors
      .filter(m => m && typeof m === 'string' && m.trim().length > 0)
      .map(m => m.trim())
  ))
  
  const heroTags = uniqueRelatedMajors.slice(0, 10)  // 5개 → 10개로 증가

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
      
      <script>
        // 사이드바 접기/펼치기 기능
        (function() {
          // 메인 자격증 목록 토글
          const expandButtons = document.querySelectorAll('.expand-toggle');
          
          expandButtons.forEach(button => {
            button.addEventListener('click', function() {
              const container = this.closest('.expandable-list');
              const hiddenItems = container.querySelectorAll('.hidden-item');
              const isExpanded = this.getAttribute('data-expanded') === 'true';
              const toggleText = this.querySelector('.toggle-text');
              const toggleIcon = this.querySelector('.toggle-icon');
              const toggleCount = this.querySelector('.toggle-count');
              
              if (isExpanded) {
                // 접기
                hiddenItems.forEach(item => {
                  item.style.display = 'none';
                });
                toggleText.textContent = '더보기';
                toggleIcon.style.transform = 'rotate(0deg)';
                toggleCount.style.display = '';
                this.setAttribute('data-expanded', 'false');
              } else {
                // 펼치기
                hiddenItems.forEach(item => {
                  item.style.display = '';
                  item.style.animation = 'fadeIn 0.3s ease-in-out';
                });
                toggleText.textContent = '접기';
                toggleIcon.style.transform = 'rotate(180deg)';
                toggleCount.style.display = 'none';
                this.setAttribute('data-expanded', 'true');
              }
            });
          });
          
          // 서브 자격증 토글 (하위 3개씩 접기/펼치기)
          const subExpandButtons = document.querySelectorAll('.sub-expand-toggle');
          
          subExpandButtons.forEach(button => {
            button.addEventListener('click', function() {
              const parentLi = this.closest('li');
              const hiddenSubItems = parentLi.querySelectorAll('.hidden-sub-item');
              const isExpanded = this.getAttribute('data-expanded') === 'true';
              const toggleText = this.querySelector('.sub-toggle-text');
              const toggleIcon = this.querySelector('.sub-toggle-icon');
              
              if (isExpanded) {
                // 접기
                hiddenSubItems.forEach(item => {
                  item.style.display = 'none';
                });
                const count = hiddenSubItems.length;
                toggleText.textContent = '+' + count + '개 더보기';
                toggleIcon.style.transform = 'rotate(0deg)';
                this.setAttribute('data-expanded', 'false');
              } else {
                // 펼치기
                hiddenSubItems.forEach(item => {
                  item.style.display = '';
                  item.style.animation = 'fadeIn 0.3s ease-in-out';
                });
                toggleText.textContent = '접기';
                toggleIcon.style.transform = 'rotate(180deg)';
                this.setAttribute('data-expanded', 'true');
              }
            });
          });
        })();
      </script>
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

