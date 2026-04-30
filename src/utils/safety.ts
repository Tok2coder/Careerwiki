/**
 * 안전 관련 공통 유틸리티
 *
 * - 자살·자해 키워드 검출 → 109/1393 자동 배너 (정책 community §5, wiki/job §7)
 * - 학교폭력·청소년 위기 신호 → 117/1388 안내 (정책 community §7-C)
 * - 보건복지부 자살보도 권고기준 5원칙에 따라 "차단"이 아닌 "정보 동반"
 *
 * 핵심 원칙: 절대 자동 삭제·차단하지 않는다. 도움 정보를 동반 표시할 뿐.
 */

// ============================================================================
// 자살·자해 키워드 (정책 community §5-A)
// ============================================================================

/**
 * 자살·자해 의도 신호 키워드.
 * - 명백한 SOS 신호만 (false positive 최소화 — "죽겠다" 같은 일상 강조 표현 제외).
 * - 보건복지부 자살보도 권고기준 5원칙에 따라 구체적 도구·장소·방법은
 *   본문에 등장하지 않도록 별도 검사 (detectSelfHarmMethod).
 */
const SELF_HARM_SIGNAL_PATTERNS: RegExp[] = [
  /자살/,
  /자해/,
  /\b1393\b/,
  /\b109\b/,
  /\b1577-?0199\b/, // 정신건강위기상담
]

/**
 * 구체적 자살 방법·도구·장소 표현 — 검출 시 운영자 검토 우선순위 ↑
 * (자살예방법 + 보건복지부 자살보도 권고기준)
 * 운영자 큐 우선순위 알림에만 사용. 일반 사용자에게는 노출하지 않음.
 */
const SELF_HARM_METHOD_PATTERNS: RegExp[] = [
  /번개탄/,
  /뛰어내리/,
  /목\s?매/,
  /수면제\s?(과량|많이)/,
  /투신/,
]

/**
 * 텍스트에 자살·자해 신호가 포함되어 있는지 검사.
 * - 검출 시 109/1393 배너를 함께 노출해야 함 (절대 자동 삭제 X)
 */
export function detectSelfHarmSignal(text: string | null | undefined): boolean {
  if (!text) return false
  return SELF_HARM_SIGNAL_PATTERNS.some(re => re.test(text))
}

/**
 * 구체적 자살 방법·도구가 등장하는지 검사 (운영자 우선순위 알림용).
 * 노출 여부와는 별개로 운영자 검토 큐에 우선 배치.
 */
export function detectSelfHarmMethod(text: string | null | undefined): boolean {
  if (!text) return false
  return SELF_HARM_METHOD_PATTERNS.some(re => re.test(text))
}

/**
 * @deprecated 진로 사이트 도메인에 부적합하여 제거됨 (2026-04-30 사용자 결정)
 * 학교폭력 관련 키워드 검출은 더 이상 지원하지 않습니다.
 */
export function detectYouthCrisisSignal(_text: string | null | undefined): boolean {
  return false
}

// ============================================================================
// 배너 HTML 생성
// ============================================================================

/**
 * 109/1393 자살예방 안내 배너 HTML
 * (정책 community §5-B)
 */
