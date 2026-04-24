(function () {
  // HTTPS(mkcert 발급) 우선, HTTP(레거시 3210 또는 3211 폴백) 순으로 프로브.
  // Secure Context에서 HTTPS loopback 호출은 Chrome LNA preflight가 요구되지 않아
  // 가장 안정적이다. HTTP는 과도기 호환 + mkcert 미설치 환경 안전망.
  const BRIDGE_CANDIDATES = [
    'https://127.0.0.1:3210',
    'http://127.0.0.1:3211', // HTTPS 서버가 사용 중인 경우의 HTTP 레거시 포트
    'http://127.0.0.1:3210', // HTTPS 미설정 환경의 HTTP 기본 포트
  ];
  let bridgeBase = null; // 최초 성공한 base를 캐시 (프로세스 수명 동안 재사용)
  const SERVER_SAVE_URL = '/api/admin/image/save';
  const REMOTE_FALLBACK_URL = '/api/admin/image/regenerate';

  const HEALTH_TIMEOUT_MS = 500;
  const BRIDGE_TIMEOUT_MS = 300000; // 5분
  const REMOTE_TIMEOUT_MS = 180000; // 3분 (Evolink 폴백)
  const HEALTH_CACHE_MS = 60000;    // 60초

  // 헬스 결과 캐시
  let healthCache = null; // { ts, ok, body }
  // 인플라이트 가드 — 동일 컨테이너 동시 호출 방지
  const inFlight = new WeakSet();
  // Chrome Local Network Access 스펙이 공개 origin → 사설 IP 호출에 대해
  // 주소 공간 선언(targetAddressSpace)을 요구한다. 스펙 진화 과정에서
  // 127.0.0.1이 'private' → 'local' → 'loopback'으로 분류가 달라져,
  // 브라우저마다 받아들이는 값이 다르다. 성공했던 값을 캐시해 재사용한다.
  // 순서: 최신 spec인 'loopback' 먼저 → 'local' → 'private' → hint 없음
  const LNA_CANDIDATES = ['loopback', 'local', 'private', null];
  let lnaPreferred = null; // 최초 성공한 값을 여기 캐시

  function isAdminUser(user) {
    return !!user && ['admin', 'super-admin', 'operator'].includes(user.role);
  }

  function sourceLabel(source, loraApplied) {
    if (!source) return '';
    const prompt = source.prompt || '?';
    const image = source.image || '?';
    const lora = loraApplied ? ' + LoRA' : '';
    return `${prompt} + ${image}${lora}`;
  }

  function ensureStatusEl(container) {
    let el = container.querySelector('[data-image-generation-status]');
    if (el) return el;
    el = document.createElement('div');
    el.setAttribute('data-image-generation-status', '');
    el.className = 'mt-2 px-3 py-1.5 rounded-lg text-xs border bg-wiki-bg/80 backdrop-blur-sm hidden';
    container.appendChild(el);
    return el;
  }

  function setStatus(container, text, tone) {
    const el = ensureStatusEl(container);
    el.classList.remove(
      'hidden',
      'text-emerald-300', 'text-amber-300', 'text-red-300', 'text-wiki-muted',
      'border-emerald-500/40', 'border-amber-500/40', 'border-red-500/40', 'border-wiki-border'
    );
    if (tone === 'success') el.classList.add('text-emerald-300', 'border-emerald-500/40');
    else if (tone === 'warn') el.classList.add('text-amber-300', 'border-amber-500/40');
    else if (tone === 'error') el.classList.add('text-red-300', 'border-red-500/40');
    else el.classList.add('text-wiki-muted', 'border-wiki-border');
    el.textContent = text;
  }

  function updateHeroImage(container, imageUrl) {
    const figure = container.closest('figure');
    const img = figure ? figure.querySelector('img') : null;
    if (!img || !imageUrl) return;
    const nextUrl = `${imageUrl}${imageUrl.includes('?') ? '&' : '?'}cb=${Date.now()}`;
    img.src = nextUrl;
    if (figure) figure.setAttribute('data-hero-url', nextUrl);
  }

  function withTimeout(promise, ms, abortCtrl) {
    let timer;
    const timeoutP = new Promise((_, rej) => {
      timer = setTimeout(() => {
        if (abortCtrl) abortCtrl.abort();
        rej(new Error(`timeout after ${ms}ms`));
      }, ms);
    });
    return Promise.race([promise.finally(() => clearTimeout(timer)), timeoutP]);
  }

  // 통합 JSON fetch 래퍼.
  // 빈 본문, 비JSON 본문(예: "Internal Server Error"), 504 타임아웃 등에서도
  // JSON.parse("") 로 SyntaxError를 던지지 않고 { success, error } 형태로 일관화한다.
  async function fetchJSON(url, opts, timeoutMs) {
    const ctrl = new AbortController();
    const finalOpts = Object.assign({}, opts || {}, { signal: ctrl.signal });
    const resp = await withTimeout(fetch(url, finalOpts), timeoutMs, ctrl);
    const text = await resp.text().catch(() => '');
    let body;
    if (!text) {
      body = { success: false, error: `HTTP ${resp.status}${resp.statusText ? ' ' + resp.statusText : ''}` };
    } else {
      try {
        body = JSON.parse(text);
      } catch {
        // 비JSON(HTML 에러 페이지, plain text 등) — 텍스트 앞부분을 에러로 노출
        const snippet = text.length > 200 ? text.slice(0, 200) + '…' : text;
        body = { success: false, error: snippet || `HTTP ${resp.status}` };
      }
    }
    if (!resp.ok) {
      throw new Error((body && body.error) || `HTTP ${resp.status}`);
    }
    if (body && body.success === false) {
      throw new Error(body.error || `HTTP ${resp.status}`);
    }
    return body;
  }

  // Chrome LNA 대응: targetAddressSpace 값을 순회하며 fetchJSON 재시도.
  // 성공한 값은 lnaPreferred에 캐시해 다음 호출에서 바로 사용한다.
  // LNA TypeError 이외의 에러(HTTP/timeout 등)는 즉시 상위로 전파한다.
  function isLnaError(err) {
    if (!err) return false;
    const msg = String(err.message || err);
    // Chrome: "Failed to fetch" / "target IP address space" / "Private Network Access"
    return err.name === 'TypeError' || /address space|Private Network|Local Network|Failed to fetch/i.test(msg);
  }

  async function fetchJSONWithLNA(url, baseOpts, timeoutMs) {
    const candidates = lnaPreferred !== null
      ? [lnaPreferred, ...LNA_CANDIDATES.filter(v => v !== lnaPreferred)]
      : LNA_CANDIDATES.slice();

    let lastErr;
    for (const hint of candidates) {
      const opts = Object.assign({}, baseOpts);
      if (hint) opts.targetAddressSpace = hint;
      try {
        const result = await fetchJSON(url, opts, timeoutMs);
        lnaPreferred = hint; // null도 유효 — hint 없이 성공하면 그대로 캐시
        return result;
      } catch (err) {
        lastErr = err;
        if (!isLnaError(err)) throw err; // 명백히 LNA 문제 아니면 즉시 탈출
        // LNA 의심 → 다음 후보로
      }
    }
    throw lastErr || new Error('LNA candidates exhausted');
  }

  async function checkBridgeHealth() {
    const now = Date.now();
    if (healthCache && now - healthCache.ts < HEALTH_CACHE_MS) {
      return healthCache;
    }
    // 이미 base가 캐시돼 있으면 그 base만 확인, 아니면 후보 순회
    const bases = bridgeBase ? [bridgeBase] : BRIDGE_CANDIDATES;
    for (const base of bases) {
      try {
        const body = await fetchJSONWithLNA(
          `${base}/api/health`,
          {
            method: 'GET',
            mode: 'cors',
            // Chrome LNA: HTTPS(Secure Context) + loopback은 preflight 불필요하지만
            // HTTP 폴백 시 필요할 수 있어 fetchJSONWithLNA가 힌트를 순회 주입한다.
          },
          HEALTH_TIMEOUT_MS
        );
        if (body && body.success === true) {
          bridgeBase = base;
          healthCache = { ts: now, ok: true, body };
          return healthCache;
        }
      } catch {
        // 이 base 실패 → 다음 후보
      }
    }
    healthCache = { ts: now, ok: false, body: null };
    return healthCache;
  }

  async function callBridge(type, slug) {
    const base = bridgeBase || BRIDGE_CANDIDATES[0];
    return fetchJSONWithLNA(
      `${base}/api/generate-image`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ type, slug }),
        mode: 'cors',
      },
      BRIDGE_TIMEOUT_MS
    );
  }

  async function callServerSave(payload) {
    return fetchJSON(
      SERVER_SAVE_URL,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify(payload),
      },
      60000
    );
  }

  async function callRemoteFallback(type, slug) {
    return fetchJSON(
      REMOTE_FALLBACK_URL,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({ type, slug }),
      },
      REMOTE_TIMEOUT_MS
    );
  }

  async function handleRegenerate(container) {
    if (inFlight.has(container)) return;
    inFlight.add(container);

    const button = container.querySelector('[data-action="regenerate-image"]');
    const type = container.getAttribute('data-image-type'); // 'jobs' | 'majors'
    const slug = container.getAttribute('data-image-slug');
    const title = container.getAttribute('data-image-title') || slug || '';
    if (!button || !type || !slug) {
      inFlight.delete(container);
      return;
    }

    const originalHtml = button.innerHTML;
    button.disabled = true;
    button.classList.add('opacity-60', 'cursor-not-allowed');
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>준비 중...</span>';

    try {
      // 1단계: 헬스체크 (500ms)
      setStatus(container, '로컬 브리지 확인 중...', 'info');
      const health = await checkBridgeHealth();

      if (health.ok) {
        // 2단계: 브리지 호출
        const comfyReady = !!(health.body?.comfyui?.instances || []).find(i => i.ready);
        const ollamaReady = !!health.body?.ollama?.ready;
        const warmHint = comfyReady && ollamaReady
          ? `로컬 생성 중: ${title} (약 30~90초)`
          : `로컬 엔진 깨우는 중: ${title} (최대 5분 소요)`;
        setStatus(container, warmHint, 'warn');
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>로컬 생성 중...</span>';

        try {
          const bridgeResult = await callBridge(type, slug);
          // 3단계: 서버에 저장
          setStatus(container, '서버에 저장 중...', 'warn');
          button.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>저장 중...</span>';
          const saveResult = await callServerSave({
            type,
            slug,
            imageBase64: bridgeResult.imageBase64,
            mimeType: bridgeResult.mimeType,
            prompt: bridgeResult.prompt,
            source: bridgeResult.source,
            loraApplied: bridgeResult.loraApplied,
          });
          updateHeroImage(container, saveResult.imageUrl);
          const label = sourceLabel(saveResult.source || bridgeResult.source, bridgeResult.loraApplied);
          setStatus(container, `로컬 생성 완료: ${label}`, 'success');
          return;
        } catch (bridgeError) {
          // 헬스는 OK였지만 본 호출 실패 → 캐시 무효화 후 폴백
          healthCache = null;
          setStatus(container, `로컬 생성 실패 (${bridgeError.message || '알 수 없음'}), 원격 폴백 시도 중...`, 'warn');
          button.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>원격 폴백 중...</span>';
        }
      } else {
        // 헬스 실패 → 즉시 원격
        setStatus(container, '로컬 브리지 미동작, 원격 생성 중...', 'warn');
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>원격 생성 중...</span>';
      }

      // 원격 폴백
      try {
        const remote = await callRemoteFallback(type, slug);
        updateHeroImage(container, remote.imageUrl);
        const label = sourceLabel(remote.source, remote.generationMeta?.loraApplied);
        setStatus(container, `원격 생성 완료: ${label || 'gemini + evolink'}`, 'success');
      } catch (remoteError) {
        setStatus(container, `이미지 생성 실패: ${remoteError.message || '알 수 없음'}`, 'error');
      }
    } finally {
      button.disabled = false;
      button.classList.remove('opacity-60', 'cursor-not-allowed');
      button.innerHTML = originalHtml;
      inFlight.delete(container);
    }
  }

  function hydrate() {
    const user = window.__USER__;
    if (!isAdminUser(user)) return;

    const containers = document.querySelectorAll('[data-admin-image-controls]');
    containers.forEach((container) => {
      container.classList.remove('hidden');
      const button = container.querySelector('[data-action="regenerate-image"]');
      if (!button || button.dataset.bound === 'true') return;
      button.dataset.bound = 'true';
      button.addEventListener('click', (e) => {
        e.preventDefault();
        handleRegenerate(container);
      });
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', hydrate);
  } else {
    hydrate();
  }
  window.addEventListener('userLoaded', hydrate);
})();
