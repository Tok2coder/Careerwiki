/**
 * 이용약관 페이지
 */

import { CONSENT_VERSIONS } from '../../services/onboardingService'
import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'

type TermsPageOptions = {
  userMenuHtml?: string
}

export function renderTermsPage(options?: TermsPageOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''

  const articles = [
    { id: 'article-1', title: '제1조 (목적)', content: `
      <p>이 약관은 Careerwiki(이하 "서비스")가 제공하는 커리어 정보 서비스의 이용과 관련하여
      서비스와 이용자 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
    `},
    { id: 'article-2', title: '제2조 (정의)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>"서비스"란 Careerwiki가 제공하는 직업·전공 정보, AI 추천, 커뮤니티 등 일체의 서비스를 말합니다.</li>
        <li>"이용자"란 서비스에 접속하여 이 약관에 따라 서비스를 이용하는 회원 및 비회원을 말합니다.</li>
        <li>"회원"이란 서비스에 가입하여 계정을 부여받은 이용자를 말합니다.</li>
        <li>"닉네임"이란 회원 식별과 서비스 이용을 위해 회원이 설정한 이름을 말합니다.</li>
        <li>"AI 추천 서비스"란 OpenAI의 인공지능 모델을 활용하여 이용자의 프로필을 분석하고 직업·전공을 추천하는 서비스를 말합니다.</li>
        <li>"HowTo 가이드"란 서비스에서 제공하는 취업·커리어 관련 실무 가이드 콘텐츠를 말합니다.</li>
        <li>"댓글 커뮤니티"란 직업·전공·HowTo 페이지에서 익명 또는 로그인 후 참여할 수 있는 댓글 서비스를 말합니다.</li>
      </ol>
    `},
    { id: 'article-3', title: '제3조 (약관의 효력 및 변경)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>이 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
        <li>서비스는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지합니다.</li>
        <li>이용자가 변경된 약관에 동의하지 않는 경우, 서비스 이용을 중단하고 탈퇴할 수 있습니다.</li>
      </ol>
    `},
    { id: 'article-4', title: '제4조 (서비스의 제공)', content: `
      <p>서비스는 다음의 서비스를 제공합니다:</p>
      <ol class="list-decimal list-inside space-y-2 mt-2">
        <li>직업위키: 공공데이터 기반 직업 정보 제공 (연봉, 만족도, 워라벨, 직무 내용, 전망 등)</li>
        <li>전공위키: 공공데이터 기반 전공 정보 제공 (취업률, 첫월급, 만족도, 관련 직업 등)</li>
        <li>HowTo 가이드: 취업·커리어 관련 실무 가이드 콘텐츠 제공</li>
        <li>AI 추천 서비스: 이용자 프로필 분석 후 AI 기반 직업·전공 추천</li>
        <li>댓글 커뮤니티: 콘텐츠별 댓글·토론 기능</li>
        <li>피드백 시스템: 버그 제보, 기능 제안, 질문 접수</li>
        <li>기타 서비스가 추가로 개발·제공하는 서비스</li>
      </ol>
    `},
    { id: 'article-5', title: '제5조 (이용자의 의무)', content: `
      <p>이용자는 다음 행위를 하여서는 안 됩니다:</p>
      <ol class="list-decimal list-inside space-y-2 mt-2">
        <li>타인의 정보 도용</li>
        <li>서비스에 게시된 정보의 무단 변경</li>
        <li>서비스가 금지한 정보(음란물, 욕설 등)의 게시</li>
        <li>서비스의 운영을 방해하는 행위</li>
        <li>타인의 명예를 훼손하거나 불이익을 주는 행위</li>
        <li>자동화된 수단(봇, 스크래핑 등)을 이용한 대량 요청</li>
        <li>AI 추천 결과를 전문 상담이나 의학적·법적 조언을 대체하는 것으로 간주하는 행위</li>
        <li>기타 관계 법령에 위배되는 행위</li>
      </ol>
    `},
    { id: 'article-6', title: '제6조 (게시물의 관리)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>이용자가 작성한 게시물의 저작권은 해당 이용자에게 있습니다.</li>
        <li>서비스는 다음에 해당하는 게시물을 사전 통지 없이 삭제하거나 이동할 수 있습니다:
          <ul class="list-disc list-inside ml-4 mt-2 space-y-1">
            <li>스팸성 게시물</li>
            <li>타인을 비방하거나 명예를 훼손하는 게시물</li>
            <li>음란물, 욕설이 포함된 게시물</li>
            <li>영리 목적의 광고성 게시물</li>
            <li>기타 약관에 위배되는 게시물</li>
          </ul>
        </li>
      </ol>
    `},
    { id: 'article-7', title: '제7조 (데이터 출처 및 지적재산)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>서비스에서 제공하는 직업·전공 정보는 한국고용정보원(커리어넷), 고용노동부(고용24) 등 공공데이터를 기반으로 합니다.</li>
        <li>공공데이터의 저작권은 원 제공기관에 귀속되며, 서비스는 이를 가공·재구성하여 제공합니다.</li>
        <li>서비스는 데이터의 정확성, 완전성, 최신성을 보장하지 않으며, 데이터 갱신 주기에 따라 최신 정보와 차이가 있을 수 있습니다.</li>
      </ol>
    `},
    { id: 'article-8', title: '제8조 (AI 생성 콘텐츠)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>AI 추천 서비스는 OpenAI의 인공지능 모델을 활용하여 생성된 참고용 정보를 제공합니다.</li>
        <li>AI 분석 결과는 전문가 상담, 진로 지도, 의학적·법적 조언을 대체하지 않습니다.</li>
        <li>AI의 특성상 부정확하거나 편향된 결과가 포함될 수 있으며, 이용자의 최종 결정은 본인의 판단과 책임 하에 이루어져야 합니다.</li>
        <li>AI 추천을 위해 이용자가 입력한 데이터는 분석 목적으로 외부 AI 서비스(OpenAI)에 전송됩니다. 자세한 사항은 개인정보처리방침을 참고하세요.</li>
      </ol>
    `},
    { id: 'article-9', title: '제9조 (서비스의 중단)', content: `
      <p>서비스는 시스템 점검, 설비 교체 등 부득이한 사유가 있는 경우 서비스 제공을 일시적으로 중단할 수 있으며,
      이 경우 사전에 공지합니다. 다만, 긴급한 경우에는 사후에 공지할 수 있습니다.</p>
    `},
    { id: 'article-10', title: '제10조 (면책조항)', content: `
      <ol class="list-decimal list-inside space-y-2">
        <li>서비스는 이용자가 서비스를 통해 얻은 정보로 인한 손해에 대해 책임을 지지 않습니다.</li>
        <li>서비스는 이용자 간 또는 이용자와 제3자 간에 발생한 분쟁에 개입하지 않으며 이로 인한 손해를 배상할 책임이 없습니다.</li>
        <li>서비스는 AI 추천 결과의 정확성, 완전성, 적시성에 대해 보증하지 않습니다.</li>
        <li>서비스는 공공데이터 원본의 오류로 인한 정보 부정확에 대해 책임을 지지 않습니다.</li>
      </ol>
    `},
    { id: 'article-11', title: '제11조 (분쟁해결)', content: `
      <p>서비스와 이용자 간에 발생한 분쟁은 대한민국 법률에 따라 해결하며,
      소송이 필요한 경우 서비스의 소재지를 관할하는 법원을 전속관할법원으로 합니다.</p>
    `},
  ]

  const tocHtml = articles.map((a, i) =>
    `<a href="#${a.id}" class="toc-item group flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all duration-200 hover:bg-white/5">
      <span class="flex-shrink-0 w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold transition-all duration-200" style="background:rgba(99,102,241,0.15);color:#818cf8;">
        ${i + 1}
      </span>
      <span class="text-sm text-slate-400 group-hover:text-white transition-colors">${a.title}</span>
    </a>`
  ).join('')

  const articlesHtml = articles.map(a => `
    <section id="${a.id}" class="scroll-mt-24">
      <h2 class="text-lg font-semibold text-white mt-8 mb-3">${a.title}</h2>
      <div class="text-slate-300 space-y-2">${a.content}</div>
    </section>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이용약관 | Careerwiki</title>
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0b1220; color: #dee3ff; }
    .glass-card { background: rgba(26, 26, 46, 0.8); border: 1px solid rgba(67, 97, 238, 0.2); backdrop-filter: blur(12px); }
  </style>
  <!-- Google Analytics 4 -->
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

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-file-contract"></i><span>이용약관</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">이용약관</h1>
        <p class="text-wiki-muted text-[15px]">버전 ${CONSENT_VERSIONS.terms} · 시행일 2026년 2월</p>
      </div>
    </header>

    <!-- 목차 -->
    <details class="mb-6 glass-card rounded-2xl overflow-hidden md:open" open>
      <summary class="px-5 py-4 cursor-pointer select-none flex items-center justify-between gap-3 hover:bg-white/[0.03] transition-colors">
        <div class="flex items-center gap-3">
          <span class="w-8 h-8 rounded-lg flex items-center justify-center" style="background:linear-gradient(135deg,rgba(99,102,241,0.25),rgba(139,92,246,0.25));">
            <i class="fas fa-list-ol text-sm" style="color:#a78bfa;"></i>
          </span>
          <span class="text-sm font-semibold text-slate-200">목차</span>
          <span class="text-xs text-slate-500">${articles.length}개 조항</span>
        </div>
        <i class="fas fa-chevron-down text-xs text-slate-500 transition-transform"></i>
      </summary>
      <div class="px-4 pb-4 grid grid-cols-1 sm:grid-cols-2 gap-1">
        ${tocHtml}
      </div>
    </details>

    <div class="glass-card rounded-2xl p-4 sm:p-6 md:p-8">
      <div class="prose prose-invert prose-slate max-w-none">
        ${articlesHtml}

        <section id="addendum" class="scroll-mt-24">
          <h2 class="text-lg font-semibold text-white mt-8 mb-3">부칙</h2>
          <p class="text-slate-300">이 약관은 2026년 2월부터 시행합니다.</p>
        </section>
      </div>
    </div>
  </main>

  ${renderNavScripts()}
</body>
</html>`;
}
