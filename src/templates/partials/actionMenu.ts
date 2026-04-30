/**
 * 페이지 액션 케밥 메뉴 (직업·전공·HowTo 공용)
 * - 점 3개 세로 버튼 → 드롭다운: 편집 / 역사 / 토론 (신설)
 * - 신뢰 박스는 ? 아이콘에 hover popup으로 표시
 * - 공유·저장은 별도 외부 버튼으로 유지 (정책상 분리 요청)
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
  const canEdit = opts.canEdit !== false  // 기본 true (직업·전공)
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

  return `
    <div class="cw-action-group" style="display:inline-flex; align-items:center; gap:8px;">
      <!-- 신뢰성 ? 아이콘 + hover popup -->
      ${trustPopupHtml ? `
      <div class="cw-trust-toggle" style="position:relative; display:inline-block;">
        <button type="button"
          class="cw-trust-trigger"
          aria-label="이 페이지의 신뢰성 정보"
          title="이 페이지의 신뢰성"
          style="width:38px; height:38px; min-height:38px; border-radius:8px;
                 background:rgba(99,102,241,0.08); border:1px solid rgba(99,102,241,0.28);
                 color:#a78bfa; cursor:pointer; display:inline-flex; align-items:center; justify-content:center;
                 transition: all 0.15s ease;">
          <i class="fas fa-question"></i>
        </button>
        <div class="cw-trust-popup"
          style="position:absolute; top:calc(100% + 8px); right:0;
                 padding:12px 14px; border-radius:12px;
                 background:rgba(15,19,35,0.98); border:1px solid rgba(99,102,241,0.32);
                 box-shadow:0 10px 30px rgba(0,0,0,0.4);
                 display:none; z-index: 50; backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);">
          ${trustPopupHtml}
        </div>
      </div>` : ''}

      <!-- 공유 -->
      ${shareBtnHtml}

      <!-- 저장 -->
      ${bookmarkBtnHtml}

      <!-- 케밥 메뉴 (편집·역사·토론) -->
      <div class="cw-kebab-menu" style="position:relative; display:inline-block;">
        <button type="button"
          class="cw-kebab-trigger"
          aria-label="편집·역사·토론 메뉴"
          aria-haspopup="true"
          aria-expanded="false"
          style="width:38px; height:38px; min-height:38px; border-radius:8px;
                 background:rgba(148,163,184,0.08); border:1px solid rgba(148,163,184,0.22);
                 color:#cbd5e1; cursor:pointer; display:inline-flex; align-items:center; justify-content:center;
                 transition: all 0.15s ease;">
          <i class="fas fa-ellipsis-vertical"></i>
        </button>
        <div class="cw-kebab-dropdown"
          role="menu"
          style="position:absolute; top:calc(100% + 6px); right:0; min-width: 180px;
                 padding: 6px; border-radius:10px;
                 background:rgba(15,19,35,0.98); border:1px solid rgba(148,163,184,0.22);
                 box-shadow:0 10px 30px rgba(0,0,0,0.4);
                 display:none; z-index: 50; backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);">
          ${editItem}
          ${historyItem}
          ${disputeItem}
        </div>
      </div>
    </div>

    <style>
      .cw-trust-trigger:hover, .cw-trust-trigger:focus-visible {
        background: rgba(99,102,241,0.16);
        outline: none;
      }
      .cw-trust-toggle:hover .cw-trust-popup,
      .cw-trust-toggle:focus-within .cw-trust-popup {
        display: block;
      }
      .cw-kebab-trigger:hover, .cw-kebab-trigger:focus-visible {
        background: rgba(148,163,184,0.16);
        color: #f1f5f9;
        outline: none;
      }
      .cw-kebab-menu.is-open .cw-kebab-dropdown {
        display: block;
      }
      .cw-action-item {
        display: flex;
        align-items: center;
        gap: 10px;
        width: 100%;
        padding: 9px 12px;
        background: transparent;
        border: none;
        border-radius: 6px;
        color: #e2e8f0;
        font-size: 0.88rem;
        cursor: pointer;
        text-align: left;
        text-decoration: none;
        transition: background 0.12s ease;
      }
      .cw-action-item:hover, .cw-action-item:focus-visible {
        background: rgba(99,102,241,0.12);
        outline: none;
      }
      .cw-action-item span { line-height: 1.2; }
    </style>
    <script>
      (function(){
        // 케밥 메뉴 토글
        document.querySelectorAll('.cw-kebab-menu').forEach(function(menu){
          if (menu.dataset.cwKebabBound === '1') return;
          menu.dataset.cwKebabBound = '1';
          var btn = menu.querySelector('.cw-kebab-trigger');
          if (!btn) return;
          btn.addEventListener('click', function(e){
            e.stopPropagation();
            var open = menu.classList.toggle('is-open');
            btn.setAttribute('aria-expanded', String(open));
          });
          document.addEventListener('click', function(e){
            if (!menu.contains(e.target)) {
              menu.classList.remove('is-open');
              btn.setAttribute('aria-expanded', 'false');
            }
          });
          document.addEventListener('keydown', function(e){
            if (e.key === 'Escape') {
              menu.classList.remove('is-open');
              btn.setAttribute('aria-expanded', 'false');
            }
          });
        });
      })();
    </script>
  `
}

function escapeAttr(text: string): string {
  return String(text).replace(/"/g, '&quot;').replace(/</g, '&lt;')
}
