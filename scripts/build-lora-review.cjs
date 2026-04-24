#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const DEFAULT_SOURCE = 'C:\\Users\\user\\ai-toolkit\\datasets\\cwbeaver';
const DEFAULT_OUTPUT = path.join(__dirname, '..', '.lora-review');

function parseArgs() {
  const args = {};
  for (const arg of process.argv.slice(2)) {
    if (!arg.startsWith('--')) continue;
    const [key, ...rest] = arg.slice(2).split('=');
    args[key] = rest.length ? rest.join('=') : true;
  }
  return args;
}

function escapeHtml(text) {
  return String(text)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function main() {
  const args = parseArgs();
  const sourceDir = args.source || DEFAULT_SOURCE;
  const outputDir = args.output ? path.resolve(args.output) : DEFAULT_OUTPUT;
  const assetsDir = path.join(outputDir, 'assets');
  const metadataPath = path.join(sourceDir, 'metadata.json');
  const metadata = fs.existsSync(metadataPath)
    ? JSON.parse(fs.readFileSync(metadataPath, 'utf8'))
    : [];
  const metadataByFile = new Map(metadata.map(item => [item.localImageFile, item]));

  if (!fs.existsSync(sourceDir)) {
    throw new Error(`LoRA 데이터 폴더를 찾을 수 없습니다: ${sourceDir}`);
  }

  ensureDir(outputDir);
  ensureDir(assetsDir);

  const imageFiles = fs.readdirSync(sourceDir)
    .filter(name => /\.(png|webp|jpg|jpeg)$/i.test(name))
    .sort((a, b) => a.localeCompare(b, 'ko'));

  const items = imageFiles.map((imageFile) => {
    const baseName = imageFile.replace(/\.(png|webp|jpg|jpeg)$/i, '');
    const captionFile = `${baseName}.txt`;
    const sourceImagePath = path.join(sourceDir, imageFile);
    const sourceCaptionPath = path.join(sourceDir, captionFile);
    const copiedImagePath = path.join(assetsDir, imageFile);
    const caption = fs.existsSync(sourceCaptionPath) ? fs.readFileSync(sourceCaptionPath, 'utf8') : '';
    const meta = metadataByFile.get(imageFile) || null;

    fs.copyFileSync(sourceImagePath, copiedImagePath);

    return {
      baseName,
      sourceImageFile: imageFile,
      sourceCaptionFile: captionFile,
      reviewImageFile: `assets/${imageFile}`.replace(/\\/g, '/'),
      caption,
      selected: true,
      sourceType: meta?.sourceType || '',
      sourceSlug: meta?.slug || '',
      sourceName: meta?.name || '',
    };
  });

  const manifest = {
    sourceDir,
    generatedAt: new Date().toISOString(),
    itemCount: items.length,
    items,
  };

  const manifestPath = path.join(outputDir, 'selection-template.json');
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2), 'utf8');

  const html = `<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>cwbeaver LoRA Review</title>
  <style>
    :root {
      --bg: #0d1321;
      --panel: #141b2d;
      --panel-2: #1b2440;
      --text: #eef3ff;
      --muted: #a8b3d1;
      --accent: #59c3c3;
      --accent-2: #ffd166;
      --border: rgba(255,255,255,0.08);
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: "Segoe UI", system-ui, sans-serif;
      background: radial-gradient(circle at top, #1a2240 0%, var(--bg) 55%);
      color: var(--text);
    }
    .wrap {
      width: min(1400px, calc(100vw - 32px));
      margin: 24px auto 48px;
    }
    .hero, .toolbar, .card {
      background: rgba(20,27,45,0.92);
      border: 1px solid var(--border);
      border-radius: 18px;
      backdrop-filter: blur(8px);
    }
    .hero, .toolbar { padding: 20px; }
    h1 { margin: 0 0 8px; font-size: 28px; }
    p, .muted { color: var(--muted); line-height: 1.55; }
    .toolbar {
      margin-top: 18px;
      display: grid;
      gap: 12px;
      grid-template-columns: 1.4fr 1fr auto auto auto;
      align-items: center;
    }
    input[type="search"] {
      width: 100%;
      padding: 12px 14px;
      border-radius: 12px;
      border: 1px solid var(--border);
      background: var(--panel-2);
      color: var(--text);
      font-size: 14px;
    }
    button {
      padding: 11px 14px;
      border-radius: 12px;
      border: 0;
      background: var(--accent);
      color: #04111b;
      font-weight: 700;
      cursor: pointer;
    }
    button.secondary {
      background: #2b3658;
      color: var(--text);
    }
    .count {
      padding: 11px 14px;
      border-radius: 12px;
      background: var(--panel-2);
      color: var(--accent-2);
      font-weight: 700;
      text-align: center;
    }
    .grid {
      margin-top: 18px;
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 16px;
    }
    .card { overflow: hidden; }
    .thumb {
      width: 100%;
      aspect-ratio: 16 / 9;
      object-fit: cover;
      display: block;
      background: #111827;
    }
    .content { padding: 14px; }
    .row {
      display: flex;
      justify-content: space-between;
      gap: 12px;
      align-items: center;
      margin-bottom: 8px;
    }
    .name {
      font-weight: 700;
      line-height: 1.35;
    }
    textarea {
      width: 100%;
      min-height: 136px;
      margin-top: 10px;
      padding: 10px 12px;
      resize: vertical;
      border-radius: 12px;
      border: 1px solid var(--border);
      background: var(--panel-2);
      color: var(--text);
      font-size: 13px;
      line-height: 1.45;
    }
    .tip {
      margin-top: 18px;
      padding: 16px 18px;
      border-left: 4px solid var(--accent-2);
      background: rgba(255, 209, 102, 0.08);
      border-radius: 12px;
    }
    label.pick {
      display: inline-flex;
      gap: 8px;
      align-items: center;
      font-weight: 700;
    }
  </style>
</head>
<body>
  <div class="wrap">
    <section class="hero">
      <h1>cwbeaver LoRA 이미지 리뷰</h1>
      <p>이 페이지는 현재 학습 후보로 모아둔 썸네일 비버 이미지들을 한 번에 검토하기 위한 갤러리입니다. 체크를 끄면 제외, 캡션은 직접 수정할 수 있습니다. 마지막에 <strong>Export JSON</strong>을 눌러 선택 결과를 저장한 뒤, 별도 적용 스크립트로 curated 데이터셋을 만들면 됩니다.</p>
      <p>기준 캐릭터는 CareerWiki 로고 비버입니다. 로고 비버와 얼굴형, 큰 둥근 눈, 작은 앞니, 둥근 볼, 크림색 배, 부드러운 2D 느낌이 가까운 이미지를 우선 남기세요.</p>
      <p class="muted">원본 데이터 폴더: ${escapeHtml(sourceDir)}</p>
    </section>

    <section class="toolbar">
      <input id="search" type="search" placeholder="직업명으로 검색">
      <div class="count" id="count"></div>
      <button class="secondary" id="all">모두 선택</button>
      <button class="secondary" id="none">모두 해제</button>
      <button id="export">Export JSON</button>
    </section>

    <section class="tip">
      추천 기준: 로고 비버와 닮은 얼굴형인지, 눈과 앞니와 볼이 유지되는지, 썸네일로 봤을 때 캐릭터가 충분히 큰지, 배경보다 비버가 먼저 보이는지를 우선 보면 좋습니다.
    </section>

    <section class="grid" id="grid"></section>
  </div>

  <script id="initial-data" type="application/json">${JSON.stringify(manifest).replace(/</g, '\\u003c')}</script>
  <script>
    const data = JSON.parse(document.getElementById('initial-data').textContent);
    const grid = document.getElementById('grid');
    const search = document.getElementById('search');
    const count = document.getElementById('count');

    function render() {
      const keyword = search.value.trim().toLowerCase();
      const filtered = data.items.filter(item => item.baseName.toLowerCase().includes(keyword));
      grid.innerHTML = filtered.map((item, index) => \`
        <article class="card" data-index="\${index}">
          <img class="thumb" src="\${item.reviewImageFile}" alt="\${item.baseName}">
          <div class="content">
            <div class="row">
              <div class="name">\${item.baseName}</div>
              <label class="pick">
                <input type="checkbox" \${item.selected ? 'checked' : ''} data-role="pick">
                포함
              </label>
            </div>
            <div class="muted">\${item.sourceType ? '[' + item.sourceType + '] ' : ''}\${item.sourceName || item.baseName}</div>
            <div class="muted">\${item.sourceSlug || item.sourceImageFile}</div>
            <textarea data-role="caption">\${item.caption || ''}</textarea>
          </div>
        </article>
      \`).join('');
      updateCount();
      bindCards(filtered);
    }

    function bindCards(filtered) {
      [...grid.querySelectorAll('.card')].forEach(card => {
        const name = card.querySelector('.name').textContent;
        const item = data.items.find(entry => entry.baseName === name);
        card.querySelector('[data-role="pick"]').addEventListener('change', (event) => {
          item.selected = event.target.checked;
          updateCount();
        });
        card.querySelector('[data-role="caption"]').addEventListener('input', (event) => {
          item.caption = event.target.value;
        });
      });
    }

    function updateCount() {
      const selected = data.items.filter(item => item.selected).length;
      count.textContent = \`선택 \${selected} / 전체 \${data.items.length}\`;
    }

    document.getElementById('all').addEventListener('click', () => {
      data.items.forEach(item => item.selected = true);
      render();
    });

    document.getElementById('none').addEventListener('click', () => {
      data.items.forEach(item => item.selected = false);
      render();
    });

    document.getElementById('export').addEventListener('click', () => {
      const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
      const url = URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = 'cwbeaver-selection.json';
      link.click();
      URL.revokeObjectURL(url);
    });

    search.addEventListener('input', render);
    render();
  </script>
</body>
</html>`;

  fs.writeFileSync(path.join(outputDir, 'index.html'), html, 'utf8');

  console.log(`리뷰 페이지 생성 완료: ${path.join(outputDir, 'index.html')}`);
  console.log(`기본 선택 템플릿: ${manifestPath}`);
  console.log('브라우저에서 index.html을 열고 선택/캡션을 조정한 뒤 Export JSON으로 저장하세요.');
}

main();
