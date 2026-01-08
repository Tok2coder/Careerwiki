/**
 * 개인정보처리방침 페이지
 */

import { CONSENT_VERSIONS } from '../../services/onboardingService'

export function renderPrivacyPage(): string {
  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>개인정보처리방침 | CareerWiki</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * { font-family: 'Noto Sans KR', sans-serif; }
    body { 
      background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
      min-height: 100vh;
    }
    .glass-card {
      background: rgba(30, 41, 59, 0.9);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(148, 163, 184, 0.15);
    }
  </style>
</head>
<body class="text-slate-100 p-4 md:p-8">
  <div class="max-w-3xl mx-auto">
    <div class="glass-card rounded-2xl p-8">
      <header class="mb-8 border-b border-slate-700 pb-6">
        <h1 class="text-2xl font-bold mb-2">개인정보처리방침</h1>
        <p class="text-slate-400 text-sm">
          버전: ${CONSENT_VERSIONS.privacy} | 시행일: 2025년 12월 1일
        </p>
      </header>

      <div class="prose prose-invert prose-slate max-w-none">
        <p class="text-slate-300 mb-6">
          CareerWiki(이하 "서비스")는 이용자의 개인정보를 중요시하며, 
          「개인정보 보호법」을 준수하고 있습니다. 서비스는 개인정보처리방침을 통해 
          이용자의 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 
          개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">1. 수집하는 개인정보 항목</h2>
        <p class="text-slate-300 mb-2">서비스는 회원가입, 서비스 이용을 위해 다음과 같은 개인정보를 수집합니다:</p>
        
        <h3 class="text-base font-medium text-slate-200 mt-4 mb-2">필수 수집 항목</h3>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>소셜 로그인 정보: 소셜 계정 고유 식별자, 이메일 주소</li>
          <li>닉네임 (회원가입 시 설정)</li>
          <li>서비스 이용 기록, 접속 로그, IP 주소</li>
        </ul>

        <h3 class="text-base font-medium text-slate-200 mt-4 mb-2">선택 수집 항목</h3>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>유입 경로 (어떻게 서비스를 알게 되었는지)</li>
          <li>관심 분야 및 현재 커리어 상태</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">2. 개인정보의 수집 및 이용 목적</h2>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>회원 가입 및 관리: 회원 식별, 서비스 이용에 따른 본인 확인</li>
          <li>서비스 제공: 콘텐츠 제공, 커뮤니티 서비스 이용</li>
          <li>서비스 개선: 서비스 이용 통계, 서비스 품질 향상</li>
          <li>부정 이용 방지: 부정 이용자 제재, 서비스 안정성 확보</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">3. 개인정보의 보유 및 이용 기간</h2>
        <p class="text-slate-300 mb-2">
          서비스는 법령에 따른 개인정보 보유·이용 기간 또는 정보주체로부터 개인정보를 수집 시에 
          동의받은 개인정보 보유·이용 기간 내에서 개인정보를 처리·보유합니다.
        </p>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>회원 정보: 회원 탈퇴 시까지</li>
          <li>서비스 이용 기록: 3년</li>
          <li>부정 이용 기록: 3년</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">4. 개인정보의 제3자 제공</h2>
        <p class="text-slate-300 mb-4">
          서비스는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 
          다만, 다음의 경우에는 예외로 합니다:
        </p>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>이용자가 사전에 동의한 경우</li>
          <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">5. 개인정보의 파기 절차 및 방법</h2>
        <p class="text-slate-300 mb-4">
          서비스는 개인정보 보유 기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 
          지체 없이 해당 개인정보를 파기합니다.
        </p>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>전자적 파일 형태: 복구 및 재생이 불가능한 방법으로 영구 삭제</li>
          <li>종이 문서: 분쇄기로 분쇄하거나 소각</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">6. 이용자의 권리와 행사 방법</h2>
        <p class="text-slate-300 mb-2">
          이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다:
        </p>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>개인정보 열람 요구</li>
          <li>오류 등이 있을 경우 정정 요구</li>
          <li>삭제 요구</li>
          <li>처리 정지 요구</li>
        </ul>
        <p class="text-slate-300 mb-4">
          위 권리 행사는 서비스에 대해 서면, 전자우편 등을 통하여 하실 수 있으며, 
          서비스는 이에 대해 지체 없이 조치하겠습니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">7. 개인정보 보호를 위한 안전조치</h2>
        <ul class="list-disc list-inside text-slate-300 space-y-1 mb-4">
          <li>개인정보의 암호화: 이용자의 개인정보는 암호화되어 저장 및 관리됩니다.</li>
          <li>접근 제한: 개인정보를 처리하는 시스템에 대한 접근 권한 관리</li>
          <li>보안 프로그램 설치: 해킹 등에 대비한 보안 조치</li>
        </ul>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">8. 쿠키(Cookie)의 운용</h2>
        <p class="text-slate-300 mb-4">
          서비스는 이용자에게 개별적인 맞춤 서비스를 제공하기 위해 이용 정보를 저장하고 
          수시로 불러오는 '쿠키(cookie)'를 사용합니다. 이용자는 웹 브라우저 설정을 통해 
          쿠키 저장을 거부할 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">9. 개인정보 보호책임자</h2>
        <p class="text-slate-300 mb-4">
          서비스는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 
          이용자의 불만 처리 및 피해구제를 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
        </p>
        <div class="bg-slate-800/50 rounded-lg p-4 mb-4">
          <p class="text-slate-300">
            <strong class="text-white">개인정보 보호책임자</strong><br>
            이메일: contact@careerwiki.org
          </p>
        </div>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">10. 개인정보처리방침의 변경</h2>
        <p class="text-slate-300 mb-4">
          이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경 내용의 추가, 
          삭제 및 정정이 있는 경우에는 변경 사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">부칙</h2>
        <p class="text-slate-300 mb-4">
          이 개인정보처리방침은 2025년 12월 1일부터 시행합니다.
        </p>
      </div>
    </div>
  </div>
</body>
</html>`;
}

