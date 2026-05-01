/**
 * 페이지 액션 케밥 메뉴 (직업·전공·HowTo 공용)
 *
 * 케밥(점 3개) 드롭다운 안에:
 *   - 편집 / 역사 / 토론
 *   - 구분선
 *   - 이 페이지의 신뢰성 (출처 등급·검수일·AI 비율·분쟁 이력)
 *
 * 외부 버튼: 공유 / 저장 / (HowTo의 경우) 신고
 *
 * 핵심 설계:
 * - 한 페이지에 액션 그룹이 여러 번 호출돼도 부트스트랩 스크립트는
 *   `window.__cwActionMenuBoot` 플래그로 단 1회만 등록.
 * - 클릭 핸들러는 document 레벨 위임 — DOM 시점에 의존하지 않음.
 */

import { type TrustBoxData } from '../../utils/trust'

export type ActionMenuOptions = {
  entityType: 'job' | 'major' | 'howto'
  entityId: string | number
  entitySlug?: string
  /** 편집 가능 여부. HowTo는 작성자/관리자만 true */
  canEdit?: boolean
  /** 토론 발제 시 prefilled */
  disputeTargetId?: string
  /** 케밥 메뉴 안에 노출할 신뢰성 정보 (선택) */
  trustData?: TrustBoxData | null
  /** telemetry */
  telemetryVariantAttr?: string
}

/**
 * 케밥 메뉴 안에 표시되는 신뢰성 정보 섹션 (외부 hover popup이 아님)
 */
function renderTrustSection(data: TrustBoxData): string {
  const tierAvg = data.sourceTierAvg
  const tierLabel =
    tierAvg == null
      ? '데이터 없음'
      : tierAvg <= 2.5
      ? '우수 (1~2순위)'
      : tierAvg <= 4.5
      ? '양호 (학술·공공)'
      : tierAvg <= 6.5
      ? '보통 (협회·언론)'
      : '주의 (개인 진술)'
  const tierColor =
    tierAvg == null
      ? '#94a3b8'
      : tierAvg <= 2.5
      ? '#86efac'
      : tierAvg <= 4.5
      ? '#7dd3fc'
      : tierAvg <= 6.5
      ? '#fde047'
      : '#fca5a5'
  const aiPct = data.aiGeneratedRatio == null ? null : Math.round(data.aiGeneratedRatio * 100)
  const aiLabel = aiPct == null ? '미상' : aiPct === 0 ? '0% (사람 편집)' : `${aiPct}%`
  const editPath = data.pageType === 'major' ? 'major' : 'job'

  return `
    <div class="cw-action-trust">
      <div class="cw-action-trust-title">
        <i class="fas fa-shield-halved" style="color:#a78bfa;"></i>
        <span>이 페이지의 신뢰성</span>
      </div>
      <ul class="cw-action-trust-list">
        <li><span>출처 등급 평균</span><span style="color:${tierColor}; font-weight:600;">${tierAvg == null ? '—' : tierAvg.toFixed(1)} <span style="opacity:0.7; font-size:0.78rem;">(${escapeHtml(tierLabel)})</span></span></li>
        <li><span>출처 개수</span><span>${data.sourceCount ?? 0}건</span></li>
        <li><span>마지막 검수</span><span>${escapeHtml(formatDateLabel(data.lastReviewedAt))}</span></li>
        <li><span>AI 생성 비율</span><span>${escapeHtml(aiLabel)}</span></li>
        <li><span>분쟁 이력</span><span>${data.disputeCount ?? 0}건</span></li>
      </ul>
      <div class="cw-action-trust-links">
        <a href="/policy/source-tier">출처 등급 정책</a>
        <span style="opacity:0.4;">·</span>
        <a href="/policy/wiki/${editPath}">편집지침</a>
      </div>
    </div>
  `
}

/**
 * 액션 케밥 + 공유 + 저장 버튼 묶음 HTML
 */
