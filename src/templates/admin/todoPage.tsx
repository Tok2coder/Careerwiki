/**
 * /admin/todo — 잔여 작업·미구현 항목 한 곳에 정리
 *
 * 정책·시스템에 명시되어 있지만 코드로 구현되지 않은 항목들을 관리자가 한 페이지에서
 * 확인할 수 있도록. "다음에 뭐 해야 돼?" 또는 "잔여 작업 있어?" 라는 질문에 답하는 곳.
 *
 * 항목을 추가/제거하려면 이 파일의 TODO_ITEMS 배열만 수정하면 됨.
 */

import { renderAdminLayout } from './adminLayout'

type Priority = 'critical' | 'high' | 'medium' | 'low'
type Category = 'auth' | 'admin-ui' | 'cron' | 'ui-polish' | 'policy-decision' | 'data-quality'

type TodoItem = {
  id: string
  priority: Priority
  category: Category
  title: string
  description: string
  why_pending: string
  what_now: string
  related_policy?: string
  blocked_by?: string
}

// ========================================================================
// 미구현·잔여 작업 목록 — 여기를 수정하면 된다
// ========================================================================
const TODO_ITEMS: TodoItem[] = [
  // ── 결정 대기 (사용자만 결정 가능)
  {
    id: 'decision-auth',
    priority: 'medium',
    category: 'auth',
    title: '인증 시스템 (커리어트리 영역)',
    description: '학교/직업 인증을 통한 신뢰 라벨 시스템(예: "○○대 4학년", "현직 5년차 PM").',
    why_pending: '커리어트리 영역에서만 의미가 있고, 정확한 도입 시점·범위가 아직 미정.',
    what_now: '커리어트리 기획이 완료되면 정책에 다시 추가하고 인프라 구축 진행.',
    related_policy: '/policy/community#identity-model'
  },
  {
    id: 'decision-ops-team',
    priority: 'medium',
    category: 'policy-decision',
    title: '운영팀 행동강령 시행',
    description: '운영자(operator)·중재자 역할 분담, enforcement §10 행동강령 정식 시행.',
    why_pending: '운영팀 인원·역할이 아직 결정되지 않음.',
    what_now: '운영팀 1차 인원 확정 시 행동강령 시행일 공지.',
    related_policy: '/policy/enforcement#admin-conduct'
  },

  // ── 운영 측면 트래픽 늘면 필요해질 것
  {
    id: 'admin-ui-howto-card-ai-badge',
    priority: 'low',
    category: 'admin-ui',
    title: 'HowTo 리스트 카드 AI 라벨 배지',
    description: '/howto 리스트의 카드에 🤖 AI 라벨 배지 노출 (renderAiLevelBadge helper는 이미 있음).',
    why_pending: '카드 렌더링 코드가 분산되어 있어 일괄 적용 미구현.',
    what_now: 'HowTo가 본격 발행되기 시작할 때 카드 렌더 위치에 helper 호출 추가.',
    related_policy: '/policy/howto#ai-label'
  },
  {
    id: 'admin-ui-wiki-howto-compare',
    priority: 'low',
    category: 'admin-ui',
    title: '위키 ↔ HowTo 자동 비교 박스',
    description: 'HowTo 본문이 위키와 통계가 모순될 때 자동 감지·표시.',
    why_pending: 'helper(renderWikiComparisonBox)는 만들어 둠. 자동 감지 로직(연봉·취업률 등 수치 추출 + 비교)이 빠짐.',
    what_now: '같은 직업에 위키-HowTo 충돌 사례가 실제 발생하면 그때 자동 감지 로직 구현.',
    related_policy: '/policy/howto#wiki-comparison'
  },
  {
    id: 'admin-ui-trust-cache-bust',
    priority: 'medium',
    category: 'admin-ui',
    title: '직업/전공 페이지 신뢰 박스 ISR 캐시 무효화',
    description: '직업/전공 페이지는 wiki_pages 테이블에 캐싱돼 신뢰 박스 변경이 즉시 반영 안 됨.',
    why_pending: '캐시 만료 시 자동 갱신은 됨. 즉시 무효화 트리거가 없음.',
    what_now: '편집 시점에 cache 무효화 또는 캐시 만료 주기 단축 (현재 일부 구현 가능성 있음).',
    related_policy: '/policy/source-tier'
  },

  // ── cron 작업 (운영 일정 정해지면 등록)
  {
    id: 'cron-ai-stale',
    priority: 'medium',
    category: 'cron',
    title: 'AI 생성 후 7일 미검수 자동 전환',
    description: 'AI가 채운 admin_data가 7일 지나도 사람 검수 없으면 "검수 필요" 자동 표시.',
    why_pending: '정책에는 명시. cron skeleton(scripts/trust-audit.cjs)은 있으나 실제 cron 미등록.',
    what_now: 'wrangler cron으로 매일 1회 자동 실행 또는 GitHub Actions 등록.',
    related_policy: '/policy/source-tier#ai-data',
    blocked_by: '운영 일정 확정'
  },
  {
    id: 'cron-ai-source-hallucination',
    priority: 'medium',
    category: 'cron',
    title: 'AI 출처 환각 자동 검증',
    description: 'AI가 표기한 출처 URL이 실제 존재하는지 자동 확인.',
    why_pending: 'cron skeleton만 있음. 분쟁 발생 시 운영자가 수동 검증 가능.',
    what_now: '주 1회 100건 샘플링 + URL fetch + HTTP 200 확인.',
    related_policy: '/policy/source-tier#ai-data'
  },
  {
    id: 'cron-dispute-finalize',
    priority: 'high',
    category: 'cron',
    title: '토론 합의안 자동 종결 cron',
    description: '이의 제기 기간(48h+6h×2회)이 만료된 합의안을 자동으로 closed_consensus 처리.',
    why_pending: 'finalizeExpiredProposals 함수는 구현됨. cron 등록만 미완.',
    what_now: 'wrangler cron으로 매시간 1회 호출.',
    related_policy: '/policy/dispute#flow'
  },
  {
    id: 'cron-transparency-quarterly',
    priority: 'low',
    category: 'cron',
    title: '분기별 투명성 보고서 자동 생성',
    description: '신고·차단·토론 통계 자동 집계 + /policy/transparency에 게시.',
    why_pending: '첫 발간 예정일이 2026-07-30. 그 전까지는 수동 작성 가능.',
    what_now: '2026-06 말 직전에 집계 스크립트 등록.',
    related_policy: '/policy/transparency'
  },

  // ── UI 폴리싱
  {
    id: 'ui-suspended-notice-page',
    priority: 'low',
    category: 'ui-polish',
    title: '사용자 정지 안내 페이지',
    description: '정지 중 사용자가 댓글 작성 시도 시 보이는 별도 안내 페이지.',
    why_pending: '현재는 댓글 폼 에러("USER_SUSPENDED:stage:endsAt")로만 노출.',
    what_now: '정지 사용자가 늘면 전용 안내 페이지 추가.',
    related_policy: '/policy/enforcement#phase5'
  },
  {
    id: 'ui-minor-label-system',
    priority: 'low',
    category: 'auth',
    title: '미성년 라벨 시스템',
    description: '만 14~18세 사용자 식별 + 운영 내부 라벨 + 민감 콘텐츠 게이트 강화.',
    why_pending: '현재는 가입 시 14세 이상 동의 체크박스만 있음 (한국 일반 서비스 동일).',
    what_now: '미성년 보호 강화가 사회적으로 요구되는 사안 발생 시.',
    related_policy: '/policy/community#minors'
  },
  {
    id: 'ui-mod-revision-message',
    priority: 'medium',
    category: 'admin-ui',
    title: '운영자 "수정요청" 작성자 메시지 채널',
    description: '신고 검토 큐에서 "수정요청" 결정 시 작성자에게 사유를 전달하는 인박스.',
    why_pending: '현재는 운영자 메모만 moderation_decisions에 기록. 작성자에게 노출되는 채널 미연결.',
    what_now: '마이페이지에 "내 작성물에 대한 운영자 메시지" 섹션 추가.',
    related_policy: '/policy/enforcement#phase3'
  },

  // ── 데이터 품질
  {
    id: 'data-quality-ai-source-grade',
    priority: 'low',
    category: 'data-quality',
    title: 'validate-job-edit.cjs에 출처 등급 검증 추가',
    description: '편집 저장 시 출처 등급(1~8순위)을 자동 검증해 5순위 이상 보장.',
    why_pending: '정책 source-tier 등급표는 있으나 자동 검증 룰 미구현.',
    what_now: '편집 시 출처 등급을 자동 감지하고 통계는 2순위 이상만 허용하는 룰 추가.',
    related_policy: '/policy/source-tier'
  }
]

