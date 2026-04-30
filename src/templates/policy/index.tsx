/**
 * 정책 인덱스 페이지 (/policy)
 * - 모든 정책·운영 문서를 카드로 모아서 한 페이지에서 둘러볼 수 있도록
 */

import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

type PolicyIndexOptions = {
  userMenuHtml?: string
}

type PolicyCard = {
  href: string
  icon: string
  color: string
  title: string
  desc: string
  group: 'charter' | 'wiki' | 'howto' | 'community' | 'ops' | 'help'
}

const CARDS: PolicyCard[] = [
  // === 헌장 ===
  {
    group: 'charter',
    href: '/policy/charter',
    icon: 'fa-scale-balanced',
    color: 'from-indigo-500/20 to-violet-500/20 border-indigo-400/30 text-indigo-200',
    title: 'Careerwiki 기본방침',
    desc: '서비스 목적, 5대 영역의 정체성, 이용자 권리·의무, 라이선스, 규정 개정 절차를 담은 헌장.'
  },
  {
    group: 'charter',
    href: '/policy/source-tier',
    icon: 'fa-layer-group',
    color: 'from-violet-500/20 to-fuchsia-500/20 border-violet-400/30 text-violet-200',
    title: '출처 신뢰성 등급표 (1~8순위)',
    desc: '직업·전공 데이터의 출처를 8단계로 분류한 핵심 기준. 모든 위키 편집·분쟁 처리의 결정 룰.'
  },

  // === 위키 ===
  {
    group: 'wiki',
    href: '/policy/wiki/job',
    icon: 'fa-briefcase',
    color: 'from-blue-500/20 to-cyan-500/20 border-blue-400/30 text-blue-200',
    title: '직업위키 편집지침',
    desc: '직업 페이지 등재 기준, 서술 규칙, AI 데이터 처리, 신규/기존 서술 7일 기준선.'
  },
  {
    group: 'wiki',
    href: '/policy/wiki/major',
    icon: 'fa-graduation-cap',
    color: 'from-cyan-500/20 to-teal-500/20 border-cyan-400/30 text-cyan-200',
    title: '전공위키 편집지침',
    desc: '전공 페이지 등재 기준, 데이터 출처, 진입 경로 서술, 모집·취업 정보 작성 원칙.'
  },

  // === HowTo ===
  {
    group: 'howto',
    href: '/policy/howto',
    icon: 'fa-route',
    color: 'from-amber-500/20 to-orange-500/20 border-amber-400/30 text-amber-200',
    title: 'HowTo 발행지침',
    desc: '진로 가이드 작성 원칙, AI 라벨 3단계, 광고·제휴 표시, 어뷰징 방지, 작성 스타일 가이드.'
  },

  // === 커뮤니티 ===
  {
    group: 'community',
    href: '/policy/community',
    icon: 'fa-comments',
    color: 'from-emerald-500/20 to-teal-500/20 border-emerald-400/30 text-emerald-200',
    title: '커뮤니티 운영지침',
    desc: '댓글 차단·삭제 사유, 자살자해 매뉴얼, 회사·학교 비방 처리 원칙. (인증 시스템은 별도 기획)'
  },

  // === 운영 절차 ===
  {
    group: 'ops',
    href: '/policy/dispute',
    icon: 'fa-comments-dollar',
    color: 'from-purple-500/20 to-pink-500/20 border-purple-400/30 text-purple-200',
    title: '토론·합의 절차서',
    desc: '편집 분쟁 발생 시 발제 → 합의안 → 이의 제기 기간 → 종결까지의 절차.'
  },
  {
    group: 'ops',
    href: '/policy/enforcement',
    icon: 'fa-gavel',
    color: 'from-rose-500/20 to-red-500/20 border-rose-400/30 text-rose-200',
    title: '신고·이의·제재 절차서',
    desc: '신고 5단계 처리, 단계제 제재(경고→7일→30일→영구), 소명 절차, 권리침해 임시조치.'
  },
  {
    group: 'ops',
    href: '/policy/transparency',
    icon: 'fa-chart-bar',
    color: 'from-sky-500/20 to-blue-500/20 border-sky-400/30 text-sky-200',
    title: '운영 투명성 보고서',
    desc: '신고 처리 통계, 차단 통계, 토론 종결 통계 — 분기별로 공개. (자리표시 단계)'
  },

  // === 도움말 ===
  {
    group: 'help',
    href: '/help',
    icon: 'fa-life-ring',
    color: 'from-slate-500/20 to-gray-500/20 border-slate-400/30 text-slate-200',
    title: '도움말 / FAQ',
    desc: '서비스 시작하기, 검색·HowTo·AI·계정 사용법, 자주 묻는 질문.'
  },
  {
    group: 'help',
    href: '/help/glossary',
    icon: 'fa-book',
    color: 'from-stone-500/20 to-zinc-500/20 border-stone-400/30 text-stone-200',
    title: '용어 사전',
    desc: '발제·합의·존치측·신뢰성 등급·임시조치 등 정책에 등장하는 용어 풀이.'
  },
  {
    group: 'help',
    href: '/legal/terms',
    icon: 'fa-file-contract',
    color: 'from-zinc-500/20 to-neutral-500/20 border-zinc-400/30 text-zinc-200',
    title: '이용약관',
    desc: '서비스 이용 조건, 회원의 권리·의무, AI 면책 조항, 분쟁 해결.'
  },
  {
    group: 'help',
    href: '/legal/privacy',
    icon: 'fa-shield-halved',
    color: 'from-neutral-500/20 to-stone-500/20 border-neutral-400/30 text-neutral-200',
    title: '개인정보처리방침',
    desc: '수집 항목, 처리 위탁, 보유 기간, 쿠키, 이용자 권리.'
  }
]