export function renderEntityActionGroup(
  opts: ActionMenuOptions,
  shareBtnHtml: string,
  bookmarkBtnHtml: string
): string {
  const canEdit = opts.canEdit !== false
  const entityType = opts.entityType
  const entityId = String(opts.entityId)
  const variant = opts.telemetryVariantAttr || ''
  const disputeTarget = opts.disputeTargetId || entityId

  const editItem = canEdit
    ? `
    <button type="button"
      class="cw-action-item"
      data-edit-mode-trigger
      data-entity-type="${entityType}"
      data-entity-id="${escapeAttr(entityId)}"
      data-cw-telemetry-component="${entityType}-edit-trigger"
      data-cw-telemetry-action="edit-open"${variant}>
      <i class="fas fa-edit" style="width:18px; color:#a78bfa;"></i>
      <span>편집</span>
    </button>`
    : ''

  const historyItem = `
    <button type="button"
      class="cw-action-item"
      data-history-trigger
      data-entity-type="${entityType}"
      data-entity-id="${escapeAttr(entityId)}"
      data-cw-telemetry-component="${entityType}-history-trigger"
      data-cw-telemetry-action="history-open"${variant}>
      <i class="fas fa-history" style="width:18px; color:#93c5fd;"></i>
      <span>역사</span>
    </button>`

  const disputeItem = `
    <a href="/dispute/open?target_type=${entityType}&target_id=${encodeURIComponent(disputeTarget)}"
      class="cw-action-item"
      data-cw-telemetry-component="${entityType}-dispute-trigger"
      data-cw-telemetry-action="dispute-open">
      <i class="fas fa-comments" style="width:18px; color:#fbbf24;"></i>
      <span>토론</span>
    </a>`

  const trustSection = opts.trustData ? `
    <div class="cw-action-divider"></div>
    ${renderTrustSection(opts.trustData)}
  ` : ''

  return `
    <div class="cw-action-group" style="display:inline-flex; align-items:center; gap:8px;">
      ${shareBtnHtml}
      ${bookmarkBtnHtml}
      <div class="cw-kebab-menu" style="position:relative; display:inline-block;">
        <button type="button"
          class="cw-kebab-trigger cw-icon-btn cw-icon-btn--kebab"
          aria-label="더보기 메뉴"
          aria-haspopup="true"
          aria-expanded="false">
          <i class="fas fa-ellipsis-vertical"></i>
        </button>
        <div class="cw-kebab-dropdown" role="menu">
          ${editItem}
          ${historyItem}
          ${disputeItem}
          ${trustSection}
        </div>
      </div>
    </div>
    ${ACTION_MENU_STYLES}
    ${ACTION_MENU_BOOTSTRAP}
  `
}

// ── 단일 인스턴스 스타일 (id로 중복 방지)
const ACTION_MENU_STYLES = `
<style id="cw-action-menu-style">
  .cw-icon-btn {
    width: 38px; height: 38px; min-height: 38px;
    border-radius: 8px; cursor: pointer;
    display: inline-flex; align-items: center; justify-content: center;
    transition: all 0.15s ease;
    border: 1px solid;
    padding: 0;
  }
  .cw-icon-btn:focus-visible { outline: 2px solid rgba(99,102,241,0.6); outline-offset: 2px; }

  .cw-icon-btn--kebab { background: rgba(148,163,184,0.08); border-color: rgba(148,163,184,0.22); color: #cbd5e1; }
  .cw-icon-btn--kebab:hover { background: rgba(148,163,184,0.16); color: #f1f5f9; }

  .cw-kebab-dropdown {
    position: absolute; top: calc(100% + 6px); right: 0; min-width: 240px; max-width: 320px;
    padding: 6px; border-radius: 10px;
    background: rgba(15,19,35,0.98); border: 1px solid rgba(148,163,184,0.22);
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    display: none; z-index: 50;
    backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);
  }
  .cw-kebab-menu.is-open .cw-kebab-dropdown { display: block; }

  .cw-action-item {
    display: flex; align-items: center; gap: 10px;
    width: 100%; padding: 9px 12px;
    background: transparent; border: none; border-radius: 6px;
    color: #e2e8f0; font-size: 0.88rem;
    cursor: pointer; text-align: left; text-decoration: none;
    transition: background 0.12s ease;
  }
  .cw-action-item:hover, .cw-action-item:focus-visible {
    background: rgba(99,102,241,0.12); outline: none;
  }
  .cw-action-item span { line-height: 1.2; }

  .cw-action-divider {
    height: 1px; margin: 6px 4px;
    background: rgba(148,163,184,0.18);
  }

  /* 신뢰성 정보 섹션 (케밥 안) */
  .cw-action-trust { padding: 8px 12px; }
  .cw-action-trust-title {
    display: flex; align-items: center; gap: 8px;
    font-size: 0.78rem; font-weight: 700; color: #e2e8f0;
    margin-bottom: 6px;
  }
  .cw-action-trust-list {
    list-style: none; padding: 0; margin: 0;
    display: grid; gap: 4px;
    font-size: 0.78rem;
  }
  .cw-action-trust-list li {
    display: flex; justify-content: space-between; gap: 12px;
    color: #cbd5e1;
  }
  .cw-action-trust-list li > span:first-child { color: #94a3b8; }
  .cw-action-trust-links {
    margin-top: 8px; padding-top: 6px;
    border-top: 1px solid rgba(148,163,184,0.18);
    font-size: 0.72rem;
  }
  .cw-action-trust-links a { color: #93c5fd; text-decoration: none; }
  .cw-action-trust-links a:hover { text-decoration: underline; }

  /* 외부 아이콘 버튼들 */
  .cw-icon-btn--share { background: rgba(67,97,238,0.12); border-color: rgba(67,97,238,0.3); color: #93c5fd; }
  .cw-icon-btn--share:hover { background: rgba(67,97,238,0.22); }

  .cw-icon-btn--report { background: rgba(248,113,113,0.08); border-color: rgba(248,113,113,0.28); color: #fca5a5; }
  .cw-icon-btn--report:hover { background: rgba(248,113,113,0.18); }

  /* 저장 버튼 색상 토글 */
  .cw-icon-btn--bookmark {
    background: rgba(148,163,184,0.06);
    border-color: rgba(148,163,184,0.22);
    color: #cbd5e1;
  }
  .cw-icon-btn--bookmark:hover { background: rgba(251,191,36,0.12); border-color: rgba(251,191,36,0.4); color: #fbbf24; }
  .cw-icon-btn--bookmark.bookmark-saved,
  .cw-icon-btn--bookmark[data-saved="1"] {
    background: rgba(251,191,36,0.22) !important;
    border-color: rgba(251,191,36,0.6) !important;
    color: #facc15 !important;
  }
  .cw-icon-btn--bookmark.bookmark-saved i,
  .cw-icon-btn--bookmark[data-saved="1"] i { color: #facc15 !important; }

  .cw-icon-btn--bookmark-counted {
    min-width: 38px; height: 38px; min-height: 38px; padding: 0 10px;
    border-radius: 8px; cursor: pointer;
    display: inline-flex; align-items: center; justify-content: center; gap: 6px;
    border: 1px solid;
    background: rgba(148,163,184,0.06); border-color: rgba(148,163,184,0.22); color: #cbd5e1;
    font-size: 0.78rem; transition: all 0.15s ease;
  }
  .cw-icon-btn--bookmark-counted:hover { background: rgba(251,191,36,0.12); border-color: rgba(251,191,36,0.4); color: #fbbf24; }
  .cw-icon-btn--bookmark-counted.bookmark-saved,
  .cw-icon-btn--bookmark-counted[data-saved="1"] {
    background: rgba(251,191,36,0.22) !important;
    border-color: rgba(251,191,36,0.6) !important;
    color: #facc15 !important;
  }
</style>
`