// ========================================================================
// 렌더링
// ========================================================================

const PRIORITY_META: Record<Priority, { label: string; color: string; order: number }> = {
  critical: { label: '🚨 긴급', color: 'background:rgba(220,38,38,0.18); color:#fca5a5; border:1px solid rgba(220,38,38,0.45);', order: 0 },
  high:     { label: '🔴 높음', color: 'background:rgba(234,88,12,0.18); color:#fdba74; border:1px solid rgba(234,88,12,0.45);', order: 1 },
  medium:   { label: '🟡 중간', color: 'background:rgba(202,138,4,0.18); color:#fde047; border:1px solid rgba(202,138,4,0.45);', order: 2 },
  low:      { label: '🟢 낮음', color: 'background:rgba(22,163,74,0.18); color:#86efac; border:1px solid rgba(22,163,74,0.45);', order: 3 }
}

const CATEGORY_META: Record<Category, { label: string; icon: string }> = {
  'auth':            { label: '인증',         icon: 'fa-id-badge' },
  'admin-ui':        { label: '관리자 UI',    icon: 'fa-screwdriver-wrench' },
  'cron':            { label: '자동화·크론',  icon: 'fa-robot' },
  'ui-polish':       { label: 'UI 폴리싱',    icon: 'fa-paintbrush' },
  'policy-decision': { label: '정책 결정 대기', icon: 'fa-gavel' },
  'data-quality':    { label: '데이터 품질',  icon: 'fa-database' }
}