export function renderSelfHarmHelpBanner(opts?: { compact?: boolean }): string {
  const compact = opts?.compact ?? false

  if (compact) {
    return `
      <div class="cw-safety-banner cw-safety-banner--selfharm" role="alert" aria-live="polite" style="margin: 12px 0; padding: 12px 14px; border-radius: 12px; border: 1px solid rgba(248, 113, 113, 0.45); background: rgba(248, 113, 113, 0.08); color: #fecaca; font-size: 0.9rem;">
        <div style="display:flex; align-items:flex-start; gap:10px;">
          <span style="font-size:1.1rem; line-height:1;">🤝</span>
          <div style="flex:1; min-width:0;">
            <strong style="color:#fecaca;">혹시 지금 힘드신가요?</strong>
            <span style="color:#fecaca; opacity:0.92;">
              자살예방상담전화 <strong>109</strong>(국번없이) · 정신건강 위기상담 <strong>1577-0199</strong> · 청소년상담 <strong>1388</strong>
              — 모두 24시간 무료입니다.
            </span>
          </div>
        </div>
      </div>
    `
  }

  return `
    <aside class="cw-safety-banner cw-safety-banner--selfharm" role="alert" aria-live="polite"
           style="margin: 16px 0; padding: 18px 20px; border-radius: 16px;
                  border: 1px solid rgba(248, 113, 113, 0.5); background: rgba(248, 113, 113, 0.07);
                  box-shadow: 0 0 0 1px rgba(248, 113, 113, 0.1) inset;">
      <header style="display:flex; align-items:center; gap:10px; margin-bottom:10px;">
        <span style="font-size:1.5rem;">🤝</span>
        <strong style="color:#fecaca; font-size:1rem;">혹시 지금 힘드신가요?</strong>
      </header>
      <p style="color:#fecaca; opacity:0.95; font-size:0.92rem; line-height:1.55; margin: 0 0 10px 0;">
        혼자 감당하지 마세요. 24시간 무료로 이야기를 들어주는 곳이 있습니다.
      </p>
      <ul style="list-style:none; padding:0; margin:0; display:grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap:8px;">
        <li style="background:rgba(15,23,42,0.4); padding:10px 12px; border-radius:10px;">
          <div style="font-weight:700; color:#fecaca;">109 · 자살예방상담</div>
          <div style="font-size:0.82rem; color:#fca5a5; opacity:0.88;">국번없이 · 24시간 무료</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:10px 12px; border-radius:10px;">
          <div style="font-weight:700; color:#fecaca;">1577-0199 · 정신건강 위기상담</div>
          <div style="font-size:0.82rem; color:#fca5a5; opacity:0.88;">24시간 · 무료</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:10px 12px; border-radius:10px;">
          <div style="font-weight:700; color:#fecaca;">1388 · 청소년상담</div>
          <div style="font-size:0.82rem; color:#fca5a5; opacity:0.88;">전화·문자(카톡 #1388)</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:10px 12px; border-radius:10px;">
          <div style="font-weight:700; color:#fecaca;">1393 · 자살예방상담 (구)</div>
          <div style="font-size:0.82rem; color:#fca5a5; opacity:0.88;">109로 통합 운영</div>
        </li>
      </ul>
      <p style="color:#fca5a5; opacity:0.78; font-size:0.78rem; margin: 10px 0 0 0;">
        보건복지부 · 한국생명존중희망재단 운영 · <a href="/policy/community#self-harm" style="color:#fecaca; text-decoration:underline;">관련 정책</a>
      </p>
    </aside>
  `
}

/**
 * @deprecated 진로 사이트 도메인에 부적합하여 제거됨 (2026-04-30 사용자 결정)
 */
export function renderYouthCrisisBanner(_opts?: { compact?: boolean }): string {
  return ''
}

/**
 * 텍스트를 검사하여 필요한 안전 배너들의 HTML을 합쳐서 반환.
 * - 자살·자해 신호 → 109/1393 배너
 * - 둘 다 없으면 빈 문자열
 */
export function renderSafetyBannersForText(
  text: string | null | undefined,
  opts?: { compact?: boolean }
): string {
  const banners: string[] = []
  if (detectSelfHarmSignal(text)) {
    banners.push(renderSelfHarmHelpBanner(opts))
  }
  return banners.join('')
}

// ============================================================================
// 미성년자 보호 (정책 community §7-B)
// ============================================================================

/**
 * 만 14~18세 미성년자에게 노출 시 "한 번 더 클릭" 게이트가 필요한 민감 콘텐츠 키워드.
 * - 회사 갑질·성희롱·갑질 후기 등 (커뮤니티 §7-B 민감 콘텐츠 필터)
 */
const SENSITIVE_FOR_MINORS_PATTERNS: RegExp[] = [
  /(갑질|성희롱|성추행)/,
  /(직장\s?내\s?괴롭힘|직장\s?폭력)/,
  /(성\s?상납|회식\s?강요)/,
  /(왕따|이지메|왕따당)/,
]

/**
 * @deprecated 한국직업사전·NCS에 등재되지 않는 직업이라 자동 차단 불필요 (2026-04-30 사용자 결정)
 */
const ADULT_ONLY_JOB_PATTERNS: RegExp[] = []

/**
 * 본문에 미성년 민감 키워드가 있으면 true (B9: 추가 클릭 게이트 노출용)
 */
export function detectSensitiveForMinors(text: string | null | undefined): boolean {
  if (!text) return false
  return SENSITIVE_FOR_MINORS_PATTERNS.some(re => re.test(text))
}

/**
 * @deprecated 자동 차단 정책 제거 (2026-04-30) — 항상 false 반환
 */
export function isAdultOnlyJob(_jobNameOrSlug: string | null | undefined): boolean {
  return false
}

/**
 * 성인 전용 직업 페이지에서 미성년에게 보여줄 안내 화면 HTML
 */
