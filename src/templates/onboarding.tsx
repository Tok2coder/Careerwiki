/**
 * 온보딩 페이지 템플릿
 * 
 * 첫 로그인 사용자를 위한 3단계 온보딩 플로우:
 * - Step 1: 닉네임 설정
 * - Step 2: 유입경로 + 관심/커리어 상태
 * - Step 3: 약관 동의
 */

import {
  CHANNEL_PRESETS,
  INTEREST_STATES,
  CAREER_STATES,
  CONSENT_VERSIONS,
  getChannelLabel,
  getInterestStateLabel,
  getCareerStateLabel
} from '../services/onboardingService'

export interface OnboardingPageProps {
  userName?: string | null
  returnUrl?: string
}

export function renderOnboardingPage(props: OnboardingPageProps): string {
  const { userName, returnUrl = '/' } = props

  return `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>시작하기 | CareerWiki</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * { font-family: 'Noto Sans KR', sans-serif; }
    body { 
      background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #0f172a 100%);
      min-height: 100vh;
    }
    .glass-card {
      background: rgba(30, 41, 59, 0.9);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(148, 163, 184, 0.15);
    }
    .step-indicator {
      transition: all 0.3s ease;
    }
    .step-indicator.active {
      background: linear-gradient(135deg, #3b82f6, #8b5cf6);
      box-shadow: 0 0 20px rgba(59, 130, 246, 0.5);
    }
    .step-indicator.completed {
      background: #10b981;
    }
    .input-field {
      transition: all 0.2s ease;
    }
    .input-field:focus {
      border-color: #3b82f6;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
    }
    .radio-card {
      transition: all 0.2s ease;
      cursor: pointer;
    }
    .radio-card:hover {
      border-color: rgba(59, 130, 246, 0.5);
      background: rgba(59, 130, 246, 0.05);
    }
    .radio-card.selected {
      border-color: #3b82f6;
      background: rgba(59, 130, 246, 0.1);
    }
    .checkbox-card {
      transition: all 0.2s ease;
      cursor: pointer;
    }
    .checkbox-card:hover {
      border-color: rgba(59, 130, 246, 0.5);
    }
    .checkbox-card.checked {
      border-color: #10b981;
      background: rgba(16, 185, 129, 0.1);
    }
    .btn-primary {
      background: linear-gradient(135deg, #3b82f6, #8b5cf6);
      transition: all 0.2s ease;
    }
    .btn-primary:hover:not(:disabled) {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(59, 130, 246, 0.3);
    }
    .btn-primary:disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }
    .fade-in {
      animation: fadeIn 0.3s ease;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .nickname-status {
      transition: all 0.2s ease;
    }
  </style>
</head>
<body class="text-slate-100">
  <div class="min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-lg">
      <!-- 로고 -->
      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
          CareerWiki
        </h1>
        <p class="text-slate-400 mt-2">
          ${userName ? `<span class="text-white font-medium">${escapeHtml(userName)}</span>님, 환영합니다!` : '환영합니다!'}
        </p>
      </div>

      <!-- 진행 상태 표시 -->
      <div class="flex items-center justify-center gap-3 sm:gap-4 mb-8">
        <div id="step1-indicator" class="step-indicator active w-11 h-11 min-w-[44px] min-h-[44px] rounded-full flex items-center justify-center font-semibold">
          1
        </div>
        <div class="w-8 sm:w-12 h-1 bg-slate-700 rounded">
          <div id="progress1" class="h-full bg-gradient-to-r from-blue-500 to-purple-500 rounded transition-all duration-300" style="width: 0%"></div>
        </div>
        <div id="step2-indicator" class="step-indicator bg-slate-700 w-11 h-11 min-w-[44px] min-h-[44px] rounded-full flex items-center justify-center font-semibold">
          2
        </div>
        <div class="w-8 sm:w-12 h-1 bg-slate-700 rounded">
          <div id="progress2" class="h-full bg-gradient-to-r from-blue-500 to-purple-500 rounded transition-all duration-300" style="width: 0%"></div>
        </div>
        <div id="step3-indicator" class="step-indicator bg-slate-700 w-11 h-11 min-w-[44px] min-h-[44px] rounded-full flex items-center justify-center font-semibold">
          3
        </div>
      </div>

      <!-- 온보딩 카드 -->
      <div class="glass-card rounded-2xl p-8">
        <!-- Step 1: 닉네임 -->
        <div id="step1" class="fade-in">
          <h2 class="text-xl font-semibold mb-2">닉네임을 정해주세요</h2>
          <p class="text-slate-400 text-sm mb-6">커리어위키에서 사용할 이름이에요.</p>
          
          <div class="relative">
            <input
              type="text"
              id="nickname"
              placeholder="2~16자, 한글/영문/숫자"
              maxlength="16"
              class="input-field w-full px-4 py-3 bg-slate-800/50 border border-slate-600 rounded-lg text-white placeholder-slate-500 focus:outline-none"
            >
            <div id="nickname-status" class="nickname-status absolute right-3 top-1/2 -translate-y-1/2">
              <!-- 상태 아이콘 표시 -->
            </div>
          </div>
          <p id="nickname-message" class="mt-2 text-sm text-slate-400"></p>
          
          <button
            id="btn-step1-next"
            disabled
            class="btn-primary w-full mt-6 py-3 min-h-[48px] rounded-lg font-semibold text-white"
          >
            다음
          </button>
        </div>

        <!-- Step 2: 유입경로 + 선택 정보 -->
        <div id="step2" class="hidden fade-in">
          <h2 class="text-xl font-semibold mb-2">어떻게 오셨나요?</h2>
          <p class="text-slate-400 text-sm mb-6">커리어위키를 어떻게 알게 되셨는지 알려주세요.</p>
          
          <!-- 유입경로 -->
          <div class="grid grid-cols-2 gap-3 mb-6">
            ${CHANNEL_PRESETS.filter(c => c !== 'other').map(channel => `
              <label class="radio-card border border-slate-600 rounded-lg p-4 min-h-[48px] flex items-center gap-3" data-channel="${channel}">
                <input type="radio" name="channel" value="${channel}" class="hidden">
                <div class="w-5 h-5 border-2 border-slate-500 rounded-full flex items-center justify-center flex-shrink-0">
                  <div class="w-2.5 h-2.5 bg-blue-500 rounded-full hidden"></div>
                </div>
                <span class="text-sm">${getChannelLabel(channel)}</span>
              </label>
            `).join('')}
            <label class="radio-card border border-slate-600 rounded-lg p-4 min-h-[48px] flex items-center gap-3 col-span-2" data-channel="other">
              <input type="radio" name="channel" value="other" class="hidden">
              <div class="w-5 h-5 border-2 border-slate-500 rounded-full flex items-center justify-center flex-shrink-0">
                <div class="w-2.5 h-2.5 bg-blue-500 rounded-full hidden"></div>
              </div>
              <span class="text-sm">기타</span>
            </label>
          </div>
          
          <!-- 기타 입력 -->
          <div id="other-channel-wrap" class="hidden mb-6">
            <input
              type="text"
              id="other-channel"
              placeholder="어떻게 알게 되셨나요? (1~50자)"
              maxlength="50"
              class="input-field w-full px-4 py-3 bg-slate-800/50 border border-slate-600 rounded-lg text-white placeholder-slate-500 focus:outline-none"
            >
          </div>
          
          <!-- 관심 상태 (선택) -->
          <div class="mb-6">
            <p class="text-sm text-slate-400 mb-3">관심 분야 <span class="text-slate-500">(선택)</span></p>
            <div class="flex flex-wrap gap-2">
              ${INTEREST_STATES.map(state => `
                <button type="button" class="interest-btn px-4 py-2.5 min-h-[44px] text-sm border border-slate-600 rounded-full hover:border-blue-500 transition-colors" data-value="${state}">
                  ${getInterestStateLabel(state)}
                </button>
              `).join('')}
            </div>
          </div>
          
          <!-- 커리어 상태 (선택) -->
          <div class="mb-6">
            <p class="text-sm text-slate-400 mb-3">현재 상태 <span class="text-slate-500">(선택)</span></p>
            <div class="flex flex-wrap gap-2">
              ${CAREER_STATES.map(state => `
                <button type="button" class="career-btn px-4 py-2.5 min-h-[44px] text-sm border border-slate-600 rounded-full hover:border-blue-500 transition-colors" data-value="${state}">
                  ${getCareerStateLabel(state)}
                </button>
              `).join('')}
            </div>
          </div>
          
          <div class="flex gap-3">
            <button
              id="btn-step2-back"
              class="flex-1 py-3 min-h-[48px] bg-slate-700 hover:bg-slate-600 rounded-lg font-semibold transition-colors"
            >
              이전
            </button>
            <button
              id="btn-step2-next"
              disabled
              class="btn-primary flex-1 py-3 min-h-[48px] rounded-lg font-semibold text-white"
            >
              다음
            </button>
          </div>
        </div>

        <!-- Step 3: 약관 동의 -->
        <div id="step3" class="hidden fade-in">
          <h2 class="text-xl font-semibold mb-2">약관에 동의해주세요</h2>
          <p class="text-slate-400 text-sm mb-6">서비스 이용을 위해 약관 동의가 필요합니다.</p>
          
          <!-- 이용약관 -->
          <label class="checkbox-card border border-slate-600 rounded-lg p-4 flex items-start gap-3 mb-3 cursor-pointer" id="terms-card">
            <input type="checkbox" id="terms-check" class="w-5 h-5 accent-green-500 bg-slate-800 border border-slate-500 rounded mt-0.5 flex-shrink-0">
            <div class="flex-1">
              <div class="flex items-center justify-between">
                <span class="font-medium">[필수] 이용약관 동의</span>
                <a href="/legal/terms" target="_blank" class="text-sm text-blue-400 hover:underline">보기</a>
              </div>
              <p class="text-xs text-slate-500 mt-1">버전: ${CONSENT_VERSIONS.terms}</p>
            </div>
          </label>
          
          <!-- 개인정보처리방침 -->
          <label class="checkbox-card border border-slate-600 rounded-lg p-4 flex items-start gap-3 mb-6 cursor-pointer" id="privacy-card">
            <input type="checkbox" id="privacy-check" class="w-5 h-5 accent-green-500 bg-slate-800 border border-slate-500 rounded mt-0.5 flex-shrink-0">
            <div class="flex-1">
              <div class="flex items-center justify-between">
                <span class="font-medium">[필수] 개인정보 처리방침 동의</span>
                <a href="/legal/privacy" target="_blank" class="text-sm text-blue-400 hover:underline">보기</a>
              </div>
              <p class="text-xs text-slate-500 mt-1">버전: ${CONSENT_VERSIONS.privacy}</p>
            </div>
          </label>
          
          <div class="flex gap-3">
            <button
              id="btn-step3-back"
              class="flex-1 py-3 min-h-[48px] bg-slate-700 hover:bg-slate-600 rounded-lg font-semibold transition-colors"
            >
              이전
            </button>
            <button
              id="btn-submit"
              disabled
              class="btn-primary flex-1 py-3 min-h-[48px] rounded-lg font-semibold text-white"
            >
              시작하기
            </button>
          </div>
        </div>
        
        <!-- 제출 중 로딩 -->
        <div id="loading" class="hidden text-center py-8">
          <div class="animate-spin w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full mx-auto mb-4"></div>
          <p class="text-slate-400">설정 중...</p>
        </div>
      </div>
    </div>
  </div>

  <script>
    (function() {
      // 상태 관리
      const state = {
        step: 1,
        nickname: '',
        nicknameOk: false,
        channel: '',
        channelOther: '',
        interestState: '',
        careerState: '',
        termsAgreed: false,
        privacyAgreed: false
      };

      const returnUrl = ${JSON.stringify(returnUrl)};
      const consentVersions = ${JSON.stringify(CONSENT_VERSIONS)};

      // DOM 요소
      const $step1 = document.getElementById('step1');
      const $step2 = document.getElementById('step2');
      const $step3 = document.getElementById('step3');
      const $loading = document.getElementById('loading');
      const $nickname = document.getElementById('nickname');
      const $nicknameStatus = document.getElementById('nickname-status');
      const $nicknameMessage = document.getElementById('nickname-message');
      const $btnStep1Next = document.getElementById('btn-step1-next');
      const $btnStep2Back = document.getElementById('btn-step2-back');
      const $btnStep2Next = document.getElementById('btn-step2-next');
      const $btnStep3Back = document.getElementById('btn-step3-back');
      const $btnSubmit = document.getElementById('btn-submit');
      const $otherChannelWrap = document.getElementById('other-channel-wrap');
      const $otherChannel = document.getElementById('other-channel');
      const $termsCheck = document.getElementById('terms-check');
      const $privacyCheck = document.getElementById('privacy-check');
      const $termsCard = document.getElementById('terms-card');
      const $privacyCard = document.getElementById('privacy-card');

      // 진행 표시기 업데이트
      function updateProgress() {
        const indicators = [
          document.getElementById('step1-indicator'),
          document.getElementById('step2-indicator'),
          document.getElementById('step3-indicator')
        ];
        const progresses = [
          document.getElementById('progress1'),
          document.getElementById('progress2')
        ];

        indicators.forEach((el, i) => {
          el.classList.remove('active', 'completed');
          el.classList.add('bg-slate-700');
          if (i + 1 < state.step) {
            el.classList.remove('bg-slate-700');
            el.classList.add('completed');
            el.innerHTML = '<i class="fas fa-check text-sm"></i>';
          } else if (i + 1 === state.step) {
            el.classList.remove('bg-slate-700');
            el.classList.add('active');
            el.textContent = i + 1;
          } else {
            el.textContent = i + 1;
          }
        });

        progresses.forEach((el, i) => {
          el.style.width = state.step > i + 1 ? '100%' : '0%';
        });
      }

      // 스텝 전환
      function goToStep(step) {
        state.step = step;
        $step1.classList.add('hidden');
        $step2.classList.add('hidden');
        $step3.classList.add('hidden');
        
        if (step === 1) $step1.classList.remove('hidden');
        if (step === 2) $step2.classList.remove('hidden');
        if (step === 3) $step3.classList.remove('hidden');
        
        updateProgress();
      }

      // 닉네임 검증
      let nicknameTimeout = null;
      async function checkNickname(value) {
        $nicknameStatus.innerHTML = '<i class="fas fa-spinner fa-spin text-slate-400"></i>';
        $nicknameMessage.textContent = '';
        $nicknameMessage.className = 'mt-2 text-sm text-slate-400';
        
        try {
          const res = await fetch('/api/nickname/check?value=' + encodeURIComponent(value));
          const data = await res.json();
          
          if (data.ok) {
            state.nicknameOk = true;
            $nicknameStatus.innerHTML = '<i class="fas fa-check-circle text-green-400"></i>';
            $nicknameMessage.textContent = '사용 가능한 닉네임입니다.';
            $nicknameMessage.className = 'mt-2 text-sm text-green-400';
          } else {
            state.nicknameOk = false;
            $nicknameStatus.innerHTML = '<i class="fas fa-times-circle text-red-400"></i>';
            $nicknameMessage.textContent = data.message || '사용할 수 없는 닉네임입니다.';
            $nicknameMessage.className = 'mt-2 text-sm text-red-400';
          }
        } catch (e) {
          state.nicknameOk = false;
          $nicknameStatus.innerHTML = '<i class="fas fa-exclamation-circle text-yellow-400"></i>';
          $nicknameMessage.textContent = '검증 중 오류가 발생했습니다.';
          $nicknameMessage.className = 'mt-2 text-sm text-yellow-400';
        }
        
        updateButtons();
      }

      $nickname.addEventListener('input', (e) => {
        state.nickname = e.target.value.trim();
        state.nicknameOk = false;
        $nicknameStatus.innerHTML = '';
        $nicknameMessage.textContent = '';
        
        clearTimeout(nicknameTimeout);
        
        if (state.nickname.length >= 2 && state.nickname.length <= 16) {
          nicknameTimeout = setTimeout(() => checkNickname(state.nickname), 500);
        } else if (state.nickname.length > 0) {
          $nicknameMessage.textContent = '닉네임은 2~16자로 입력해주세요.';
          $nicknameMessage.className = 'mt-2 text-sm text-slate-400';
        }
        
        updateButtons();
      });

      // 유입경로 선택
      document.querySelectorAll('.radio-card').forEach(card => {
        card.addEventListener('click', () => {
          const channel = card.dataset.channel;
          state.channel = channel;
          
          document.querySelectorAll('.radio-card').forEach(c => {
            c.classList.remove('selected');
            c.querySelector('div > div').classList.add('hidden');
          });
          card.classList.add('selected');
          card.querySelector('div > div').classList.remove('hidden');
          
          if (channel === 'other') {
            $otherChannelWrap.classList.remove('hidden');
          } else {
            $otherChannelWrap.classList.add('hidden');
            state.channelOther = '';
          }
          
          updateButtons();
        });
      });

      $otherChannel.addEventListener('input', (e) => {
        state.channelOther = e.target.value.trim();
        updateButtons();
      });

      // 관심 상태 선택
      document.querySelectorAll('.interest-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const value = btn.dataset.value;
          if (state.interestState === value) {
            state.interestState = '';
            btn.classList.remove('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
          } else {
            document.querySelectorAll('.interest-btn').forEach(b => {
              b.classList.remove('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
            });
            state.interestState = value;
            btn.classList.add('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
          }
        });
      });

      // 커리어 상태 선택
      document.querySelectorAll('.career-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const value = btn.dataset.value;
          if (state.careerState === value) {
            state.careerState = '';
            btn.classList.remove('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
          } else {
            document.querySelectorAll('.career-btn').forEach(b => {
              b.classList.remove('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
            });
            state.careerState = value;
            btn.classList.add('bg-blue-500/20', 'border-blue-500', 'text-blue-400');
          }
        });
      });

      // 약관 동의
      function syncTerms(checked) {
        state.termsAgreed = checked;
        $termsCheck.checked = checked;
        $termsCard.classList.toggle('checked', checked);
        updateButtons();
      }

      function syncPrivacy(checked) {
        state.privacyAgreed = checked;
        $privacyCheck.checked = checked;
        $privacyCard.classList.toggle('checked', checked);
        updateButtons();
      }

      $termsCheck.addEventListener('change', (e) => {
        syncTerms(e.target.checked);
      });

      $privacyCheck.addEventListener('change', (e) => {
        syncPrivacy(e.target.checked);
      });

      $termsCard.addEventListener('click', (e) => {
        if (e.target.tagName === 'A' || e.target === $termsCheck) return;
        syncTerms(!$termsCheck.checked);
      });

      $privacyCard.addEventListener('click', (e) => {
        if (e.target.tagName === 'A' || e.target === $privacyCheck) return;
        syncPrivacy(!$privacyCheck.checked);
      });

      // 버튼 상태 업데이트
      function updateButtons() {
        $btnStep1Next.disabled = !state.nicknameOk;
        
        const channelValid = state.channel && (state.channel !== 'other' || state.channelOther.length >= 1);
        $btnStep2Next.disabled = !channelValid;
        
        $btnSubmit.disabled = !(state.termsAgreed && state.privacyAgreed);
      }

      // 네비게이션
      $btnStep1Next.addEventListener('click', () => goToStep(2));
      $btnStep2Back.addEventListener('click', () => goToStep(1));
      $btnStep2Next.addEventListener('click', () => goToStep(3));
      $btnStep3Back.addEventListener('click', () => goToStep(2));

      // 제출
      $btnSubmit.addEventListener('click', async () => {
        $step3.classList.add('hidden');
        $loading.classList.remove('hidden');
        
        const payload = {
          nickname: state.nickname,
          channel: {
            self_channel: state.channel,
            self_channel_other: state.channel === 'other' ? state.channelOther : undefined
          },
          interest_state: state.interestState || undefined,
          career_state: state.careerState || undefined,
          consents: [
            { type: 'terms', version: consentVersions.terms },
            { type: 'privacy', version: consentVersions.privacy }
          ]
        };
        
        try {
          const res = await fetch('/api/onboarding', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
          });
          
          const data = await res.json();
          
          if (data.success) {
            window.location.href = returnUrl;
          } else {
            alert(data.error || '오류가 발생했습니다. 다시 시도해주세요.');
            $loading.classList.add('hidden');
            $step3.classList.remove('hidden');
          }
        } catch (e) {
          alert('네트워크 오류가 발생했습니다. 다시 시도해주세요.');
          $loading.classList.add('hidden');
          $step3.classList.remove('hidden');
        }
      });

      // 초기화
      updateProgress();
      updateButtons();
    })();
  </script>
</body>
</html>`;
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