export function renderAdminTodoPage(): string {
  // 우선순위 → 카테고리로 정렬
  const sorted = [...TODO_ITEMS].sort((a, b) => {
    const pa = PRIORITY_META[a.priority].order
    const pb = PRIORITY_META[b.priority].order
    if (pa !== pb) return pa - pb
    return a.category.localeCompare(b.category)
  })

  // 카테고리별 그룹
  const byCategory: Record<string, TodoItem[]> = {}
  for (const item of sorted) {
    if (!byCategory[item.category]) byCategory[item.category] = []
    byCategory[item.category].push(item)
  }

  // 카테고리 순서
  const catOrder: Category[] = ['policy-decision', 'admin-ui', 'cron', 'auth', 'ui-polish', 'data-quality']

  const sectionsHtml = catOrder
    .filter(c => byCategory[c])
    .map(c => {
      const meta = CATEGORY_META[c]
      const items = byCategory[c]
      return `
        <section class="glass-card rounded-xl p-5 mb-6">
          <header class="flex items-center justify-between mb-4 pb-3 border-b border-slate-700/40">
            <h3 class="text-lg font-bold text-white flex items-center gap-2">
              <i class="fas ${meta.icon} text-slate-400"></i>
              ${escapeHtml(meta.label)}
            </h3>
            <span class="text-xs text-slate-400">${items.length}건</span>
          </header>
          <div class="space-y-3">
            ${items.map(it => renderTodoItem(it)).join('')}
          </div>
        </section>
      `
    })
    .join('')

  // KPI 헤더
  const counts = {
    critical: TODO_ITEMS.filter(i => i.priority === 'critical').length,
    high: TODO_ITEMS.filter(i => i.priority === 'high').length,
    medium: TODO_ITEMS.filter(i => i.priority === 'medium').length,
    low: TODO_ITEMS.filter(i => i.priority === 'low').length
  }

  const content = `
    <div class="mb-6">
      <h1 class="text-2xl sm:text-3xl font-bold text-white mb-2">잔여 작업·미구현 항목</h1>
      <p class="text-slate-400 text-sm">정책에 명시되어 있거나 시스템상 필요하지만 아직 구현되지 않은 항목 목록입니다. 다음에 뭐 해야 되지? 라고 물으면 여기를 보세요.</p>
    </div>

    <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-8">
      <div class="glass-card rounded-xl p-4 text-center" style="border-left: 4px solid #dc2626;">
        <div class="text-2xl font-bold text-rose-300">${counts.critical}</div>
        <div class="text-xs text-slate-400">🚨 긴급</div>
      </div>
      <div class="glass-card rounded-xl p-4 text-center" style="border-left: 4px solid #ea580c;">
        <div class="text-2xl font-bold text-orange-300">${counts.high}</div>
        <div class="text-xs text-slate-400">🔴 높음</div>
      </div>
      <div class="glass-card rounded-xl p-4 text-center" style="border-left: 4px solid #ca8a04;">
        <div class="text-2xl font-bold text-yellow-300">${counts.medium}</div>
        <div class="text-xs text-slate-400">🟡 중간</div>
      </div>
      <div class="glass-card rounded-xl p-4 text-center" style="border-left: 4px solid #16a34a;">
        <div class="text-2xl font-bold text-emerald-300">${counts.low}</div>
        <div class="text-xs text-slate-400">🟢 낮음</div>
      </div>
    </div>

    ${sectionsHtml}

    <div class="glass-card rounded-xl p-4 sm:p-5 mt-6">
      <p class="text-sm text-slate-300 mb-2"><strong>📝 항목 추가·제거</strong></p>
      <p class="text-xs text-slate-400 leading-relaxed">
        이 페이지의 항목은 <code class="px-2 py-0.5 rounded bg-slate-800 text-emerald-300">src/templates/admin/todoPage.tsx</code> 의 <code class="px-2 py-0.5 rounded bg-slate-800 text-emerald-300">TODO_ITEMS</code> 배열을 수정해 관리합니다.
        새 항목 추가, 우선순위 변경, 완료 항목 제거 모두 그 한 곳에서 처리됩니다.
      </p>
    </div>
  `

  return renderAdminLayout({
    title: '잔여 작업·미구현',
    currentPath: '/admin/todo',
    children: content
  })
}

