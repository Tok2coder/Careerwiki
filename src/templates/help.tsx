/**
 * Help Center page (static content)
 * - Search bar with client-side filtering
 * - Left category nav, right main content
 * - Links to feedback board (/feedback) and releases (/releases)
 * - Bottom usefulness widget (stubbed client-side only)
 */

import { renderNav, renderNavStyles, renderNavScripts } from './partials/nav'

type HelpSection = {
  id: string
  title: string
  desc: string
  items: { title: string; body: string }[]
}

const SECTIONS: HelpSection[] = [
  {
    id: 'quickstart',
    title: '빠른 시작',
    desc: '핵심 흐름',
    items: [
      { title: '통합검색', body: '상단 검색창 또는 /search에서 직업·전공·HowTo를 한번에 찾아보세요.' },
      { title: '직업위키', body: '연봉·만족도·워라벨 메트릭과 요약/업무/전망 탭을 통해 직업을 파악하세요.' },
      { title: '전공위키', body: '취업률·첫월급·만족도 메트릭과 관련 직업을 확인할 수 있습니다.' },
      { title: 'HowTo 가이드', body: '취업/커리어 실무 가이드를 모았습니다. 필요한 키워드로 검색해 보세요.' }
    ]
  },
  {
    id: 'guide',
    title: '검색·상세 안내',
    desc: '검색, 상세 탭, 통합검색 미리보기 활용법',
    items: [
      { title: '검색 키워드 팁', body: '2~3단어 구체적으로 입력하면 매칭 정확도가 올라갑니다.' },
      { title: '직업 상세 읽기', body: '개요·연봉/만족도·직무내용·전망 순서로 탭이 구성되어 있습니다.' },
      { title: '전공 상세 읽기', body: '취업률·첫월급·만족도와 관련 직업/HowTo 링크를 함께 제공합니다.' },
      { title: '통합검색 더보기', body: '미리보기 하단 “직업 결과 더보기” 링크로 /job, /major 목록으로 이동하세요.' }
    ]
  },
  {
    id: 'howto',
    title: 'HowTo 이용',
    desc: 'HowTo 활용법',
    items: [
      { title: '검색', body: '“이력서”, “면접”, “자격증”처럼 주제 키워드로 검색하세요.' },
      { title: '목차 활용', body: '가이드 상단 목차를 사용해 필요한 섹션으로 바로 이동하세요.' },
      { title: '신고', body: '부적절한 내용은 가이드 하단 신고 버튼으로 알려주세요.' }
    ]
  },
  {
    id: 'feedback',
    title: '피드백/문의',
    desc: '버그 제보·제안 접수',
    items: [
      { title: '피드백 남기기', body: '/feedback에서 버그·기능건의·질문을 등록하면 답변을 받습니다.' },
      { title: '링크 첨부', body: '관련 페이지 URL을 선택 입력하면 처리 속도가 빨라집니다.' },
      { title: '알려진 이슈', body: '해결 중인 문제는 “알려진 이슈” 섹션에서 먼저 확인하세요.' }
    ]
  },
  {
    id: 'account',
    title: '계정/보안',
    desc: '로그인 및 기본 정책',
    items: [
      { title: '소셜 로그인', body: 'Google 로그인만 지원합니다. 로그인 후 피드백 작성·신고가 가능합니다.' },
      { title: '닉네임 규칙', body: '2~16자, 한글/영문/숫자/._- 허용. 금칙어·중복은 불가합니다.' },
      { title: '차단/해제', body: '운영 정책 위반 시 차단될 수 있으며 문의를 통해 이의 제기가 가능합니다.' },
      { title: '회원 탈퇴', body: '현재 문의로 처리합니다. 셀프 탈퇴 기능은 준비 중입니다.' }
    ]
  },
  {
    id: 'community',
    title: '커뮤니티 가이드',
    desc: '댓글 금칙어·신고·제재 요약 (전체 정책은 별도 페이지)',
    items: [
      { title: '금칙어/욕설 필터', body: '욕설·혐오·사칭 단어는 자동 치환/차단됩니다.' },
      { title: '도배/광고 금지', body: '반복 게시·상업 링크는 제재 대상입니다.' },
      { title: '신고 처리', body: '신고 누적 시 블라인드/차단되며 이의 제기 절차를 제공합니다.' }
    ]
  },
  {
    id: 'data',
    title: '데이터 출처·정확성',
    desc: '데이터 업데이트·정정 방법',
    items: [
      { title: '업데이트 주기', body: '공공 API/파트너 데이터 동기화 후 캐시 만료 규칙에 따라 갱신됩니다.' },
      { title: '정정 요청', body: '오류는 /feedback에서 “버그” 유형으로 제보해 주세요.' }
    ]
  },
  {
    id: 'accessibility',
    title: '접근성',
    desc: '키보드·스크린리더 팁',
    items: [
      { title: '키보드 내비', body: 'Tab/Shift+Tab으로 이동, Enter/Space로 액션을 수행합니다.' },
      { title: '스크린리더', body: '주요 내비게이션에 landmark 역할이 지정되어 있습니다.' }
    ]
  },
  {
    id: 'faq',
    title: 'FAQ',
    desc: '자주 묻는 질문',
    items: [
      { title: '데이터 출처는?', body: '공공 데이터와 파트너 데이터를 사용합니다.' },
      { title: '온보딩을 건너뛰었어요', body: '닉네임/동의가 필요하면 재로그인 시 온보딩이 다시 표시될 수 있습니다.' },
      { title: '댓글이 안 올라가요', body: '욕설 필터 또는 일시적 차단 가능성. 금칙어를 제거해 보세요.' }
    ]
  },
  {
    id: 'known',
    title: '알려진 이슈',
    desc: '현재 인지한 문제',
    items: [
      { title: '이미지 로딩 지연', body: '저해상도 플레이스홀더 도입을 준비 중입니다.' }
    ]
  },
  {
    id: 'legal',
    title: '약관/개인정보 처리방침',
    desc: '법적 고지 문서',
    items: [
      { title: '이용약관', body: '서비스 이용 시 준수해야 할 규칙입니다.' },
      { title: '개인정보 처리방침', body: '개인정보 수집·보유·파기·문의 채널을 명시합니다.' }
    ]
  }
]

