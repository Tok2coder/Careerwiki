const AdminImageManager = (() => {
  let isAdmin = false;

  // XSS 諛⑹???HTML ?댁뒪耳?댄봽
  const esc = (v = '') => String(v).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');

  // 愿由ъ옄 ?щ? ?뺤씤
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

  // ?대?吏 ?ъ깮??紐⑤떖 ?쒖떆
  const showRegenerateModal = (type, slug, title) => {
    // 湲곗〈 紐⑤떖 ?쒓굅
    const existingModal = document.getElementById('cw-image-regen-modal');
    if (existingModal) existingModal.remove();

    const modalHtml = `
      <div id="cw-image-regen-modal" class="fixed inset-0 z-[9999] flex items-center justify-center p-4 bg-black/80">
        <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-lg w-full shadow-2xl">
          <h3 class="text-xl font-bold text-white mb-4">
            <i class="fas fa-image mr-2 text-wiki-primary"></i>
            ?대?吏 ?ъ깮??
          </h3>
          <p class="text-wiki-muted text-sm mb-4">
            "${title}" ?대?吏瑜??덈줈 ?앹꽦?⑸땲??
          </p>
          <div class="mb-4">
            <details class="group">
              <summary class="cursor-pointer text-sm text-wiki-muted hover:text-wiki-text transition-colors flex items-center gap-1">
                <i class="fas fa-chevron-right text-xs transition-transform group-open:rotate-90"></i>
                吏곸젒 ?꾨＼?꾪듃 ?낅젰 (?좏깮?ы빆)
              </summary>
              <textarea
                id="image-prompt-input"
                class="w-full mt-2 px-4 py-3 bg-wiki-bg border border-wiki-border rounded-xl text-white placeholder-wiki-muted focus:outline-none focus:border-wiki-primary resize-none"
                rows="3"
                placeholder="鍮꾩썙?먮㈃ AI媛 ?먮룞?쇰줈 ?꾨＼?꾪듃瑜??앹꽦?⑸땲??
              ></textarea>
            </details>
          </div>
          <div class="flex gap-3 justify-end">
            <button type="button" class="px-4 py-2 rounded-lg border border-wiki-border text-wiki-muted hover:text-white hover:border-wiki-text transition-colors" data-action="cancel">
              痍⑥냼
            </button>
            <button type="button" class="px-4 py-2 rounded-lg bg-wiki-primary text-white hover:bg-wiki-primary/80 transition-colors flex items-center gap-2" data-action="generate">
              <i class="fas fa-magic"></i>
              ?먮룞 ?앹꽦
            </button>
          </div>
          <div id="image-regen-status" class="mt-4 hidden">
            <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
              <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
              <span class="text-sm text-wiki-muted">?대?吏 ?앹꽦 以?.. (??10-30珥??뚯슂)</span>
            </div>
          </div>
        </div>
      </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHtml);

    const modal = document.getElementById('cw-image-regen-modal');
    const promptInput = document.getElementById('image-prompt-input');
    const statusDiv = document.getElementById('image-regen-status');

    // 痍⑥냼 踰꾪듉
    modal.querySelector('[data-action="cancel"]').addEventListener('click', () => {
      modal.remove();
    });

    // 諛곌꼍 ?대┃ ???リ린
    modal.addEventListener('click', (e) => {
      if (e.target === modal) modal.remove();
    });

    // ?대쭅?쇰줈 ?대?吏 ?앹꽦 ?곹깭 ?뺤씤 ?????
    const pollAndSaveImage = async (taskId, type, slug) => {
      const maxAttempts = 120; // 理쒕? 120??(??2遺?
      const pollInterval = 1000; // 1珥?媛꾧꺽 (??鍮좊Ⅸ ?묐떟)
      
      for (let i = 0; i < maxAttempts; i++) {
        statusDiv.innerHTML = `
          <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
            <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
            <span class="text-sm text-wiki-muted">?대?吏 ?앹꽦 以?.. (${i}珥?寃쎄낵)</span>
          </div>
        `;
        
        try {
          const statusResp = await fetch(`/api/image/status/${taskId}`);
          const statusData = await statusResp.json();
          
          if (!statusData.success) {
            throw new Error(statusData.error || '?곹깭 議고쉶 ?ㅽ뙣');
          }
          
          if (statusData.status === 'failed') {
            throw new Error('?대?吏 ?앹꽦 ?ㅽ뙣');
          }
          
          if (statusData.status === 'completed' && statusData.imageUrl) {
            // ?대?吏 ???API ?몄텧
            statusDiv.innerHTML = `
              <div class="flex items-center gap-3 p-3 rounded-lg bg-wiki-bg border border-wiki-border">
                <i class="fas fa-spinner fa-spin text-wiki-primary"></i>
                <span class="text-sm text-wiki-muted">?대?吏 ???以?..</span>
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
              throw new Error(saveData.error || '?대?吏 ????ㅽ뙣');
            }
            
            // ?깃났!
            return saveData;
          }
        } catch (pollError) {
          throw pollError;
        }
        
        // ?湲?
        await new Promise(resolve => setTimeout(resolve, pollInterval));
      }
      
      throw new Error('?대?吏 ?앹꽦 ?쒓컙 珥덇낵 (2遺?');
    };

    // ?앹꽦 踰꾪듉
    modal.querySelector('[data-action="generate"]').addEventListener('click', async () => {
      const prompt = promptInput ? promptInput.value.trim() : '';

      // 踰꾪듉 鍮꾪솢?깊솕 諛??곹깭 ?쒖떆
      const generateBtn = modal.querySelector('[data-action="generate"]');
      generateBtn.disabled = true;
      generateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ?붿껌 以?..';
      statusDiv.classList.remove('hidden');

      try {
        // 1. ?대?吏 ?앹꽦 ?붿껌
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
          throw new Error(result.error || '?대?吏 ?앹꽦 ?붿껌 ?ㅽ뙣');
        }

        // 2. ?대쭅?쇰줈 ?꾨즺 ?湲??????
        const saveResult = await pollAndSaveImage(result.taskId, type, slug);

        // ?깃났 硫붿떆吏
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
                <p class="text-sm text-emerald-300 font-medium">?대?吏媛 ?깃났?곸쑝濡?援먯껜?섏뿀?듬땲??</p>
                <p class="text-xs text-emerald-400/70 mt-1">
                  <span id="regen-countdown">8</span>珥????덈줈怨좎묠?⑸땲??..
                </p>
              </div>
            </div>
            ${debugInfo}
          </div>
        `;

        // 8珥?移댁슫?몃떎?????덈줈怨좎묠 (?붾쾭洹??뺤씤 媛??
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
        generateBtn.innerHTML = '<i class="fas fa-magic"></i> ?ㅼ떆 ?쒕룄';
      }
    });
  };

  // 愿由ъ옄 而⑦듃濡?珥덇린??
  const init = async () => {
    isAdmin = await checkAdminStatus();
    if (!isAdmin) return;

    // 愿由ъ옄???대?吏 而⑦듃濡??쒖떆
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