function renderTodoItem(item: TodoItem): string {
  const priorityMeta = PRIORITY_META[item.priority]
  return `
    <article style="padding: 14px 16px; background: rgba(15,23,42,0.5); border-radius: 10px; border-left: 4px solid ${
      item.priority === 'critical' ? '#dc2626' :
      item.priority === 'high' ? '#ea580c' :
      item.priority === 'medium' ? '#ca8a04' : '#16a34a'
    };">
      <header class="flex items-start justify-between gap-3 mb-2">
        <h4 class="text-base font-semibold text-white">${escapeHtml(item.title)}</h4>
        <span class="pill" style="${priorityMeta.color} padding:2px 10px; border-radius:8px; font-size:0.7rem; font-weight:700; white-space:nowrap;">${escapeHtml(priorityMeta.label)}</span>
      </header>
      <p class="text-sm text-slate-300 mb-2">${escapeHtml(item.description)}</p>
      <dl class="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs">
        <div>
          <dt class="text-slate-500 mb-0.5">왜 아직 안 됐나</dt>
          <dd class="text-slate-300">${escapeHtml(item.why_pending)}</dd>
        </div>
        <div>
          <dt class="text-slate-500 mb-0.5">언제·어떻게 하면 되나</dt>
          <dd class="text-slate-300">${escapeHtml(item.what_now)}</dd>
        </div>
      </dl>
      <footer class="mt-2 pt-2 border-t border-slate-700/30 flex items-center gap-3 flex-wrap text-xs text-slate-500">
        <span><code style="font-size:0.7rem; color:#94a3b8;">${escapeHtml(item.id)}</code></span>
        ${item.related_policy ? `<a href="${escapeHtml(item.related_policy)}" class="text-blue-400 hover:underline">관련 정책</a>` : ''}
        ${item.blocked_by ? `<span style="color:#fbbf24;">⛔ 차단 요소: ${escapeHtml(item.blocked_by)}</span>` : ''}
      </footer>
    </article>
  `
}

function escapeHtml(text: string | null | undefined): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}
