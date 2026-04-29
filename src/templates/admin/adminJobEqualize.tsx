/**
 * 관리자 직업/전공 데이터 보완 현황 대시보드
 * - DB 실시간 조회 (user_contributed_json 파싱)
 * - 12개 필드별 완성도
 * - 스킬 적용 여부 (page_revisions.change_summary 마커 기반)
 * - 직업/전공 탭 전환
 * - 클라이언트 사이드 필터/정렬/검색/페이지네이션
 */

import { renderAdminLayout } from './adminLayout'

export type EqualizeTab = 'job' | 'major'

export const EQUALIZE_FIELDS = [
  'way', 'overviewSalary', 'overviewProspect', 'trivia',
  'detailWlb', 'detailReady', 'sidebarJobs', 'sidebarMajors',
  'sidebarCerts', 'heroTags', 'youtubeLinks', '_sources',
] as const

export const EQUALIZE_FIELD_LABELS: Record<string, string> = {
  way: '진입방법',
  overviewSalary: '임금',
  overviewProspect: '전망',
  trivia: '여담',
  detailWlb: '워라밸',
  detailReady: '준비방법',
  sidebarJobs: '관련직업',
  sidebarMajors: '관련전공',
  sidebarCerts: '자격증',
  heroTags: '태그',
  youtubeLinks: 'YouTube',
  _sources: '출처',
}

export const EQUALIZE_FIELD_TOOLTIPS: Record<string, string> = {
  way: 'way 필드 — 직업 진입 경로/방법 정보',
  overviewSalary: 'overviewSalary 필드 — 급여/임금 정보',
  overviewProspect: 'overviewProspect 필드 — 직업 전망 정보',
  trivia: 'trivia 필드 — 여담/재미있는 사실',
  detailWlb: 'detailWlb 필드 — 워라밸 상세 정보',
  detailReady: 'detailReady 필드 — 준비 방법 상세',
  sidebarJobs: 'sidebarJobs 필드 — 관련 직업 목록',
  sidebarMajors: 'sidebarMajors 필드 — 관련 전공 목록',
  sidebarCerts: 'sidebarCerts 필드 — 관련 자격증 목록',
  heroTags: 'heroTags 필드 — 직업 태그 배열',
  youtubeLinks: 'youtubeLinks 필드 — YouTube 관련 영상 링크',
  _sources: '_sources 필드 — 출처 정보 존재 여부',
}

export interface JobEqualizeItem {
  name: string
  slug: string
  fields: boolean[]   // 12 fields in EQUALIZE_FIELDS order
  fieldCount: number   // X/12
  jsonSize: number     // bytes
  sourceCount: number  // 출처 총 항목 수
  urlSourceCount: number // URL이 포함된 출처 수
  youtubeCount: number
  skillApplied: boolean // page_revisions.change_summary에 스킬 마커 존재 여부
  skillLastAppliedAt: string | null // 최근 스킬 적용 시각 ('YYYY-MM-DD HH:MM:SS' or null)
  // 품질 플래그
  wayIsArray: boolean     // way가 배열 형식 (위험)
  imageUrlBad: boolean    // image_url 포맷 오류 (경고)
  wayTrunc: boolean       // way 잘린 텍스트 의심 (주의)
  srcOrderBad: boolean    // _sources 첫 항목이 커리어넷 아님 (주의)
  ytLow: boolean          // youtubeLinks 0개 + _youtubeSearchNote 없음 (진짜 누락, 주의)
}

export interface QualityAlerts {
  wayIsArray: number
  imageUrlBad: number
  wayTrunc: number
  srcOrderBad: number
  ytLow: number
}

export interface AdminJobEqualizeProps {
  tab: EqualizeTab             // 'job' | 'major'
  totalJobs: number            // tab 엔티티 총 수 (전체 활성)
  contributedCount: number     // user_contributed_json 존재 수
  perfectCount: number         // 12/12
  poorCount: number            // <6
  avgJsonSize: number
  items: JobEqualizeItem[]
  qualityAlerts: QualityAlerts
  skillAppliedCount: number    // 스킬 적용된 엔티티 수
}

