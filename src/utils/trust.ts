/**
 * 신뢰성·AI 라벨링 공통 유틸 (C 그룹)
 *
 * - C1: 직업/전공 페이지 신뢰 박스 (출처 등급 평균, 마지막 검수, AI 비율)
 * - C2/C3: HowTo AI 라벨 3단계 박스 + meta 태그
 * - C4: HowTo 카드 AI 배지 (🤖)
 * - C5: AI 이미지 caption 자동 표기
 * - C6: 위키↔HowTo 모순 자동 비교 박스
 * - C7: admin_data_json ↔ user_contributed_json 분리 시각화
 *
 * 정책: /policy/source-tier, /policy/howto §3, /policy/wiki/job §8
 */

// ============================================================================
// AI 라벨 (C2, C3)
// ============================================================================

export type AiContentLevel = 'human' | 'ai-assisted' | 'ai-draft-human-edited' | 'ai-generated'

export const AI_LEVEL_META: Record<AiContentLevel, { label: string; desc: string; severity: number; meta: string }> = {
  'human': {
    label: '사람 작성',
    desc: '편집자가 직접 작성한 글입니다.',
    severity: 0,
    meta: 'human'
  },
  'ai-assisted': {
    label: 'AI 보조',
    desc: '사람이 작성한 본문에 AI가 번역·교정·아이디어 일부를 보조했습니다 (50% 이하).',
    severity: 1,
    meta: 'ai-assisted'
  },
  'ai-draft-human-edited': {
    label: 'AI 초안 + 사람 검수',
    desc: 'AI가 초안을 만들고 사람 편집자가 검수·보강했습니다.',
    severity: 2,
    meta: 'ai-draft-human-edited'
  },
  'ai-generated': {
    label: 'AI 생성 (검수 부족)',
    desc: 'AI가 작성하고 사람 검수가 거의 없는 상태입니다. 발행 전 검수가 필요합니다.',
    severity: 3,
    meta: 'ai-generated'
  }
}

/**
 * HowTo 본문 상단에 표시되는 AI 라벨 박스 (C2)
 */
export function renderAiLevelBanner(
  level: AiContentLevel,
  opts?: { editorName?: string; lastReviewedAt?: string }
): string {
  if (level === 'human') return '' // 사람 작성은 별도 표시 안 함

  const m = AI_LEVEL_META[level]
  const colors: Record<AiContentLevel, string> = {
    'human': '',
    'ai-assisted': 'border:1px solid rgba(96,165,250,0.4); background:rgba(96,165,250,0.07); color:#bfdbfe;',
    'ai-draft-human-edited': 'border:1px solid rgba(167,139,250,0.4); background:rgba(167,139,250,0.07); color:#ddd6fe;',
    'ai-generated': 'border:2px solid rgba(251,146,60,0.55); background:rgba(251,146,60,0.10); color:#fed7aa;'
  }

  const editorLine = opts?.editorName ? `<br><span style="opacity:0.78; font-size:0.82rem;">검수: ${escapeHtml(opts.editorName)}${opts.lastReviewedAt ? ' · ' + escapeHtml(opts.lastReviewedAt) : ''}</span>` : ''

  return `
    <div class="cw-ai-label" data-ai-level="${m.meta}" role="note"
         style="margin: 0 0 18px 0; padding: 14px 18px; border-radius: 12px; ${colors[level]}">
      <div style="display:flex; align-items:flex-start; gap:10px;">
        <span style="font-size:1.4rem;">🤖</span>
        <div style="flex:1;">
          <strong>${escapeHtml(m.label)}</strong>
          <p style="margin: 4px 0 0 0; font-size:0.88rem; line-height:1.55; opacity:0.92;">${escapeHtml(m.desc)}</p>
          ${editorLine}
        </div>
      </div>
    </div>
  `
}

/**
 * AI 라벨용 메타 태그 HTML (C3 — head에 삽입)
 */
export function renderAiLevelMetaTag(level: AiContentLevel): string {
  return `<meta name="ai-content-level" content="${AI_LEVEL_META[level].meta}">`
}

/**
 * HowTo 카드용 AI 라벨 배지 (C4 — 리스트 노출)
 */
