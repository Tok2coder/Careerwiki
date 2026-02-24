/**
 * AI 추천 결과 이력 페이지
 * 직업/전공 탭으로 구분된 이력 목록
 */

export interface AiResultItem {
  id: number
  request_id: number
  session_id: string
  analysis_type: 'job' | 'major'
  top_recommendations: Array<{ name: string; score?: number }>
  confidence_score: number | null
  created_at: string
  engine_version?: string
  has_premium_report?: boolean
  version_number?: number
  version_note?: string | null
  parent_request_id?: number | null
}

export interface DraftItem {
  id: number
  session_id: string
  analysis_type: 'job' | 'major'
  current_step: number
  profile_sub_step?: number  // 프로필 서브스텝 (1: 5축, 2: 나를 알아가기)
  current_round?: number     // 심층 질문 라운드 (1-3)
  updated_at: string
  request_id?: number | null  // 완료된 분석의 request_id (결과 페이지 링크용)
}

export interface UserAiResultsProps {
  results: AiResultItem[]
  filter: 'all' | 'job' | 'major'
  totalCount: number
  page: number
  totalPages: number
  drafts?: DraftItem[]  // 여러 개의 draft 지원
  draft?: DraftItem     // 레거시 호환
}

function formatDate(dateStr: string): string {
  try {
    // DB 시간이 UTC 'YYYY-MM-DD HH:MM:SS' 형식일 수 있음
    // 'Z'를 붙여서 UTC로 명시적 파싱
    let date: Date
    if (dateStr.includes('T')) {
      date = new Date(dateStr)
    } else {
      // SQLite DATETIME 형식 'YYYY-MM-DD HH:MM:SS' -> UTC로 파싱
      date = new Date(dateStr.replace(' ', 'T') + 'Z')
    }
    
    return date.toLocaleString('ko-KR', {
      timeZone: 'Asia/Seoul',
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })
  } catch {
    return dateStr
  }
}

function formatRelativeTime(dateStr: string): string {
  try {
    // DB 시간이 UTC 'YYYY-MM-DD HH:MM:SS' 형식일 수 있음
    let date: Date
    if (dateStr.includes('T')) {
      date = new Date(dateStr)
    } else {
      // SQLite DATETIME 형식 'YYYY-MM-DD HH:MM:SS' -> UTC로 파싱
      date = new Date(dateStr.replace(' ', 'T') + 'Z')
    }
    
    const now = new Date()
    const diff = now.getTime() - date.getTime()
    const minutes = Math.floor(diff / 60000)
    const hours = Math.floor(minutes / 60)
    const days = Math.floor(hours / 24)
    
    if (minutes < 1) return '방금 전'
    if (minutes < 60) return `${minutes}분 전`
    if (hours < 24) return `${hours}시간 전`
    if (days < 7) return `${days}일 전`
    return formatDate(dateStr)
  } catch {
    return dateStr
  }
}

function getStepName(step: number): string {
  // 3단계 구조: 프로필 → 심층 → 결과
  const stepNames = ['', '프로필', '심층 질문', '결과']
  return stepNames[step] || `${step}단계`
}

// 3단계 구조 기준 진행률 계산
function calculateProgress(step: number, profileSubStep?: number, currentRound?: number): number {
  // Step 1: 0-33% (프로필 1/2: 0-16%, 프로필 2/2: 17-33%)
  // Step 2: 34-90% (기초: 34-50%, 라운드1: 51-60%, 라운드2: 61-70%, 라운드3: 71-90%)
  // Step 3: 100% (결과)
  
  if (step >= 3) return 100
  
  if (step === 1) {
    if (profileSubStep === 2) return 25
    return 10
  }
  
  if (step === 2) {
    if (currentRound && currentRound > 0) {
      // 라운드 진행 중: 50% + (라운드 * 15%)
      return Math.min(50 + (currentRound * 15), 90)
    }
    // 기초 서술형 진행 중
    return 40
  }
  
  return 10
}

// 현재 진행 중인 단계 이름 (3단계 구조)
function getCurrentStepLabel(step: number, profileSubStep?: number, currentRound?: number): string {
  // 3단계 구조: 프로필 → 심층 → 결과
  if (step >= 3) return '분석 완료!'
  
  if (step === 1) {
    if (profileSubStep === 2) return '프로필 2/2 진행 중'
    return '프로필 1/2 진행 중'
  }
  
  if (step === 2) {
    if (currentRound && currentRound > 0) {
      return `심층 질문 라운드 ${currentRound}/3`
    }
    return '심층 질문 기초 진행 중'
  }
  
  return '진행 중'
}