export function renderAdultGateHtml(jobName: string): string {
  return `
    <div class="cw-adult-gate" role="alert"
         style="max-width: 640px; margin: 80px auto; padding: 32px;
                border-radius: 16px; border: 2px solid rgba(248,113,113,0.5);
                background: rgba(248,113,113,0.07); text-align: center;">
      <h1 style="font-size: 1.6rem; color: #fecaca; margin: 0 0 14px 0;">성인 인증이 필요합니다</h1>
      <p style="color: #fecaca; opacity: 0.9; line-height: 1.6;">
        <strong>${escapeHtml(jobName)}</strong> 직업 페이지는 만 19세 이상에게만 표시됩니다.
        <br>청소년 보호법에 따라 미성년 사용자에게는 노출되지 않습니다.
      </p>
      <p style="color: #fca5a5; opacity: 0.8; font-size: 0.85rem; margin-top: 18px;">
        본인이 만 19세 이상인 경우 운영자에게 문의해 주세요.
      </p>
      <div style="margin-top: 22px; display:flex; gap:10px; justify-content:center; flex-wrap:wrap;">
        <a href="/job" style="padding: 10px 20px; border-radius: 10px; background: rgba(99,102,241,0.15); color: #c7d2fe; text-decoration: none;">직업 목록으로</a>
        <a href="/help" style="padding: 10px 20px; border-radius: 10px; border: 1px solid rgba(148,163,184,0.3); color: #cbd5e1; text-decoration: none;">도움말</a>
      </div>
    </div>
  `
}

/**
 * 미성년 민감 콘텐츠 게이트 박스 HTML (B9: 본문 위에 클릭 1회 더 요구)
 * - JS로 클릭 시 본문 표시
 */
export function renderSensitiveContentGate(reason?: string): string {
  return `
    <div class="cw-sensitive-gate" data-cw-sensitive-gate
         style="margin: 16px 0; padding: 18px 22px; border-radius: 14px;
                border: 1px solid rgba(251,146,60,0.45); background: rgba(251,146,60,0.08);">
      <p style="color: #fed7aa; font-size: 0.95rem; line-height: 1.55; margin: 0 0 10px 0;">
        ⚠️ <strong>민감한 내용 안내</strong> — ${escapeHtml(reason || '이 페이지에는 직장 내 갈등·괴롭힘 등 청소년에게 부담될 수 있는 내용이 포함되어 있습니다.')}
      </p>
      <button type="button" data-cw-sensitive-gate-confirm
        style="padding: 8px 18px; border-radius: 10px; border: none; cursor: pointer;
               background: rgba(251,146,60,0.22); color: #fed7aa; font-weight: 600;">
        그래도 보기
      </button>
    </div>
    <script>
      (function(){
        document.querySelectorAll('[data-cw-sensitive-gate]').forEach(function(gate){
          var btn = gate.querySelector('[data-cw-sensitive-gate-confirm]');
          if (!btn) return;
          btn.addEventListener('click', function(){
            // 게이트가 감추고 있던 다음 형제 요소들의 'cw-gated' 클래스를 해제
            var next = gate.nextElementSibling;
            while (next) {
              if (next.classList && next.classList.contains('cw-gated')) {
                next.classList.remove('cw-gated');
              }
              next = next.nextElementSibling;
            }
            gate.style.display = 'none';
          });
        });
      })();
    </script>
  `
}

// ============================================================================
// 광고·제휴 표시 (HowTo §4 — 공정거래위원회 추천보증 심사지침 2024.12.1)
// ============================================================================

/**
 * 광고·협찬 표시 박스 HTML
 * - 본문 첫 줄에 본문보다 큰 글자/다른 색으로 표시 의무
 * - 위치: HowTo 본문 최상단 (자동 삽입)
 */
export function renderAdDisclosureBanner(disclosureType: 'ad' | 'sponsored' | 'paid' | 'affiliate' | 'received', detail?: string): string {
  const labelMap: Record<string, string> = {
    ad: '광고',
    sponsored: '협찬',
    paid: '유료광고 포함',
    affiliate: '제휴 활동에 따라 수수료 지급받음',
    received: '제품·서비스를 제공받음'
  }
  const label = labelMap[disclosureType] || '광고'

  return `
    <div class="cw-ad-disclosure" role="note"
         style="margin: 0 0 18px 0; padding: 14px 18px; border-radius: 12px;
                border: 2px solid #fbbf24; background: rgba(251, 191, 36, 0.12);
                color: #fde68a; font-size: 1.05rem; font-weight: 700;
                display:flex; align-items:center; gap:12px;">
      <span style="background:#fbbf24; color:#1c1917; padding:3px 10px; border-radius:8px; font-size:0.92rem;">${escapeHtml(label)}</span>
      <span style="flex:1; font-size:0.95rem; font-weight:600;">${escapeHtml(detail || '이 글에는 ' + label + ' 내용이 포함되어 있습니다. 공정거래위원회 추천·보증 심사지침에 따라 안내드립니다.')}</span>
    </div>
  `
}

