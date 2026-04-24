const AdminImageManager = (() => {
  let isAdmin = false;

  // XSS 방지용 HTML 이스케이프
  const esc = (v = '') => String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');

  // 관리자 여부 확인
  const checkAdminStatus = async () => {
    try {
      const resp = await fetch('/api/me');
      if (!resp.ok) return false;
      const data = await resp.json();
      return data?.user?.role === 'admin';
    } catch (e) {
      return false;
    }
  };

  // 이미지 재생성 모달 표시
  const showRegenerateModal = (type, slug, title) => {
    // 기존 모달 제거
    const existingModal = document.getElementById('cw-image-regen-modal');
    if (existingModal) existingModal.remove();

    const modalHtml = `
      <div id="cw-image-regen-modal" class="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-black/80">
        <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-lg w-full shadow-2xl">
          <h3 class="text-xl font-bold text-white mb-4">
            <i class="fas fa-image mr-2 text-wiki-primary"></i>
            이미지 재생성
          </h3>
          <p class="text-wiki-muted text-sm mb-4">
            "${title}" 이미지를 새로 생성합니다.
          </p>
          <div class="mb-4">
            <details class="group">
              <summary class="cursor-pointer text-sm text-wiki-muted hover:text-wiki-text transition-colors flex items-center gap-1">
                <i class="fas fa-chevron-right text-xs transition-transform group-open:rotate-90"></i>
                직접 프롬프트 입력 (선택사항)
              </summary>
              <textarea
                id="image-prompt-input"
                class="w-full mt-2 px-4 py-3 bg-wiki-bg border border-wiki-border rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:border-wiki-primary resize-none"
                rows="3"
                placeholder="비워두면 AI가 자동으로 프롬프트를 생성합니다"
              ></textarea>
            </details>
          </div>
          <div class="flex gap-3 justify-end">
            <button type="button" class="px-4 py-2 rounded-lg border border-wiki-border text-wiki-muted hover:text-white hover:border-wiki-text transition-colors" data-action="cancel">
              취소
            </button>
            <button type="button" class="px-4 py-2 rounded-lg bg-wiki-primary text-white hover:bg-wiki-primary/80 transition-colors flex items-center gap-2" data-action="generate">
              <i class="fas fa-magic"></i>
              자동 생성
            </button>
          </div>
          <div id="image-regen-status" class="mt-4 hidden">
            <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
              <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
              <span class="text-sm text-wiki-muted">이미지 생성 중... (약 10-30초 소요)</span>
            </div>
          </div>
        </div>
      </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHtml);

    const modal = document.getElementById('cw-image-regen-modal');
    const promptInput = document.getElementById('image-prompt-input');
    const statusDiv = document.getElementById('image-regen-status');

    // 취소 버튼
    modal.querySelector('[data-action="cancel"]').addEventListener('click', () => {
      modal.remove();
    });

    // 배경 클릭 시 닫기
    modal.addEventListener('click', (e) => {
      if (e.target === modal) modal.remove();
    });

    // 폴링으로 이미지 생성 상태 확인 후 저장
    const pollAndSaveImage = async (taskId, type, slug) => {
      const maxAttempts = 120; // 최대 120회 (약 2분)
      const pollInterval = 1000; // 1초 간격 (더 빠른 응답)
      
      for (let i = 0; i < maxAttempts; i++) {
        statusDiv.innerHTML = `
          <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
            <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
            <span class="text-sm text-wiki-muted">이미지 생성 중... (${i}초 경과)</span>
          </div>
        `;
        
        try {
          const statusResp = await fetch(`/api/image/status/${taskId}`);
          const statusData = await statusResp.json();
          
          if (!statusData.success) {
            throw new Error(statusData.error || '상태 조회 실패');
          }
          
          if (statusData.status === 'failed') {
            throw new Error('이미지 생성 실패');
          }
          
          if (statusData.status === 'completed' && statusData.imageUrl) {
            // 이미지 저장 API 호출
            statusDiv.innerHTML = `
              <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
                <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
                <span class="text-sm text-wiki-muted">이미지 저장 중...</span>
              </div>
            `;
            
            const saveResp = await fetch('/api/image/save', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                taskId,
                type,
                slug,
                imageUrl: statusData.imageUrl
              })
            });
            
            const saveData = await saveResp.json();
            
            if (!saveData.success) {
              throw new Error(saveData.error || '이미지 저장 실패');
            }
            
            // 성공!
            return saveData;
          }
        } catch (pollError) {
          throw pollError;
        }
        
        // 대기
        await new Promise(resolve => setTimeout(resolve, pollInterval));
      }
      
      throw new Error('이미지 생성 시간 초과 (2분)');
    };

    // 생성 버튼
    modal.querySelector('[data-action="generate"]').addEventListener('click', async () => {
      const prompt = promptInput ? promptInput.value.trim() : '';

      // 버튼 비활성화 및 상태 표시
      const generateBtn = modal.querySelector('[data-action="generate"]');
      generateBtn.disabled = true;
      generateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 요청 중...';
      statusDiv.classList.remove('hidden');

      try {
        // 1. 이미지 생성 요청
        const resp = await fetch('/api/image/generate', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            type,
            slug,
            ...(prompt ? { promptOverride: prompt } : {})
          })
        });

        const result = await resp.json();

        if (!result.success) {
          throw new Error(result.error || '이미지 생성 요청 실패');
        }

        // 2. 폴링으로 완료 대기 후 저장
        const saveResult = await pollAndSaveImage(result.taskId, type, slug);

        // 성공 메시지
        console.log('[ImageRegen] Save result:', JSON.stringify(saveResult));
        const dbg = saveResult.debug || {};
        const debugInfo = saveResult.debug ? `
          <div class="mt-2 p-2 rounded bg-black/40 text-xs font-mono text-emerald-400/70 space-y-1">
            <p>R2 Key: ${esc(dbg.fileKey)}</p>
            <p>Download: ${esc(String(dbg.downloadSize))} bytes (${esc(dbg.actualContentType)})</p>
            <p>Source: ${esc((dbg.sourceUrl || '').substring(0, 80))}...</p>
            <p>DB changes: ${esc(String(dbg.dbChanges))}</p>
          </div>` : '';
        statusDiv.innerHTML = `
          <div class="p-3 rounded-lg bg-emerald-500/20 border border-emerald-500/40">
            <div class="flex items-center gap-3">
              <i class="fas fa-check-circle text-emerald-400"></i>
              <div>
                <p class="text-sm text-emerald-300 font-medium">이미지가 성공적으로 교체되었습니다!</p>
                <p class="text-xs text-emerald-400/70 mt-1">
                  <span id="regen-countdown">8</span>초 후 새로고침됩니다...
                </p>
              </div>
            </div>
            ${debugInfo}
          </div>
        `;

        // 8초 카운트다운 후 새로고침 (디버그 확인 가능)
        let countdown = 8;
        const countdownEl = document.getElementById('regen-countdown');
        const countdownInterval = setInterval(() => {
          countdown--;
          if (countdownEl) countdownEl.textContent = countdown;
          if (countdown <= 0) {
            clearInterval(countdownInterval);
            const url = new URL(window.location.href);
            url.searchParams.set('_t', Date.now());
            window.location.href = url.toString();
          }
        }, 1000);

      } catch (err) {
        statusDiv.innerHTML = `
          <div class="flex items-center gap-3 p-3 rounded-lg bg-red-500/20 border border-red-500/40">
            <i class="fas fa-exclamation-circle text-red-400"></i>
            <span class="text-sm text-red-300">${esc(err.message)}</span>
          </div>
        `;
        generateBtn.disabled = false;
        generateBtn.innerHTML = '<i class="fas fa-magic"></i> 다시 시도';
      }
    });
  };

  // 관리자 컨트롤 초기화
  const init = async () => {
    isAdmin = await checkAdminStatus();
    if (!isAdmin) return;

    // 관리자용 이미지 컨트롤 표시
    document.querySelectorAll('[data-admin-image-controls]').forEach((controls) => {
      controls.classList.remove('hidden');
      
      const type = controls.dataset.imageType;
      const slug = controls.dataset.imageSlug;
      const title = controls.dataset.imageTitle;

      const regenBtn = controls.querySelector('[data-action="regenerate-image"]');
      if (regenBtn) {
        regenBtn.addEventListener('click', (e) => {
          e.preventDefault();
          e.stopPropagation();
          showRegenerateModal(type, slug, title);
        });
      }
    });
  };

  return { init, showRegenerateModal };
})();