/** Check if a field has meaningful content */
export function hasField(json: any, key: string): boolean {
  const val = json[key]
  if (val === null || val === undefined) return false
  if (typeof val === 'string') return val.trim().length > 0
  if (Array.isArray(val)) return val.length > 0
  if (typeof val === 'object') return Object.keys(val).length > 0
  return true
}

/**
 * _sources 파싱: 다양한 구조 처리
 * 1. Object: {"way":[{"id":1,"text":"...","url":"..."}]} → 모든 섹션 배열 합산
 * 2. Array: ["워크넷", "한국가스공사"] or [{text, url}] → 배열 길이
 * 3. null/undefined → 0
 */
export function parseSources(sources: any): { sourceCount: number; urlSourceCount: number } {
  if (!sources) return { sourceCount: 0, urlSourceCount: 0 }

  // Case 1: Array (flat list or array of objects)
  if (Array.isArray(sources)) {
    const sourceCount = sources.length
    let urlSourceCount = 0
    for (const s of sources) {
      if (typeof s === 'string' && s.startsWith('http')) {
        urlSourceCount++
      } else if (typeof s === 'object' && s !== null && typeof s.url === 'string' && s.url.startsWith('http')) {
        urlSourceCount++
      }
    }
    return { sourceCount, urlSourceCount }
  }

  // Case 2: Object with section keys (e.g. {"way": [...], "overviewSalary": [...]})
  if (typeof sources === 'object') {
    let sourceCount = 0
    let urlSourceCount = 0
    for (const key of Object.keys(sources)) {
      const arr = sources[key]
      if (Array.isArray(arr)) {
        sourceCount += arr.length
        for (const s of arr) {
          if (typeof s === 'string' && s.startsWith('http')) {
            urlSourceCount++
          } else if (typeof s === 'object' && s !== null && typeof s.url === 'string' && s.url.startsWith('http')) {
            urlSourceCount++
          }
        }
      }
    }
    return { sourceCount, urlSourceCount }
  }

  return { sourceCount: 0, urlSourceCount: 0 }
}

