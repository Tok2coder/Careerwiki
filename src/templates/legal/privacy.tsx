/**
 * 개인정보처리방침 페이지
 */

import { CONSENT_VERSIONS } from '../../services/onboardingService'
import { renderNav, renderNavStyles, renderNavScripts } from '../partials/nav'
import { renderFooter } from '../../utils/shared-helpers'

type PrivacyPageOptions = {
  userMenuHtml?: string
}

export function renderPrivacyPage(options?: PrivacyPageOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''

  const sections = [
    { id: 'section-1', title: '1. 수집하는 개인정보 항목', content: `
      <p>Careerwiki는 회원가입, 서비스 이용을 위해 다음과 같은 개인정보를 수집합니다.</p>

      <h3 class="text-base font-medium text-slate-200 mt-4 mb-2">필수 수집 항목</h3>
      <ul class="list-disc list-inside space-y-1">
        <li>Google 계정 로그인 정보: 계정 고유 식별자, 이메일 주소, 프로필 이름, 프로필 사진 URL</li>
        <li>닉네임 (회원가입 시 직접 설정)</li>
        <li>접속 정보: IP 주소, 접속 일시, 기기 및 브라우저 정보</li>
      </ul>

      <h3 class="text-base font-medium text-slate-200 mt-4 mb-2">선택 수집 항목 (온보딩 시)</h3>
      <ul class="list-disc list-inside space-y-1">
        <li>유입 경로: 서비스를 알게 된 경로 (검색, SNS, 지인 추천 등)</li>
        <li>관심 분야: 직업 탐색, 전공 탐색, 전직 고민, 상담 관심, 둘러보기</li>
        <li>현재 상태: 고등학생, 대학생, 취준생, 재직자, 커리어 전환, 기타</li>
        <li>프로필 사진: 직접 업로드한 이미지 파일</li>
      </ul>

      <h3 class="text-base font-medium text-slate-200 mt-4 mb-2">AI 추천 서비스 이용 시</h3>
      <ul class="list-disc list-inside space-y-1">
        <li>흥미, 가치관, 기술, 선호, 제약 사항 등 자가 평가 데이터</li>
        <li>서술형 답변 (성과, 경험, 커리어 스토리 등)</li>
        <li>심층 질문 3라운드 답변</li>
        <li>MBTI 유형 (선택 입력)</li>
      </ul>
    `},
    { id: 'section-2', title: '2. 개인정보의 수집 및 이용 목적', content: `
      <ul class="list-disc list-inside space-y-1">
        <li>회원 가입 및 관리: Google 계정을 통한 본인 식별, 부정 이용 방지</li>
        <li>AI 추천 서비스: 이용자 프로필 분석 후 직업·전공 추천 (결과 저장 및 조회)</li>
        <li>콘텐츠 제공: 직업, 전공, HowTo 가이드 정보 제공</li>
        <li>커뮤니티 서비스: 댓글 작성, 신고, 공감/비공감</li>
        <li>서비스 품질 개선: 성능 모니터링, Google Analytics 4를 통한 이용 통계 분석</li>
        <li>부정 이용 방지: 부정 이용자 제재, 서비스 안정성 확보</li>
      </ul>
    `},
    { id: 'section-3', title: '3. 개인정보의 보유 및 이용 기간', content: `
      <p>서비스는 법령에 따른 개인정보 보유·이용 기간 또는 정보주체로부터 개인정보를 수집 시에
      동의받은 개인정보 보유·이용 기간 내에서 개인정보를 처리·보유합니다.</p>
      <ul class="list-disc list-inside space-y-1 mt-2">
        <li>회원 정보: 회원 탈퇴 시까지</li>
        <li>AI 추천 결과: 회원 탈퇴 시까지 (이용자가 직접 삭제 가능)</li>
        <li>세션 정보: 최대 30일 (7일 미접속 시 자동 만료)</li>
        <li>서비스 이용 기록·접속 로그: 3년</li>
        <li>부정 이용 기록: 3년</li>
      </ul>
    `},
    { id: 'section-4', title: '4. 개인정보의 제3자 제공 및 처리 위탁', content: `
      <p>서비스는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다.
      다만, 다음의 경우에는 예외로 합니다:</p>
      <ul class="list-disc list-inside space-y-1 mt-2 mb-4">
        <li>이용자가 사전에 동의한 경우</li>
        <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
      </ul>

      <p class="font-medium text-slate-200 mb-2">서비스 운영을 위해 다음과 같이 개인정보 처리를 위탁하고 있습니다:</p>
      <div class="overflow-x-auto">
        <table class="w-full text-sm border-collapse mt-2">
          <thead>
            <tr class="border-b border-slate-600">
              <th class="text-left py-2 px-3 text-slate-300 font-medium">수탁업체</th>
              <th class="text-left py-2 px-3 text-slate-300 font-medium">위탁 업무</th>
              <th class="text-left py-2 px-3 text-slate-300 font-medium">처리 데이터</th>
            </tr>
          </thead>
          <tbody>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3">Google LLC</td>
              <td class="py-2 px-3">회원 인증 (OAuth 2.0)</td>
              <td class="py-2 px-3">인증 토큰, 이메일, 프로필</td>
            </tr>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3">OpenAI, Inc.</td>
              <td class="py-2 px-3">AI 추천 분석</td>
              <td class="py-2 px-3">이용자 자가 평가, 서술형 답변</td>
            </tr>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3">Cloudflare, Inc.</td>
              <td class="py-2 px-3">인프라 호스팅, 보안, 데이터 저장</td>
              <td class="py-2 px-3">서비스 전체 데이터</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="bg-slate-800/50 rounded-lg p-4 mt-4">
        <p class="text-sm text-slate-300">
          AI 추천 서비스 이용 시, 이용자가 입력한 자가 평가 및 서술형 답변이 분석을 위해
          외부 AI 서비스(OpenAI)로 전송됩니다. 전송된 데이터는 분석 목적으로만 사용되며,
          서비스 제공자의 모델 학습에 사용되지 않습니다.
        </p>
      </div>
    `},
    { id: 'section-5', title: '5. 개인정보의 파기 절차 및 방법', content: `
      <p>서비스는 개인정보 보유 기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는
      지체 없이 해당 개인정보를 파기합니다.</p>
      <ul class="list-disc list-inside space-y-1 mt-2">
        <li>전자적 파일 형태: 복구 및 재생이 불가능한 방법으로 영구 삭제</li>
      </ul>
      <p class="mt-2">서비스는 100% 디지털 서비스로서 종이 문서 형태의 개인정보를 보유하지 않습니다.</p>
    `},
    { id: 'section-6', title: '6. 이용자의 권리와 행사 방법', content: `
      <p>이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다:</p>
      <ul class="list-disc list-inside space-y-1 mt-2">
        <li>개인정보 열람 요구</li>
        <li>오류 등이 있을 경우 정정 요구</li>
        <li>삭제 요구</li>
        <li>처리 정지 요구</li>
      </ul>
      <p class="mt-3 font-medium text-slate-200">서비스 내에서 직접 변경할 수 있는 항목:</p>
      <ul class="list-disc list-inside space-y-1 mt-1">
        <li>닉네임, 프로필 사진: 설정 메뉴에서 직접 변경</li>
        <li>AI 추천 결과: 마이페이지에서 직접 삭제 가능</li>
      </ul>
      <p class="mt-3">회원 탈퇴는 이메일(contact@careerwiki.org)로 요청하실 수 있으며,
      서비스는 이에 대해 지체 없이 조치하겠습니다.</p>
    `},
    { id: 'section-7', title: '7. 개인정보 보호를 위한 안전조치', content: `
      <p>서비스는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다:</p>
      <ul class="list-disc list-inside space-y-1 mt-2">
        <li>통신 구간 암호화: 모든 데이터 전송은 HTTPS를 통해 암호화됩니다.</li>
        <li>인증 정보 보호: 인증 관련 정보는 암호화하여 저장합니다.</li>
        <li>클라우드 보안: DDoS 방어, 웹 방화벽(WAF) 등 클라우드 인프라 수준의 보안을 적용합니다.</li>
        <li>비밀번호 미저장: Google 소셜 로그인 방식을 사용하여 이용자의 비밀번호를 저장하지 않습니다.</li>
        <li>접근 권한 관리: 개인정보를 처리하는 시스템에 대한 접근 권한을 제한합니다.</li>
      </ul>
    `},
    { id: 'section-8', title: '8. 쿠키(Cookie)의 운용', content: `
      <p>서비스는 이용자의 로그인 상태 유지 및 보안을 위해 다음과 같은 쿠키를 사용합니다.</p>
      <div class="overflow-x-auto">
        <table class="w-full text-sm border-collapse mt-2">
          <thead>
            <tr class="border-b border-slate-600">
              <th class="text-left py-2 px-3 text-slate-300 font-medium">쿠키 이름</th>
              <th class="text-left py-2 px-3 text-slate-300 font-medium">용도</th>
              <th class="text-left py-2 px-3 text-slate-300 font-medium">유효 기간</th>
              <th class="text-left py-2 px-3 text-slate-300 font-medium">유형</th>
            </tr>
          </thead>
          <tbody>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3 font-mono text-xs">session_token</td>
              <td class="py-2 px-3">로그인 세션 유지</td>
              <td class="py-2 px-3">30일</td>
              <td class="py-2 px-3">필수</td>
            </tr>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3 font-mono text-xs">oauth_state</td>
              <td class="py-2 px-3">로그인 보안 검증</td>
              <td class="py-2 px-3">5분</td>
              <td class="py-2 px-3">임시</td>
            </tr>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3 font-mono text-xs">oauth_return_url</td>
              <td class="py-2 px-3">로그인 후 돌아갈 페이지 저장</td>
              <td class="py-2 px-3">5분</td>
              <td class="py-2 px-3">임시</td>
            </tr>
            <tr class="border-b border-slate-700/50">
              <td class="py-2 px-3 font-mono text-xs">onboarding_return_url</td>
              <td class="py-2 px-3">가입 후 돌아갈 페이지 저장</td>
              <td class="py-2 px-3">12시간</td>
              <td class="py-2 px-3">임시</td>
            </tr>
          </tbody>
        </table>
      </div>
      <p class="mt-3">서비스는 Google Analytics 및 Google AdSense를 통해 분석·광고 쿠키를 사용합니다.
      이용자는 웹 브라우저 설정을 통해 쿠키 저장을 거부할 수 있으나,
      이 경우 로그인 등 일부 서비스 이용이 제한될 수 있습니다.</p>
      <div class="overflow-x-auto mt-3">
        <table class="w-full text-sm">
          <thead>
            <tr class="border-b border-slate-700">
              <th class="py-2 px-3 text-left text-slate-400">쿠키</th>
              <th class="py-2 px-3 text-left text-slate-400">용도</th>
              <th class="py-2 px-3 text-left text-slate-400">유효 기간</th>
              <th class="py-2 px-3 text-left text-slate-400">유형</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-700/50">
            <tr>
              <td class="py-2 px-3 font-mono text-xs">_ga, _ga_*</td>
              <td class="py-2 px-3">Google Analytics 방문자 식별</td>
              <td class="py-2 px-3">2년</td>
              <td class="py-2 px-3">분석</td>
            </tr>
            <tr>
              <td class="py-2 px-3 font-mono text-xs">_gid</td>
              <td class="py-2 px-3">Google Analytics 세션 식별</td>
              <td class="py-2 px-3">24시간</td>
              <td class="py-2 px-3">분석</td>
            </tr>
            <tr>
              <td class="py-2 px-3 font-mono text-xs">__gads, __gpi</td>
              <td class="py-2 px-3">Google AdSense 광고 맞춤</td>
              <td class="py-2 px-3">13개월</td>
              <td class="py-2 px-3">광고</td>
            </tr>
          </tbody>
        </table>
      </div>
      <p class="mt-3 text-sm text-slate-400">맞춤 광고를 거부하려면 <a href="https://adssettings.google.com" class="text-blue-400 hover:underline" target="_blank" rel="noopener">Google 광고 설정</a>에서 변경할 수 있습니다.</p>
    `},
    { id: 'section-9', title: '9. 서비스 품질 모니터링 및 분석', content: `
      <p>서비스 품질 개선을 위해 페이지 로딩 속도, 응답 시간 등 성능 지표를 자체적으로 수집합니다.</p>
      <p class="mt-2">또한 서비스는 이용 통계 분석을 위해 <strong class="text-slate-200">Google Analytics 4</strong>를 사용합니다.
      Google Analytics는 쿠키를 사용하여 이용자의 사이트 이용 방식에 대한 익명화된 통계 정보(페이지 조회 수, 세션 정보, 기기 및 브라우저 정보, 대략적인 지리적 위치)를 수집합니다.
      수집된 데이터는 Google의 서버에 저장되며, <a href="https://policies.google.com/privacy" class="text-blue-400 hover:underline" target="_blank" rel="noopener">Google의 개인정보처리방침</a>에 따라 관리됩니다.</p>
      <p class="mt-2">서비스 운영 비용 충당을 위해 <strong class="text-slate-200">Google AdSense</strong> 광고 서비스를 이용합니다.
      Google AdSense는 이용자의 관심사에 기반한 광고를 제공하기 위해 쿠키 및 유사 기술을 사용합니다.
      Google의 광고 쿠키 사용에 대한 상세 내용은 <a href="https://policies.google.com/technologies/ads" class="text-blue-400 hover:underline" target="_blank" rel="noopener">Google 광고 기술 정책</a>에서 확인하실 수 있습니다.</p>
    `},
    { id: 'section-10', title: '10. 개인정보 보호책임자', content: `
      <p>서비스는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한
      이용자의 불만 처리 및 피해구제를 위하여 아래와 같이 연락처를 제공합니다.</p>
      <div class="bg-slate-800/50 rounded-lg p-4 mt-3">
        <p>
          <strong class="text-white">개인정보 관련 문의</strong><br>
          이메일: <a href="mailto:contact@careerwiki.org" class="text-blue-400 hover:underline">contact@careerwiki.org</a>
        </p>
      </div>
    `},
    { id: 'section-11', title: '11. 개인정보처리방침의 변경', content: `
      <p>이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경 내용의 추가,
      삭제 및 정정이 있는 경우에는 변경 사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.</p>
    `},
  ]

  const tocHtml = sections.map((s, i) =>
    `<a href="#${s.id}" class="toc-item group flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all duration-200 hover:bg-white/5">
      <span class="flex-shrink-0 w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold transition-all duration-200" style="background:rgba(99,102,241,0.15);color:#818cf8;">
        ${i + 1}
      </span>
      <span class="text-sm text-slate-400 group-hover:text-white transition-colors">${s.title}</span>
    </a>`
  ).join('')

  const sectionsHtml = sections.map(s => `
    <section id="${s.id}" class="scroll-mt-24">
      <h2 class="text-lg font-semibold text-white mt-8 mb-3">${s.title}</h2>
      <div class="text-slate-300 space-y-2">${s.content}</div>
    </section>
  `).join('')

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>개인정보처리방침 | Careerwiki</title>
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
  <!-- Google AdSense -->
  <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-9810002715600854" crossorigin="anonymous"></script>
  ${renderNavStyles()}
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="max-w-[1400px] mx-auto px-4 pt-20 pb-10 sm:pt-12">
    <header class="mb-8 space-y-3">
      <div class="flex items-center gap-2 text-xs text-blue-300 font-semibold uppercase tracking-[0.2em]">
        <i class="fas fa-shield-halved"></i><span>개인정보처리방침</span>
      </div>
      <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <h1 class="text-3xl md:text-4xl font-bold text-white">개인정보처리방침</h1>
        <p class="text-wiki-muted text-[15px]">버전 ${CONSENT_VERSIONS.privacy} · 시행일 2026년 2월</p>
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
          <span class="text-xs text-slate-500">${sections.length}개 항목</span>
        </div>
        <i class="fas fa-chevron-down text-xs text-slate-500 transition-transform"></i>
      </summary>
      <div class="px-4 pb-4 grid grid-cols-1 sm:grid-cols-2 gap-1">
        ${tocHtml}
      </div>
    </details>

    <div class="glass-card rounded-2xl p-4 sm:p-6 md:p-8">
      <p class="text-slate-300 mb-6">
        Careerwiki(이하 "서비스")는 이용자의 개인정보를 중요시하며,
        「개인정보 보호법」을 준수하고 있습니다. 서비스는 개인정보처리방침을 통해
        이용자의 개인정보가 어떠한 용도와 방식으로 이용되고 있으며,
        개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
      </p>

      <div class="prose prose-invert prose-slate max-w-none">
        ${sectionsHtml}

        <section id="addendum" class="scroll-mt-24">
          <h2 class="text-lg font-semibold text-white mt-8 mb-3">부칙</h2>
          <p class="text-slate-300">이 개인정보처리방침은 2026년 2월부터 시행합니다.</p>
        </section>
      </div>
    </div>
  </main>

  ${renderNavScripts()}
  ${renderFooter()}
</body>
</html>`;
}
