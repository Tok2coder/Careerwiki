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
  renderAdSlot,
  sanitizeJson
} from './detailTemplateUtils'
import { composeDetailSlug } from '../utils/slug'
import { renderKoreaMap, normalizeRegionName, type RegionData } from '../components/koreaMap'
import { inferRegionFromUniversityName } from '../utils/universityRegionMapper'

export interface RelatedMajorItem {
  id: string
  name: string
  slug: string
}

export interface UnifiedMajorDetailTemplateParams {
  profile: UnifiedMajorDetail
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>
  sources?: SourceStatusRecord
  existingJobSlugs?: Map<string, string>  // 직업명 → slug 매핑 (DB에 존재하는 직업)
  relatedMajorsByCategory?: RelatedMajorItem[]  // 같은 계열 전공 (자기 자신 제외)
}

// 전공 템플릿용 데이터 출처 레이블 (직업 템플릿과 다름)
const SOURCE_LABELS: Partial<Record<DataSource, string>> = {
  ...DEFAULT_SOURCE_LABELS,
  CAREERNET: '커리어넷 학과정보',  // 직업백과 → 학과정보
  GOYONG24: '고용24 학과정보',     // 직업정보 → 학과정보
  WORK24_MAJOR: '고용24 학과정보'  // 전공용 소스
}

const SOURCE_DESCRIPTIONS: Partial<Record<DataSource, string>> = {
  CAREERNET: '교육부 산하 진로·진학 정보 플랫폼\n통합 데이터에 포함되었습니다.',
  GOYONG24: '고용노동부 고용24 학과 정보\n통합 데이터에 포함되었습니다.',
  WORK24_MAJOR: '고용노동부 고용24 학과 정보\n통합 데이터에 포함되었습니다.'
}

/**
 * 안전한 trim 함수 - undefined/null 체크
 */
const safeTrim = (value: any): string => {
  if (value === null || value === undefined) return ''
  if (typeof value !== 'string') return String(value).trim()
  return value.trim()
}

/**
 * 취업률 포맷 함수: "70% 이상" 같은 텍스트에서 숫자 추출 후 소수점 1자리까지 반올림
 */
const formatEmploymentRate = (rate: string | undefined): string | undefined => {
  if (!rate) return undefined
  const cleaned = rate.replace(/<[^>]*>/g, '').trim()
  const match = cleaned.match(/([\d.]+)/)
  if (!match) return cleaned
  const num = parseFloat(match[1])
  if (isNaN(num)) return cleaned
  const rounded = Math.round(num * 10) / 10
  return Number.isInteger(rounded) ? `${rounded}%` : `${rounded.toFixed(1)}%`
}

/**
 * chartData.employment_rate에서 정확한 취업률 추출 (전체 값 우선)
 * 없으면 employmentRate 필드를 폴백으로 사용
 */