// ── 단일 부트스트랩 스크립트 (전역 가드)
const ACTION_MENU_BOOTSTRAP = `
<script id="cw-action-menu-bootstrap">
(function(){
  if (window.__cwActionMenuBoot) return;
  window.__cwActionMenuBoot = true;

  document.addEventListener('click', function(e){
    var t = e.target;
    if (!t || !t.closest) return;

    var kebabTrigger = t.closest('.cw-kebab-trigger');
    if (kebabTrigger) {
      e.stopPropagation();
      var kebabMenu = kebabTrigger.closest('.cw-kebab-menu');
      if (!kebabMenu) return;
      document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
        if (m !== kebabMenu) {
          m.classList.remove('is-open');
          var b = m.querySelector('.cw-kebab-trigger');
          if (b) b.setAttribute('aria-expanded', 'false');
        }
      });
      var open = kebabMenu.classList.toggle('is-open');
      kebabTrigger.setAttribute('aria-expanded', String(open));
      return;
    }

    // 외부 클릭 → 모두 닫기 (케밥 메뉴 내부가 아닐 때)
    if (!t.closest('.cw-kebab-menu')) {
      document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
        m.classList.remove('is-open');
        var b = m.querySelector('.cw-kebab-trigger');
        if (b) b.setAttribute('aria-expanded', 'false');
      });
    }
  }, true);

  document.addEventListener('keydown', function(e){
    if (e.key !== 'Escape') return;
    document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
      m.classList.remove('is-open');
      var trig = m.querySelector('.cw-kebab-trigger');
      if (trig) trig.setAttribute('aria-expanded', 'false');
    });
  });
})();
</script>
`

function escapeAttr(text: string): string {
  return String(text).replace(/"/g, '&quot;').replace(/</g, '&lt;')
}

function escapeHtml(text: string | null | undefined): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}

function formatDateLabel(s?: string | null): string {
  if (!s) return '미상'
  const m = /^(\d{4}-\d{2}-\d{2})/.exec(s)
  if (m) return m[1]
  return s
}