const RELEASE_PREVIEW = [
  { version: 'v0.7.3', date: '2025-12-09', title: '온보딩/욕설 필터/관리자 상세 개선' },
  { version: 'v0.7.2', date: '2025-12-05', title: '댓글 블라인드 및 신고 UX 개선' },
  { version: 'v0.7.1', date: '2025-11-30', title: '직업 상세 성능 튜닝 및 캐시 만료 정책 조정' }
]

const FEEDBACK_TEMPLATES = [
  { title: '버그 제보 템플릿', body: '재현 단계, 기대 결과, 실제 결과, 환경(브라우저/OS), 스크린샷' },
  { title: '기능 제안 템플릿', body: '문제 정의, 제안, 기대 효과, 참고 사례' }
]

type HelpPageOptions = {
  userMenuHtml?: string
}

export function renderHelpPage(options?: HelpPageOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''
  const sectionCards = SECTIONS.map((section) => {
    const items = section.items
      .map(
        (it) => `
        <li class="p-3 rounded-lg glass-card border border-wiki-border/60">
          <p class="font-semibold text-wiki-text">${escapeHtml(it.title)}</p>
          <p class="text-sm text-wiki-muted mt-1">${escapeHtml(it.body)}</p>
        </li>`
      )
      .join('')

    return `
      <section id="${section.id}" class="scroll-mt-24">
        <div class="flex items-start justify-between gap-3 mb-3">
          <div>
            <p class="text-xs uppercase tracking-wide text-slate-400">${escapeHtml(section.title)}</p>
            <h2 class="text-xl font-bold text-white">${escapeHtml(section.desc)}</h2>
          </div>
          <a href="#${section.id}" class="text-xs text-slate-500 hover:text-blue-400">#</a>
        </div>
        <ul class="grid md:grid-cols-2 gap-3">
          ${items}
        </ul>
      </section>
    `
  }).join('<div class="border-t border-slate-800 my-10"></div>')

  const tocLinks = SECTIONS.map((s) => `<a href="#${s.id}" class="block text-sm text-slate-300 hover:text-white py-2 min-h-[40px] flex items-center">${escapeHtml(s.title)}</a>`).join('')

  const releaseList = RELEASE_PREVIEW.map((r) => `
    <li class="p-3 rounded-lg glass-card border border-wiki-border/60 flex items-center justify-between">
      <div>
        <p class="font-semibold text-wiki-text">${escapeHtml(r.title)}</p>
        <p class="text-xs text-wiki-muted">${escapeHtml(r.version)} · ${escapeHtml(r.date)}</p>
      </div>
      <a href="/releases" class="text-wiki-link text-sm hover:underline">보기</a>
    </li>
  `).join('')

  const feedbackList = FEEDBACK_TEMPLATES.map((f) => `
    <li class="p-3 rounded-lg glass-card border border-wiki-border/60">
      <p class="font-semibold text-wiki-text">${escapeHtml(f.title)}</p>
      <p class="text-sm text-wiki-muted mt-1">${escapeHtml(f.body)}</p>
    </li>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>도움말 | CareerWiki</title>
  <link href="/static/style.css" rel="stylesheet" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body { background-color: #0b1220; color: #dee3ff; }
    .glass { background: rgba(26, 26, 46, 0.8); border: 1px solid rgba(67, 97, 238, 0.2); backdrop-filter: blur(10px); }
    .glass-card { background: rgba(26, 26, 46, 0.8); border: 1px solid rgba(67, 97, 238, 0.2); backdrop-filter: blur(12px); }
    .sticky-nav { position: sticky; top: 90px; }
    .card-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 14px; }
  </style>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-life-ring"></i><span>도움말</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">무엇을 도와드릴까요?</h1>
        <div class="flex gap-2 flex-wrap">
          <a href="/feedback" class="px-4 py-2.5 min-h-[44px] flex items-center rounded-lg border border-slate-700 text-sm text-blue-300 hover:border-blue-500">피드백</a>
          <a href="/help/community-guidelines" class="px-4 py-2.5 min-h-[44px] flex items-center rounded-lg border border-slate-700 text-sm text-emerald-200 hover:border-emerald-400">커뮤니티 정책</a>
          <a href="/releases" class="px-4 py-2.5 min-h-[44px] flex items-center rounded-lg border border-slate-700 text-sm text-slate-200 hover:border-blue-500">릴리즈 노트</a>
        </div>
      </div>
      <div class="glass rounded-2xl p-4">
        <div class="flex items-center gap-3">
          <i class="fas fa-search text-slate-400"></i>
          <input id="help-search" type="search" placeholder="무엇을 도와드릴까요? '직업 검색', '전공 검색', 'HowTo'…" class="w-full bg-transparent outline-none text-white placeholder:text-slate-500 text-base" style="font-size: 16px;">
          <span id="search-count" class="text-xs text-slate-500 shrink-0"></span>
        </div>
      </div>
    </header>

    <div class="grid grid-cols-1 lg:grid-cols-[240px_minmax(0,1fr)] gap-6">
      <!-- Left nav -->
      <aside class="glass rounded-2xl p-4 sticky-nav hidden lg:block">
        <p class="text-xs text-slate-400 mb-2">카테고리</p>
        <div class="space-y-1">${tocLinks}</div>
        <div class="mt-4 pt-4 border-t border-slate-800 space-y-2">
          <a href="/help/community-guidelines" class="block text-sm text-emerald-200 hover:text-white">커뮤니티 이용 정책</a>
          <a href="/legal/terms" class="block text-sm text-slate-300 hover:text-white">이용약관</a>
          <a href="/legal/privacy" class="block text-sm text-slate-300 hover:text-white">개인정보 처리방침</a>
        </div>
      </aside>

      <!-- Main content -->
      <section id="help-content" class="space-y-10">
        ${sectionCards}

        <div class="glass rounded-2xl p-5 flex flex-col md:flex-row md:items-center md:justify-between gap-3">
          <div>
            <p class="text-white font-semibold">커뮤니티 이용 정책</p>
            <p class="text-sm text-wiki-muted">댓글 금칙어, BEST/신고/공감 기준을 확인하세요.</p>
          </div>
          <a href="/help/community-guidelines" class="px-5 py-3 min-h-[44px] flex items-center justify-center rounded-lg border border-emerald-400/60 text-sm text-emerald-200 hover:bg-emerald-500/10">전체 정책 보기</a>
        </div>

        <!-- Useful? widget -->
      </section>
    </div>
  </main>

  ${renderNavScripts()}
  <script>
    const sections = ${JSON.stringify(SECTIONS)};
    const searchInput = document.getElementById('help-search');
    const countEl = document.getElementById('search-count');
    const cards = document.querySelectorAll('#help-content section');

    function filter(query) {
      const q = query.trim().toLowerCase();
      let visible = 0;
      cards.forEach((section) => {
        const id = section.id;
        const data = sections.find(s => s.id === id);
        if (!data) return;
        const haystack = (data.title + ' ' + data.desc + ' ' + data.items.map(i => i.title + ' ' + i.body).join(' ')).toLowerCase();
        const match = q === '' || haystack.includes(q);
        section.style.display = match ? '' : 'none';
        if (match) visible += 1;
      });
      countEl.textContent = q ? visible + '개 문서' : '';
    }

    searchInput.addEventListener('input', (e) => filter(e.target.value));
    filter('');

    // Usefulness widget (client-only stub)
    const btnYes = document.getElementById('btn-useful-yes');
    const btnNo = document.getElementById('btn-useful-no');
    const note = document.getElementById('useful-note');
    function toast(msg, ok=true){
      alert(msg);
    }
    btnYes.addEventListener('click', () => {
      toast('의견이 기록되었습니다. 감사합니다!');
      note.value = '';
    });
    btnNo.addEventListener('click', () => {
      toast('의견이 기록되었습니다. 더 나은 경험을 만들겠습니다.');
      note.value = '';
    });
  </script>
</body>
</html>`;
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}