export function renderAiLevelBadge(level: AiContentLevel): string {
  if (level === 'human') return ''
  const m = AI_LEVEL_META[level]
  const colors: Record<AiContentLevel, string> = {
    'human': '',
    'ai-assisted': 'background:rgba(96,165,250,0.18); color:#bfdbfe;',
    'ai-draft-human-edited': 'background:rgba(167,139,250,0.18); color:#ddd6fe;',
    'ai-generated': 'background:rgba(251,146,60,0.22); color:#fed7aa;'
  }
  return `<span class="cw-ai-badge" title="${escapeHtml(m.desc)}"
    style="display:inline-flex; align-items:center; gap:4px; padding:2px 8px; border-radius:8px; font-size:0.72rem; font-weight:600; ${colors[level]}">
    🤖 ${escapeHtml(m.label)}
  </span>`
}

// ============================================================================
// AI 이미지 caption 자동 표기 (C5)
// ============================================================================

/**
 * HTML에서 <img> 태그를 검사 → AI 생성 이미지 표기 자동 추가
 * - alt 또는 src에 'ai-' / 'aigen-' / 'comfyui' 등 마커가 있으면 caption 추가
 */
const AI_IMAGE_HINT = /(^|[\/_-])(ai|aigen|aigenerated|comfyui|flux|sdxl|stablediffusion|midjourney|dalle)([\/_-]|$|\.)/i

