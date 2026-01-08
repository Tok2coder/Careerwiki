import { renderNav, renderNavStyles, renderNavScripts } from './partials/nav'

type NotFoundOptions = {
  userMenuHtml?: string
  requestedPath?: string
}

export function renderNotFoundPage(options?: NotFoundOptions): string {
  const userMenuHtml = options?.userMenuHtml || ''
  const path = options?.requestedPath || ''

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>페이지를 찾을 수 없습니다 | CareerWiki</title>
  <link href="/static/style.css" rel="stylesheet" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  ${renderNavStyles()}
  <style>
    body { background: #0b1220; color: #e6e8f5; }
    .nf-hero {
      max-width: 960px;
      margin: 0 auto;
      padding: 48px 20px 64px;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 28px;
      align-items: center;
    }
    .nf-illustration {
      position: relative;
      width: 100%;
      aspect-ratio: 4 / 3;
      border-radius: 18px;
      background: radial-gradient(circle at 20% 30%, rgba(100, 181, 246, 0.25), transparent 45%),
                  radial-gradient(circle at 80% 40%, rgba(99, 102, 241, 0.22), transparent 50%),
                  rgba(26, 26, 46, 0.7);
      border: 1px solid rgba(148, 163, 184, 0.22);
      box-shadow: 0 25px 60px rgba(0, 0, 0, 0.45);
      overflow: hidden;
    }
    .nf-illustration::after {
      content: '';
      position: absolute;
      inset: 18% 18%;
      border: 1px dashed rgba(148, 163, 184, 0.25);
      border-radius: 14px;
    }
    .nf-illustration .icon {
      position: absolute;
      inset: 0;
      display: grid;
      place-items: center;
      font-size: 64px;
      color: #9aa3c5;
      opacity: 0.9;
    }
    .nf-card {
      padding: 28px;
      border-radius: 18px;
      background: rgba(26, 26, 46, 0.78);
      border: 1px solid rgba(148, 163, 184, 0.22);
      box-shadow: 0 18px 42px rgba(0, 0, 0, 0.35);
    }
    .nf-title { font-size: 28px; font-weight: 800; margin-bottom: 10px; color: #ffffff; }
    .nf-sub { color: #9aa3c5; margin-bottom: 18px; }
    .nf-path {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 12px;
      border-radius: 12px;
      background: rgba(15, 23, 42, 0.55);
      border: 1px solid rgba(148, 163, 184, 0.25);
      color: #e6e8f5;
      font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace;
      font-size: 13px;
      margin-bottom: 18px;
      word-break: break-all;
    }
    .nf-actions { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 12px; }
    .nf-btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 12px 14px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 14px;
      border: 1px solid rgba(148, 163, 184, 0.25);
      background: linear-gradient(135deg, #4f46e5 0%, #60a5fa 100%);
      color: #fff;
      box-shadow: 0 12px 30px rgba(79, 70, 229, 0.3);
      transition: transform 0.15s ease, box-shadow 0.15s ease, opacity 0.15s ease;
    }
    .nf-btn.secondary {
      background: rgba(26, 26, 46, 0.75);
      color: #e6e8f5;
      box-shadow: none;
    }
    .nf-btn:hover { transform: translateY(-1px); opacity: 0.98; }
    .nf-list { margin-top: 14px; padding-left: 18px; color: #c7cee7; }
    .nf-list li { margin-bottom: 6px; }
    @media (max-width: 640px) {
      .nf-title { font-size: 24px; }
      .nf-card { padding: 22px; }
    }
  </style>
</head>
<body class="bg-wiki-bg text-wiki-text min-h-screen">
  ${renderNav(userMenuHtml)}

  <main class="nf-hero">
    <div class="nf-illustration">
      <div class="icon"><i class="fas fa-compass"></i></div>
    </div>
    <div class="nf-card">
      <div class="nf-title">페이지를 찾을 수 없습니다</div>
      <div class="nf-sub">요청하신 주소가 없거나 이동되었어요. 아래에서 다음 경로를 선택해 보세요.</div>
      <div class="nf-path"><i class="fas fa-link"></i><span>${path ? escapeHtml(path) : '/'}</span></div>
      <ul class="nf-list">
        <li>주소를 다시 확인하거나, 검색을 이용해 주세요.</li>
        <li>도움말에서 사용 가이드를 확인할 수 있습니다.</li>
        <li>피드백에서 문제를 알려주시면 빠르게 개선하겠습니다.</li>
      </ul>
      <div class="nf-actions">
        <a class="nf-btn" href="/"><i class="fas fa-home"></i>홈으로</a>
        <a class="nf-btn secondary" href="/help"><i class="fas fa-life-ring"></i>도움말</a>
        <a class="nf-btn secondary" href="/feedback"><i class="fas fa-comment-dots"></i>피드백</a>
      </div>
    </div>
  </main>

  ${renderNavScripts()}
</body>
</html>`
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}