const getAccurateEmploymentRate = (profile: UnifiedMajorDetail): string | undefined => {
  // chartData 정규화 (배열인 경우 첫 번째 요소 사용)
  let chartData = (profile as any).chartData
  if (Array.isArray(chartData)) {
    chartData = chartData[0]
  }
  
  // chartData.employment_rate에서 정확한 값 추출
  if (chartData?.employment_rate && Array.isArray(chartData.employment_rate)) {
    const totalItem = chartData.employment_rate.find((e: any) => e.item === '전체')
    if (totalItem?.data) {
      const rate = parseFloat(totalItem.data)
      if (!isNaN(rate)) {
        return Number.isInteger(rate) ? `${rate}%` : `${rate.toFixed(1)}%`
      }
    }
  }
  // 폴백: employmentRate 필드 (대략적인 값)
  if (profile.employmentRate) {
    return formatEmploymentRate(profile.employmentRate)
  }
  return undefined
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
      class="glass-card border px-4 py-6 md:px-6 rounded-2xl border-wiki-border/60 bg-wiki-bg/70"
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
    return ''  // 데이터 없으면 빈 문자열 반환
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
        <div class="bg-wiki-bg/60 border border-wiki-border rounded-lg px-4 py-4 md:px-4 university-card hover:border-wiki-primary/40 hover:bg-wiki-bg/80 transition-all duration-200" data-region="${escapeHtml(finalRegion)}">
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
    return ''  // 유효한 대학 없으면 빈 문자열 반환
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
    return ''  // 데이터 없으면 빈 문자열 반환 (탭 숨김)
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

// 숫자 포맷팅 (천 단위 구분 + '명' 붙이기)
const formatPersonCount = (num: string | number | undefined | null): string => {
  if (num === undefined || num === null || num === '-' || num === '') return '-'
  const n = typeof num === 'string' ? parseInt(num, 10) : num
  if (isNaN(n)) return '-'
  return n.toLocaleString('ko-KR') + '명'
}

const renderRecruitmentTable = (stats?: UnifiedMajorDetail['recruitmentStatus']): string => {
  if (!stats || stats.length === 0) {
    return ''
  }

  const rows = stats.map((row) => `
    <tr>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.year ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${escapeHtml(row.universityType ?? '-')}</td>
      <td class="px-4 py-3 text-wiki-text">${formatPersonCount(row.enrollmentQuota)}</td>
      <td class="px-4 py-3 text-wiki-text">${formatPersonCount(row.applicants)}</td>
      <td class="px-4 py-3 text-wiki-text">${formatPersonCount(row.graduates)}</td>
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
  const accurateEmploymentRate = getAccurateEmploymentRate(profile)
  const highlights = [
    accurateEmploymentRate ? { label: '취업률', value: accurateEmploymentRate, icon: 'fa-briefcase', accent: 'text-green-400' } : null,
    profile.salaryAfterGraduation ? { label: '졸업 후 평균 월급', value: profile.salaryAfterGraduation, icon: 'fa-coins', accent: 'text-yellow-300' } : null,
    profile.categoryName ? { label: '계열/분야', value: profile.categoryName, icon: 'fa-layer-group', accent: 'text-wiki-secondary' } : null
  ].filter(Boolean) as Array<{ label: string; value: string; icon: string; accent: string }>

  if (highlights.length === 0) return ''

  return `
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-6">
      ${highlights
        .map(
          (item) => `
            <div class="bg-wiki-bg/60 border border-wiki-border rounded-xl px-4 py-4 md:px-4">
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
  partials?: Partial<Record<DataSource, UnifiedMajorDetail | null>>,
  userSourcesFlat: Array<{ id: number; fieldKey: string; text: string; displayOrder?: number }> = []
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

  // 사용자가 추가한 출처 (_sources) - 직업 템플릿과 동일
  const userSources = (profile as any)._sources as Record<string, { id?: number; text?: string; url?: string }[] | { id?: number; text?: string; url?: string }> | undefined
  
  // 필드 키를 읽기 쉬운 레이블로 변환
  const fieldLabels: Record<string, string> = {
    'overview.summary': '전공 개요',
    'summary': '전공 설명',
    'property': '전공 특성',
    'aptitude': '이 전공에 어울리는 사람',
    'enterField': '졸업 후 진출 분야',
    'trivia': '여담',
    'whatStudy': '배우는 내용',
    'mainSubject': '주요 교과목',
    'relateSubject': '고교 추천 교과목',
    'careerAct': '진로 탐색 활동',
    'sidebarJobs': '관련 직업',
    'sidebarMajors': '관련 전공',
    'sidebarHowtos': '관련 HowTo'
  }
  
  // 사용자 출처 HTML 생성 (배열 지원)
  let userSourcesHtml = ''
  if (userSourcesFlat.length > 0) {
    const sourceItems: string[] = []
    userSourcesFlat.forEach((source) => {
      const fieldLabel = fieldLabels[source.fieldKey] || source.fieldKey
      sourceItems.push(`
        <li class="user-source-item p-3 border border-wiki-secondary/30 rounded-lg bg-wiki-secondary/5 transition cursor-pointer hover:border-wiki-secondary/50 hover:bg-wiki-secondary/10" 
            id="user-fn-${source.id}" 
            data-back-to="user-fnref-${source.id}"
            data-field-key="${escapeHtml(source.fieldKey)}">
          <div class="flex items-start gap-3">
            <span class="flex-shrink-0 w-6 h-6 rounded-full bg-wiki-secondary/20 text-wiki-secondary text-xs font-bold flex items-center justify-center">${source.id}</span>
            <div class="flex-1 text-sm">
              <span class="text-wiki-muted">[${escapeHtml(fieldLabel)}]</span>
              <span class="text-wiki-text ml-2">${escapeHtml(source.text)}</span>
            </div>
          </div>
        </li>
      `)
    })
    userSourcesHtml = sourceItems.join('')
  }

  const hasUserSources = userSourcesFlat.length > 0
  
  if (!panel || !safeTrim(panel)) {
    // API 출처가 없어도 사용자 출처가 있으면 표시
    if (!hasUserSources) {
      return ''
    }
  }

  const activeSourceCount = (partials ? Object.values(partials).filter((value) => Boolean(value)).length : 0) + userSourcesFlat.length
  const badgeLabel = activeSourceCount > 0 ? `${activeSourceCount}개` : '확인하기'

  const toggleId = `source-toggle-${normalizedId}`
  const iconId = `source-icon-${normalizedId}`

  // 사용자 출처 섹션
  const userSourcesSection = hasUserSources ? `
    <div class="mt-6 pt-4 border-t border-wiki-border/40">
      <h4 class="text-sm font-semibold text-wiki-text mb-3 flex items-center gap-2">
        <i class="fas fa-user-edit text-wiki-secondary"></i>
        사용자 추가 출처
      </h4>
      <ol class="space-y-2">
        ${userSourcesHtml}
      </ol>
    </div>
  ` : ''

  return `
    <section class="glass-card p-0 rounded-2xl border border-wiki-border/60 bg-wiki-bg/50" data-source-collapsible>
      <button
        type="button"
        id="${toggleId}"
        class="w-full flex items-center justify-between gap-3 px-4 py-4 md:px-6 md:py-5 content-text font-semibold text-white transition hover:text-wiki-secondary cursor-pointer"
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
        ${panel || ''}
        ${userSourcesSection}
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
        
        // 사용자 출처 클릭 시 해당 필드로 이동
        document.querySelectorAll('.user-source-item').forEach(function(item) {
          item.addEventListener('click', function() {
            const backTo = this.getAttribute('data-back-to');
            const fieldKey = this.getAttribute('data-field-key');
            if (backTo) {
              const targetEl = document.getElementById(backTo);
              if (targetEl) {
                // 탭 전환이 필요한지 확인
                let targetTabId = 'overview';
                if (fieldKey && (fieldKey.startsWith('what') || fieldKey.startsWith('main') || fieldKey.startsWith('relate') || fieldKey.startsWith('career'))) {
                  targetTabId = 'details';
                }
                
                // 현재 활성 탭 확인
                const activeTab = document.querySelector('[data-major-tab-btn][aria-selected="true"]');
                const currentTabId = activeTab?.getAttribute('data-target');
                
                if (currentTabId !== targetTabId) {
                  // 탭 전환
                  const targetTabBtn = document.querySelector('[data-major-tab-btn][data-target="' + targetTabId + '"]');
                  if (targetTabBtn) {
                    targetTabBtn.click();
                  }
                }
                
                // 스크롤 이동
                setTimeout(function() {
                  targetEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 100);
              }
            }
          });
        });
        
        // 데이터 출처 하이라이트 기능 (배타적 + 토글 방식)
        (function() {
          var activeSource = null;
          var sourceColors = {
            'CAREERNET': { bg: 'rgba(59, 130, 246, 0.08)', border: 'rgba(59, 130, 246, 0.3)' },
            'GOYONG24': { bg: 'rgba(34, 197, 94, 0.08)', border: 'rgba(34, 197, 94, 0.3)' },
            'WORK24_MAJOR': { bg: 'rgba(34, 197, 94, 0.08)', border: 'rgba(34, 197, 94, 0.3)' }
          };
          
          function clearAllHighlights() {
            document.querySelectorAll('[data-source]').forEach(function(el) {
              el.style.backgroundColor = '';
              el.style.boxShadow = '';
              el.classList.remove('source-highlighted');
            });
            document.querySelectorAll('[data-source-entry]').forEach(function(el) {
              el.classList.remove('ring-2', 'ring-wiki-primary');
            });
          }
          
          function highlightSource(source) {
            var color = sourceColors[source];
            if (!color) return;
            
            document.querySelectorAll('[data-source]').forEach(function(el) {
              var sources = (el.getAttribute('data-source') || '').split(',');
              if (sources.indexOf(source) !== -1) {
                el.style.backgroundColor = color.bg;
                el.style.boxShadow = 'inset 0 0 0 1px ' + color.border;
                el.classList.add('source-highlighted');
              }
            });
            
            // 해당 출처 항목도 강조
            var sourceEntry = document.querySelector('[data-source-entry="' + source + '"]');
            if (sourceEntry) {
              sourceEntry.classList.add('ring-2', 'ring-wiki-primary');
            }
          }
          
          // 출처 항목 클릭 이벤트
          document.querySelectorAll('[data-source-entry][data-source-has-data="true"]').forEach(function(entry) {
            entry.addEventListener('click', function(e) {
              // 다른 클릭 이벤트와 충돌 방지
              if (e.target.closest('.user-source-item')) return;
              
              var source = this.getAttribute('data-source-entry');
              
              // 배타적 + 토글 방식
              if (activeSource === source) {
                // 같은 출처 클릭 시 끄기
                clearAllHighlights();
                activeSource = null;
              } else {
                // 다른 출처 클릭 시 전환
                clearAllHighlights();
                highlightSource(source);
                activeSource = source;
              }
            });
          });
        })();
      })();
    </script>
  `
}

export const renderUnifiedMajorDetail = ({ profile, partials, sources, existingJobSlugs, relatedMajorsByCategory }: UnifiedMajorDetailTemplateParams): string => {
  // categoryName 정리: ETL에서 이미 처리된 categoryDisplay 사용, 없으면 폴백
  const cleanCategoryName = (profile as any).categoryDisplay 
    || (profile.categoryName && profile.categoryName.split(',').length <= 2 ? profile.categoryName : undefined)

  // 1. 히어로 요약: ETL에서 병합된 heroSummary 사용 (첫 문장만), 없으면 폴백
  const careernetSummary = partials?.CAREERNET?.summary
  const goyong24Summary = partials?.GOYONG24?.summary
  const heroDescription = (profile as any).heroSummary 
    || (profile.summary || careernetSummary || goyong24Summary)?.split('\n')[0]?.trim()
  
  const heroImageUrl = (profile as any).image_url
  const heroImageAlt = (profile as any).image_alt ?? `${profile.name} 전공 관련 학습 환경`
  // slug 추출 (이미지 재생성용)
  const majorSlug = (profile as any).slug || profile.name
  const heroImage = heroImageUrl && heroImageUrl.trim() !== '' 
    ? renderHeroImage(profile.name, { imageUrl: heroImageUrl, imageAlt: heroImageAlt, dataAttribute: 'data-major-hero-image', context: 'major', slug: majorSlug })
    : ''

  // chartData 정규화: 문자열로 저장된 경우 파싱, 배열이면 첫 번째 요소 추출
  let chartData: any = null
  try {
    const rawChartData = profile.chartData
    if (typeof rawChartData === 'string') {
      // JSON 문자열로 저장된 경우 파싱
      const parsed = JSON.parse(rawChartData)
      chartData = Array.isArray(parsed) ? parsed[0] : parsed
    } else if (Array.isArray(rawChartData)) {
      chartData = rawChartData[0]
    } else {
      chartData = rawChartData
    }
  } catch (e) {
    console.error('[renderUnifiedMajorDetail] Failed to parse chartData:', e)
    chartData = null
  }

  // 고유한 차트 ID 생성용 카운터
  let chartIdCounter = 0
  const generateChartId = (prefix: string) => {
    const safeId = (profile.id || 'default').replace(/[^a-zA-Z0-9가-힣-]/g, '-')
    return `${prefix}-${safeId}-${++chartIdCounter}`
  }

  const overviewCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushOverviewCard = (label: string, icon: string, markup: string, dataSources?: string[]) => {
    const id = anchorIdFactory('overview', label)
    overviewCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id, dataSources }) })
  }

  // 특정 필드가 어느 출처에서 왔는지 판단하는 헬퍼 함수
  // partials가 있으면 partials 기반, 없으면 profile.sources 기반
  const normalizedProfileSources = Array.isArray(profile.sources) ? profile.sources : []
  const getFieldSources = (fieldExtractor: (p: UnifiedMajorDetail | null | undefined) => any): string[] => {
    const sources: string[] = []
    
    // partials 기반 판단 (더 정확함)
    if (partials?.CAREERNET && fieldExtractor(partials.CAREERNET)) {
      sources.push('CAREERNET')
    }
    if (partials?.GOYONG24 && fieldExtractor(partials.GOYONG24)) {
      sources.push('GOYONG24')
    }
    
    // partials가 비어있으면 profile.sources 기반으로 폴백
    if (sources.length === 0 && normalizedProfileSources.length > 0) {
      // 해당 필드가 profile에 있으면 profile.sources 사용
      if (fieldExtractor(profile)) {
        normalizedProfileSources.forEach(s => {
          if (s === 'CAREERNET' || s === 'GOYONG24' || s === 'WORK24_MAJOR') {
            sources.push(s)
          }
        })
      }
    }
    
    return [...new Set(sources)]  // 중복 제거
  }

  // 1. 전공 개요: 고용24만 사용, 둘 다 있으면 개요에만 표시 (히어로와 중복 방지)
  const hasCareernetOnly = careernetSummary && !goyong24Summary
  const hasGoyong24Only = goyong24Summary && !careernetSummary
  const hasBothSummaries = careernetSummary && goyong24Summary
  
  // 전공 개요: overview.summary 우선, 없으면 summary, 없으면 고용24/커리어넷
  const overviewSummary = (profile as any)?.overview?.summary || profile.summary
  if (overviewSummary?.trim()) {
    const summarySources = getFieldSources(p => p?.summary)
    pushOverviewCard('전공 개요', 'fa-circle-info', formatRichText(overviewSummary), summarySources)
  } else if (goyong24Summary?.trim()) {
    pushOverviewCard('전공 개요', 'fa-circle-info', formatRichText(goyong24Summary), ['GOYONG24'])
  } else if (hasCareernetOnly && careernetSummary?.trim()) {
    pushOverviewCard('전공 개요', 'fa-circle-info', formatRichText(careernetSummary), ['CAREERNET'])
  }
  
  // 전공 특성 (property)
  if (profile.property?.trim()) {
    const propertySources = getFieldSources(p => p?.property)
    pushOverviewCard('전공 특성', 'fa-star', formatRichText(profile.property), propertySources)
  }
  
  if (profile.aptitude?.trim()) {
    const aptitudeSources = getFieldSources(p => p?.aptitude)
    pushOverviewCard('이 전공에 어울리는 사람', 'fa-user-check', formatRichText(profile.aptitude), aptitudeSources)
  }

  // 졸업 후 진출 분야 (enterField + chartData.field + careerFields) - 개요로 이동
  const normalizePairList = (list: any): Array<{ title: string; description: string }> => {
    if (!list) return []
    if (typeof list === 'string') {
      return list.split(/\n+/).map(line => line.trim()).filter(Boolean).map(line => ({ title: line, description: '' }))
    }
    if (Array.isArray(list)) {
      return list.map((item: any) => {
        if (typeof item === 'string') return { title: item.trim(), description: '' }
        const title = item.title || item.name || item.gradeuate || item.field_name || item.act_name || item.ACT_NM || item.SUBJECT_NM || ''
        const description = item.description || item.desc || item.text || item.field_description || item.field_desc || item.act_description || item.ACT_SUMRY || ''
        if (!title && !description) return null
        return { title, description }
      }).filter(Boolean) as Array<{ title: string; description: string }>
    }
    return []
  }
  const hasFieldChart = chartData?.field && Array.isArray(chartData.field) && chartData.field.length > 0
  const normalizedEnterField = normalizePairList(profile.enterField)
  const hasEnterField = normalizedEnterField.length > 0
  const hasCareerFields = !!(profile as any).careerFields?.trim() // 이색학과 진출 분야
  
  if (hasEnterField || hasFieldChart || hasCareerFields) {
    const enterFieldParts: string[] = []
    
    // 1. 차트 먼저 (chartData.field)
    if (hasFieldChart) {
      const chartId = generateChartId('field-chart')
      const fieldLabels = chartData!.field!.map((item: { item?: string; data?: string }) => item.item || '')
      const fieldValues = chartData!.field!.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0'))
      // 값이 0이 아닌 항목만 필터링
      const filteredData = fieldLabels.map((label: string, i: number) => ({ label, value: fieldValues[i] }))
        .filter((d: { label: string; value: number }) => d.value > 0)
        .sort((a: { label: string; value: number }, b: { label: string; value: number }) => b.value - a.value)
      
      if (filteredData.length > 0) {
        const filteredLabels = filteredData.map((d: { label: string; value: number }) => d.label)
        const filteredValues = filteredData.map((d: { label: string; value: number }) => d.value)
        const colors = [
          'rgba(59, 130, 246, 0.85)',   // blue
          'rgba(16, 185, 129, 0.85)',   // emerald
          'rgba(244, 114, 182, 0.85)',  // pink
          'rgba(251, 191, 36, 0.85)',   // amber
          'rgba(139, 92, 246, 0.85)',   // violet
          'rgba(236, 72, 153, 0.85)',   // pink-600
          'rgba(34, 197, 94, 0.85)',    // green
          'rgba(249, 115, 22, 0.85)',   // orange
          'rgba(14, 165, 233, 0.85)',   // sky
          'rgba(168, 85, 247, 0.85)'    // purple
        ]
        
        // 커스텀 범례 생성 - 상위 5개만 표시, 텍스트 전체 표시 + 퍼센트 오른쪽 정렬
        const topItems = filteredLabels.slice(0, 5).map((label: string, i: number) => {
          const value = filteredValues[i] || 0
          return `<div class="flex items-center gap-3 px-4 py-2.5 rounded-lg bg-white/5 border border-white/10 min-w-[220px]">
            <span class="w-3 h-3 rounded-full shrink-0" style="background: ${colors[i]}"></span>
            <span class="text-[15px] text-white/90 flex-1">${escapeHtml(label)}</span>
            <span class="text-[15px] text-wiki-secondary font-bold ml-auto">${value}%</span>
          </div>`
        }).join('')
        
        enterFieldParts.push(`
          <div class="mb-6">
            <div class="bg-wiki-bg/40 rounded-2xl p-6 border border-wiki-border/40">
              <h5 class="text-[16px] font-bold text-wiki-secondary mb-5 flex items-center gap-2">
                <i class="fas fa-chart-pie text-sm"></i>
                졸업 후 첫 직업 분야 비율
              </h5>
              <div class="flex flex-col lg:flex-row gap-6 items-center">
                <div class="relative w-full lg:w-1/2 p-4" style="height: 300px;">
                  <canvas id="${chartId}"></canvas>
                </div>
                <div class="flex flex-wrap lg:flex-col gap-2 justify-center">${topItems}</div>
              </div>
              <p class="text-sm text-wiki-muted/60 italic text-right mt-4">자료: 한국고용정보원, 대졸자 직업이동 경로조사(2020), ${escapeHtml(profile.name)}</p>
              <script>
                (function() {
                  const ctx = document.getElementById('${chartId}');
                  if (ctx && typeof Chart !== 'undefined') {
                    new Chart(ctx, {
                      type: 'doughnut',
                      data: {
                        labels: ${JSON.stringify(filteredLabels)},
                        datasets: [{
                          data: ${JSON.stringify(filteredValues)},
                          backgroundColor: ${JSON.stringify(colors.slice(0, filteredLabels.length))},
                          borderWidth: 0,
                          hoverOffset: 10
                        }]
                      },
                      options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        layout: { padding: 15 },
                        cutout: '50%',
                        plugins: {
                          legend: { display: false },
                          tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.9)',
                            padding: 14,
                            titleFont: { size: 15 },
                            bodyFont: { size: 15 },
                            callbacks: { label: ctx => ctx.label + ': ' + ctx.parsed + '%' }
                          }
                        }
                      }
                    });
                  }
                })();
              </script>
            </div>
          </div>
        `)
      }
    }
    
    // 2. 텍스트 항목 (enterField)
    if (hasEnterField) {
      const enterItems = normalizedEnterField
        .map(item => {
          const name = item.title || ''
          const desc = item.description || ''
          if (desc) {
            return `<div class="mb-3"><span class="font-semibold text-wiki-text">${escapeHtml(name)}</span><p class="text-[15px] text-wiki-muted mt-1">${escapeHtml(desc)}</p></div>`
          }
          return `<span class="inline-block px-3 py-1 bg-wiki-bg/60 border border-wiki-border/70 rounded-full text-[15px] text-wiki-text mr-2 mb-2">${escapeHtml(name)}</span>`
        })
        .join('')
      if (enterItems) {
        enterFieldParts.push(enterItems)
      }
    }
    
    // 3. 이색학과 진출 분야 (careerFields) - 다른 내용처럼 단순하게 표시
    if (hasCareerFields) {
      const careerFieldsText = (profile as any).careerFields.trim()
      enterFieldParts.push(`<p class="text-[15px] text-wiki-text leading-relaxed">${escapeHtml(careerFieldsText)}</p>`)
    }
    
    if (enterFieldParts.length > 0) {
      // 진출 분야 출처 판단
      const enterFieldSources = getFieldSources(p => p?.enterField || (p as any)?.careerFields)
      pushOverviewCard('졸업 후 진출 분야', 'fa-door-open', enterFieldParts.join(''), enterFieldSources)
    }
  }

  // 4. 핵심 지표 - chartData 차트 + 텍스트 지표
  const profileAny = profile as any
  const careernetSalary = (partials?.CAREERNET as any)?.salary
  const goyong24Salary = (partials?.GOYONG24 as any)?.salary
  const careernetEmployment = (partials?.CAREERNET as any)?.employment
  const goyong24Employment = (partials?.GOYONG24 as any)?.employment
  
  const hasAnyMetrics = profileAny.salary || profile.salaryAfterGraduation || profileAny.employment || profile.employmentRate
  const hasChartMetrics = chartData && (
    chartData.after_graduation?.length ||
    chartData.employment_rate?.length ||
    chartData.avg_salary?.length ||
    chartData.satisfaction?.length
  )
  
  if (hasAnyMetrics || hasChartMetrics) {
    const metricsContent: string[] = []
    
    // 1. 차트 섹션 (2x2 그리드)
    if (hasChartMetrics) {
      const chartCards: string[] = []
      
      // 진학률 (after_graduation) - 도넛 차트
      if (chartData?.after_graduation && chartData.after_graduation.length > 0) {
        const chartId = generateChartId('graduation-chart')
        const labels = chartData.after_graduation.map((item: { item?: string; data?: string }) => item.item || '')
        const values = chartData.after_graduation.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0'))
        const gradColors = ['#10B981', '#3B82F6', '#F472B6']
        
        const gradLegendHtml = labels.map((label: string, i: number) => 
          `<span class="inline-flex items-center gap-2 text-[15px]">
            <span class="w-2.5 h-2.5 rounded-full" style="background: ${gradColors[i % gradColors.length]}"></span>
            <span class="text-white/80">${escapeHtml(label)}</span>
            <span class="text-wiki-secondary font-semibold">${values[i]}%</span>
          </span>`
        ).join('')
        
        chartCards.push(`
          <div class="bg-wiki-bg/40 rounded-2xl p-5 border border-wiki-border/40">
            <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
              <i class="fas fa-graduation-cap text-sm"></i>
              진학률
            </h5>
            <div class="relative p-3" style="height: 200px;">
              <canvas id="${chartId}"></canvas>
            </div>
            <div class="flex flex-wrap justify-center gap-x-5 gap-y-2 mt-3">${gradLegendHtml}</div>
            <script>
              (function() {
                const ctx = document.getElementById('${chartId}');
                if (ctx && typeof Chart !== 'undefined') {
                  new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                      labels: ${JSON.stringify(labels)},
                      datasets: [{
                        data: ${JSON.stringify(values)},
                        backgroundColor: ${JSON.stringify(gradColors)},
                        borderWidth: 0,
                        hoverOffset: 8
                      }]
                    },
                    options: {
                      responsive: true,
                      maintainAspectRatio: false,
                      layout: { padding: 10 },
                      cutout: '55%',
                      plugins: {
                        legend: { display: false },
                        tooltip: { backgroundColor: 'rgba(0,0,0,0.9)', padding: 12, titleFont: { size: 14 }, bodyFont: { size: 14 }, callbacks: { label: ctx => ctx.label + ': ' + ctx.parsed + '%' } }
                      }
                    }
                  });
                }
              })();
            </script>
          </div>
        `)
      }
      
      // 취업률 (employment_rate) - 바 차트 + 진학률과 동일한 범례 스타일
      if (chartData?.employment_rate && chartData.employment_rate.length > 0) {
        const chartId = generateChartId('emprate-chart')
        const labels = chartData.employment_rate.map((item: { item?: string; data?: string }) => item.item || '')
        const values = chartData.employment_rate.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0'))
        const empColors = ['#10B981', '#3B82F6', '#FBBF24']
        
        // 진학률과 동일한 범례 스타일
        const empLegendHtml = labels.map((label: string, i: number) => 
          `<span class="inline-flex items-center gap-2 text-[15px]">
            <span class="w-2.5 h-2.5 rounded-full" style="background: ${empColors[i % empColors.length]}"></span>
            <span class="text-white/80">${escapeHtml(label)}</span>
            <span class="text-wiki-secondary font-semibold">${values[i]}%</span>
          </span>`
        ).join('')
        
        chartCards.push(`
          <div class="bg-wiki-bg/40 rounded-2xl p-5 border border-wiki-border/40">
            <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
              <i class="fas fa-briefcase text-sm"></i>
              취업률
            </h5>
            <div class="relative p-3" style="height: 200px;">
              <canvas id="${chartId}"></canvas>
            </div>
            <div class="flex flex-wrap justify-center gap-x-5 gap-y-2 mt-3">${empLegendHtml}</div>
            <script>
              (function() {
                const ctx = document.getElementById('${chartId}');
                if (ctx && typeof Chart !== 'undefined') {
                  new Chart(ctx, {
                    type: 'bar',
                    data: {
                      labels: ${JSON.stringify(labels)},
                      datasets: [{
                        data: ${JSON.stringify(values)},
                        backgroundColor: ${JSON.stringify(empColors)},
                        borderRadius: 6,
                        barThickness: 36
                      }]
                    },
                    options: {
                      responsive: true,
                      maintainAspectRatio: false,
                      layout: { padding: 10 },
                      scales: {
                        y: { display: false, beginAtZero: true, max: 100 },
                        x: { display: false }
                      },
                      plugins: {
                        legend: { display: false },
                        tooltip: { backgroundColor: 'rgba(0,0,0,0.9)', padding: 12, callbacks: { label: ctx => ctx.parsed.y + '%' } }
                      }
                    }
                  });
                }
              })();
            </script>
          </div>
        `)
      }
      
      // 월평균 임금 분포 (avg_salary) - 도넛 차트
      if (chartData?.avg_salary && chartData.avg_salary.length > 0) {
        const chartId = generateChartId('salary-chart')
        const labels = chartData.avg_salary.map((item: { item?: string; data?: string }) => item.item || '')
        const values = chartData.avg_salary.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0'))
        const salaryColors = ['#3B82F6', '#F472B6', '#FBBF24', '#10B981', '#8B5CF6']
        
        const salaryLegendHtml = labels.map((label: string, i: number) => 
          `<span class="inline-flex items-center gap-2 text-[15px]">
            <span class="w-2.5 h-2.5 rounded-full" style="background: ${salaryColors[i % salaryColors.length]}"></span>
            <span class="text-white/80">${escapeHtml(label)}</span>
            <span class="text-wiki-secondary font-semibold">${values[i]}%</span>
          </span>`
        ).join('')
        
        chartCards.push(`
          <div class="bg-wiki-bg/40 rounded-2xl p-5 border border-wiki-border/40">
            <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
              <i class="fas fa-won-sign text-sm"></i>
              월평균 임금 분포
            </h5>
            <div class="relative p-3" style="height: 200px;">
              <canvas id="${chartId}"></canvas>
            </div>
            <div class="flex flex-wrap justify-center gap-x-4 gap-y-2 mt-3">${salaryLegendHtml}</div>
            <script>
              (function() {
                const ctx = document.getElementById('${chartId}');
                if (ctx && typeof Chart !== 'undefined') {
                  new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                      labels: ${JSON.stringify(labels)},
                      datasets: [{
                        data: ${JSON.stringify(values)},
                        backgroundColor: ${JSON.stringify(salaryColors)},
                        borderWidth: 0,
                        hoverOffset: 8
                      }]
                    },
                    options: {
                      responsive: true,
                      maintainAspectRatio: false,
                      layout: { padding: 10 },
                      cutout: '55%',
                      plugins: {
                        legend: { display: false },
                        tooltip: { backgroundColor: 'rgba(0,0,0,0.9)', padding: 12, titleFont: { size: 14 }, bodyFont: { size: 14 }, callbacks: { label: ctx => ctx.label + ': ' + ctx.parsed + '%' } }
                      }
                    }
                  });
                }
              })();
            </script>
          </div>
        `)
      }
      
      // 첫 직장 만족도 (satisfaction) - 도넛 차트
      if (chartData?.satisfaction && chartData.satisfaction.length > 0) {
        const chartId = generateChartId('satisfaction-chart')
        const labels = chartData.satisfaction.map((item: { item?: string; data?: string }) => item.item || '')
        const values = chartData.satisfaction.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0'))
        // 매우불만족(빨강) -> 불만족(주황) -> 보통(노랑) -> 만족(연두) -> 매우만족(진한초록)
        const satColors = ['#EF4444', '#F97316', '#FBBF24', '#84CC16', '#166534']
        
        const satLegendHtml = labels.map((label: string, i: number) => 
          `<span class="inline-flex items-center gap-2 text-[15px]">
            <span class="w-2.5 h-2.5 rounded-full" style="background: ${satColors[i % satColors.length]}"></span>
            <span class="text-white/80">${escapeHtml(label)}</span>
            <span class="text-wiki-secondary font-semibold">${values[i]}%</span>
          </span>`
        ).join('')
        
        chartCards.push(`
          <div class="bg-wiki-bg/40 rounded-2xl p-5 border border-wiki-border/40">
            <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
              <i class="fas fa-face-smile text-sm"></i>
              첫 직장 만족도
            </h5>
            <div class="relative p-3" style="height: 200px;">
              <canvas id="${chartId}"></canvas>
            </div>
            <div class="flex flex-wrap justify-center gap-x-4 gap-y-2 mt-3">${satLegendHtml}</div>
            <script>
              (function() {
                const ctx = document.getElementById('${chartId}');
                if (ctx && typeof Chart !== 'undefined') {
                  new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                      labels: ${JSON.stringify(labels)},
                      datasets: [{
                        data: ${JSON.stringify(values)},
                        backgroundColor: ${JSON.stringify(satColors)},
                        borderWidth: 0,
                        hoverOffset: 8
                      }]
                    },
                    options: {
                      responsive: true,
                      maintainAspectRatio: false,
                      layout: { padding: 10 },
                      cutout: '55%',
                      plugins: {
                        legend: { display: false },
                        tooltip: { backgroundColor: 'rgba(0,0,0,0.9)', padding: 12, titleFont: { size: 14 }, bodyFont: { size: 14 }, callbacks: { label: ctx => ctx.label + ': ' + ctx.parsed + '%' } }
                      }
                    }
                  });
                }
              })();
            </script>
          </div>
        `)
      }
      
      if (chartCards.length > 0) {
        metricsContent.push(`
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-4">
            ${chartCards.join('')}
          </div>
          <p class="text-xs text-wiki-muted/70 italic text-right mb-4">자료: 한국고용정보원, 대졸자 직업이동 경로조사(2020)</p>
        `)
      }
    }
    
    // 2. 텍스트 지표 (카드 형태로 강조)
    if (hasAnyMetrics) {
      const textMetrics: string[] = []
      
      const salaryValue = profileAny.salary
      const salaryAfterValue = profile.salaryAfterGraduation
      const isSameSalary = salaryValue && salaryAfterValue && 
        salaryValue.replace(/<[^>]*>/g, '').trim() === salaryAfterValue.replace(/<[^>]*>/g, '').trim()
      
      // 월급 지표
      let displaySalary = ''
      if (salaryValue && !isSameSalary) {
        displaySalary = salaryValue.replace(/<[^>]*>/g, '').trim()
        if (/^\d+(\.\d+)?$/.test(displaySalary)) displaySalary = `${displaySalary}만원`
      } else if (salaryAfterValue) {
        displaySalary = salaryAfterValue.replace(/<[^>]*>/g, '').trim()
        if (/^\d+(\.\d+)?$/.test(displaySalary)) displaySalary = `${displaySalary}만원`
      } else if (isSameSalary && salaryValue) {
        displaySalary = salaryValue.replace(/<[^>]*>/g, '').trim()
        if (/^\d+(\.\d+)?$/.test(displaySalary)) displaySalary = `${displaySalary}만원`
      }
      
      if (displaySalary) {
        textMetrics.push(`
          <div class="flex items-center gap-4 p-4 rounded-xl bg-gradient-to-r from-amber-500/10 to-orange-500/10 border border-amber-500/30">
            <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-amber-500/20">
              <i class="fas fa-won-sign text-xl text-amber-400"></i>
            </div>
            <div>
              <p class="text-xs text-wiki-muted mb-1">졸업 후 평균 월급</p>
              <p class="text-xl font-bold text-amber-300">${escapeHtml(displaySalary)}</p>
            </div>
          </div>
        `)
      }
      
      // 취업률 지표 - chartData.employment_rate 우선 사용
      const displayEmployment = getAccurateEmploymentRate(profile) || ''
      
      if (displayEmployment) {
        textMetrics.push(`
          <div class="flex items-center gap-4 p-4 rounded-xl bg-gradient-to-r from-emerald-500/10 to-green-500/10 border border-emerald-500/30">
            <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-emerald-500/20">
              <i class="fas fa-briefcase text-xl text-emerald-400"></i>
            </div>
            <div>
              <p class="text-xs text-wiki-muted mb-1">취업률</p>
              <p class="text-xl font-bold text-emerald-300">${escapeHtml(displayEmployment)}</p>
            </div>
          </div>
        `)
      }
      
      if (textMetrics.length > 0) {
        metricsContent.push(`
          <div class="grid md:grid-cols-2 gap-3">
            ${textMetrics.join('')}
          </div>
        `)
      }
    }
    
    if (metricsContent.length > 0) {
      // 핵심 지표는 여러 출처에서 올 수 있음
      const metricsSources = getFieldSources(p => (p as any)?.salary || (p as any)?.employment)
      pushOverviewCard('핵심 지표', 'fa-gauge-high', metricsContent.join(''), metricsSources)
    }
  }

  // 여담 (trivia) - 개요 탭 마지막에 표시
  const triviaSource = (profile as any)?.trivia
  if (triviaSource) {
    const normalizeTriviaItem = (item: any): string | null => {
      if (typeof item === 'string') return item.trim()
      if (item && typeof item === 'object') {
        const text = item.title || item.name || item.text || item.description || item.value || ''
        return text.trim() || null
      }
      return null
    }
    
    const triviaItems = Array.isArray(triviaSource)
      ? triviaSource
          .map(normalizeTriviaItem)
          .filter((p: any) => p && String(p).trim())
          .map((p: any) => String(p).trim())
      : typeof triviaSource === 'string'
        ? triviaSource.split(/\n|•/).map(s => s.trim()).filter(Boolean)
        : []
    
    if (triviaItems.length > 0) {
      const html = `<ul class="space-y-2">${triviaItems
        .map(
          item =>
            `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(
              item
            )}</span></li>`
        )
        .join('')}</ul>`
      // 여담은 사용자 기여 데이터 (출처 정보 없음)
      pushOverviewCard('여담', 'fa-comment-dots', html)
    }
  }

  // 개요 탭: 콘텐츠가 없으면 빈 문자열 반환 (탭 자체를 숨김)
  const overviewContent = overviewCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('overview', '목차', overviewCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${overviewCards.map((card) => card.markup).join('')}
      </div>`
    : ''  // 콘텐츠 없으면 탭 숨김
  
  // 2. 적성 리스트 (lstMiddleAptd, lstHighAptd) 제거됨 - 사용자 요청
  
  // 가치관 리스트 (lstVals)
  if (profile.lstVals && Array.isArray(profile.lstVals) && profile.lstVals.length > 0) {
    const valItems = profile.lstVals
      .filter(item => item && (item.item || item.val_name))
      .slice(0, 10)
      .map(item => {
        const name = item.item || item.val_name || ''
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
      // 가치관은 커리어넷에서 제공
      pushOverviewCard('가치관', 'fa-heart', valItems, ['CAREERNET'])
    }
  }

  // 5. 상세정보 탭 순서 재구성
  const learningCards: Array<{ id: string; label: string; icon: string; markup: string }> = []
  const pushLearningCard = (label: string, icon: string, markup: string) => {
    const id = anchorIdFactory('curriculum', label)
    learningCards.push({ id, label, icon, markup: buildCard(label, icon, markup, { anchorId: id }) })
  }
  
  // 0) 입학상황 섹션 (chartData.gender + chartData.applicant) - 첫 번째 섹션
  if (chartData) {
    const admissionCharts: string[] = []
    
    // 미리 ID와 데이터 준비
    const genderChartId = (chartData.gender && Array.isArray(chartData.gender) && chartData.gender.length > 0) 
      ? generateChartId('gender-chart') : null
    const genderLabels = chartData.gender?.map((item: { item?: string; data?: string }) => item.item || '') || []
    const genderValues = chartData.gender?.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0')) || []
    
    const admissionChartId = (chartData.applicant && Array.isArray(chartData.applicant) && chartData.applicant.length > 0)
      ? generateChartId('admission-chart') : null
    const applicantLabels = chartData.applicant?.map((item: { item?: string; data?: string }) => item.item || '') || []
    const applicantValues = chartData.applicant?.map((item: { item?: string; data?: string }) => parseFloat(item.data || '0')) || []
    
    // 성별 비율 (도넛 차트) - 커스텀 범례로 데이터 표시
    if (genderChartId) {
      const genderLegendHtml = genderLabels.map((label: string, i: number) => {
        const value = genderValues[i] || 0
        const colors = ['#3B82F6', '#F472B6']
        return `<span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10">
          <span class="w-3 h-3 rounded-full" style="background: ${colors[i % colors.length]}"></span>
          <span class="text-[15px] text-white/90 font-medium">${escapeHtml(label)}</span>
          <span class="text-[15px] text-wiki-secondary font-bold">${value}%</span>
        </span>`
      }).join('')
      
      admissionCharts.push(`
        <div class="bg-wiki-bg/40 rounded-2xl p-6 border border-wiki-border/40">
          <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
            <i class="fas fa-venus-mars text-sm"></i>
            입학상황(성별)
          </h5>
          <div class="relative p-3" style="height: 200px;">
            <canvas id="${genderChartId}"></canvas>
          </div>
          <div class="flex flex-wrap justify-center gap-3 mt-4">${genderLegendHtml}</div>
        </div>
      `)
    }
    
    // 지원자/입학자 (바 차트) - 커스텀 범례로 데이터 표시
    if (admissionChartId) {
      const applicantLegendHtml = applicantLabels.map((label: string, i: number) => {
        const value = applicantValues[i] || 0
        const colors = ['#8B5CF6', '#FBBF24']
        return `<span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10">
          <span class="w-3 h-3 rounded-full" style="background: ${colors[i % colors.length]}"></span>
          <span class="text-[15px] text-white/90 font-medium">${escapeHtml(label)}</span>
          <span class="text-[15px] text-wiki-secondary font-bold">${value.toLocaleString()}명</span>
        </span>`
      }).join('')
      
      admissionCharts.push(`
        <div class="bg-wiki-bg/40 rounded-2xl p-6 border border-wiki-border/40">
          <h5 class="text-[16px] font-bold text-wiki-secondary mb-4 flex items-center gap-2">
            <i class="fas fa-user-graduate text-sm"></i>
            입학상황(지원/입학)
          </h5>
          <div class="relative p-3" style="height: 200px;">
            <canvas id="${admissionChartId}"></canvas>
          </div>
          <div class="flex flex-wrap justify-center gap-3 mt-4">${applicantLegendHtml}</div>
        </div>
      `)
    }
    
    // 입학상황 차트 초기화 스크립트
    if (admissionCharts.length > 0) {
      admissionCharts.push(`
        <script>
          (function() {
            var genderChart = null;
            var admissionChart = null;
            
            function tryInitCharts() {
              if (typeof Chart === 'undefined') return;
              
              ${genderChartId ? `
              if (!genderChart) {
                var canvas1 = document.getElementById('${genderChartId}');
                if (canvas1 && canvas1.getContext) {
                  try {
                    genderChart = new Chart(canvas1.getContext('2d'), {
                    type: 'doughnut',
                    data: {
                      labels: ${JSON.stringify(genderLabels)},
                      datasets: [{ data: ${JSON.stringify(genderValues)}, backgroundColor: ['#3B82F6', '#F472B6'], borderWidth: 0 }]
                    },
                    options: {
                      responsive: true, maintainAspectRatio: false, cutout: '55%',
                      plugins: {
                        legend: { display: false },
                        tooltip: { callbacks: { label: function(c) { return c.label + ': ' + c.parsed + '%'; } } }
                      }
                    }
                  });
                  } catch(e) {}
                }
              }
              ` : ''}
              
              ${admissionChartId ? `
              if (!admissionChart) {
                var canvas2 = document.getElementById('${admissionChartId}');
                if (canvas2 && canvas2.getContext) {
                  try {
                    admissionChart = new Chart(canvas2.getContext('2d'), {
                    type: 'bar',
                    data: {
                      labels: ${JSON.stringify(applicantLabels)},
                      datasets: [{ data: ${JSON.stringify(applicantValues)}, backgroundColor: ['#8B5CF6', '#FBBF24'], borderRadius: 8, barThickness: 35 }]
                    },
                    options: {
                      responsive: true, maintainAspectRatio: false, indexAxis: 'y',
                      scales: {
                        x: { display: false, beginAtZero: true },
                        y: { display: false }
                      },
                      plugins: { legend: { display: false }, tooltip: { callbacks: { label: function(c) { return c.parsed.x.toLocaleString() + '명'; } } } }
                    }
                  });
                  } catch(e) {}
                }
              }
              ` : ''}
            }
            
            // 여러 시점에 시도
            window.addEventListener('load', tryInitCharts);
            setTimeout(tryInitCharts, 500);
            setTimeout(tryInitCharts, 1500);
            setTimeout(tryInitCharts, 3000);
            
            // 모든 클릭에 반응
            document.addEventListener('click', function() {
              setTimeout(tryInitCharts, 100);
              setTimeout(tryInitCharts, 400);
            });
          })();
        </script>
      `)
    }
    
    if (admissionCharts.length > 0) {
      const admissionContent = `
        <div class="grid md:grid-cols-2 gap-6 mb-5">
          ${admissionCharts.join('')}
        </div>
        <p class="text-sm text-wiki-muted/70 italic text-right">자료: 한국교육개발원, 교육통계(2025), ${escapeHtml(profile.name)}</p>
      `
      pushLearningCard('입학상황', 'fa-chart-pie', admissionContent)
    }
  }
  
  // 교육과정 카드 (배우는 내용 + 기초/심화 + 대학 상세 + 고교 추천)
  const curriculumSections: string[] = []
  const subjectSections: string[] = []
  
  if (profile.whatStudy?.trim()) {
    curriculumSections.push(`
      <div class="pb-6 mb-8 border-b border-wiki-border/30">
        <h4 class="text-base font-bold text-wiki-secondary mb-3 flex items-center gap-2">
          <span class="flex h-8 w-8 items-center justify-center rounded-full bg-wiki-secondary/15 text-wiki-secondary">
            <i class="fas fa-graduation-cap text-xs"></i>
          </span>
          배우는 내용
        </h4>
        ${formatRichText(profile.whatStudy)}
      </div>
    `)
  }
  
  // ETL에서 파싱된 basicSubjects/advancedSubjects가 있으면 우선 사용 (이색학과)
  let basicSubjects: string[] = Array.isArray((profile as any).basicSubjects) ? (profile as any).basicSubjects : []
  let advancedSubjects: string[] = Array.isArray((profile as any).advancedSubjects) ? (profile as any).advancedSubjects : []
  
  // ETL에서 제공된 데이터가 없고 mainSubjects가 있으면 파싱 시도
  if (basicSubjects.length === 0 && advancedSubjects.length === 0 && profile.mainSubjects?.length) {
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
  }
  
  // 기초/심화 과목
  if (basicSubjects.length > 0) {
    subjectSections.push(`
      <div class="pb-6 mb-8 border-b border-wiki-border/30">
        <h4 class="text-base font-bold text-wiki-secondary mb-3 flex items-center gap-2">
          <span class="flex h-8 w-8 items-center justify-center rounded-full bg-blue-500/15 text-blue-400">
            <i class="fas fa-seedling text-xs"></i>
          </span>
          기초과목
        </h4>
        <div class="flex flex-wrap gap-2">
          ${basicSubjects.map(subj => `<span class="inline-flex items-center gap-1.5 px-3 py-2 bg-blue-500/10 border border-blue-500/20 rounded-lg text-sm text-blue-300 font-medium">${escapeHtml(subj)}</span>`).join('')}
        </div>
      </div>
    `)
  }
  
  if (advancedSubjects.length > 0) {
    subjectSections.push(`
      <div class="pb-6 mb-8 border-b border-wiki-border/30">
        <h4 class="text-base font-bold text-wiki-secondary mb-3 flex items-center gap-2">
          <span class="flex h-8 w-8 items-center justify-center rounded-full bg-purple-500/15 text-purple-400">
            <i class="fas fa-rocket text-xs"></i>
          </span>
          심화과목
        </h4>
        <div class="flex flex-wrap gap-2">
          ${advancedSubjects.map(subj => `<span class="inline-flex items-center gap-1.5 px-3 py-2 bg-purple-500/10 border border-purple-500/20 rounded-lg text-sm text-purple-300 font-medium">${escapeHtml(subj)}</span>`).join('')}
        </div>
      </div>
    `)
  }
  
  // 서브섹션: 대학 주요 교과목 상세 (pairList 포함, JSON 문자열 파싱)
  let mainSubjectArray = (profile as any).mainSubject || (profile as any).main_subject || (profile as any).mainSubjects
  if (typeof mainSubjectArray === 'string') {
    try {
      mainSubjectArray = JSON.parse(mainSubjectArray)
    } catch (e) {
      mainSubjectArray = []
    }
  }
  
  if (mainSubjectArray && Array.isArray(mainSubjectArray) && mainSubjectArray.length > 0) {
      const detailItems = mainSubjectArray
        .filter(item => item)
        .map(item => {
          const anyItem = item as any
          const name = anyItem.title || anyItem.SBJECT_NM || anyItem.subject_name || anyItem.SUBJECT_NM || ''
          const desc = anyItem.description || anyItem.SBJECT_SUMRY || anyItem.subject_description || anyItem.SUBJECT_SUMRY || ''
          if (!name && !desc) return ''
          return `
            <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-primary/40 transition-colors">
              <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
                <i class="fas fa-book-open text-wiki-primary text-xs"></i>
                ${escapeHtml(name)}
              </h5>
              ${desc ? `<p class="text-[15px] text-wiki-muted leading-relaxed">${escapeHtml(desc)}</p>` : ''}
            </div>
          `
        })
        .filter(Boolean)
        .join('')
      
      if (detailItems) {
        subjectSections.push(`
          <div class="pb-6 mb-8 border-b border-wiki-border/30">
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
    
  // 서브섹션: 고교 추천 교과목 (pairList 포함, [출처] 제거)
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
      .map(item => {
        if (!item) return ''
        const anyItem = item as any
        const title = anyItem.title || anyItem.subject_name || anyItem.SUBJECT_NM || ''
        if (!title || title.trim().startsWith('[출처')) return ''
        let desc = anyItem.description || anyItem.subject_description || anyItem.SUBJECT_SUMRY || ''
        if (typeof desc === 'string') {
          desc = desc
            .replace(/<br\s*\/?>/gi, '\n')
            .replace(/&lt;br\s*\/?&gt;/gi, '\n')
        }
        return `
          <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-secondary/40 transition-colors">
            <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
              <i class="fas fa-school text-wiki-secondary text-xs"></i>
              ${escapeHtml(title)}
            </h5>
            ${desc ? `<p class="text-[15px] text-wiki-muted leading-relaxed">${formatRichText(desc)}</p>` : ''}
          </div>
        `
      })
      .filter(Boolean)
      .join('')
    
    if (highSchoolItems) {
      subjectSections.push(`
        <div class="pb-6 mb-8 border-b border-wiki-border/30">
          <h4 class="text-base font-bold text-wiki-secondary mb-4 flex items-center gap-2">
            <span class="flex h-8 w-8 items-center justify-center rounded-full bg-wiki-secondary/15 text-wiki-secondary">
              <i class="fas fa-school text-xs"></i>
            </span>
            고교 추천 교과목
          </h4>
          <div class="grid gap-3">${highSchoolItems}</div>
        </div>
      `)
    }
  }
  
  const curriculumAll = [...curriculumSections, ...subjectSections]
  if (curriculumAll.length > 0) {
    const wrappedSections = `<div class="[&>div:last-child]:border-b-0 [&>div:last-child]:pb-0 [&>div:last-child]:mb-0">${curriculumAll.join('')}</div>`
    pushLearningCard('교육과정', 'fa-book-open', wrappedSections)
  }
  
  // 7) 진로 탐색 활동 (careerAct) - pairList 지원
  const normalizedCareerAct = normalizePairList((profile as any).careerAct || (profile as any).career_act)
  if (normalizedCareerAct.length > 0) {
    const actItems = normalizedCareerAct
      .map(item => {
        const name = (item.title || '').trim()
        const desc = (item.description || '').trim()
        return `
          <div class="p-4 rounded-lg border border-wiki-border/40 bg-wiki-bg/20 hover:border-wiki-primary/40 transition-colors">
            <h5 class="font-semibold text-wiki-text mb-2 flex items-center gap-2">
              <i class="fas fa-compass text-wiki-primary text-xs"></i>
              ${escapeHtml(name)}
            </h5>
            ${desc ? `<p class="text-[15px] text-wiki-muted leading-relaxed">${escapeHtml(desc)}</p>` : ''}
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

  // 진로 전망 (jobProspect) - 상세정보 탭 진로 섹션에 표시
  const jobProspectSource =
    (profile as any)?.jobProspect ||
    (profile as any)?.overview?.jobProspect ||
    (profile as any)?.prospect
  
  if (jobProspectSource) {
    // 진로 전망 아이템 정규화 함수
    const normalizeProspectItem = (item: any): string | null => {
      if (typeof item === 'string') return item.trim()
      if (item && typeof item === 'object') {
        const text = item.title || item.name || item.text || item.description || item.value || ''
        return typeof text === 'string' ? text.trim() : null
      }
      return null
    }
    
    const prospectItems = Array.isArray(jobProspectSource)
      ? jobProspectSource
          .map(normalizeProspectItem)
          .filter((p: any) => p && String(p).trim())
          .map((p: any) => String(p).trim())
      : typeof jobProspectSource === 'string'
        ? jobProspectSource.split(/\n|•/).map(s => s.trim()).filter(Boolean)
        : []
    if (prospectItems.length > 0) {
      const html = `<ul class="space-y-2">${prospectItems
        .map(
          item =>
            `<li class="flex items-start gap-2 text-[15px] text-wiki-text"><span class="text-wiki-secondary">•</span><span>${escapeHtml(
              item
            )}</span></li>`
        )
        .join('')}</ul>`
      pushCareerCard('진로 전망', 'fa-chart-line', html)
    }
  }
  
  // chartData 차트는 개요 탭(핵심 지표)과 상세정보 탭(입학상황)으로 이동됨

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

  // 대학정보 탭: 콘텐츠가 없으면 빈 문자열 반환 (탭 자체를 숨김)
  const universityContent = universityCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('universities', '목차', universityCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${universityCards.map((card) => card.markup).join('')}
      </div>`
    : ''  // 콘텐츠 없으면 탭 숨김

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
  // 주의: 정규식에서 g 플래그 제거 - 첫 번째(article) ID만 교체하고 내부 canvas ID는 유지
  learningCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    const newMarkup = card.markup
      .replace(/id="[^"]+"/, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  // 진로·전망 카드들을 details ID로 다시 빌드
  careerCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    const newMarkup = card.markup
      .replace(/id="[^"]+"/, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  // 연결정보 카드들을 details ID로 다시 빌드
  networkCards.forEach(card => {
    const newId = anchorIdFactory('details', card.label)
    const newMarkup = card.markup
      .replace(/id="[^"]+"/, `id="${escapeHtml(newId)}"`)
      .replace(/data-card-anchor="[^"]+"/, `data-card-anchor="${escapeHtml(newId)}"`)
    detailCards.push({ id: newId, label: card.label, icon: card.icon, markup: newMarkup })
  })

  // 상세정보 탭: 콘텐츠가 없으면 빈 문자열 반환 (탭 자체를 숨김)
  const detailContent = detailCards.length > 0
    ? `<div class="space-y-6">
        ${renderSectionToc('details', '목차', detailCards.map(({ id, label, icon }) => ({ id, label, icon })))}
        ${detailCards.map((card) => card.markup).join('')}
      </div>`
    : ''  // 콘텐츠 없으면 탭 숨김

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
      title: '재학생 · 졸업생 의견',
      description: '댓글, 리액션, 신고 기능을 사용할 수 있습니다.',
      feedbackLabel: '우선 적용 의견 보내기',
      notifyLabel: '알림 받기',
      emptyLabel: `아직 등록된 댓글이 없습니다. ${profile.name}에 대한 경험을 공유해주세요.`,
      showForm: true  // 익명 사용자도 댓글 작성 가능
    },
    partials,
    sources,
    metaExtra: Object.keys(detailMetaExtra).length ? detailMetaExtra : undefined
  })

  // 사이드바 구성 (직업 템플릿과 동일한 구조)
  const normalizeNameSlug = (item: any, defaultType: 'job' | 'major' | 'howto'): { name: string; slug: string } => {
    if (!item) return { name: '', slug: '' }
    if (typeof item === 'string') return { name: item, slug: item }
    const name = item.name || item.title || item.slug || item.id || ''
    let slug = item.slug || item.id || ''
    if (!slug && name) slug = name
    return { name, slug }
  }
  const renderSidebarSection = (title: string, icon: string, body: string): string => {
    return `
      <section class="glass-card border px-4 py-4 md:px-5 md:py-5 rounded-lg md:rounded-2xl space-y-4 bg-wiki-bg/30" data-major-sidebar-section>
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

  // 관련 직업 (sidebarJobs 우선, 없으면 relatedJobs) - 5개 이상일 때 접기/펼치기
  const sidebarJobsArr = (profile as any)?.sidebarJobs || profile.relatedJobs || []
  if (sidebarJobsArr.length) {
    const limit = 5
    const hasMore = sidebarJobsArr.length > limit
    const visibleJobs = sidebarJobsArr.slice(0, limit)
    const hiddenJobs = sidebarJobsArr.slice(limit)
    
    const renderJob = (job: any, isHidden: boolean = false) => {
      const { name: jobName, slug: jobSlug } = normalizeNameSlug(job, 'job')
      if (!jobName) return ''
      // 커리어위키에 존재하는 직업이면 직접 링크, 아니면 검색 페이지로
      const existingSlug = existingJobSlugs?.get(jobName) || (jobSlug ? existingJobSlugs?.get(jobSlug) : undefined)
      const href = existingSlug 
        ? `/job/${encodeURIComponent(existingSlug)}`
        : `/search?q=${encodeURIComponent(jobName)}&type=job`
      
      return `
      <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
        <a href="${href}" class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
          <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
            <i class="fas fa-briefcase text-xs" aria-hidden="true"></i>
          </span>
          <span class="text-sm text-wiki-text group-hover:text-white font-medium transition-colors">${escapeHtml(jobName)}</span>
          <i class="fas fa-chevron-right ml-auto text-[10px] text-wiki-muted/50 group-hover:text-wiki-primary group-hover:translate-x-0.5 transition-all" aria-hidden="true"></i>
        </a>
      </li>
    `
    }
    
    const jobsList = [
      ...visibleJobs.map((job: any) => renderJob(job, false)),
      ...hiddenJobs.map((job: any) => renderJob(job, true))
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

  // 6-2. 관련 전공 (sidebarMajors 우선, 없으면 relatedMajorsByCategory)
  const sidebarMajorsArr = (profile as any)?.sidebarMajors || relatedMajorsByCategory || []
  if (sidebarMajorsArr && sidebarMajorsArr.length > 0) {
    // 자기 자신 제외 (DB에서 이미 제외하지만 방어 로직)
    const currentMajorName = profile.name?.trim().toLowerCase()
    const filteredMajors = sidebarMajorsArr.filter((major: any) => 
      major.name?.trim().toLowerCase() !== currentMajorName
    )
    
    if (filteredMajors.length === 0) {
      // 필터링 후 남은 게 없으면 섹션 표시 안 함
    } else {
    const limit = 5
    const hasMore = filteredMajors.length > limit
    const visibleMajors = filteredMajors.slice(0, limit)
    const hiddenMajors = filteredMajors.slice(limit)
    
    const renderRelatedMajor = (major: { id?: string; name?: string; slug?: string }, isHidden: boolean = false) => {
      const { name, slug } = normalizeNameSlug(major, 'major')
      if (!name || !slug) return ''
      return `
      <li${isHidden ? ' class="hidden-item" style="display: none;"' : ''}>
        <a href="/major/${encodeURIComponent(slug)}" 
           class="group flex items-center gap-3 px-3 py-2.5 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200">
          <span class="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-wiki-primary/10 text-wiki-primary group-hover:bg-wiki-primary/20 transition-colors">
            <i class="fas fa-graduation-cap text-xs" aria-hidden="true"></i>
          </span>
          <span class="text-sm text-wiki-text font-medium group-hover:text-wiki-primary transition-colors">${escapeHtml(name)}</span>
        </a>
      </li>
    `
    }
    
    const majorsList = [
      ...visibleMajors.map((major: any) => renderRelatedMajor(major, false)),
      ...hiddenMajors.map((major: any) => renderRelatedMajor(major, true))
    ].join('')
    
    const toggleButton = hasMore ? `
      <button class="expand-toggle mt-3 w-full px-3 py-2 rounded-lg border border-wiki-border/40 bg-wiki-bg/40 hover:border-wiki-primary/60 hover:bg-wiki-primary/5 transition-all duration-200 flex items-center justify-center gap-2 text-sm text-wiki-muted hover:text-wiki-primary" data-expanded="false">
        <span class="toggle-text">더보기</span>
        <span class="toggle-count text-xs opacity-75">(+${hiddenMajors.length})</span>
        <i class="fas fa-chevron-down text-xs toggle-icon transition-transform"></i>
      </button>
    ` : ''
    
    sidebarSections.push(renderSidebarSection('관련 전공', 'fa-graduation-cap', `
      <div class="expandable-list">
        <ul class="space-y-2" role="list">${majorsList}</ul>
        ${toggleButton}
      </div>
    `))
    }
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

  // 사용자 출처 평탄화 (페이지 표시 순서대로 정렬, 1부터 번호 부여)
  const normalizeUserSources = (src: any): Array<{ id: number; fieldKey: string; text: string; displayOrder: number }> => {
    if (!src || typeof src !== 'object') return []
    
    // 필드 표시 순서 (개요 탭 → 상세정보 탭)
    const fieldOrder: string[] = [
      // 개요 탭
      'overview.summary', 'summary', 'property', 'aptitude', 'enterField', 'trivia',
      // 상세정보 탭
      'whatStudy', 'mainSubject', 'relateSubject', 'careerAct',
      // 사이드바
      'sidebarJobs', 'sidebarMajors', 'sidebarHowtos'
    ]
    
    const flat: Array<{ id: number; fieldKey: string; text: string; displayOrder: number; originalId: number }> = []
    
    for (const [fieldKey, val] of Object.entries(src)) {
      const arr = Array.isArray(val) ? val : [val]
      arr.forEach((item: any) => {
        const text = (item?.text || item?.url || '').trim()
        if (!text) return
        const originalId = item?.id || 0
        const displayOrder = fieldOrder.indexOf(fieldKey)
        flat.push({ 
          id: 0, // 나중에 순서대로 재부여
          fieldKey, 
          text, 
          displayOrder: displayOrder >= 0 ? displayOrder : 999,
          originalId 
        })
      })
    }
    
    // 표시 순서대로 정렬 후 1부터 번호 재부여
    flat.sort((a, b) => {
      if (a.displayOrder !== b.displayOrder) return a.displayOrder - b.displayOrder
      return a.originalId - b.originalId // 같은 필드 내에서는 입력 순서
    })
    
    return flat.map((item, idx) => ({
      id: idx + 1, // 1부터 순차 번호
      fieldKey: item.fieldKey,
      text: item.text,
      displayOrder: item.displayOrder
    }))
  }

  const userSourcesFlat = normalizeUserSources((profile as any)._sources)

  // 데이터 출처 collapsible (직업 템플릿과 동일)
  const sourcesCollapsible = renderMajorSourcesCollapsible(profile, sources, partials, userSourcesFlat)

  const sourcesBlock = sourcesCollapsible
    ? `<div data-major-sources>${sourcesCollapsible}</div>`
    : ''

  const adSlotBlock = renderAdSlot({ entityType: 'major' })
  const communityBlock = `<div data-major-community>${commentsPlaceholder}</div>`

  // 6. 히어로 태그: ETL에서 병합된 heroTags 사용, 없으면 폴백
  const etlHeroTags = (profile as any).heroTags
  let heroTags: string[] = []
  
  if (etlHeroTags && Array.isArray(etlHeroTags) && etlHeroTags.length > 0) {
    // ETL에서 미리 병합된 태그 사용 (제한 없음)
    heroTags = etlHeroTags
  } else {
    // 폴백: 기존 로직으로 계산
    const careernetRelated = partials?.CAREERNET?.relatedMajors || []
    const goyong24Related = partials?.GOYONG24?.relatedMajors || []
    
    const allDepartments: string[] = []
    if (profile.universities && Array.isArray(profile.universities)) {
      profile.universities.forEach(uni => {
        if (uni.department && typeof uni.department === 'string' && uni.department.trim().length > 0) {
          allDepartments.push(uni.department.trim())
        }
      })
    }
    
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
    
    heroTags = uniqueRelatedMajors  // 제한 없음
  }

  // 태그 15개 + 더보기/접기 버튼
  const visibleLimit = 15
  const hasMoreTags = heroTags.length > visibleLimit
  const visibleTags = heroTags.slice(0, visibleLimit)
  const hiddenTags = heroTags.slice(visibleLimit)
  
  const majorTagClass = 'inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-primary/10 border border-wiki-primary/20 text-xs text-wiki-primary font-medium hover:bg-wiki-primary/20 transition'
  
  const visibleTagsHtml = visibleTags
    .map(tag => `<span class="${majorTagClass}"><i class="fas fa-graduation-cap text-[10px]"></i>${escapeHtml(tag)}</span>`)
    .join('')
  
  const hiddenTagsHtml = hiddenTags
    .map(tag => `<span class="${majorTagClass}"><i class="fas fa-graduation-cap text-[10px]"></i>${escapeHtml(tag)}</span>`)
    .join('')
  
  const majorContainerId = `major-tags-${Date.now()}`
  
  const moreTagsButton = hasMoreTags
    ? `<button type="button" id="${majorContainerId}-more" class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-bg/80 text-xs text-wiki-muted font-medium border-2 border-dashed border-wiki-border hover:border-wiki-primary/50 hover:text-wiki-primary hover:bg-wiki-primary/5 transition-all duration-200" onclick="document.getElementById('${majorContainerId}-hidden').classList.remove('hidden'); this.classList.add('hidden'); document.getElementById('${majorContainerId}-less').classList.remove('hidden');">
        <i class="fas fa-plus text-[10px]" aria-hidden="true"></i>${hiddenTags.length}개 더보기
      </button>`
    : ''
  
  const lessTagsButton = hasMoreTags
    ? `<button type="button" id="${majorContainerId}-less" class="hidden inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-wiki-bg/80 text-xs text-wiki-muted font-medium border-2 border-dashed border-wiki-border hover:border-wiki-primary/50 hover:text-wiki-primary hover:bg-wiki-primary/5 transition-all duration-200" onclick="document.getElementById('${majorContainerId}-hidden').classList.add('hidden'); this.classList.add('hidden'); document.getElementById('${majorContainerId}-more').classList.remove('hidden');">
        <i class="fas fa-minus text-[10px]" aria-hidden="true"></i>접기
      </button>`
    : ''
  
  const hiddenTagsContainer = hasMoreTags
    ? `<span id="${majorContainerId}-hidden" class="hidden contents">${hiddenTagsHtml}</span>`
    : ''
  
  const heroTagsMarkup = heroTags.length > 0
    ? `<div class="flex flex-wrap gap-2 mt-4">${visibleTagsHtml}${hiddenTagsContainer}${moreTagsButton}${lessTagsButton}</div>`
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
    <div class="max-w-[1400px] mx-auto px-4 md:px-6 space-y-4 md:space-y-8 md:py-8 md:mt-4" data-major-id="${escapeHtml(profile.id)}">
      <section class="glass-card border px-6 py-8 md:px-8 rounded-2xl space-y-6 md:space-y-8" data-major-hero>
        <div class="space-y-5">
          ${cleanCategoryName ? `<span class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-wiki-primary/15 text-xs text-wiki-primary font-semibold"><i class="fas fa-layer-group"></i>${escapeHtml(cleanCategoryName)}</span>` : ''}
          <div class="flex flex-wrap items-start justify-between gap-4">
            <h1 class="text-[32px] md:text-[34px] lg:text-4xl font-bold text-white leading-tight">${escapeHtml(profile.name)}</h1>
            <div class="flex items-center gap-2 shrink-0">
              <button 
                type="button" 
                class="px-4 py-2 bg-wiki-secondary text-white rounded-lg text-sm hover:bg-purple-600 transition inline-flex items-center gap-2" 
                data-edit-mode-trigger
                data-entity-type="major"
                data-entity-id="${escapeHtml(profile.id)}"
                aria-label="편집 모드"
                title="이 페이지 편집하기"
              >
                <i class="fas fa-edit" aria-hidden="true"></i>
                편집
              </button>
              <button 
                type="button" 
                class="px-4 py-2 bg-wiki-bg/60 border border-wiki-border/60 text-white rounded-lg text-sm hover:bg-wiki-bg/80 hover:border-wiki-primary/60 transition inline-flex items-center gap-2" 
                data-history-trigger
                data-entity-type="major"
                data-entity-id="${escapeHtml(profile.id)}"
                aria-label="역사"
                title="이 페이지의 편집 이력 보기"
              >
                <i class="fas fa-history" aria-hidden="true"></i>
                역사
              </button>
              <div class="relative" data-share-root>
                <button type="button" class="px-4 py-2 bg-wiki-primary text-white rounded-lg text-sm hover:bg-blue-600 transition inline-flex items-center gap-2" data-share-trigger data-share-path="/major/${escapeHtml(profile.id)}" data-share-title="${escapeHtml(profile.name)}">
                  <i class="fas fa-share-nodes" aria-hidden="true"></i>
                  공유
                </button>
                <div class="absolute right-0 mt-2 w-72 rounded-xl border border-wiki-border/60 bg-wiki-bg/95 shadow-xl backdrop-blur hidden z-[1001]" data-share-panel role="dialog" aria-modal="false" aria-label="링크 공유">
                  <div class="flex items-center justify-between px-4 py-3 border-b border-wiki-border/60">
                    <p class="text-sm font-semibold text-white">'${escapeHtml(profile.name)}' 공유하기</p>
                    <button type="button" class="text-xs text-wiki-muted hover:text-white transition" data-share-close aria-label="닫기">
                      <i class="fas fa-times" aria-hidden="true"></i>
                    </button>
                  </div>
                  <div class="p-4 space-y-3">
                    <div class="flex items-center gap-2">
                      <input type="text" class="flex-1 px-3 py-2 rounded-lg bg-wiki-bg/70 border border-wiki-border/60 text-xs text-white focus:outline-none" value="/major/${escapeHtml(profile.id)}" readonly data-share-url>
                      <button type="button" class="px-3 py-2 bg-wiki-primary text-white text-xs rounded-md hover:bg-blue-600 transition" data-share-copy>
                        <i class="fas fa-copy mr-1" aria-hidden="true"></i>복사
                      </button>
                    </div>
                    <p class="text-[11px] text-wiki-muted">복사 버튼을 누르면 링크가 클립보드에 저장됩니다.</p>
                  </div>
                </div>
              </div>
              <!-- 저장 버튼 -->
              <button 
                type="button" 
                class="p-2.5 bg-wiki-card border border-wiki-border/60 text-wiki-text rounded-lg text-sm hover:border-amber-400/50 hover:text-amber-400 transition"
                data-bookmark-btn
                data-bookmark-type="major"
                data-bookmark-slug="${escapeHtml(profile.id)}"
                data-bookmark-title="${escapeHtml(profile.name)}"
                aria-label="저장"
                title="저장함에 추가"
              >
                <i class="fas fa-bookmark" aria-hidden="true"></i>
              </button>
            </div>
          </div>
          ${heroDescription ? `<p class="text-[15px] text-wiki-muted leading-relaxed">${escapeHtml(heroDescription)}</p>` : ''}
          ${heroImage}
          ${heroTagsMarkup}
        </div>
      </section>

      ${layoutBlock}
      ${sourcesBlock}
      ${adSlotBlock}
      ${communityBlock}

      <script>
        // 사용자 추가 출처 데이터 (평탄화된 배열)
        window.__USER_SOURCES__ = ${JSON.stringify(userSourcesFlat)};
        
        // 필드별 주석 번호 매핑 (major)
        window.__SOURCE_FIELD_MAP__ = {
          'overview.summary': ['전공 개요', 'h3:contains("전공 개요")', '[data-field="overview.summary"]'],
          'summary': ['전공 설명', 'h3:contains("전공 설명")', '[data-field="summary"]'],
          'property': ['전공 특성', 'h3:contains("전공 특성")', '[data-field="property"]'],
          'aptitude': ['이 전공에 어울리는 사람', 'h3:contains("이 전공에 어울리는 사람")', '[data-field="aptitude"]'],
          'enterField': ['졸업 후 진출 분야', 'h3:contains("졸업 후 진출 분야")', '[data-field="enterField"]'],
          'trivia': ['여담', 'h3:contains("여담")', '[data-field="trivia"]'],
          'whatStudy': ['배우는 내용', 'h3:contains("배우는 내용")', '[data-field="whatStudy"]'],
          'mainSubject': ['주요 교과목', 'h3:contains("주요 교과목")', '[data-field="mainSubject"]'],
          'relateSubject': ['고교 추천 교과목', 'h3:contains("고교 추천 교과목")', '[data-field="relateSubject"]'],
          'careerAct': ['진로 탐색 활동', 'h3:contains("진로 탐색 활동")', '[data-field="careerAct"]'],
          'sidebarJobs': ['관련 직업', 'h3:contains("관련 직업")', '[data-field="sidebarJobs"]'],
          'sidebarMajors': ['관련 전공', 'h3:contains("관련 전공")', '[data-field="sidebarMajors"]'],
          'sidebarHowtos': ['관련 HowTo', 'h3:contains("관련 HowTo")', '[data-field="sidebarHowtos"]']
        };
      </script>
      <script>
        // 사용자 추가 출처에 주석 번호 추가 및 클릭 이벤트 등록 (배열 지원)
        (function() {
          const sources = window.__USER_SOURCES__ || [];
          const fieldMap = window.__SOURCE_FIELD_MAP__ || {};
          
          sources.forEach(function(source) {
            const sourceId = source.id;
            const fieldKey = source.fieldKey;
            const mapping = fieldMap[fieldKey];
            if (!mapping) return;
            const fieldLabel = mapping[0];
            
            // content-heading 혹은 h3/h4에서 필드명 포함 요소 찾기
            const headings = document.querySelectorAll('.content-heading, h3, h4');
            headings.forEach(function(heading) {
              if (heading.textContent && heading.textContent.includes(fieldLabel)) {
                // 동일 ID 주석이 이미 있으면 패스
                if (heading.querySelector('#user-fnref-' + sourceId)) return;
                
                const footnoteRef = document.createElement('sup');
                footnoteRef.className = 'user-footnote-ref ml-1 inline-flex align-middle cursor-pointer';
                footnoteRef.id = 'user-fnref-' + sourceId;
                footnoteRef.setAttribute('data-source-id', sourceId);
                footnoteRef.innerHTML = '<span class="inline-flex items-center justify-center w-4 h-4 text-[10px] font-bold rounded-full bg-wiki-secondary/20 text-wiki-secondary hover:bg-wiki-secondary/30 transition">' + sourceId + '</span>';
                
                // flex justify-between로 밀리는 문제를 피하기 위해 텍스트 컨테이너에 부착
                const attachTarget =
                  heading.querySelector('.section-title-text') ||
                  heading.querySelector('.content-heading-text') ||
                  heading.querySelector('.flex.items-center') ||
                  heading.firstElementChild ||
                  heading;
                
                attachTarget.appendChild(footnoteRef);
                
                // 클릭 시 출처 섹션으로 이동
                footnoteRef.addEventListener('click', function(e) {
                  e.preventDefault();
                  e.stopPropagation();
                  const targetEl = document.getElementById('user-fn-' + sourceId);
                  if (!targetEl) return;
                  const sourceSection = document.querySelector('[data-source-collapsible]');
                  if (sourceSection) {
                    const toggleBtn = sourceSection.querySelector('button[aria-controls]');
                    const panelId = toggleBtn ? toggleBtn.getAttribute('aria-controls') : null;
                    const panel = panelId ? document.getElementById(panelId) : null;
                    if (panel && panel.classList.contains('hidden')) {
                      toggleBtn?.click();
                    }
                  }
                  setTimeout(function() {
                    targetEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    targetEl.classList.add('ring-2', 'ring-wiki-secondary/60');
                    setTimeout(() => targetEl.classList.remove('ring-2', 'ring-wiki-secondary/60'), 1200);
                  }, 100);
                });
              }
            });
          });
          
          // 출처 리스트에서 해당 필드로 스크롤 (탭 전환 포함)
          document.querySelectorAll('.user-source-item').forEach(function(item) {
            item.addEventListener('click', function() {
              const sourceId = this.id.replace('user-fn-', '');
              const fieldKey = this.getAttribute('data-field-key');
              const mapping = fieldMap[fieldKey || ''];
              if (!mapping) return;
              
              // 상세정보 탭 필드 목록
              const detailFields = [
                'whatStudy', 'mainSubject', 'relateSubject', 'careerAct', 'jobProspect',
                'detailReady.curriculum', 'detailReady.recruit', 'detailReady.training', 'detailReady.researchList'
              ];
              let targetTabId = 'overview';
              if (fieldKey && (fieldKey.startsWith('detail') || detailFields.some(function(f) { return fieldKey.startsWith(f) || fieldKey === f; }))) {
                targetTabId = 'details';
              }
              
              // 탭 전환 함수 (job 템플릿과 동일한 cw-tabset 스펙)
              function switchToTab(tabId) {
                const tabBtn = document.getElementById('cw-tab-' + tabId);
                const tabPanel = document.getElementById('cw-tab-panel-' + tabId);
                if (!tabBtn || !tabPanel) return;
                
                // 이미 활성 탭이면 스킵
                if (tabBtn.getAttribute('aria-selected') === 'true') return;
                
                const ACTIVE_CLASSES = ['text-white', 'border-wiki-primary', 'md:bg-wiki-border/30'];
                const INACTIVE_CLASSES = ['text-wiki-muted', 'border-transparent', 'bg-transparent'];
                
                // 모든 탭 버튼 비활성화
                document.querySelectorAll('[data-cw-tab-trigger]').forEach(function(btn) {
                  btn.setAttribute('aria-selected', 'false');
                  btn.setAttribute('tabindex', '-1');
                  btn.classList.remove('is-active');
                  ACTIVE_CLASSES.forEach(function(cls) { btn.classList.remove(cls); });
                  INACTIVE_CLASSES.forEach(function(cls) { btn.classList.add(cls); });
                });
                
                // 모든 탭 패널 비활성화
                document.querySelectorAll('[data-cw-tab-panel]').forEach(function(panel) {
                  panel.setAttribute('aria-hidden', 'true');
                  panel.setAttribute('tabindex', '-1');
                  panel.classList.remove('is-active');
                  panel.classList.add('is-hidden');
                });
                
                // 대상 탭 버튼 활성화
                tabBtn.setAttribute('aria-selected', 'true');
                tabBtn.setAttribute('tabindex', '0');
                tabBtn.classList.add('is-active');
                INACTIVE_CLASSES.forEach(function(cls) { tabBtn.classList.remove(cls); });
                ACTIVE_CLASSES.forEach(function(cls) { tabBtn.classList.add(cls); });
                
                // 대상 탭 패널 활성화
                tabPanel.setAttribute('aria-hidden', 'false');
                tabPanel.setAttribute('tabindex', '0');
                tabPanel.classList.add('is-active');
                tabPanel.classList.remove('is-hidden');
                
                // tabset의 data-active-tab 업데이트
                const tabset = document.querySelector('[data-cw-tabset]');
                if (tabset) {
                  tabset.setAttribute('data-active-tab', tabId);
                }
              }
              
              // 탭 전환 필요 시 전환
              if (targetTabId) {
                switchToTab(targetTabId);
              }
              
              // 약간의 지연 후 스크롤 (탭 전환 후 렌더링 대기)
              setTimeout(function() {
                const refEl = document.getElementById('user-fnref-' + sourceId);
                if (refEl) {
                  refEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
                  // 하이라이트 효과
                  refEl.classList.add('ring-2', 'ring-wiki-secondary');
                  setTimeout(function() {
                    refEl.classList.remove('ring-2', 'ring-wiki-secondary');
                  }, 2000);
                }
              }, 160);
            });
          });
        })();
      </script>

      ${metaScript}
      
      <script>
        // _t 파라미터 제거 (캐시 우회 후 URL 정리)
        (function() {
          if (window.location.search.includes('_t=')) {
            const url = new URL(window.location.href);
            url.searchParams.delete('_t');
            window.history.replaceState({}, '', url.toString());
          }
        })();
        
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