export function renderAdminJobEqualize(props: AdminJobEqualizeProps): string {
  const { tab, totalJobs, contributedCount, perfectCount, poorCount, avgJsonSize, items, qualityAlerts, skillAppliedCount } = props
  const skillAppliedPct = totalJobs > 0 ? ((skillAppliedCount / totalJobs) * 100).toFixed(1) : '0.0'

  const isJob = tab === 'job'
  const entityLabel = isJob ? '직업' : '전공'
  const entityUrlPrefix = isJob ? '/job/' : '/major/'
  const skillName = isJob ? 'job-data-enhance' : 'major-data-enhance'

  const itemsJson = JSON.stringify(items)

  function alertCard(filterKey: string, label: string, count: number, level: 'danger' | 'warning' | 'caution'): string {
    const colors = {
      danger:  { dot: 'bg-red-500',    num: 'text-red-400',    border: 'border-red-500/30',  badge: '위험' },
      warning: { dot: 'bg-orange-500', num: 'text-orange-400', border: 'border-orange-500/30', badge: '경고' },
      caution: { dot: 'bg-yellow-500', num: 'text-yellow-400', border: 'border-yellow-500/30', badge: '주의' },
    }
    const c = colors[level]
    if (count === 0) {
      return `<div class="glass-card rounded-xl p-3 border border-green-500/20">
        <div class="flex items-center gap-1.5 mb-1"><span class="w-2 h-2 rounded-full bg-green-500"></span><span class="text-[11px] text-slate-300">${label}</span></div>
        <div class="text-xl font-bold text-green-400">0</div>
        <div class="text-[10px] text-green-500">정상 ✓</div>
      </div>`
    }
    return `<button onclick="setQualityFilter('${filterKey}')" class="glass-card rounded-xl p-3 border ${c.border} text-left hover:brightness-110 transition-all cursor-pointer">
      <div class="flex items-center gap-1.5 mb-1"><span class="w-2 h-2 rounded-full ${c.dot}"></span><span class="text-[11px] text-slate-300">${label}</span></div>
      <div class="text-xl font-bold ${c.num}">${count.toLocaleString()}</div>
      <div class="text-[10px] text-slate-500">${c.badge} · 클릭 필터</div>
    </button>`
  }

  const content = `
    <!-- 커스텀 툴팁 스타일 -->
    <style>
      th[data-tooltip] {
        position: relative;
        cursor: help;
      }
      th[data-tooltip]::after {
        content: attr(data-tooltip);
        position: absolute;
        top: 100%;
        left: 50%;
        transform: translateX(-50%);
        white-space: nowrap;
        background: #111827;
        color: #f1f5f9;
        font-size: 11px;
        font-weight: 400;
        padding: 6px 10px;
        border-radius: 6px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.4);
        z-index: 50;
        pointer-events: none;
        opacity: 0;
        transition: opacity 0.15s ease;
      }
      th[data-tooltip]:hover::after {
        opacity: 1;
      }
    </style>

    <!-- 탭 네비게이션 -->
    <div class="glass-card rounded-xl p-1 mb-4 inline-flex gap-1">
      <a href="/admin/job-equalize?tab=job"
         class="px-4 py-2 rounded-lg text-sm font-medium transition-all ${isJob ? 'bg-blue-500/20 text-blue-300' : 'text-slate-400 hover:text-white'}">
        <i class="fas fa-briefcase mr-1.5 text-xs"></i>직업
      </a>
      <a href="/admin/job-equalize?tab=major"
         class="px-4 py-2 rounded-lg text-sm font-medium transition-all ${!isJob ? 'bg-purple-500/20 text-purple-300' : 'text-slate-400 hover:text-white'}">
        <i class="fas fa-graduation-cap mr-1.5 text-xs"></i>전공
      </a>
    </div>

    <!-- 요약 통계 KPI — 사용자 KPI = [${skillName}] 마커 적용 여부 -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3 mb-6">
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 ${isJob ? 'bg-blue-500/20' : 'bg-purple-500/20'} rounded-lg flex items-center justify-center">
            <i class="fas ${isJob ? 'fa-briefcase text-blue-400' : 'fa-graduation-cap text-purple-400'} text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">전체 ${entityLabel}</span>
        </div>
        <div class="text-xl font-bold text-white">${totalJobs.toLocaleString()}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card" title="change_summary에 [${skillName}] 마커가 있는 ${entityLabel} (스킬 돌린 수)">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-cyan-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-wand-magic-sparkles text-cyan-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">스킬 적용</span>
        </div>
        <div class="text-xl font-bold text-cyan-400">${skillAppliedCount.toLocaleString()}</div>
        <div class="text-[10px] text-slate-500">${skillAppliedPct}%</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card" title="[${skillName}] 마커가 없는 ${entityLabel} (스킬 안 돌린 수)">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-slate-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-circle-xmark text-slate-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">스킬 미적용</span>
        </div>
        <div class="text-xl font-bold text-slate-300">${(totalJobs - skillAppliedCount).toLocaleString()}</div>
        <div class="text-[10px] text-slate-500">${(100 - parseFloat(skillAppliedPct)).toFixed(1)}%</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-red-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-exclamation-triangle text-red-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">부실 (&lt;6)</span>
        </div>
        <div class="text-xl font-bold text-red-400">${poorCount}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-green-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-star text-green-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">완벽 (12/12)</span>
        </div>
        <div class="text-xl font-bold text-green-400">${perfectCount}</div>
      </div>
      <div class="glass-card rounded-xl p-4 stat-card">
        <div class="flex items-center gap-2 mb-2">
          <div class="w-8 h-8 bg-purple-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-database text-purple-400 text-xs"></i>
          </div>
          <span class="text-[11px] text-slate-400">평균 JSON</span>
        </div>
        <div class="text-xl font-bold text-purple-400">${avgJsonSize > 1024 ? (avgJsonSize / 1024).toFixed(1) + 'KB' : avgJsonSize + 'B'}</div>
      </div>
    </div>

    <!-- 진행률 바 (스킬 적용률 기준) -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center justify-between mb-2">
        <div class="flex items-center gap-2">
          <i class="fas fa-wand-magic-sparkles text-cyan-400 text-xs"></i>
          <h3 class="text-sm font-semibold text-white">스킬 적용률</h3>
          <span class="text-[10px] text-slate-500">[${skillName}] 마커 기준 · 사용자 KPI</span>
        </div>
        <span class="text-sm font-bold text-cyan-400">${skillAppliedCount.toLocaleString()} / ${totalJobs.toLocaleString()} · ${skillAppliedPct}%</span>
      </div>
      <div class="w-full bg-slate-700/60 rounded-full h-2.5 overflow-hidden">
        <div class="h-2.5 rounded-full bg-gradient-to-r from-cyan-500 to-cyan-400" style="width: ${skillAppliedPct}%"></div>
      </div>
    </div>

    <!-- 품질 경보 섹션 -->
    <div class="glass-card rounded-xl p-4 mb-6">
      <div class="flex items-center gap-2 mb-3">
        <i class="fas fa-shield-alt text-amber-400 text-sm"></i>
        <h3 class="text-sm font-semibold text-white">품질 경보</h3>
        <span class="text-xs text-slate-500">카드 클릭 시 해당 직업만 필터링</span>
      </div>
      <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-3">
        ${alertCard('wayIsArray', 'way 배열 오류', qualityAlerts.wayIsArray, 'danger')}
        ${alertCard('imageUrlBad', '이미지 URL 오류', qualityAlerts.imageUrlBad, 'warning')}
        ${alertCard('wayTrunc', 'way 잘린 텍스트', qualityAlerts.wayTrunc, 'caution')}
        ${alertCard('srcOrderBad', '_sources 순서 오류', qualityAlerts.srcOrderBad, 'caution')}
        ${alertCard('ytLow', 'YT 3개 미만', qualityAlerts.ytLow, 'caution')}
      </div>
    </div>

    <!-- 필터/검색 바 -->
    <div class="glass-card rounded-xl p-4 mb-4">
      <div class="flex flex-wrap items-center gap-3">
        <!-- 검색 -->
        <div class="relative flex-1 min-w-[200px]">
          <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-500 text-xs"></i>
          <input id="searchInput" type="text" placeholder="${entityLabel}명 검색..."
            class="w-full pl-9 pr-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white placeholder-slate-500 focus:outline-none focus:border-blue-500/50" />
        </div>
        <!-- 필터 -->
        <select id="filterSelect" class="px-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white focus:outline-none focus:border-blue-500/50">
          <option value="all">전체 (${totalJobs.toLocaleString()})</option>
          <option value="perfect">완벽 12/12 (${perfectCount})</option>
          <option value="good">양호 6~11 (${contributedCount - perfectCount - poorCount})</option>
          <option value="poor">부실 &lt;6 (${poorCount})</option>
          <optgroup label="── 스킬 적용 ──">
            <option value="skillApplied">스킬 적용됨</option>
            <option value="skillNotApplied">스킬 미적용</option>
          </optgroup>
          <optgroup label="── 품질 이슈 ──">
            <option value="quality">품질 이슈 있음</option>
            <option value="wayIsArray">way 배열 오류</option>
            <option value="imageUrlBad">이미지 URL 오류</option>
            <option value="wayTrunc">way 잘린 텍스트</option>
            <option value="srcOrderBad">_sources 순서 오류</option>
            <option value="ytLow">YT 3개 미만</option>
          </optgroup>
        </select>
        <!-- 정렬 -->
        <select id="sortSelect" class="px-3 py-2 bg-slate-800/60 border border-slate-600/50 rounded-lg text-sm text-white focus:outline-none focus:border-blue-500/50">
          <option value="skill-desc" selected>스킬 적용순 (최근)</option>
          <option value="name-asc">이름순 ↑</option>
          <option value="name-desc">이름순 ↓</option>
          <option value="field-desc">완성도 높은순</option>
          <option value="field-asc">완성도 낮은순</option>
          <option value="size-desc">JSON 큰순</option>
          <option value="size-asc">JSON 작은순</option>
          <option value="yt-asc">YT수 낮은순</option>
        </select>
      </div>
      <div class="mt-2 text-xs text-slate-500">
        <span id="resultCount">${totalJobs.toLocaleString()}</span>개 ${entityLabel} 표시 중
      </div>
    </div>

    <!-- 목록 테이블 -->
    <div class="glass-card rounded-xl overflow-hidden">
      <div class="overflow-x-auto admin-mini-scroll">
        <table class="w-full text-sm">
          <thead>
            <tr class="text-left border-b border-slate-700/50 bg-slate-800/40">
              <th class="px-4 py-3 text-xs text-slate-400 font-medium sticky left-0 bg-slate-800/90 z-10 min-w-[140px]" data-tooltip="${entityLabel}명 (클릭하면 프로덕션 페이지로 이동)">${entityLabel}명</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center min-w-[56px]" data-tooltip="change_summary에 [${skillName}] 마커가 있는지">스킬</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[60px]" data-tooltip="12개 필드 중 채워진 필드 수 (n/12)">완성도</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="way 필드 — 직업 진입 경로/방법 정보">방법</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="overviewSalary 필드 — 급여/임금 정보">임금</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="overviewProspect 필드 — 직업 전망 정보">전망</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="trivia 필드 — 여담/재미있는 사실">여담</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="detailWlb 필드 — 워라밸 상세 정보">WLB</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="detailReady 필드 — 준비 방법 상세">준비</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="sidebarJobs 필드 — 관련 직업 목록">직업</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="sidebarMajors 필드 — 관련 전공 목록">전공</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="sidebarCerts 필드 — 관련 자격증 목록">자격</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="heroTags 필드 — 직업 태그 배열">태그</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="youtubeLinks 필드 — YouTube 링크 존재 여부">YT</th>
              <th class="px-2 py-3 text-xs text-slate-400 font-medium text-center" data-tooltip="_sources 필드 — 출처 정보 존재 여부">출처</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[60px]" data-tooltip="user_contributed_json 총 바이트 수">JSON</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" data-tooltip="출처 항목 수 (Object: 섹션 합산, Array: 배열 길이)">출처수</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" data-tooltip="URL(http)이 포함된 출처 수">URL</th>
              <th class="px-3 py-3 text-xs text-slate-400 font-medium text-center min-w-[40px]" data-tooltip="youtubeLinks 배열 내 YouTube 링크 수">YT수</th>
            </tr>
          </thead>
          <tbody id="tableBody" class="divide-y divide-slate-700/30">
          </tbody>
        </table>
      </div>
      <!-- 페이지네이션 -->
      <div class="flex items-center justify-between px-4 py-3 border-t border-slate-700/50">
        <span class="text-xs text-slate-500">페이지 <span id="pageInfo">1/1</span></span>
        <div class="flex gap-2">
          <button id="prevBtn" class="px-3 py-1.5 bg-slate-700/50 rounded text-xs text-slate-400 hover:bg-slate-600/50 disabled:opacity-30 disabled:cursor-not-allowed" disabled>
            <i class="fas fa-chevron-left mr-1"></i>이전
          </button>
          <button id="nextBtn" class="px-3 py-1.5 bg-slate-700/50 rounded text-xs text-slate-400 hover:bg-slate-600/50 disabled:opacity-30 disabled:cursor-not-allowed" disabled>
            다음<i class="fas fa-chevron-right ml-1"></i>
          </button>
        </div>
      </div>
    </div>

    <script>
    (function() {
      var ITEMS = ${itemsJson};
      var URL_PREFIX = ${JSON.stringify(entityUrlPrefix)};
      var PAGE_SIZE = 50;
      var currentPage = 1;
      var filtered = ITEMS;

      var searchInput = document.getElementById('searchInput');
      var filterSelect = document.getElementById('filterSelect');
      var sortSelect = document.getElementById('sortSelect');
      var tableBody = document.getElementById('tableBody');
      var resultCount = document.getElementById('resultCount');
      var pageInfo = document.getElementById('pageInfo');
      var prevBtn = document.getElementById('prevBtn');
      var nextBtn = document.getElementById('nextBtn');

      function setQualityFilter(key) {
        filterSelect.value = key;
        applyFilters();
      }
      window.setQualityFilter = setQualityFilter;

      function applyFilters() {
        var query = searchInput.value.trim().toLowerCase();
        var filter = filterSelect.value;
        var sort = sortSelect.value;

        filtered = ITEMS.filter(function(item) {
          if (query && item.name.toLowerCase().indexOf(query) === -1) return false;
          if (filter === 'perfect' && item.fieldCount !== 12) return false;
          if (filter === 'good' && (item.fieldCount < 6 || item.fieldCount >= 12)) return false;
          if (filter === 'poor' && item.fieldCount >= 6) return false;
          if (filter === 'skillApplied' && !item.skillApplied) return false;
          if (filter === 'skillNotApplied' && item.skillApplied) return false;
          if (filter === 'quality' && !(item.wayIsArray || item.imageUrlBad || item.wayTrunc || item.srcOrderBad || item.ytLow)) return false;
          if (filter === 'wayIsArray' && !item.wayIsArray) return false;
          if (filter === 'imageUrlBad' && !item.imageUrlBad) return false;
          if (filter === 'wayTrunc' && !item.wayTrunc) return false;
          if (filter === 'srcOrderBad' && !item.srcOrderBad) return false;
          if (filter === 'ytLow' && !item.ytLow) return false;
          return true;
        });

        var parts = sort.split('-');
        var key = parts[0], dir = parts[1];
        filtered.sort(function(a, b) {
          // 스킬 적용순: 적용된 것 먼저, 그 안에서 최근 적용일시 desc. 미적용끼리는 이름 asc.
          if (key === 'skill') {
            if (a.skillApplied !== b.skillApplied) return a.skillApplied ? -1 : 1;
            if (a.skillApplied) {
              var at = a.skillLastAppliedAt || '';
              var bt = b.skillLastAppliedAt || '';
              if (at !== bt) return bt.localeCompare(at); // desc
            }
            return a.name.localeCompare(b.name, 'ko');
          }
          var va, vb;
          if (key === 'name') { va = a.name; vb = b.name; }
          else if (key === 'field') { va = a.fieldCount; vb = b.fieldCount; }
          else if (key === 'size') { va = a.jsonSize; vb = b.jsonSize; }
          else if (key === 'yt') { va = a.youtubeCount; vb = b.youtubeCount; }
          if (typeof va === 'string') {
            var cmp = va.localeCompare(vb, 'ko');
            return dir === 'asc' ? cmp : -cmp;
          }
          return dir === 'asc' ? va - vb : vb - va;
        });

        currentPage = 1;
        render();
      }

      function formatSize(bytes) {
        if (bytes > 1024) return (bytes / 1024).toFixed(1) + 'K';
        return bytes + 'B';
      }

      function render() {
        var totalPages = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
        if (currentPage > totalPages) currentPage = totalPages;
        var start = (currentPage - 1) * PAGE_SIZE;
        var page = filtered.slice(start, start + PAGE_SIZE);

        resultCount.textContent = filtered.length;
        pageInfo.textContent = currentPage + '/' + totalPages;
        prevBtn.disabled = currentPage <= 1;
        nextBtn.disabled = currentPage >= totalPages;

        var html = '';
        for (var i = 0; i < page.length; i++) {
          var item = page[i];
          var pct = Math.round((item.fieldCount / 12) * 100);
          var barColor = pct === 100 ? 'bg-green-500' : pct >= 50 ? 'bg-emerald-500' : 'bg-red-500';
          var countColor = item.fieldCount === 12 ? 'text-green-400' : item.fieldCount >= 6 ? 'text-emerald-400' : 'text-red-400';

          // 품질 이슈 행 강조
          var hasDanger  = item.wayIsArray;
          var hasWarning = item.imageUrlBad;
          var hasCaution = item.wayTrunc || item.srcOrderBad || item.ytLow;
          var rowBorder  = hasDanger  ? 'border-left:3px solid #ef4444;'
                         : hasWarning ? 'border-left:3px solid #f97316;'
                         : hasCaution ? 'border-left:3px solid #eab308;'
                         : '';

          html += '<tr class="hover:bg-slate-700/20 transition-colors" style="' + rowBorder + '">';
          html += '<td class="px-4 py-2 sticky left-0 bg-slate-900/80 z-10">';
          html += '<a href="https://careerwiki.org' + URL_PREFIX + encodeURIComponent(item.slug) + '" target="_blank" class="text-blue-400 hover:text-blue-300 font-medium text-xs">' + item.name + '</a>';
          if (item.imageUrlBad) html += '<span class="ml-1 text-orange-400 text-[10px]" title="이미지 URL 포맷 오류">⚠</span>';
          html += '</td>';
          html += '<td class="px-2 py-2 text-center">';
          if (item.skillApplied) {
            var tipAt = item.skillLastAppliedAt ? ' · 최근 ' + item.skillLastAppliedAt : '';
            html += '<span class="inline-flex items-center gap-1 px-1.5 py-0.5 rounded bg-cyan-500/15 text-cyan-400 text-[10px]" title="스킬 적용됨' + tipAt + '"><i class="fas fa-wand-magic-sparkles text-[9px]"></i>적용</span>';
          } else {
            html += '<span class="text-slate-600 text-[10px]" title="스킬 미적용">—</span>';
          }
          html += '</td>';
          html += '<td class="px-3 py-2 text-center">';
          html += '<div class="flex items-center gap-1.5 justify-center">';
          html += '<div class="w-12 bg-slate-700/50 rounded-full h-1.5"><div class="h-1.5 rounded-full ' + barColor + '" style="width:' + pct + '%"></div></div>';
          html += '<span class="text-[11px] font-mono ' + countColor + '">' + item.fieldCount + '</span>';
          html += '</div></td>';

          for (var f = 0; f < 12; f++) {
            var has = item.fields[f];
            html += '<td class="px-2 py-2 text-center">';
            // way 필드(f=0): wayIsArray 또는 wayTrunc 경고
            if (f === 0 && has && (item.wayIsArray || item.wayTrunc)) {
              var wayTitle = item.wayIsArray ? 'way가 배열 형식(오류)' : 'way 잘린 텍스트 의심';
              var wayIcon  = item.wayIsArray ? 'text-red-400' : 'text-yellow-400';
              html += '<i class="fas fa-check ' + wayIcon + ' text-[10px]" title="' + wayTitle + '"></i>';
              html += '<span class="' + wayIcon + ' text-[10px]" title="' + wayTitle + '"> ⚠</span>';
            }
            // _sources 필드(f=11): srcOrderBad 경고
            else if (f === 11 && has && item.srcOrderBad) {
              html += '<i class="fas fa-check text-yellow-400 text-[10px]" title="_sources 첫 항목이 커리어넷이 아님"></i>';
              html += '<span class="text-yellow-400 text-[10px]" title="_sources 순서 오류"> ⚠</span>';
            } else if (has) {
              html += '<i class="fas fa-check text-emerald-400 text-[10px]"></i>';
            } else {
              html += '<i class="fas fa-times text-slate-600 text-[10px]"></i>';
            }
            html += '</td>';
          }

          html += '<td class="px-3 py-2 text-center text-[11px] text-slate-400 font-mono">' + formatSize(item.jsonSize) + '</td>';
          html += '<td class="px-3 py-2 text-center text-[11px] text-slate-400">' + item.sourceCount + '</td>';
          html += '<td class="px-3 py-2 text-center text-[11px]">';
          if (item.urlSourceCount > 0) {
            html += '<span class="text-blue-400">' + item.urlSourceCount + '</span>';
          } else if (item.sourceCount > 0) {
            html += '<span class="text-amber-500" title="출처는 있으나 URL 없음">0</span>';
          } else {
            html += '<span class="text-slate-600">-</span>';
          }
          html += '</td>';
          var ytColor = item.ytLow ? 'text-amber-400' : 'text-slate-400';
          html += '<td class="px-3 py-2 text-center text-[11px] ' + ytColor + '">' + item.youtubeCount + (item.ytLow && item.youtubeCount > 0 ? ' ⚠' : '') + '</td>';
          html += '</tr>';
        }
        tableBody.innerHTML = html;
      }

      searchInput.addEventListener('input', applyFilters);
      filterSelect.addEventListener('change', applyFilters);
      sortSelect.addEventListener('change', applyFilters);
      prevBtn.addEventListener('click', function() { if (currentPage > 1) { currentPage--; render(); } });
      nextBtn.addEventListener('click', function() { currentPage++; render(); });

      applyFilters();
    })();
    </script>
  `

  return renderAdminLayout({
    title: `데이터 보완 현황 (${entityLabel})`,
    currentPath: '/admin/job-equalize',
    children: content,
  })
}