// 완료된 단계인지 확인 (3단계 구조)
function isAnalysisComplete(step: number): boolean {
  return step >= 3
}

export function renderUserAiResultsContent({ results, filter, totalCount, page, totalPages, drafts = [], draft }: UserAiResultsProps): string {
  const jobResults = results.filter(r => r.analysis_type === 'job')
  const majorResults = results.filter(r => r.analysis_type === 'major')

  const filteredResults = filter === 'job' ? jobResults
    : filter === 'major' ? majorResults
    : results

  // 버전 그룹핑: 같은 session_id의 결과를 그룹으로 묶기
  const sessionGroups = new Map<string, AiResultItem[]>()
  for (const r of filteredResults) {
    const key = r.session_id
    if (!sessionGroups.has(key)) {
      sessionGroups.set(key, [])
    }
    sessionGroups.get(key)!.push(r)
  }
  // 각 그룹 내에서 version_number 내림차순 정렬 (최신 먼저)
  for (const [, group] of sessionGroups) {
    group.sort((a, b) => (b.version_number || 1) - (a.version_number || 1))
  }
  // 그룹별 최신 결과를 기준으로 정렬
  const sortedGroups = [...sessionGroups.values()].sort((a, b) => {
    return new Date(b[0].created_at).getTime() - new Date(a[0].created_at).getTime()
  })
    
  // drafts 배열 우선, 레거시 draft 호환
  const allDrafts = drafts.length > 0 ? drafts : (draft ? [draft] : [])
  
  // 필터에 따른 draft 필터링
  const filteredDrafts = filter === 'all' ? allDrafts
    : allDrafts.filter(d => d.analysis_type === filter)

  // 진행중인 draft 카드
  const renderDraftCard = (draftItem: DraftItem) => {
    const isJob = draftItem.analysis_type === 'job'
    const typeLabel = isJob ? '직업 추천' : '전공 추천'
    const typeIcon = isJob ? 'fa-briefcase' : 'fa-university'
    const baseUrl = isJob ? '/analyzer/job' : '/analyzer/major'
    const continueUrl = `${baseUrl}?session_id=${encodeURIComponent(draftItem.session_id)}`
    const isComplete = isAnalysisComplete(draftItem.current_step)
    
    // 완료된 분석은 다른 스타일로 표시
    if (isComplete) {
      // 완료된 경우 결과 페이지로 이동 (request_id가 있으면 직접 이동, 없으면 분석 페이지)
      const resultUrl = draftItem.request_id 
        ? `/user/ai-results/${draftItem.request_id}`
        : continueUrl
      
      return `
        <div class="relative p-4 sm:p-5 rounded-xl border-2 transition-all hover:border-emerald-400/70 hover:shadow-lg hover:shadow-emerald-500/10 group"
             style="background: linear-gradient(135deg, rgba(16, 185, 129, 0.1) 0%, rgba(5, 150, 105, 0.05) 100%); border-color: rgba(16, 185, 129, 0.4);">
          <!-- 삭제 버튼 -->
          <button onclick="deleteDraft('${draftItem.session_id}')"
                  class="absolute top-3 right-3 w-10 h-10 rounded-lg bg-red-500/20 text-red-400 hover:bg-red-500/40 hover:text-red-300 transition-all flex items-center justify-center opacity-60 hover:opacity-100"
                  title="삭제">
            <i class="fas fa-trash text-sm"></i>
          </button>

          <a href="${resultUrl}" class="block">
            <div class="flex items-start justify-between gap-4 mb-4 pr-10">
              <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-lg flex items-center justify-center bg-emerald-500/20">
                  <i class="fas ${typeIcon} text-emerald-400"></i>
                </div>
                <div>
                  <h4 class="text-base font-bold text-white">${typeLabel}</h4>
                  <p class="text-xs text-emerald-300/70">${formatRelativeTime(draftItem.updated_at)}</p>
                </div>
              </div>
              <span class="px-3 py-1 rounded-full text-xs font-bold bg-emerald-500 text-white">
                완료!
              </span>
            </div>
            
            <!-- 완료 상태 표시 -->
            <div class="space-y-2">
              <div class="flex items-center gap-2">
                <div class="flex-1 h-2 rounded-full bg-wiki-bg/50 overflow-hidden">
                  <div class="h-full bg-gradient-to-r from-emerald-400 to-emerald-500 transition-all" style="width: 100%"></div>
                </div>
                <span class="text-xs text-emerald-300">완료</span>
              </div>
              <p class="text-sm text-white/80">
                <i class="fas fa-check-circle text-emerald-400 mr-1"></i>
                분석 완료! 결과를 확인하세요
              </p>
            </div>
            
            <div class="mt-4 pt-3 border-t flex items-center justify-between" style="border-color: rgba(16, 185, 129, 0.2);">
              <span class="text-xs text-emerald-300/60">완료: ${formatDate(draftItem.updated_at)}</span>
              <span class="text-xs text-emerald-400 group-hover:underline font-medium">
                결과 보기 <i class="fas fa-arrow-right ml-1"></i>
              </span>
            </div>
          </a>
        </div>
      `
    }
    
    return `
      <div class="relative p-4 sm:p-5 rounded-xl border-2 transition-all hover:border-amber-400/70 hover:shadow-lg hover:shadow-amber-500/10 group"
           style="background: linear-gradient(135deg, rgba(251, 191, 36, 0.1) 0%, rgba(245, 158, 11, 0.05) 100%); border-color: rgba(251, 191, 36, 0.4);">
        <!-- 삭제 버튼 -->
        <button onclick="deleteDraft('${draftItem.session_id}')"
                class="absolute top-3 right-3 w-10 h-10 rounded-lg bg-red-500/20 text-red-400 hover:bg-red-500/40 hover:text-red-300 transition-all flex items-center justify-center opacity-60 hover:opacity-100"
                title="삭제">
          <i class="fas fa-trash text-sm"></i>
        </button>

        <a href="${continueUrl}" class="block">
          <div class="flex items-start justify-between gap-4 mb-4 pr-10">
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-lg flex items-center justify-center bg-amber-500/20">
                <i class="fas ${typeIcon} text-amber-400"></i>
              </div>
              <div>
                <h4 class="text-base font-bold text-white">${typeLabel}</h4>
                <p class="text-xs text-amber-300/70">${formatRelativeTime(draftItem.updated_at)}</p>
              </div>
            </div>
            <span class="px-3 py-1 rounded-full text-xs font-bold bg-amber-500 text-black">
              진행중
            </span>
          </div>
          
          <!-- 진행 상황 -->
          <div class="space-y-2">
            <p class="text-xs font-medium text-amber-300/80">진행 상황</p>
            <div class="flex items-center gap-2">
              <div class="flex-1 h-2 rounded-full bg-wiki-bg/50 overflow-hidden">
                <div class="h-full bg-gradient-to-r from-amber-400 to-amber-500 transition-all" style="width: ${calculateProgress(draftItem.current_step, draftItem.profile_sub_step, draftItem.current_round)}%"></div>
              </div>
              <span class="text-xs text-amber-300">${calculateProgress(draftItem.current_step, draftItem.profile_sub_step, draftItem.current_round)}%</span>
            </div>
            <p class="text-sm text-white/80">
              <i class="fas fa-map-marker-alt text-amber-400 mr-1"></i>
              ${getCurrentStepLabel(draftItem.current_step, draftItem.profile_sub_step, draftItem.current_round)}
            </p>
          </div>
          
          <div class="mt-4 pt-3 border-t flex items-center justify-between" style="border-color: rgba(251, 191, 36, 0.2);">
            <span class="text-xs text-amber-300/60">마지막 작업: ${formatDate(draftItem.updated_at)}</span>
            <span class="text-xs text-amber-400 group-hover:underline font-medium">
              이어서 하기 <i class="fas fa-arrow-right ml-1"></i>
            </span>
          </div>
        </a>
      </div>
    `
  }

  // 완료된 결과 카드 (버전 정보 포함)
  const renderResultCard = (result: AiResultItem, versionCount?: number) => {
    const isJob = result.analysis_type === 'job'
    const typeLabel = isJob ? '직업 추천' : '전공 추천'
    const typeIcon = isJob ? 'fa-briefcase' : 'fa-university'
    const typeColor = isJob ? 'text-blue-400' : 'text-emerald-400'
    const typeBg = isJob ? 'bg-blue-500/10' : 'bg-emerald-500/10'

    const top3 = result.top_recommendations?.slice(0, 3) || []
    const confidence = result.confidence_score
      ? Math.round(result.confidence_score * 100)
      : null
    const version = result.version_number || 1
    const hasVersions = versionCount && versionCount > 1

    return `
      <div class="p-4 sm:p-5 rounded-xl border transition-all"
           style="background: rgba(26, 26, 46, 0.6); border-color: rgba(148, 163, 184, 0.15);">
        <div class="flex items-start justify-between gap-3 sm:gap-4 mb-4">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-lg flex items-center justify-center ${typeBg}">
              <i class="fas ${typeIcon} ${typeColor}"></i>
            </div>
            <div>
              <span class="text-sm font-medium text-white">${typeLabel}</span>
              <p class="text-xs" style="color: #9aa3c5;">${formatRelativeTime(result.created_at)}</p>
            </div>
          </div>
          <div class="flex items-center gap-1.5 flex-wrap justify-end">
            ${result.engine_version && result.engine_version.startsWith('v3') ? `
              <span class="px-2 py-0.5 rounded-full text-xs font-medium bg-purple-500/20 text-purple-400">Premium</span>
            ` : ''}
            ${hasVersions ? `
              <span class="px-2 py-0.5 rounded-full text-xs font-medium bg-sky-500/20 text-sky-400">
                v${version}
              </span>
            ` : ''}
          </div>
        </div>

        ${result.version_note ? `
          <p class="text-xs mb-3" style="color: #9aa3c5;">
            <i class="fas fa-tag mr-1"></i>${result.version_note}
          </p>
        ` : ''}

        <!-- TOP 3 -->
        ${top3.length > 0 ? `
          <div class="flex flex-wrap gap-2 mb-4">
            ${top3.map((rec, i) => `
              <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm"
                    style="background: rgba(67, 97, 238, 0.1); color: #e6e8f5;">
                <span class="text-xs font-bold ${i === 0 ? 'text-amber-400' : i === 1 ? 'text-slate-300' : 'text-amber-600'}">
                  ${i + 1}.
                </span>
                ${rec.name}
              </span>
            `).join('')}
          </div>
        ` : ''}

        <div class="pt-3 border-t flex items-center justify-between" style="border-color: rgba(148, 163, 184, 0.1);">
          <span class="text-xs" style="color: #9aa3c5;">${hasVersions ? `v${version} · ` : ''}${formatDate(result.created_at)}</span>
          <a href="/user/ai-results/${result.request_id}" target="_blank" rel="noopener"
             class="inline-flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition hover:opacity-90"
             style="background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%); color: #fff;">
            <i class="fas fa-file-alt"></i>리포트 보기
            <i class="fas fa-external-link-alt text-xs opacity-70"></i>
          </a>
        </div>
      </div>
    `
  }

  // 버전 히스토리 (이전 버전들 표시)
  const renderVersionHistory = (olderVersions: AiResultItem[]) => {
    if (olderVersions.length === 0) return ''
    return `
      <div class="ml-4 pl-4 border-l-2 space-y-2" style="border-color: rgba(148, 163, 184, 0.1);">
        ${olderVersions.map(v => `
          <a href="/user/ai-results/${v.request_id}"
             class="block p-3 rounded-lg transition hover:bg-wiki-card/50"
             style="background: rgba(26, 26, 46, 0.3);">
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-2">
                <span class="px-1.5 py-0.5 rounded text-xs font-medium bg-sky-500/15 text-sky-400/70">v${v.version_number || 1}</span>
                <span class="text-xs" style="color: #9aa3c5;">${v.version_note || '최초 분석'}</span>
              </div>
              <span class="text-xs" style="color: #9aa3c5;">${formatRelativeTime(v.created_at)}</span>
            </div>
          </a>
        `).join('')}
      </div>
    `
  }

  // draft 카운트
  const jobDraftCount = allDrafts.filter(d => d.analysis_type === 'job').length
  const majorDraftCount = allDrafts.filter(d => d.analysis_type === 'major').length

  return `
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto">
        <a href="/user/ai-results?filter=all"
           class="px-4 py-2.5 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'all' ? 'text-white' : ''}"
           style="${filter === 'all' ? 'background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);' : 'color: #9aa3c5;'}">
          전체
        </a>
        <a href="/user/ai-results?filter=job"
           class="px-4 py-2.5 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'job' ? 'text-white' : ''}"
           style="${filter === 'job' ? 'background: rgba(59, 130, 246, 0.3); color: #fff;' : 'color: #9aa3c5;'}">
          <i class="fas fa-briefcase mr-1.5 text-blue-400"></i>직업 추천
        </a>
        <a href="/user/ai-results?filter=major"
           class="px-4 py-2.5 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'major' ? 'text-white' : ''}"
           style="${filter === 'major' ? 'background: rgba(16, 185, 129, 0.3); color: #fff;' : 'color: #9aa3c5;'}">
          <i class="fas fa-university mr-1.5 text-emerald-400"></i>전공 추천
        </a>
      </div>
      
      <!-- 진행중 모두 삭제 버튼 (2개 이상일 때만) -->
      ${allDrafts.length >= 2 ? `
        <div class="flex justify-end mb-4">
          <button onclick="deleteAllDrafts()" class="px-4 py-2.5 text-sm text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition flex items-center gap-2">
            <i class="fas fa-trash"></i>
            진행중 모두 삭제 (${allDrafts.length}개)
          </button>
        </div>
      ` : ''}
      
      <!-- 결과 목록 -->
      ${filteredDrafts.length > 0 || sortedGroups.length > 0 ? `
        <div class="space-y-4">
          ${filteredDrafts.map(d => renderDraftCard(d)).join('')}
          ${sortedGroups.map(group => {
            const latest = group[0]
            const olderVersions = group.slice(1)
            const groupId = `versions-${latest.session_id.replace(/[^a-zA-Z0-9]/g, '_')}`
            return `
              <div class="space-y-2">
                ${renderResultCard(latest, group.length)}
                ${olderVersions.length > 0 ? `
                  <button onclick="document.getElementById('${groupId}').classList.toggle('hidden')"
                          class="ml-4 text-xs px-3 py-1.5 rounded-lg transition hover:bg-wiki-card/50"
                          style="color: #9aa3c5;">
                    <i class="fas fa-history mr-1"></i>이전 버전 ${olderVersions.length}개
                  </button>
                  <div id="${groupId}" class="hidden">
                    ${renderVersionHistory(olderVersions)}
                  </div>
                ` : ''}
              </div>
            `
          }).join('')}
        </div>
        
        <!-- 페이지네이션 -->
        ${totalPages > 1 ? `
          <div class="flex items-center justify-center gap-2 mt-8">
            ${page > 1 ? `
              <a href="/user/ai-results?filter=${filter}&page=${page - 1}"
                 class="px-5 py-2.5 rounded-lg text-sm transition"
                 style="background: rgba(26, 26, 46, 0.6); color: #9aa3c5;">
                <i class="fas fa-chevron-left mr-1"></i> 이전
              </a>
            ` : ''}
            <span class="px-4 py-2.5 text-sm" style="color: #9aa3c5;">
              ${page} / ${totalPages}
            </span>
            ${page < totalPages ? `
              <a href="/user/ai-results?filter=${filter}&page=${page + 1}"
                 class="px-5 py-2.5 rounded-lg text-sm transition"
                 style="background: rgba(26, 26, 46, 0.6); color: #9aa3c5;">
                다음 <i class="fas fa-chevron-right ml-1"></i>
              </a>
            ` : ''}
          </div>
        ` : ''}
      ` : `
        <div class="text-center py-10 sm:py-16">
          <div class="inline-flex items-center justify-center w-20 h-20 rounded-full mb-6" style="background: rgba(67, 97, 238, 0.1);">
            <i class="fas fa-robot text-3xl" style="color: #4361ee;"></i>
          </div>
          <h3 class="text-xl font-semibold text-white mb-3">
            ${filter === 'all' ? 'AI 추천 결과가 없습니다' : filter === 'job' ? '직업 추천 결과가 없습니다' : '전공 추천 결과가 없습니다'}
          </h3>
          <p class="mb-6 text-wiki-muted">
            AI 추천을 받아보세요! 당신에게 딱 맞는 ${filter === 'major' ? '전공' : '직업'}을 찾아드립니다.
          </p>
          <a href="${filter === 'major' ? '/analyzer/major' : '/analyzer/job'}" 
             class="inline-flex items-center gap-2 px-6 py-3 rounded-xl text-white font-medium transition hover:opacity-90"
             style="background: linear-gradient(135deg, #4361ee 0%, #64b5f6 100%);">
            <i class="fas fa-brain"></i>
            AI 추천 시작하기
          </a>
        </div>
      `}
  `
}