export function annotateAiImages(html: string): string {
  if (!html) return html
  return html.replace(
    /<img\b([^>]*)>/gi,
    (full, attrs: string) => {
      const srcMatch = /src\s*=\s*(["'])([^"']+)\1/i.exec(attrs)
      const altMatch = /alt\s*=\s*(["'])([^"']*)\1/i.exec(attrs)
      const dataAiMatch = /data-ai\s*=\s*(["'])([^"']*)\1/i.exec(attrs)
      const src = srcMatch ? srcMatch[2] : ''
      const alt = altMatch ? altMatch[2] : ''
      const dataAi = dataAiMatch ? dataAiMatch[2] : ''
      const looksAi = AI_IMAGE_HINT.test(src) || AI_IMAGE_HINT.test(alt) || dataAi
      if (!looksAi) return full
      // alt 끝에 자동 caption 추가
      const aiNote = dataAi || 'AI 생성 이미지'
      let newAttrs = attrs
      if (altMatch) {
        const newAlt = alt.includes('AI 생성') ? alt : `${alt}${alt ? ' · ' : ''}${aiNote}`
        newAttrs = newAttrs.replace(altMatch[0], `alt="${escapeAttr(newAlt)}"`)
      } else {
        newAttrs += ` alt="${escapeAttr(aiNote)}"`
      }
      // figcaption 자동 wrapping은 너무 침습적이라 alt만 보강
      return `<img${newAttrs}>`
    }
  )
}

// ============================================================================
// 신뢰 박스 (C1) - 직업/전공 페이지
// ============================================================================

export type TrustBoxData = {
  /** 평균 출처 등급 (1=최고, 8=최저) */
  sourceTierAvg?: number | null
  /** 출처 개수 */
  sourceCount?: number
  /** 마지막 사람 검수 일자 (ISO 또는 표시 문자열) */
  lastReviewedAt?: string | null
  /** AI 생성분 비율 (0~1) */
  aiGeneratedRatio?: number | null
  /** 분쟁/토론 이력 건수 */
  disputeCount?: number
  /** 페이지 종류 */
  pageType?: 'job' | 'major' | 'howto'
  /** 편집 링크 등을 띄울지 */
  showEditAction?: boolean
  /** 직업/전공/HowTo의 ID (편집 링크용) */
  entityId?: string | number
}

export function renderTrustBox(data: TrustBoxData): string {
  const tierAvg = data.sourceTierAvg
  const tierLabel = tierAvg == null ? '데이터 없음'
    : tierAvg <= 2.5 ? '우수 (1~2순위 비중 높음)'
    : tierAvg <= 4.5 ? '양호 (학술·공공 보고서)'
    : tierAvg <= 6.5 ? '보통 (협회·언론)'
    : '주의 (개인 진술 비중 높음)'
  const tierColor = tierAvg == null ? '#94a3b8'
    : tierAvg <= 2.5 ? '#86efac'
    : tierAvg <= 4.5 ? '#7dd3fc'
    : tierAvg <= 6.5 ? '#fde047'
    : '#fca5a5'

  const aiPct = data.aiGeneratedRatio == null ? null : Math.round(data.aiGeneratedRatio * 100)
  const aiLabel = aiPct == null ? '미상'
    : aiPct === 0 ? '0% (사람 편집)'
    : aiPct < 30 ? `${aiPct}% (AI 보조)`
    : aiPct < 60 ? `${aiPct}% (AI 보조 다수)`
    : aiPct < 95 ? `${aiPct}% (AI 초안 + 사람 검수)`
    : `${aiPct}% (AI 생성 — 검수 부족)`

  const disputeLabel = data.disputeCount && data.disputeCount > 0
    ? `<a href="/policy/dispute" style="color:#c7d2fe; text-decoration:underline;">${data.disputeCount}건 / 합의 도달</a>`
    : '없음'

  return `
    <aside class="cw-trust-box"
      style="margin: 16px 0; padding: 16px 18px; border-radius: 14px;
             border: 1px solid rgba(99,102,241,0.3); background: rgba(99,102,241,0.06);">
      <header style="display:flex; align-items:center; gap:8px; margin-bottom:10px;">
        <i class="fas fa-shield-halved" style="color:#a78bfa;"></i>
        <strong style="color:#e2e8f0;">이 페이지의 신뢰성</strong>
      </header>
      <ul style="list-style:none; padding:0; margin:0; display:grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap:8px; font-size: 0.84rem;">
        <li style="background:rgba(15,23,42,0.4); padding:8px 10px; border-radius:8px;">
          <div style="color:#94a3b8; font-size:0.72rem;">출처 등급 평균</div>
          <div style="color:${tierColor}; font-weight:700; margin-top:2px;">${tierAvg == null ? '—' : tierAvg.toFixed(1)} <span style="font-weight:400; font-size:0.78rem; opacity:0.8;">${escapeHtml(tierLabel)}</span></div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:8px 10px; border-radius:8px;">
          <div style="color:#94a3b8; font-size:0.72rem;">출처 개수</div>
          <div style="color:#e2e8f0; font-weight:700; margin-top:2px;">${data.sourceCount ?? 0}건</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:8px 10px; border-radius:8px;">
          <div style="color:#94a3b8; font-size:0.72rem;">마지막 검수</div>
          <div style="color:#e2e8f0; font-weight:700; margin-top:2px;">${escapeHtml(formatDateLabel(data.lastReviewedAt))}</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:8px 10px; border-radius:8px;">
          <div style="color:#94a3b8; font-size:0.72rem;">AI 생성 비율</div>
          <div style="color:#e2e8f0; font-weight:700; margin-top:2px;">${escapeHtml(aiLabel)}</div>
        </li>
        <li style="background:rgba(15,23,42,0.4); padding:8px 10px; border-radius:8px;">
          <div style="color:#94a3b8; font-size:0.72rem;">분쟁 이력</div>
          <div style="color:#e2e8f0; font-weight:700; margin-top:2px;">${disputeLabel}</div>
        </li>
      </ul>
      <p style="margin: 10px 0 0 0; color:#94a3b8; font-size:0.75rem;">
        <a href="/policy/source-tier" style="color:#93c5fd; text-decoration:underline;">출처 등급 정책</a> ·
        <a href="/policy/wiki/${data.pageType === 'major' ? 'major' : 'job'}" style="color:#93c5fd; text-decoration:underline;">위키 편집지침</a>
      </p>
    </aside>
  `
}

/**
 * 신뢰 박스 컴팩트 버전 — 케밥 메뉴 안의 ? hover popup 용
 */
export function renderTrustBoxCompact(data: TrustBoxData): string {
  const tierAvg = data.sourceTierAvg
  const tierLabel = tierAvg == null ? '데이터 없음'
    : tierAvg <= 2.5 ? '우수 (1~2순위)'
    : tierAvg <= 4.5 ? '양호 (학술·공공)'
    : tierAvg <= 6.5 ? '보통 (협회·언론)'
    : '주의 (개인 진술)'
  const aiPct = data.aiGeneratedRatio == null ? null : Math.round(data.aiGeneratedRatio * 100)
  const aiLabel = aiPct == null ? '미상'
    : aiPct === 0 ? '0%'
    : `${aiPct}%`

  return `
    <div style="font-size:0.78rem; color:#cbd5e1; min-width:240px;">
      <div style="font-weight:700; color:#e2e8f0; margin-bottom:6px; padding-bottom:6px; border-bottom: 1px solid rgba(148,163,184,0.18);">
        <i class="fas fa-shield-halved" style="color:#a78bfa; margin-right:6px;"></i>이 페이지의 신뢰성
      </div>
      <ul style="list-style:none; padding:0; margin:0; display:grid; gap:4px;">
        <li style="display:flex; justify-content:space-between; gap:12px;"><span style="color:#94a3b8;">출처 등급 평균</span><span>${tierAvg == null ? '—' : tierAvg.toFixed(1)} <span style="opacity:0.7;">(${escapeHtml(tierLabel)})</span></span></li>
        <li style="display:flex; justify-content:space-between; gap:12px;"><span style="color:#94a3b8;">출처 개수</span><span>${data.sourceCount ?? 0}건</span></li>
        <li style="display:flex; justify-content:space-between; gap:12px;"><span style="color:#94a3b8;">마지막 검수</span><span>${escapeHtml(formatDateLabel(data.lastReviewedAt))}</span></li>
        <li style="display:flex; justify-content:space-between; gap:12px;"><span style="color:#94a3b8;">AI 생성 비율</span><span>${escapeHtml(aiLabel)}</span></li>
        <li style="display:flex; justify-content:space-between; gap:12px;"><span style="color:#94a3b8;">분쟁 이력</span><span>${data.disputeCount ?? 0}건</span></li>
      </ul>
      <div style="margin-top:8px; padding-top:6px; border-top: 1px solid rgba(148,163,184,0.18); font-size:0.72rem; color:#94a3b8;">
        <a href="/policy/source-tier" style="color:#93c5fd;">출처 등급 정책</a> · <a href="/policy/wiki/${data.pageType === 'major' ? 'major' : data.pageType === 'howto' ? 'job' : 'job'}" style="color:#93c5fd;">편집지침</a>
      </div>
    </div>
  `
}

// ============================================================================
// 위키↔HowTo 모순 비교 박스 (C6)
// ============================================================================

/**
 * HowTo의 통계 주장이 위키 데이터와 모순될 때 본문에 자동 삽입.
 */
export function renderWikiComparisonBox(opts: {
  field: string                          // "평균 연봉" 같은 필드명
  wikiValue: string                      // "4,500만원" 같은 위키 값
  howtoValue: string                     // "6,000만원" 같은 HowTo 값
  wikiSourceUrl?: string
}): string {
  return `
    <div class="cw-wiki-comparison" role="note"
         style="margin: 16px 0; padding: 14px 18px; border-radius: 12px;
                border: 1px solid rgba(251,191,36,0.45); background: rgba(251,191,36,0.07);">
      <div style="display:flex; align-items:flex-start; gap:10px;">
        <span style="font-size:1.2rem;">📊</span>
        <div style="flex:1;">
          <strong style="color:#fde68a;">위키 데이터와 차이가 있습니다</strong>
          <ul style="list-style:none; padding:0; margin:8px 0 0 0; font-size:0.88rem; color:#fde68a;">
            <li>위키 ${escapeHtml(opts.field)}: <strong>${escapeHtml(opts.wikiValue)}</strong>${opts.wikiSourceUrl ? ` (<a href="${escapeAttr(opts.wikiSourceUrl)}" style="color:#fde047;">출처 보기</a>)` : ''}</li>
            <li>본 글 주장: <strong>${escapeHtml(opts.howtoValue)}</strong></li>
          </ul>
          <p style="margin: 8px 0 0 0; opacity:0.8; font-size:0.82rem;">출처·시점 차이일 수 있습니다. 본문 작성자의 출처를 함께 확인해 주세요.</p>
        </div>
      </div>
    </div>
  `
}

// ============================================================================
// admin/user 데이터 분리 시각화 (C7) - 직업 페이지 사이드바용
// ============================================================================

export function renderDataSplitBadge(opts: {
  adminFields: number
  userFields: number
  aiFields: number
}): string {
  const total = opts.adminFields + opts.userFields + opts.aiFields
  if (total === 0) return ''
  const pct = (n: number) => Math.round((n / total) * 100)
  return `
    <div class="cw-data-split" style="margin: 12px 0; padding: 10px 14px; border-radius: 10px; background: rgba(15,23,42,0.5); border: 1px solid rgba(148,163,184,0.18);">
      <div style="font-size:0.78rem; color:#94a3b8; margin-bottom: 6px;">데이터 출처 구성</div>
      <div style="display:flex; height: 10px; border-radius: 6px; overflow: hidden; background: rgba(0,0,0,0.3);">
        <div style="width: ${pct(opts.adminFields)}%; background: #6366f1;" title="공식 데이터"></div>
        <div style="width: ${pct(opts.userFields)}%; background: #34d399;" title="사용자 편집"></div>
        <div style="width: ${pct(opts.aiFields)}%; background: #fbbf24;" title="AI 생성"></div>
      </div>
      <div style="display:flex; gap:10px; flex-wrap:wrap; margin-top:6px; font-size:0.74rem;">
        <span style="color:#a5b4fc;">● 공식 ${pct(opts.adminFields)}%</span>
        <span style="color:#86efac;">● 사용자 ${pct(opts.userFields)}%</span>
        <span style="color:#fde68a;">● AI ${pct(opts.aiFields)}%</span>
      </div>
    </div>
  `
}

// ============================================================================
// E2 [개인 의견] 라벨 자동 인식 (정책 charter §3, source-tier §3)
// ============================================================================

/**
 * 텍스트에 "[개인 의견]" 또는 "현직자 본인" 같은 자기 라벨이 있는지 검사.
 * - 출처 등급 룰 적용에서 제외할지 결정용
 */
const PERSONAL_OPINION_PATTERNS: RegExp[] = [
  /\[개인\s*의견\]/,
  /현직자\s*본인의\s*견해/,
  /개인적인\s*경험/,
  /제\s*경험상/,
  /저는\s*\S+\s*\d+년차/,
  /저는\s*현직/,
]

export function hasPersonalOpinionLabel(text: string | null | undefined): boolean {
  if (!text) return false
  return PERSONAL_OPINION_PATTERNS.some(re => re.test(text))
}

// ============================================================================
// E3 안티패턴 검출 (정책 wiki/job §12)
// ============================================================================

/**
 * "추가 바람", "수정 바람" 같은 안티패턴 검출 — 위키 본문에서 차단
 */
const ANTI_PATTERN_REGEX: RegExp[] = [
  /\b추가\s*바람\b/,
  /\b수정\s*바람\b/,
  /\b보충\s*바람\b/,
  /\b채워\s*주세요\b/,
]

export function detectAntiPatterns(text: string | null | undefined): string[] {
  if (!text) return []
  const hits: string[] = []
  for (const re of ANTI_PATTERN_REGEX) {
    const m = re.exec(text)
    if (m) hits.push(m[0])
  }
  return hits
}

// ============================================================================
// E1 편집 요약 검증 (정책 wiki/job §9-B)
// ============================================================================

/**
 * 편집 요약(reason)이 5자 이상이고 비하·반말·비아냥이 없는지 검사
 */
const EDIT_REASON_BAD_PATTERNS: RegExp[] = [
  /\b씨발\b/,
  /\b개새/,
  /\b좆\w*/,
  /\b미친놈\b/,
  /\b닥쳐\b/,
]

export type EditReasonValidation = {
  valid: boolean
  reason?: string
}

export function validateEditReason(reason: string | null | undefined): EditReasonValidation {
  const text = (reason || '').trim()
  if (text.length < 5) {
    return { valid: false, reason: '편집 요약은 5자 이상 입력해주세요.' }
  }
  for (const re of EDIT_REASON_BAD_PATTERNS) {
    if (re.test(text)) {
      return { valid: false, reason: '편집 요약에 비하·욕설 표현은 사용할 수 없습니다.' }
    }
  }
  return { valid: true }
}

// ============================================================================
// E5/D4 신규/기존 서술 7일 기준선 (정책 wiki/job §9-C)
// ============================================================================

/**
 * 편집된 시점 기준 7일 미만이면 '신규 서술' — 입증 책임이 추가자에게.
 */
export function classifyEditAge(editedAt: string | Date | null | undefined): 'new' | 'established' | 'unknown' {
  if (!editedAt) return 'unknown'
  const editedMs = typeof editedAt === 'string' ? Date.parse(editedAt) : editedAt.getTime()
  if (!Number.isFinite(editedMs)) return 'unknown'
  const ageMs = Date.now() - editedMs
  return ageMs < 7 * 24 * 3600_000 ? 'new' : 'established'
}

// ============================================================================
// G 그룹 - 어뷰징 방어 (정책 community §9, howto §6)
// ============================================================================

const RECENT_COMMENT_WINDOW_MS = 60_000  // 1분
const RECENT_COMMENT_LIMIT = 5

/**
 * G1 댓글 도배 rate limit — 1분당 5개 초과 차단
 * (호출 측에서 최근 1분간 같은 IP 댓글 수를 세어 호출)
 */
export function isRateLimited(recentCount: number, windowMs: number = RECENT_COMMENT_WINDOW_MS): boolean {
  return recentCount > RECENT_COMMENT_LIMIT
}

/**
 * G2 5분 내 동일 단어 60% 이상 반복 검사 (도배 의심)
 */
export function detectKeywordSpam(currentText: string, recentTexts: string[]): boolean {
  if (recentTexts.length < 2) return false
  const tokenize = (s: string) => s.split(/\s+/).filter(t => t.length >= 2)
  const currentTokens = new Set(tokenize(currentText))
  if (currentTokens.size === 0) return false
  let totalShared = 0
  for (const recent of recentTexts) {
    const recentTokens = tokenize(recent)
    if (recentTokens.length === 0) continue
    const shared = recentTokens.filter(t => currentTokens.has(t)).length
    const ratio = shared / recentTokens.length
    if (ratio >= 0.6) totalShared++
  }
  return totalShared >= Math.ceil(recentTexts.length * 0.5)
}

/**
 * G4 HowTo 키워드 도배 검사 — 메인 키워드가 본문 단어수의 3% 초과인지
 */
export function detectKeywordStuffing(body: string, mainKeyword: string): {
  ratio: number
  stuffing: boolean
} {
  if (!body || !mainKeyword) return { ratio: 0, stuffing: false }
  const bodyTokens = body.split(/\s+/).filter(t => t.length >= 1)
  const totalCount = bodyTokens.length
  if (totalCount === 0) return { ratio: 0, stuffing: false }
  const re = new RegExp(escapeRegex(mainKeyword), 'gi')
  const matches = body.match(re) || []
  const ratio = matches.length / totalCount
  return { ratio, stuffing: ratio > 0.03 }
}

/**
 * G5 HowTo 중복 콘텐츠 검사 — 두 본문이 80% 이상 동일한지 (단순 토큰 자카드)
 */
export function detectDuplicateContent(a: string, b: string): {
  similarity: number
  duplicate: boolean
} {
  if (!a || !b) return { similarity: 0, duplicate: false }
  const tokenize = (s: string) => new Set(s.toLowerCase().split(/\s+/).filter(t => t.length >= 2))
  const ta = tokenize(a)
  const tb = tokenize(b)
  if (ta.size === 0 || tb.size === 0) return { similarity: 0, duplicate: false }
  let intersect = 0
  for (const t of ta) if (tb.has(t)) intersect++
  const union = ta.size + tb.size - intersect
  const similarity = union > 0 ? intersect / union : 0
  return { similarity, duplicate: similarity >= 0.8 }
}

function escapeRegex(s: string): string {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
}

// ============================================================================
// 유틸
// ============================================================================

function formatDateLabel(s?: string | null): string {
  if (!s) return '미상'
  // ISO 형식이면 YYYY-MM-DD만
  const m = /^(\d{4}-\d{2}-\d{2})/.exec(s)
  if (m) return m[1]
  return s
}

function escapeHtml(text: string | undefined | null): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text ?? '').replace(/[&<>"']/g, (m) => map[m])
}

function escapeAttr(text: string): string {
  return String(text).replace(/"/g, '&quot;').replace(/</g, '&lt;')
}
