/**
 * 페이지 액션 케밥 메뉴 (직업·전공·HowTo 공용)
 * - 점 3개 세로 버튼 → 드롭다운: 편집 / 역사 / 토론 / 도움말
 * - 신뢰 박스는 ? 아이콘에 hover/click popup
 * - 공유·저장은 별도 외부 버튼으로 유지
 *
 * 핵심 설계 결정:
 * - 한 페이지에 액션 그룹이 여러 번 호출되어도 클라이언트 부트스트랩 스크립트는
 *   `window.__cwActionMenuBoot` 플래그로 단 1회만 등록.
 * - 클릭 핸들러는 document 레벨 위임 — DOM 시점에 의존하지 않음.
 */

import { renderTrustBoxCompact, type TrustBoxData } from '../../utils/trust'

export type ActionMenuOptions = {
  entityType: 'job' | 'major' | 'howto'
  entityId: string | number
  entitySlug?: string
  /** 편집 가능 여부. HowTo는 작성자/관리자만 true */
  canEdit?: boolean
  /** 토론 발제 시 prefilled */
  disputeTargetId?: string
  /** ? 아이콘 hover popup용 신뢰 데이터 (선택) */
  trustData?: TrustBoxData | null
  /** telemetry */
  telemetryVariantAttr?: string
}

