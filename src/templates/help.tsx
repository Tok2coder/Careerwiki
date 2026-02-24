/**
 * Help Center page (static content)
 * - Search bar with client-side filtering
 * - Left category nav, right main content
 * - Links to feedback board (/feedback) and releases (/releases)
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
    desc: '처음 오셨나요?',
    items: [
      { title: '검색으로 시작하기', body: '상단 검색창에 관심 있는 직업이나 전공 이름을 입력하세요. "간호사", "컴퓨터공학" 같은 키워드면 충분합니다. 직업·전공·HowTo 결과가 한번에 나타납니다.' },
      { title: '직업위키 읽는 법', body: '직업 상세 페이지에서는 연봉(중간값 기준), 직무만족도(5점 척도), 워라벨 점수를 한눈에 볼 수 있습니다. 아래로 스크롤하면 하는 일, 필요 역량, 되는 법, 향후 전망을 탭별로 확인할 수 있습니다.' },
      { title: '전공위키 읽는 법', body: '전공 상세 페이지에서는 졸업 후 취업률, 첫 직장 월급, 전공 만족도를 확인할 수 있습니다. 하단에는 이 전공 졸업 후 진출 가능한 직업 목록이 연결되어 있어 진로 탐색에 활용하세요.' },
      { title: 'AI 추천 받기', body: '로그인 후 상단 메뉴의 "AI 추천"을 클릭하면, 나의 흥미·가치관·경험을 바탕으로 AI가 적합한 직업이나 전공을 추천해 줍니다. 약 5~10분 소요됩니다.' }
    ]
  },
  {
    id: 'guide',
    title: '검색 가이드',
    desc: '원하는 정보를 빠르게 찾는 법',
    items: [
      { title: '통합검색 활용', body: '상단 검색창은 AI 기반 의미 검색을 사용합니다. "돈 많이 버는 직업"처럼 자연어로도 검색할 수 있고, "IT 개발"처럼 분야명으로도 검색됩니다. 결과에서 직업·전공·HowTo를 각각 확인하세요.' },
      { title: '직업 목록 탐색', body: '메뉴의 직업위키 또는 /job에서 전체 직업 목록을 볼 수 있습니다. 카테고리 필터로 관심 분야를 좁히거나, 연봉순·만족도순으로 정렬하여 비교해 보세요.' },
      { title: '전공 목록 탐색', body: '메뉴의 전공위키 또는 /major에서 전체 전공 목록을 볼 수 있습니다. 계열별(인문, 사회, 공학 등) 필터를 활용하면 관심 분야를 빠르게 좁힐 수 있습니다.' },
      { title: '데이터 수치 이해하기', body: '연봉은 해당 직업 종사자의 중간값(중위값)입니다. 만족도는 1~5점 척도, 워라벨도 1~5점 척도로 현직자 설문 결과입니다. 취업률은 해당 전공 졸업자 기준 취업률입니다.' }
    ]
  },
  {
    id: 'howto',
    title: 'HowTo 가이드',
    desc: '실무 중심 커리어 가이드',
    items: [
      { title: 'HowTo란?', body: '이력서 작성법, 면접 준비, 자격증 취득 가이드 등 실제 취업/커리어에 필요한 실무 가이드입니다. 각 가이드는 단계별로 구성되어 있어 순서대로 따라하면 됩니다.' },
      { title: '가이드 찾기', body: '/howto 페이지에서 "이력서", "면접", "자격증", "포트폴리오" 같은 키워드로 검색하세요. 가이드 본문에서 목차를 클릭하면 원하는 섹션으로 바로 이동할 수 있습니다.' },
      { title: '가이드 작성하기', body: '로그인 후 HowTo 페이지에서 직접 가이드를 작성할 수 있습니다. 마크다운 에디터를 지원하며, 작성한 가이드는 검토 후 공개됩니다. 마이페이지 > 작성 가이드에서 상태를 확인하세요.' },
      { title: '댓글·신고', body: '가이드 하단에서 댓글로 질문하거나 추가 정보를 공유할 수 있습니다. 부정확하거나 부적절한 내용이 있으면 신고 버튼을 눌러주세요.' }
    ]
  },
  {
    id: 'ai',
    title: 'AI 추천',
    desc: 'AI 직업/전공 추천 서비스',
    items: [
      { title: '추천 과정 (5단계)', body: '① 직업/전공 추천 중 선택 → ② 흥미, 가치관, 기술, 선호, 제약사항을 슬라이더로 자가 평가 → ③ 본인의 경험과 강점을 서술형으로 작성 → ④ AI가 추가 심층 질문 3라운드 진행 → ⑤ 분석 결과 및 추천 직업/전공 확인' },
      { title: '좋은 결과를 받으려면', body: '서술형 답변에서 구체적인 경험을 적을수록 AI 추천 정확도가 올라갑니다. "컴퓨터를 좋아한다"보다 "고등학교 때 파이썬으로 웹 크롤러를 만들어본 경험이 있다" 같은 구체적 서술이 효과적입니다.' },
      { title: '결과 확인·공유', body: '추천 결과는 마이페이지 > AI 추천에서 언제든 다시 볼 수 있습니다. 각 추천 직업/전공을 클릭하면 해당 위키 페이지로 이동하여 상세 정보를 확인할 수 있습니다.' },
      { title: '데이터 처리 안내', body: '입력한 자가 평가와 서술형 답변은 OpenAI API로 전송되어 분석됩니다. OpenAI는 이 데이터를 모델 학습에 사용하지 않습니다. 결과는 서비스 내에 저장되며 마이페이지에서 삭제할 수 있습니다.' }
    ]
  },
  {
    id: 'feedback',
    title: '피드백/문의',
    desc: '문제 신고와 기능 제안',
    items: [
      { title: '피드백 유형', body: '버그(오류·깨진 화면), 기능건의(새 기능·개선 요청), 질문(사용법·데이터 관련), 기타로 나뉩니다. 적절한 유형을 선택하면 더 빠르게 답변받을 수 있습니다.' },
      { title: '효과적인 피드백 작성법', body: '문제가 발생한 페이지 URL을 "관련 링크"에 첨부하세요. 버그라면 "어떤 동작을 했을 때, 기대한 결과와 실제 결과가 어떻게 다른지" 적어주시면 빠른 해결에 도움이 됩니다.' },
      { title: '답변 확인', body: '피드백에 관리자 답변이 달리면 해당 게시글에서 확인할 수 있습니다. 추가 질문이 있으면 댓글로 이어서 대화할 수 있습니다.' },
      { title: '비공개 피드백', body: '개인정보가 포함된 문의는 비공개로 작성할 수 있습니다. 비공개 피드백은 작성자와 관리자만 볼 수 있습니다.' }
    ]
  },
  {
    id: 'account',
    title: '계정/설정',
    desc: '로그인, 프로필, 탈퇴 안내',
    items: [
      { title: '로그인', body: 'Google 계정으로 로그인합니다. 별도 회원가입 절차 없이 Google 로그인만으로 가입이 완료됩니다. 첫 로그인 시 닉네임 설정과 약관 동의 절차(온보딩)가 진행됩니다.' },
      { title: '프로필 수정', body: '마이페이지 > 개인 설정에서 닉네임과 프로필 사진을 변경할 수 있습니다. 닉네임은 2~16자, 한글/영문/숫자/._-만 사용 가능하며 욕설·금칙어와 이미 사용 중인 닉네임은 불가합니다.' },
      { title: '로그인 상태 유지', body: '로그인하면 30일간 세션이 유지됩니다. 7일 이상 접속하지 않으면 자동으로 로그아웃되며, 다시 로그인하면 됩니다.' },
      { title: '회원 탈퇴', body: 'contact@careerwiki.org로 탈퇴를 요청하면 처리됩니다. 탈퇴 시 계정 정보, AI 추천 결과, 작성한 댓글이 삭제됩니다. 작성한 HowTo 가이드는 협의 후 처리합니다.' }
    ]
  },
  {
    id: 'community',
    title: '커뮤니티 가이드',
    desc: '댓글·신고·제재 규칙',
    items: [
      { title: '댓글 작성', body: '직업·전공·HowTo 페이지 하단에서 댓글을 작성할 수 있습니다. 로그인 없이도 익명 댓글이 가능하며, 로그인 시 닉네임이 표시됩니다. 댓글에 공감/비공감을 눌러 의견을 표현할 수 있습니다.' },
      { title: '자동 필터링', body: '욕설, 혐오 표현, 개인정보, 광고성 문구는 자동으로 감지되어 게시가 차단됩니다. 필터에 걸린 경우 해당 표현을 수정한 뒤 다시 작성하세요.' },
      { title: '신고 및 제재', body: '부적절한 댓글은 신고 버튼으로 알려주세요. 신고가 일정 수 이상 누적되면 해당 댓글이 블라인드 처리됩니다. 반복적으로 위반하면 계정이 차단될 수 있습니다.' },
      { title: '이의 제기', body: '부당한 차단이라고 생각되면 contact@careerwiki.org로 이의 제기할 수 있습니다. 전체 커뮤니티 정책은 별도 페이지에서 확인하세요.' }
    ]
  },
  {
    id: 'data',
    title: '데이터 출처',
    desc: '어디서 온 데이터인가요?',
    items: [
      { title: '직업 데이터', body: '한국고용정보원(커리어넷)의 직업 정보를 기반으로 합니다. 연봉, 만족도, 워라벨 점수, 하는 일, 되는 법, 전망 등이 포함됩니다. 커리어넷에서 설문 조사 기반으로 수집한 데이터입니다.' },
      { title: '전공 데이터', body: '고용노동부(고용24)의 학과 정보를 기반으로 합니다. 취업률, 첫 직장 월급, 전공 만족도, 개설 대학 수, 관련 직업 등이 포함됩니다.' },
      { title: '데이터 한계', body: '공공데이터는 보통 1~2년 전 조사 결과입니다. 최신 트렌드와 차이가 있을 수 있으며, 신생 직업이나 소규모 전공은 데이터가 없을 수 있습니다. 참고 자료로 활용하되 실제 의사결정은 다양한 정보를 종합해서 하세요.' },
      { title: '오류 제보', body: '데이터가 잘못되었거나 업데이트가 필요한 경우 /feedback에서 "버그" 유형으로 제보해 주세요. 해당 직업/전공 페이지 URL을 함께 첨부하면 빠르게 확인할 수 있습니다.' }
    ]
  },
  {
    id: 'faq',
    title: 'FAQ',
    desc: '자주 묻는 질문',
    items: [
      { title: '비회원도 이용할 수 있나요?', body: '네, 직업위키·전공위키·HowTo 가이드 열람, 통합검색, 익명 댓글 작성은 로그인 없이 가능합니다. AI 추천, 피드백 작성, HowTo 가이드 작성, 북마크 기능은 로그인이 필요합니다.' },
      { title: '연봉 데이터가 실제와 다른 거 같아요', body: '표시되는 연봉은 해당 직업 종사자의 중간값(중위값)으로, 경력·지역·회사 규모에 따라 실제와 차이가 있을 수 있습니다. 공공데이터 기반이라 조사 시점에 따른 시차도 있습니다.' },
      { title: 'AI 추천 결과가 마음에 안 들어요', body: '서술형 답변을 더 구체적으로 수정하면 결과가 달라질 수 있습니다. 새로 분석을 시작하면 이전 결과와 별개의 새 결과를 받을 수 있습니다.' },
      { title: '온보딩을 건너뛰었는데 어떻게 하나요?', body: '닉네임 설정이나 약관 동의가 완료되지 않으면 다음 로그인 시 온보딩이 다시 표시됩니다. 로그아웃 후 다시 로그인해 보세요.' },
      { title: '댓글이 등록되지 않아요', body: '욕설 필터에 걸리면 댓글이 등록되지 않습니다. 문제가 되는 표현을 수정해 보세요. 계정이 차단된 경우에도 댓글 작성이 제한됩니다.' },
      { title: '모바일에서도 잘 되나요?', body: '네, 모든 기능이 모바일 브라우저에서 정상 작동합니다. 별도 앱 설치는 필요 없습니다.' }
    ]
  },
  {
    id: 'legal',
    title: '약관/정책',
    desc: '법적 고지 문서',
    items: [
      { title: '이용약관', body: '서비스 이용 조건, 회원의 권리와 의무, 콘텐츠 관리, AI 생성 콘텐츠 면책, 분쟁 해결 등을 규정합니다. /legal/terms에서 전문을 확인하세요.' },
      { title: '개인정보처리방침', body: '수집하는 개인정보 항목, 이용 목적, 보유 기간, 외부 위탁(Google·OpenAI·Cloudflare), 쿠키 사용, 이용자 권리 등을 안내합니다. /legal/privacy에서 전문을 확인하세요.' }
    ]
  }
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

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>도움말 | Careerwiki</title>
  <link href="/static/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/static/tailwind.css">
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
  </script>
</body>
</html>`;
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}