const GROUP_LABEL: Record<PolicyCard['group'], { label: string; desc: string }> = {
  charter: { label: '헌장', desc: '서비스의 가치와 모든 정책의 토대' },
  wiki: { label: '위키 편집', desc: '직업·전공 페이지 작성·편집·분쟁 처리' },
  howto: { label: 'HowTo 발행', desc: '진로 가이드 콘텐츠 작성·발행 정책' },
  community: { label: '커뮤니티', desc: '댓글·토론·신고 — 안전한 진로 대화 공간' },
  ops: { label: '운영 절차', desc: '분쟁이 났을 때 어떻게 풀어가는가' },
  help: { label: '도움말·법적 문서', desc: '사용자 가이드와 법적 고지' }
}

export function renderPolicyIndexPage(options?: PolicyIndexOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''

  const groups: PolicyCard['group'][] = ['charter', 'wiki', 'howto', 'community', 'ops', 'help']

  const groupedSections = groups.map(g => {
    const items = CARDS.filter(c => c.group === g)
    if (!items.length) return ''
    const meta = GROUP_LABEL[g]
    const cardsHtml = items.map(c => `
      <a href="${c.href}" class="group flex flex-col gap-3 p-5 rounded-2xl border bg-gradient-to-br ${c.color} hover:scale-[1.02] hover:shadow-lg transition-all">
        <div class="flex items-center gap-3">
          <span class="w-10 h-10 rounded-lg flex items-center justify-center bg-black/30">
            <i class="fas ${c.icon} text-base"></i>
          </span>
          <h3 class="text-base font-semibold text-white flex-1">${escapeHtml(c.title)}</h3>
          <i class="fas fa-arrow-right text-xs opacity-60 group-hover:opacity-100 group-hover:translate-x-1 transition-all"></i>
        </div>
        <p class="text-sm text-slate-200/85 leading-relaxed">${escapeHtml(c.desc)}</p>
      </a>
    `).join('')

    return `
      <section class="mb-10">
        <div class="mb-4 flex items-baseline justify-between gap-3">
          <h2 class="text-xl font-bold text-white">${escapeHtml(meta.label)}</h2>
          <p class="text-sm text-slate-400">${escapeHtml(meta.desc)}</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
          ${cardsHtml}
        </div>
      </section>
    `
  }).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>정책 인덱스 | Careerwiki</title>
  <meta name="description" content="Careerwiki의 운영 정책, 편집 지침, 커뮤니티 가이드, 신고 절차를 한 페이지에서 확인하세요.">
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0f0f23; color: #e0e0e0; }
    .glass-card { background: rgba(26, 26, 46, 0.82); border: 1px solid rgba(148, 163, 184, 0.22); backdrop-filter: blur(14px); -webkit-backdrop-filter: blur(14px); }
  </style>
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-H9R83SJRRY"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-H9R83SJRRY');
  </script>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-3 md:px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-10 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-book-open"></i><span>Policy Hub</span>
      </div>
      <h1 class="text-3xl md:text-4xl font-bold text-white">정책·운영·도움말 한눈에</h1>
      <p class="text-wiki-muted text-[15px] leading-relaxed max-w-3xl">
        Careerwiki는 진로 정보의 정확성과 안전한 대화를 동시에 추구합니다.
        아래 문서들이 그 약속의 구체적인 형태입니다. 어디서부터 시작할지 모르겠다면
        <a href="/policy/charter" class="text-blue-300 hover:underline">기본방침</a>부터 읽어주세요.
      </p>
    </header>

    ${groupedSections}

    <div class="glass-card rounded-2xl p-5 sm:p-6 mt-12 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
      <div>
        <p class="text-white font-semibold mb-1">정책에 의견이 있나요?</p>
        <p class="text-sm text-wiki-muted">정책 자체도 토론으로 바뀝니다. 피드백 게시판에 의견을 남겨주세요.</p>
      </div>
      <div class="flex flex-wrap gap-2">
        <a href="/feedback" class="px-4 py-2.5 min-h-[44px] flex items-center rounded-lg border border-blue-400/60 text-sm text-blue-200 hover:bg-blue-500/10">피드백 보내기</a>
        <a href="/policy/dispute" class="px-4 py-2.5 min-h-[44px] flex items-center rounded-lg border border-purple-400/60 text-sm text-purple-200 hover:bg-purple-500/10">토론 절차 보기</a>
      </div>
    </div>
  </main>

  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}