/**
 * 액션 케밥 + 신뢰 ? 아이콘 + 공유 + 저장 버튼 묶음 HTML
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
  const trustPopupHtml = opts.trustData ? renderTrustBoxCompact(opts.trustData) : ''

  const editItem = canEdit ? `
    <button type="button"
      class="cw-action-item"
      data-edit-mode-trigger
      data-entity-type="${entityType}"
      data-entity-id="${escapeAttr(entityId)}"
      data-cw-telemetry-component="${entityType}-edit-trigger"
      data-cw-telemetry-action="edit-open"${variant}>
      <i class="fas fa-edit" style="width:18px; color:#a78bfa;"></i>
      <span>편집</span>
    </button>` : ''

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

  const helpItem = `
    <a href="/help"
      class="cw-action-item">
      <i class="fas fa-circle-question" style="width:18px; color:#7dd3fc;"></i>
      <span>도움말</span>
    </a>`

  return `
    <div class="cw-action-group" style="display:inline-flex; align-items:center; gap:8px;">
      ${trustPopupHtml ? `
      <div class="cw-trust-toggle" style="position:relative; display:inline-block;">
        <button type="button"
          class="cw-trust-trigger cw-icon-btn cw-icon-btn--trust"
          aria-label="이 페이지의 신뢰성 정보"
          aria-haspopup="true"
          aria-expanded="false"
          title="이 페이지의 신뢰성">
          <i class="fas fa-question"></i>
        </button>
        <div class="cw-trust-popup">
          ${trustPopupHtml}
        </div>
      </div>` : ''}

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
          ${helpItem}
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

  .cw-icon-btn--trust { background: rgba(99,102,241,0.08); border-color: rgba(99,102,241,0.28); color: #a78bfa; }
  .cw-icon-btn--trust:hover { background: rgba(99,102,241,0.16); }

  .cw-icon-btn--kebab { background: rgba(148,163,184,0.08); border-color: rgba(148,163,184,0.22); color: #cbd5e1; }
  .cw-icon-btn--kebab:hover { background: rgba(148,163,184,0.16); color: #f1f5f9; }

  .cw-trust-popup {
    position: absolute; top: calc(100% + 8px); right: 0;
    padding: 12px 14px; border-radius: 12px;
    background: rgba(15,19,35,0.98); border: 1px solid rgba(99,102,241,0.32);
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    display: none; z-index: 50;
    backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);
  }
  .cw-trust-toggle.is-open .cw-trust-popup,
  .cw-trust-toggle:hover .cw-trust-popup,
  .cw-trust-toggle:focus-within .cw-trust-popup {
    display: block;
  }

  .cw-kebab-dropdown {
    position: absolute; top: calc(100% + 6px); right: 0; min-width: 180px;
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

  .cw-icon-btn--share { background: rgba(67,97,238,0.12); border-color: rgba(67,97,238,0.3); color: #93c5fd; }
  .cw-icon-btn--share:hover { background: rgba(67,97,238,0.22); }

  .cw-icon-btn--report { background: rgba(248,113,113,0.08); border-color: rgba(248,113,113,0.28); color: #fca5a5; }
  .cw-icon-btn--report:hover { background: rgba(248,113,113,0.18); }

  /* 저장 버튼 색상 토글 — bookmark-saved 클래스 적용 시 */
  .cw-icon-btn--bookmark {
    background: rgba(251,191,36,0.08);
    border-color: rgba(251,191,36,0.28);
    color: #fbbf24;
  }
  .cw-icon-btn--bookmark:hover { background: rgba(251,191,36,0.18); }
  .cw-icon-btn--bookmark.bookmark-saved,
  .cw-icon-btn--bookmark[data-saved="1"] {
    background: rgba(251,191,36,0.22) !important;
    border-color: rgba(251,191,36,0.6) !important;
    color: #facc15 !important;
  }
  .cw-icon-btn--bookmark.bookmark-saved i,
  .cw-icon-btn--bookmark[data-saved="1"] i { color: #facc15 !important; }

  /* HowTo 카운트 표시 저장 버튼 (가로 길이 조정) */
  .cw-icon-btn--bookmark-counted {
    min-width: 38px; height: 38px; min-height: 38px; padding: 0 10px;
    border-radius: 8px; cursor: pointer;
    display: inline-flex; align-items: center; justify-content: center; gap: 6px;
    border: 1px solid;
    background: rgba(251,191,36,0.08); border-color: rgba(251,191,36,0.28); color: #fbbf24;
    font-size: 0.78rem; transition: all 0.15s ease;
  }
  .cw-icon-btn--bookmark-counted:hover { background: rgba(251,191,36,0.18); }
  .cw-icon-btn--bookmark-counted.bookmark-saved {
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

  // 단일 클릭 위임 — 케밥, 신뢰 토글 처리
  document.addEventListener('click', function(e){
    var t = e.target;
    if (!t || !t.closest) return;

    // 케밥 트리거
    var kebabTrigger = t.closest('.cw-kebab-trigger');
    if (kebabTrigger) {
      e.stopPropagation();
      var kebabMenu = kebabTrigger.closest('.cw-kebab-menu');
      if (!kebabMenu) return;
      // 다른 모든 케밥·신뢰 닫기
      document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
        if (m !== kebabMenu) {
          m.classList.remove('is-open');
          var b = m.querySelector('.cw-kebab-trigger');
          if (b) b.setAttribute('aria-expanded', 'false');
        }
      });
      document.querySelectorAll('.cw-trust-toggle.is-open').forEach(function(m){
        m.classList.remove('is-open');
        var b = m.querySelector('.cw-trust-trigger');
        if (b) b.setAttribute('aria-expanded', 'false');
      });
      var open = kebabMenu.classList.toggle('is-open');
      kebabTrigger.setAttribute('aria-expanded', String(open));
      return;
    }

    // 신뢰 ? 트리거 (클릭으로도 토글 가능 — 모바일/터치)
    var trustTrigger = t.closest('.cw-trust-trigger');
    if (trustTrigger) {
      e.stopPropagation();
      var trustToggle = trustTrigger.closest('.cw-trust-toggle');
      if (!trustToggle) return;
      document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
        m.classList.remove('is-open');
        var b = m.querySelector('.cw-kebab-trigger');
        if (b) b.setAttribute('aria-expanded', 'false');
      });
      var topen = trustToggle.classList.toggle('is-open');
      trustTrigger.setAttribute('aria-expanded', String(topen));
      return;
    }

    // 외부 클릭 → 모두 닫기
    if (!t.closest('.cw-kebab-menu') && !t.closest('.cw-trust-toggle')) {
      document.querySelectorAll('.cw-kebab-menu.is-open').forEach(function(m){
        m.classList.remove('is-open');
        var b = m.querySelector('.cw-kebab-trigger');
        if (b) b.setAttribute('aria-expanded', 'false');
      });
      document.querySelectorAll('.cw-trust-toggle.is-open').forEach(function(m){
        m.classList.remove('is-open');
        var b = m.querySelector('.cw-trust-trigger');
        if (b) b.setAttribute('aria-expanded', 'false');
      });
    }
  }, true);

  // ESC로 모두 닫기
  document.addEventListener('keydown', function(e){
    if (e.key !== 'Escape') return;
    document.querySelectorAll('.cw-kebab-menu.is-open, .cw-trust-toggle.is-open').forEach(function(m){
      m.classList.remove('is-open');
      var trig = m.querySelector('.cw-kebab-trigger, .cw-trust-trigger');
      if (trig) trig.setAttribute('aria-expanded', 'false');
    });
  });
})();
</script>
`

function escapeAttr(text: string): string {
  return String(text).replace(/"/g, '&quot;').replace(/</g, '&lt;')
}
