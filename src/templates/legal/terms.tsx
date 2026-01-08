/**
 * 이용약관 페이지
 */

import { CONSENT_VERSIONS } from '../../services/onboardingService'

export function renderTermsPage(): string {
  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이용약관 | CareerWiki</title>
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
        <h1 class="text-2xl font-bold mb-2">CareerWiki 이용약관</h1>
        <p class="text-slate-400 text-sm">
          버전: ${CONSENT_VERSIONS.terms} | 시행일: 2025년 12월 1일
        </p>
      </header>

      <div class="prose prose-invert prose-slate max-w-none">
        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제1조 (목적)</h2>
        <p class="text-slate-300 mb-4">
          이 약관은 CareerWiki(이하 "서비스")가 제공하는 커리어 정보 서비스의 이용과 관련하여 
          서비스와 이용자 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제2조 (정의)</h2>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
          <li>"서비스"란 CareerWiki가 제공하는 직업, 전공 정보 및 관련 커뮤니티 서비스를 말합니다.</li>
          <li>"이용자"란 서비스에 접속하여 이 약관에 따라 서비스를 이용하는 회원 및 비회원을 말합니다.</li>
          <li>"회원"이란 서비스에 가입하여 아이디(ID)를 부여받은 이용자를 말합니다.</li>
          <li>"닉네임"이란 회원 식별과 서비스 이용을 위해 회원이 설정한 이름을 말합니다.</li>
        </ol>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제3조 (약관의 효력 및 변경)</h2>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
          <li>이 약관은 서비스 화면에 게시하거나 기타의 방법으로 이용자에게 공지함으로써 효력이 발생합니다.</li>
          <li>서비스는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지합니다.</li>
          <li>이용자가 변경된 약관에 동의하지 않는 경우, 서비스 이용을 중단하고 탈퇴할 수 있습니다.</li>
        </ol>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제4조 (서비스의 제공)</h2>
        <p class="text-slate-300 mb-2">서비스는 다음의 서비스를 제공합니다:</p>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
          <li>직업 및 전공 정보 제공</li>
          <li>커리어 관련 커뮤니티 서비스</li>
          <li>기타 서비스가 정하는 서비스</li>
        </ol>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제5조 (이용자의 의무)</h2>
        <p class="text-slate-300 mb-2">이용자는 다음 행위를 하여서는 안 됩니다:</p>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
          <li>타인의 정보 도용</li>
          <li>서비스에 게시된 정보의 무단 변경</li>
          <li>서비스가 금지한 정보(음란물, 욕설 등)의 게시</li>
          <li>서비스의 운영을 방해하는 행위</li>
          <li>타인의 명예를 훼손하거나 불이익을 주는 행위</li>
          <li>기타 관계 법령에 위배되는 행위</li>
        </ol>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제6조 (게시물의 관리)</h2>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
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

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제7조 (서비스의 중단)</h2>
        <p class="text-slate-300 mb-4">
          서비스는 시스템 점검, 설비 교체 등 부득이한 사유가 있는 경우 서비스 제공을 일시적으로 중단할 수 있으며, 
          이 경우 사전에 공지합니다. 다만, 긴급한 경우에는 사후에 공지할 수 있습니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제8조 (면책조항)</h2>
        <ol class="list-decimal list-inside text-slate-300 space-y-2 mb-4">
          <li>서비스는 이용자가 서비스를 통해 얻은 정보로 인한 손해에 대해 책임을 지지 않습니다.</li>
          <li>서비스는 이용자 간 또는 이용자와 제3자 간에 발생한 분쟁에 개입하지 않으며 이로 인한 손해를 배상할 책임이 없습니다.</li>
        </ol>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">제9조 (분쟁해결)</h2>
        <p class="text-slate-300 mb-4">
          서비스와 이용자 간에 발생한 분쟁은 대한민국 법률에 따라 해결하며, 
          소송이 필요한 경우 서비스의 소재지를 관할하는 법원을 전속관할법원으로 합니다.
        </p>

        <h2 class="text-lg font-semibold text-white mt-6 mb-3">부칙</h2>
        <p class="text-slate-300 mb-4">
          이 약관은 2025년 12월 1일부터 시행합니다.
        </p>
      </div>
    </div>
  </div>
</body>
</html>`;
}