// ============================================================================
// affiliate 링크 자동 sponsored nofollow 부여 (HowTo §4-D)
// ============================================================================

/**
 * 알려진 affiliate 도메인 목록 — 매칭되면 자동 rel="sponsored nofollow noopener"
 */
const AFFILIATE_HOST_PATTERNS: RegExp[] = [
  /(^|\.)coupang\.com$/i,
  /^link\.coupang\.com$/i,
  /^ads-partners\.coupang\.com$/i,
  /(^|\.)partners\.coupang\.com$/i,
  /^amzn\.to$/i,
  /^amzn\.asia$/i,
  /(^|\.)amazon\.[a-z.]+\/.*tag=/i, // amazon affiliate tag — 정규식 약식
  /^aliexpress\.com\/.*aff/i,
  /^s\.click\.aliexpress\.com$/i,
  /(^|\.)11st\.co\.kr\/.*affiliate/i,
  /(^|\.)gmarket\.co\.kr\/.*affiliate/i,
  /^bit\.ly$/i, // shortened — 보수적으로 sponsored 부여
  /^t\.co$/i,
]

/**
 * URL이 affiliate 가능성이 있는지 — 도메인·쿼리 기반 휴리스틱
 */
export function isLikelyAffiliateUrl(url: string): boolean {
  try {
    const u = new URL(url)
    // 1) 도메인 매칭
    if (AFFILIATE_HOST_PATTERNS.some(re => re.test(u.hostname))) return true
    // 2) 쿼리 파라미터 매칭 (tag, ref, aff, affiliate, partnerid, utm_source=affiliate 등)
    const params = u.searchParams
    if (params.has('aff') || params.has('affiliate') || params.has('partnerid')) return true
    if (params.get('tag')) return true // amazon
    if (params.get('ref') && /(?:aff|partner)/i.test(params.get('ref') || '')) return true
    if (/(?:affiliate|partner)/i.test(params.get('utm_source') || '')) return true
    return false
  } catch {
    return false
  }
}

/**
 * HTML 본문에서 외부 링크에 자동으로 rel·target 추가.
 * - affiliate 의심 링크: rel="sponsored nofollow noopener" target="_blank"
 * - 일반 외부 링크: rel="nofollow ugc noopener" target="_blank"
 * - 내부 링크는 건드리지 않음
 */
export function autoAffiliateRel(html: string, currentHost?: string): string {
  if (!html) return html

  // <a ... href="..." ...>...</a> 형태의 모든 a 태그를 처리
  return html.replace(
    /<a\b([^>]*?)href\s*=\s*(["'])([^"']+?)\2([^>]*?)>/gi,
    (full, before: string, _quote: string, href: string, after: string) => {
      // 내부 링크는 건드리지 않음
      if (href.startsWith('/') || href.startsWith('#')) return full
      // mailto/tel/javascript 건너뜀
      if (/^(mailto|tel|javascript):/i.test(href)) return full

      let host = ''
      try {
        host = new URL(href).hostname
      } catch {
        return full
      }
      if (currentHost && host === currentHost) return full

      const isAffiliate = isLikelyAffiliateUrl(href)

      // 기존 rel 추출
      const attrs = before + after
      const relMatch = /rel\s*=\s*(["'])([^"']*?)\1/i.exec(attrs)
      const existingRel = relMatch ? relMatch[2] : ''
      const relTokens = new Set(existingRel.split(/\s+/).filter(Boolean))

      if (isAffiliate) {
        relTokens.add('sponsored')
      }
      relTokens.add('nofollow')
      relTokens.add('noopener')
      if (!isAffiliate) relTokens.add('ugc')

      const newRel = Array.from(relTokens).join(' ')

      // 기존 target 추출
      const targetMatch = /target\s*=\s*(["'])([^"']*?)\1/i.exec(attrs)
      const hasTargetBlank = targetMatch && targetMatch[2] === '_blank'

      // 새 속성 문자열 생성
      let newAttrs = attrs
      if (relMatch) {
        newAttrs = newAttrs.replace(/rel\s*=\s*(["'])([^"']*?)\1/i, `rel="${newRel}"`)
      } else {
        newAttrs = newAttrs + ` rel="${newRel}"`
      }
      if (!hasTargetBlank) {
        if (targetMatch) {
          newAttrs = newAttrs.replace(/target\s*=\s*(["'])([^"']*?)\1/i, 'target="_blank"')
        } else {
          newAttrs = newAttrs + ' target="_blank"'
        }
      }

      return `<a${newAttrs} href="${href}">`
    }
  )
}

// ============================================================================
// 유틸
// ============================================================================

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}
