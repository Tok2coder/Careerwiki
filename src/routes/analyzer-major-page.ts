/**
 * AI 전공 추천 분석기 페이지
 * index.tsx에서 추출: /analyzer/major 거대 핸들러 (5,000+ 줄)
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  isAdminRole, renderLayoutWithContext, escapeHtml, serializeForScript,
  isDevEnv
} from '../utils/shared-helpers'
import {
  MAJOR_STUDENT_OPTIONS,
  ROLE_IDENTITY_OPTIONS,
  CAREER_STAGE_OPTIONS,
  TRANSITION_STATUS_OPTIONS,
  CONSTRAINT_OPTIONS,
  TRANSITION_SIGNAL_QUESTIONS,
  IDENTITY_ANCHOR_PATTERNS
} from '../services/ai-analyzer/career-tree-types'

const analyzerMajorPage = new Hono<AppEnv>()

// AI Major Analyzer v2.0.0 - 5단계 플로우 (직업 추천과 동일 구조)
analyzerMajorPage.get('/', requireAuth, (c) => {
  const debugMode = c.req.query('debug') === 'true'
  
  // 전공용 스테이지
  const majorStagesJson = JSON.stringify([
    { id: 'major_child', label: '어린이', description: '호기심 탐색', emoji: '🌈' },
    { id: 'major_elementary', label: '초등학생', description: '관심사 발견', emoji: '🧒' },
    { id: 'major_middle', label: '중학생', description: '진로 탐색 중', emoji: '🎒' },
    { id: 'major_high', label: '고등학생', description: '대학 진학 준비', emoji: '📖' },
    { id: 'major_freshman', label: '대학 신입생', description: '전공 탐색 중', emoji: '🎓' },
    { id: 'major_student', label: '대학 재학생', description: '전과/복수전공 고려', emoji: '📚' },
    { id: 'major_graduate', label: '대학원 진학', description: '석/박사 준비', emoji: '🔬' },
  ])
  
  // Universal Questions (전공용)
  const majorQuestionsJson = JSON.stringify([
    { id: 'univ_interest', order: 1, text: '어떤 분야에 관심이 있나요?', ui_type: 'chips', options: [
      { value: 'tech', label: '기술/IT', emoji: '💻' }, { value: 'science', label: '자연과학', emoji: '🔬' },
      { value: 'humanities', label: '인문학', emoji: '📜' }, { value: 'social', label: '사회과학', emoji: '🏛️' },
      { value: 'art', label: '예술/디자인', emoji: '🎨' }, { value: 'business', label: '경영/경제', emoji: '💼' },
      { value: 'health', label: '의료/보건', emoji: '🏥' }, { value: 'education', label: '교육', emoji: '📚' },
      { value: 'engineering', label: '공학', emoji: '⚙️' }, { value: 'law', label: '법학', emoji: '⚖️' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.interest.keywords', required: true, max_selections: 5 },
    { id: 'univ_good_subjects', order: 2, text: '자신 있거나 좋아하는 과목은?', ui_type: 'chips', options: [
      { value: 'korean', label: '국어', emoji: '📖' }, { value: 'math', label: '수학', emoji: '🔢' },
      { value: 'english', label: '영어', emoji: '🌐' }, { value: 'science', label: '과학', emoji: '🧪' },
      { value: 'social', label: '사회', emoji: '🗺️' }, { value: 'history', label: '역사', emoji: '📜' },
      { value: 'art', label: '미술', emoji: '🎨' }, { value: 'music', label: '음악', emoji: '🎵' },
    ], allow_unknown: true, unknown_label: '딱히 없어요', fact_key: 'profile.good_subjects', required: true, max_selections: 4 },
    { id: 'univ_weak_subjects', order: 3, text: '어렵거나 피하고 싶은 과목은?', ui_type: 'chips', options: [
      { value: 'korean', label: '국어', emoji: '📖' }, { value: 'math', label: '수학', emoji: '🔢' },
      { value: 'english', label: '영어', emoji: '🌐' }, { value: 'science', label: '과학', emoji: '🧪' },
      { value: 'social', label: '사회', emoji: '🗺️' }, { value: 'history', label: '역사', emoji: '📜' },
    ], fact_key: 'profile.weak_subjects', required: true, max_selections: 3 },
    { id: 'univ_workstyle', order: 4, text: '공부할 때 어떤 방식이 더 맞나요?', ui_type: 'radio', options: [
      { value: 'theory', label: '이론/개념 학습', emoji: '📚' }, { value: 'practice', label: '실습/실험', emoji: '🔧' },
      { value: 'discuss', label: '토론/발표', emoji: '💬' }, { value: 'mixed', label: '상황에 따라', emoji: '🔀' },
    ], allow_unknown: true, unknown_label: '모르겠어요', fact_key: 'profile.workstyle.study', required: true },
    { id: 'univ_priority', order: 5, text: '전공 선택에서 가장 중요한 건?', ui_type: 'radio', options: [
      { value: 'interest', label: '내 관심사와 맞는 것', emoji: '❤️' }, { value: 'job', label: '취업 잘 되는 것', emoji: '💼' },
      { value: 'salary', label: '연봉이 높은 것', emoji: '💰' }, { value: 'stable', label: '안정적인 것', emoji: '🏠' },
      { value: 'growth', label: '성장 가능성', emoji: '📈' }, { value: 'social', label: '사회에 기여', emoji: '🌍' },
    ], allow_unknown: true, unknown_label: '아직 모르겠어요', fact_key: 'priority.top1', required: true },
  ])
  
  // 5축 데이터 JSON (전공 추천용)
  const majorStudentOptionsJson = JSON.stringify(MAJOR_STUDENT_OPTIONS)
  const roleIdentityOptionsJson = JSON.stringify(ROLE_IDENTITY_OPTIONS)
  const careerStageOptionsJson = JSON.stringify(CAREER_STAGE_OPTIONS)
  const transitionStatusOptionsJson = JSON.stringify(TRANSITION_STATUS_OPTIONS)
  const constraintOptionsJson = JSON.stringify(CONSTRAINT_OPTIONS)
  const transitionSignalQuestionsJson = JSON.stringify(TRANSITION_SIGNAL_QUESTIONS)
  const identityAnchorPatternsJson = JSON.stringify(IDENTITY_ANCHOR_PATTERNS)
  
  const content = `
    <div class="max-w-6xl mx-auto px-2 md:px-6 pt-0 md:pt-2">
        <h1 class="text-3xl md:text-4xl font-bold mb-6 text-center text-white">
            <i class="fas fa-university mr-2 text-wiki-primary"></i>AI 전공 추천
            ${debugMode ? '<span class="ml-2 text-sm bg-yellow-500 text-black px-2 py-1 rounded">DEBUG MODE</span>' : ''}
        </h1>

        <!-- Step Indicator (5단계) -->
        <div class="flex justify-center items-center gap-2 md:gap-4 mb-6 flex-wrap" id="step-indicator">
            <div class="step-dot flex flex-col items-center active" data-step="1">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-primary text-white rounded-full font-bold text-sm md:text-base">1</span>
                <span class="text-xs mt-1">프로필</span>
            </div>
            <div class="w-8 md:w-12 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="2">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-card text-wiki-muted rounded-full font-bold text-sm md:text-base">2</span>
                <span class="text-xs mt-1">심층</span>
            </div>
            <div class="w-8 md:w-12 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="3">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-card text-wiki-muted rounded-full font-bold text-sm md:text-base">3</span>
                <span class="text-xs mt-1">결과</span>
            </div>
        </div>
        
        <!-- 본인 계정 사용 안내 배너 (Step 1에서만 표시) -->
        <div id="account-warning-banner" class="mb-6 p-4 rounded-xl border border-amber-500/30 bg-amber-500/10">
            <div class="flex items-center gap-3">
                <i class="fas fa-exclamation-triangle text-amber-400 text-lg"></i>
                <div>
                    <p class="text-amber-300 font-medium">반드시 본인 계정으로 진행해주세요</p>
                    <p class="text-sm text-amber-200/70">입력한 정보는 현재 로그인된 계정에 저장됩니다. 다른 사람의 계정으로 진행하면 데이터가 섞일 수 있어요.</p>
                </div>
            </div>
        </div>
        
        <!-- 로딩 오버레이 (비-프로그레스 용) -->
        <div id="loading-overlay" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <div class="glass-card p-8 rounded-2xl text-center max-w-md mx-4">
                <div class="relative w-16 h-16 mx-auto mb-5">
                    <div class="absolute inset-0 border-4 border-wiki-primary/30 rounded-full"></div>
                    <div class="absolute inset-0 border-4 border-transparent border-t-wiki-primary rounded-full animate-spin"></div>
                </div>
                <p id="loading-message" class="text-lg font-semibold text-white mb-2">처리 중...</p>
                <p id="loading-submessage" class="text-sm text-wiki-muted mb-3">잠시만 기다려주세요</p>
                <div id="loading-progress-wrap" class="w-full mt-2">
                    <div class="w-full h-1.5 bg-white/10 rounded-full overflow-hidden">
                        <div id="loading-progress-bar" class="h-full rounded-full"
                             style="width: 0%; background: linear-gradient(90deg, #a855f7, #6366f1, #818cf8); box-shadow: 0 0 12px rgba(99,102,241,0.4); transition: width 0.3s ease-out;"></div>
                    </div>
                    <p id="loading-progress-text" class="text-[11px] text-white/40 mt-2"></p>
                </div>
            </div>
        </div>
        <!-- 상단 프로그레스 바 (Skeleton 모드용) -->
        <div id="top-progress-container" class="hidden fixed top-0 left-0 right-0 z-50 pointer-events-none">
            <div id="top-progress-bar" class="h-1 rounded-r-full transition-all duration-700 ease-out"
                 style="width: 0%; background: linear-gradient(90deg, #a855f7, #10b981);"></div>
            <div class="pointer-events-auto">
                <div id="top-progress-info" class="flex items-center justify-center gap-3 py-2.5 px-4 bg-black/40 backdrop-blur-sm">
                    <div class="relative w-4 h-4 flex-shrink-0">
                        <div class="absolute inset-0 border-2 border-wiki-primary/30 rounded-full"></div>
                        <div class="absolute inset-0 border-2 border-transparent border-t-wiki-primary rounded-full animate-spin"></div>
                    </div>
                    <p id="top-progress-message" class="text-xs text-white/80 font-medium">분석 중...</p>
                    <div id="top-progress-steps" class="hidden sm:flex items-center gap-2 text-xs ml-2">
                        <span id="tp-step-1" class="text-wiki-primary font-medium">프로필</span>
                        <span class="text-white/20">›</span>
                        <span id="tp-step-2" class="text-white/30">검색</span>
                        <span class="text-white/20">›</span>
                        <span id="tp-step-3" class="text-white/30">분석</span>
                        <span class="text-white/20">›</span>
                        <span id="tp-step-4" class="text-white/30">리포트</span>
                    </div>
                    <span id="top-progress-elapsed" class="text-xs text-white/30 ml-auto"></span>
                </div>
            </div>
        </div>
        
        <!-- 이어하기/새로시작 모달 -->
        <div id="continue-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <div class="glass-card p-6 rounded-2xl max-w-md mx-4 border border-wiki-border/50">
                <div class="text-center mb-6">
                    <div class="w-16 h-16 mx-auto mb-4 bg-gradient-to-br from-emerald-500 to-wiki-primary rounded-full flex items-center justify-center">
                        <i class="fas fa-history text-2xl text-white"></i>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-2">진행 중인 분석이 있습니다</h3>
                    <p class="text-wiki-muted text-sm" id="continue-modal-info"></p>
                </div>
                <div class="flex flex-col gap-3">
                    <button type="button" onclick="continueFromDraft()" 
                            class="w-full px-6 py-3 bg-gradient-to-r from-emerald-500 to-wiki-primary text-white font-bold rounded-xl hover:opacity-90 transition">
                        <i class="fas fa-play mr-2"></i>이어서 하기
                    </button>
                    <button type="button" onclick="showRestartWarning()"
                            class="w-full px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                        <i class="fas fa-redo mr-2"></i>새로 시작하기
                    </button>
                </div>
            </div>
        </div>
        
        <!-- 새로 시작 경고 모달 -->
        <div id="restart-warning-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <div class="glass-card p-6 rounded-2xl max-w-md mx-4 border border-red-500/30">
                <div class="text-center mb-6">
                    <div class="w-16 h-16 mx-auto mb-4 bg-gradient-to-br from-red-500 to-orange-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-exclamation-triangle text-2xl text-white"></i>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-2">정말 새로 시작하시겠어요?</h3>
                    <p class="text-wiki-muted text-sm">진행 중인 데이터가 모두 삭제됩니다.<br>이 작업은 되돌릴 수 없습니다.</p>
                </div>
                <div class="flex flex-col gap-3">
                    <button type="button" onclick="confirmRestart()" 
                            class="w-full px-6 py-3 bg-gradient-to-r from-red-500 to-orange-500 text-white font-bold rounded-xl hover:opacity-90 transition">
                        <i class="fas fa-trash mr-2"></i>삭제하고 새로 시작
                    </button>
                    <button type="button" onclick="hideRestartWarning()"
                            class="w-full px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                        <i class="fas fa-arrow-left mr-2"></i>취소
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Step 1: 학생 유형 선택 (전공 추천 전용) -->
        <div id="step1" class="step-content glass-card p-6 md:p-8 rounded-2xl mb-6">
            <div class="text-center mb-8">
                <h2 class="text-2xl md:text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-300">
                    현재 학업 상황을 알려주세요
                </h2>
                <p class="text-wiki-muted mt-2">학생 유형에 맞는 전공을 추천해드려요</p>
            </div>
            
            <div class="space-y-8" id="major-state-form">
                <!-- 학생 유형 -->
                <div class="state-axis-section" data-axis="student_type">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-cyan-500 to-blue-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">1</div>
                        <h3 class="text-lg font-bold">나는 현재?</h3>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-5 gap-3" id="student-type-options">
                        <!-- JS로 동적 생성 -->
                    </div>
                    <div id="student-sub-options" class="hidden">
                        <!-- 고등학생/대학생 하위옵션 동적 생성 -->
                    </div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 전공 선택 목적 -->
                <div class="state-axis-section" data-axis="major_purpose">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-purple-500 to-violet-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">2</div>
                        <h3 class="text-lg font-bold">전공을 찾는 이유는?</h3>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-3" id="career-stage-options"></div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 축 3: 전공 선택 상황 (다중 선택) -->
                <div class="state-axis-section" data-axis="transition_status">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">3</div>
                        <h3 class="text-lg font-bold">전공 선택 상황은?</h3>
                        <span class="px-2 py-0.5 bg-emerald-500/20 text-emerald-400 text-xs rounded-full">복수 선택</span>
                    </div>
                    <p class="text-sm text-wiki-muted mb-4 ml-11">해당하는 상황을 모두 선택해주세요</p>
                    <div class="grid grid-cols-2 md:grid-cols-3 gap-3" id="transition-status-options"></div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>

                <!-- 축 4: 제약 조건 -->
                <div class="state-axis-section" data-axis="constraints">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-amber-500 to-orange-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">4</div>
                        <h3 class="text-lg font-bold">현재 제약이 있나요?</h3>
                        <span class="px-2 py-0.5 bg-amber-500/20 text-amber-400 text-xs rounded-full">선택사항</span>
                    </div>
                    <p class="text-sm text-wiki-muted mb-4 ml-11">해당하는 제약을 선택하면 맞춤 추천에 반영됩니다</p>
                    <div class="max-w-2xl mx-auto" id="constraint-options"></div>
                </div>
            </div>
            
            <!-- 구분선 -->
            <div class="border-t border-wiki-border/30 my-6"></div>

            <!-- 기본 정보 (관심사) -->
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 bg-gradient-to-br from-blue-500 to-indigo-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">5</div>
                <h3 class="text-lg font-bold">관심사 & 기본 정보</h3>
            </div>
            <form id="universal-form">
                <div id="universal-questions" class="space-y-6"></div>
            </form>

            <!-- 구분선 -->
            <div class="border-t border-wiki-border/30 my-6"></div>

            <!-- 앞으로의 방향 (전이 신호) -->
            <div class="flex items-center gap-3 mb-4">
                <div class="w-8 h-8 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">6</div>
                <h3 class="text-lg font-bold">앞으로의 방향</h3>
            </div>
            <p class="text-sm text-wiki-muted mb-4 ml-11">원하는 변화와 목표를 알려주세요</p>
            <div id="transition-signal-form" class="space-y-6"></div>

            <!-- 하단 버튼 -->
            <div class="flex justify-center gap-4 pt-8 mt-6 border-t border-wiki-border/30">
                <a href="/analyzer" class="px-6 py-3 bg-wiki-card/50 border border-wiki-border text-gray-300 rounded-xl hover:bg-wiki-card hover:text-white transition inline-flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i>유형 다시 선택
                </a>
                <button type="button" id="step1-next-btn" onclick="goToStep2WithLoading()" disabled
                        class="px-10 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl shadow-lg shadow-wiki-primary/25 transition disabled:opacity-40 disabled:cursor-not-allowed disabled:shadow-none hover:shadow-wiki-primary/40 hover:scale-[1.02] active:scale-[0.98]">
                    <i class="fas fa-arrow-right mr-2"></i>다음
                </button>
            </div>
                </div>

        <!-- Step 2: 심층 인터뷰 (V3) -->
        <div id="step2" class="step-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">
            <h2 class="text-xl font-bold mb-2 text-center">
                <i class="fas fa-comments text-wiki-primary mr-2"></i>심층 질문 기초
            </h2>
            <p class="text-center text-wiki-muted mb-6 text-sm" id="step2-subtitle">당신의 이야기를 자유롭게 들려주세요</p>

            <div id="followup-questions-form" class="space-y-6"></div>

            <div class="flex justify-center gap-4 pt-6">
                <button type="button" id="step2-prev-btn" onclick="goToStep(1)" class="px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                    <i class="fas fa-arrow-left mr-2"></i>이전
                </button>
                <button type="button" id="analyze-btn"
                        class="px-12 py-4 bg-gradient-to-r from-purple-500 to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                    <i class="fas fa-arrow-right mr-2"></i>다음
                </button>
            </div>
                </div>

        <!-- Step 3: 결과 -->
        <div id="step3" class="step-content hidden">
            <!-- Confidence UI: 근거 강도 + 결정변수 -->
            <div id="confidence-card" class="glass-card p-6 rounded-2xl mb-6 border border-emerald-500/30 hidden">
                <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
                    <i class="fas fa-shield-alt text-emerald-400"></i>
                    <span>추천 근거 강도</span>
                </h2>
                
                <!-- 근거 강도 게이지 -->
                <div class="mb-6">
                    <div class="flex justify-between items-center mb-2">
                        <span class="text-sm text-wiki-muted">신뢰도</span>
                        <span id="confidence-score-text" class="text-lg font-bold text-emerald-400">--%</span>
                    </div>
                    <div class="w-full bg-wiki-bg rounded-full h-3 overflow-hidden">
                        <div id="confidence-bar" class="h-full bg-gradient-to-r from-emerald-500 to-emerald-400 rounded-full transition-all duration-500" style="width: 0%"></div>
                    </div>
                    <p id="confidence-description" class="text-xs text-wiki-muted mt-2">-</p>
                </div>
                
                <!-- 결정 변수 -->
                <div>
                    <h3 class="text-sm font-semibold mb-3 flex items-center gap-2">
                        <i class="fas fa-key text-amber-400"></i>
                        <span>이 답변들이 결과에 영향을 주었어요</span>
                    </h3>
                    <div id="key-decisions" class="space-y-2"></div>
                </div>
                </div>
                
            <div class="glass-card p-6 rounded-2xl mb-6">
                <h2 class="text-xl font-bold mb-4 text-center">
                    <i class="fas fa-star text-yellow-400 mr-2"></i>추천 전공
                </h2>
                <div id="major-results" class="space-y-4"></div>
                </div>
                
            <div class="text-center">
                <button onclick="resetAnalysis()" class="px-6 py-3 bg-wiki-card text-white rounded-lg hover:bg-wiki-primary transition">
                    <i class="fas fa-redo mr-2"></i>새로 분석하기
                </button>
            </div>
        </div>
    </div>
    
    <script>
        const DEBUG_MODE = ${debugMode};
        const UNIVERSAL_QUESTIONS = ${majorQuestionsJson};
        const MAJOR_STAGES = ${majorStagesJson};
        
        // 5축 데이터
        const ROLE_IDENTITY_OPTIONS = ${roleIdentityOptionsJson};
        const CAREER_STAGE_OPTIONS = ${careerStageOptionsJson};
        const TRANSITION_STATUS_OPTIONS = ${transitionStatusOptionsJson};
        const CONSTRAINT_OPTIONS = ${constraintOptionsJson};
        const TRANSITION_SIGNAL_QUESTIONS = ${transitionSignalQuestionsJson};
        const IDENTITY_ANCHOR_PATTERNS = ${identityAnchorPatternsJson};
        
        // 상태 관리
        let currentStep = 1;
        let selectedAnalysisType = 'major';
        let selectedStage = null;
        let universalAnswers = {};
        let followupAnswers = {};
        let transitionSignalAnswers = {};
        let currentSessionId = null;
        let currentRequestId = null;
        window.analyzerUnsavedChanges = false;

        // V3 심층 인터뷰 상태
        window.V3_MODE = true;
        window.currentRound = 0;
        window.roundAnswers = [];
        window.narrativeFacts = null;
        window.roundQuestions = null;
        window.savedNarrativeQuestions = null;
        
        let careerState = {
            role_identity: null,
            career_stage_years: null,
            transition_status: null,
            constraints: {}
        };

        // 로딩 (시간 기반 프로그레스)
        let loadingTimer = null;
        let loadingStartTime = 0;

        // 메시지 단계 정의 (프로그레스 수치는 로그 커브로 별도 계산)
        const ANALYSIS_STEPS_MAJOR = [
            { msg: '프로필 분석 중...',         step: 1, delayMs: 3000 },
            { msg: '전공 데이터 검색 중...',     step: 2, delayMs: 10000 },
            { msg: 'AI 적합도 분석 중...',       step: 2, delayMs: 20000 },
            { msg: '최적의 후보를 선별 중...',    step: 3, delayMs: 35000 },
            { msg: 'AI 심층 평가 중...',         step: 3, delayMs: 50000 },
            { msg: '거의 다 됐어요...',          step: 3, delayMs: 65000 },
            { msg: '리포트 작성 중...',          step: 4, delayMs: 80000 },
            { msg: '리포트 정리 중...',          step: 4, delayMs: 95000 },
            { msg: '마무리 중...',               step: 4, delayMs: 110000 },
        ];

        // 로그 커브 프로그레스
        function logProgress(elapsedMs) {
            const k = 0.035;
            const maxPct = 95;
            const elapsedSec = elapsedMs / 1000;
            return Math.min(maxPct, maxPct * (1 - Math.exp(-k * elapsedSec)));
        }

        // Skeleton HTML (전공용)
        function getSkeletonHtml() {
            return '<div id="skeleton-report" class="animate-pulse">' +
                '<div class="text-center mb-8">' +
                    '<div class="h-8 bg-white/10 rounded-lg w-72 mx-auto mb-3"></div>' +
                    '<div class="h-4 bg-white/5 rounded w-52 mx-auto"></div>' +
                '</div>' +
                '<div class="flex justify-center gap-2 mb-8">' +
                    '<div class="h-11 bg-white/10 rounded-xl w-20"></div>' +
                    '<div class="h-11 bg-white/10 rounded-xl w-20"></div>' +
                    '<div class="h-11 bg-white/10 rounded-xl w-24"></div>' +
                    '<div class="h-11 bg-white/[0.07] rounded-xl w-11"></div>' +
                '</div>' +
                '<div class="glass-card p-6 rounded-2xl mb-6">' +
                    '<div class="h-6 bg-white/10 rounded w-36 mb-5"></div>' +
                    '<div class="p-5 rounded-2xl bg-white/5 mb-8">' +
                        '<div class="h-5 bg-white/10 rounded w-full mb-2.5"></div>' +
                        '<div class="h-5 bg-white/10 rounded w-4/5 mb-2.5"></div>' +
                        '<div class="h-5 bg-white/10 rounded w-3/5"></div>' +
                    '</div>' +
                    '<div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">' +
                        '<div class="h-24 bg-white/5 rounded-xl border border-white/5"></div>' +
                        '<div class="h-24 bg-white/5 rounded-xl border border-white/5"></div>' +
                        '<div class="h-24 bg-white/5 rounded-xl border border-white/5"></div>' +
                    '</div>' +
                    '<div class="h-6 bg-white/10 rounded w-44 mb-5"></div>' +
                    '<div class="grid md:grid-cols-3 gap-4">' +
                        '<div class="bg-white/5 rounded-xl p-4 border border-white/5">' +
                            '<div class="h-32 bg-white/10 rounded-lg mb-3"></div>' +
                            '<div class="h-5 bg-white/10 rounded w-3/4 mb-2"></div>' +
                            '<div class="h-4 bg-white/5 rounded w-full"></div>' +
                        '</div>' +
                        '<div class="bg-white/5 rounded-xl p-4 border border-white/5">' +
                            '<div class="h-32 bg-white/10 rounded-lg mb-3"></div>' +
                            '<div class="h-5 bg-white/10 rounded w-3/4 mb-2"></div>' +
                            '<div class="h-4 bg-white/5 rounded w-full"></div>' +
                        '</div>' +
                        '<div class="bg-white/5 rounded-xl p-4 border border-white/5">' +
                            '<div class="h-32 bg-white/10 rounded-lg mb-3"></div>' +
                            '<div class="h-5 bg-white/10 rounded w-3/4 mb-2"></div>' +
                            '<div class="h-4 bg-white/5 rounded w-full"></div>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
        }

        // Skeleton 모드 표시
        function showSkeletonLoading() {
            const stepIndicator = document.getElementById('step-indicator');
            if (stepIndicator) stepIndicator.style.display = 'none';
            const pageTitle = document.querySelector('h1.text-3xl');
            if (pageTitle) pageTitle.style.display = 'none';
            const accountBanner = document.getElementById('account-warning-banner');
            if (accountBanner) accountBanner.style.display = 'none';

            const container = document.getElementById('step3');
            if (container) container.innerHTML = getSkeletonHtml();
            goToStep(3);
            window.scrollTo({ top: 0, behavior: 'smooth' });

            const topBar = document.getElementById('top-progress-container');
            const bar = document.getElementById('top-progress-bar');
            const msgEl = document.getElementById('top-progress-message');
            const elapsedEl = document.getElementById('top-progress-elapsed');
            if (topBar) topBar.classList.remove('hidden');
            if (bar) bar.style.width = '0%';

            for (let i = 1; i <= 4; i++) {
                const s = document.getElementById('tp-step-' + i);
                if (s) s.className = i === 1 ? 'text-wiki-primary font-medium' : 'text-white/30';
            }

            loadingStartTime = Date.now();
            if (loadingTimer) clearInterval(loadingTimer);
            loadingTimer = setInterval(() => {
                const elapsedMs = Date.now() - loadingStartTime;
                const elapsed = Math.floor(elapsedMs / 1000);

                const pct = logProgress(elapsedMs);
                if (bar) bar.style.width = pct.toFixed(1) + '%';

                if (elapsedEl) {
                    if (elapsed >= 150) {
                        elapsedEl.textContent = elapsed + '초 — 네트워크 확인';
                        elapsedEl.style.color = '#fbbf24';
                    } else if (elapsed >= 5) {
                        elapsedEl.textContent = elapsed + '초';
                        elapsedEl.style.color = '';
                    }
                }

                let activeStep = ANALYSIS_STEPS_MAJOR[0];
                for (let i = ANALYSIS_STEPS_MAJOR.length - 1; i >= 0; i--) {
                    if (elapsedMs >= ANALYSIS_STEPS_MAJOR[i].delayMs) { activeStep = ANALYSIS_STEPS_MAJOR[i]; break; }
                }
                if (msgEl) msgEl.textContent = activeStep.msg;

                for (let i = 1; i <= 4; i++) {
                    const s = document.getElementById('tp-step-' + i);
                    if (s) {
                        if (i < activeStep.step) s.className = 'text-emerald-400';
                        else if (i === activeStep.step) s.className = 'text-wiki-primary font-medium';
                        else s.className = 'text-white/30';
                    }
                }
            }, 500);
        }

        function hideSkeletonLoading() {
            if (loadingTimer) { clearInterval(loadingTimer); loadingTimer = null; }
            const bar = document.getElementById('top-progress-bar');
            const topBar = document.getElementById('top-progress-container');
            const msgEl = document.getElementById('top-progress-message');
            if (bar) bar.style.width = '100%';
            if (msgEl) msgEl.textContent = '완료!';
            for (let i = 1; i <= 4; i++) {
                const s = document.getElementById('tp-step-' + i);
                if (s) s.className = 'text-emerald-400';
            }
            setTimeout(() => {
                if (topBar) {
                    topBar.style.transition = 'opacity 0.4s ease-out';
                    topBar.style.opacity = '0';
                    setTimeout(() => {
                        topBar.classList.add('hidden');
                        topBar.style.opacity = '';
                        topBar.style.transition = '';
                    }, 400);
                }
            }, 800);
        }

        var modalProgressTimer = null;

        function showLoading(message, submessage = '잠시만 기다려주세요', showProgress = false, expectedSec = 5) {
            if (showProgress) {
                showSkeletonLoading();
                return;
            }
            const overlay = document.getElementById('loading-overlay');
            const msgEl = document.getElementById('loading-message');
            const subEl = document.getElementById('loading-submessage');
            if (msgEl) msgEl.textContent = message;
            if (subEl) subEl.textContent = submessage;
            if (overlay) overlay.classList.remove('hidden');

            startModalProgress(expectedSec);
        }

        function startModalProgress(expectedSec) {
            const bar = document.getElementById('loading-progress-bar');
            const text = document.getElementById('loading-progress-text');
            if (!bar) return;
            bar.style.width = '0%';
            if (modalProgressTimer) clearInterval(modalProgressTimer);

            const startTime = Date.now();
            const k = 3.0 / expectedSec;

            text.textContent = '약 ' + expectedSec + '초 소요';
            modalProgressTimer = setInterval(function() {
                const elapsed = (Date.now() - startTime) / 1000;
                const pct = Math.min(95, 95 * (1 - Math.exp(-k * elapsed)));
                bar.style.width = pct.toFixed(1) + '%';

                const remaining = Math.max(1, Math.ceil(expectedSec - elapsed));
                if (elapsed < expectedSec) {
                    text.textContent = '약 ' + remaining + '초 남음';
                } else {
                    text.textContent = '거의 완료...';
                }
            }, 100);
        }

        function hideLoading() {
            const bar = document.getElementById('loading-progress-bar');
            const text = document.getElementById('loading-progress-text');
            if (bar) bar.style.width = '100%';
            if (text) text.textContent = '';
            if (modalProgressTimer) {
                clearInterval(modalProgressTimer);
                modalProgressTimer = null;
            }

            setTimeout(function() {
                const overlay = document.getElementById('loading-overlay');
                if (overlay) overlay.classList.add('hidden');
                if (bar) bar.style.width = '0%';
            }, 250);

            hideSkeletonLoading();
        }

        // ============================================
        // 편집 모드 유틸리티 (Major)
        // ============================================
        function showEditModeBanner() {
            if (!window.__editMode) return;
            const banner = document.createElement('div');
            banner.id = 'edit-mode-banner';
            banner.className = 'mb-4 p-3 rounded-xl border';
            banner.style.cssText = 'border-color:rgba(251,191,36,0.4);background:rgba(251,191,36,0.08);';
            banner.innerHTML = \`
              <div class="flex items-center justify-between flex-wrap gap-2">
                <div class="flex items-center gap-2">
                  <i class="fas fa-edit text-amber-400"></i>
                  <span class="text-amber-300 text-sm font-medium">수정 모드</span>
                  <span class="text-amber-200/70 text-xs">변경사항이 있으면 이후 단계가 초기화됩니다</span>
                </div>
                <button onclick="cancelEditMode()" class="px-3 py-1 text-xs rounded-lg border border-wiki-border text-wiki-muted hover:text-white transition">취소</button>
              </div>\`;
            const container = document.querySelector('.max-w-6xl') || document.querySelector('main');
            if (container) container.insertBefore(banner, container.firstChild);
        }

        async function cancelEditMode() {
            if (!window.__editMode) return;
            try {
                await fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(window.__editSessionId), {
                    method: 'DELETE', credentials: 'same-origin'
                });
            } catch (e) {}
            window.location.href = '/user/ai-results/' + window.__sourceRequestId;
        }

        function getEditModePayloadExtras() {
            if (!window.__editMode) return {};
            return {
                session_id: window.__originalSessionId,
                edit_mode: true,
                edit_session_id: window.__editSessionId,
                source_request_id: window.__sourceRequestId,
                version_note: '입력 수정',
            };
        }

        function detectStep1Changes() {
            if (!window.__editMode) return false;
            return JSON.stringify(careerState) !== window.__editSnapshot.careerState;
        }

        function detectStep2Changes() {
            if (!window.__editMode) return false;
            return JSON.stringify(universalAnswers) !== window.__editSnapshot.universalAnswers;
        }

        function detectStep3Changes() {
            if (!window.__editMode) return false;
            return JSON.stringify(transitionSignalAnswers) !== window.__editSnapshot.transitionSignalAnswers;
        }

        function cascadeResetFromStep1() {
            universalAnswers = {};
            transitionSignalAnswers = {};
            followupAnswers = {};
            window.narrativeFacts = null;
            window.roundAnswers = [];
            window.roundQuestions = null;
            window.currentRound = 0;
            window.savedNarrativeQuestions = null;
            window.__editSnapshot.universalAnswers = '{}';
            window.__editSnapshot.transitionSignalAnswers = '{}';
            if (window.__editSnapshot) {
                window.__editSnapshot.narrativeFacts = '{}';
                window.__editSnapshot.roundAnswers = '[]';
            }
        }

        function cascadeResetFromStep2() {
            transitionSignalAnswers = {};
            followupAnswers = {};
            window.__editSnapshot.transitionSignalAnswers = '{}';
        }

        function detectNarrativeChanges() {
            if (!window.__editMode) return false;
            return JSON.stringify(window.narrativeFacts || {}) !== (window.__editSnapshot.narrativeFacts || '{}');
        }

        function detectRoundChanges(roundNumber) {
            if (!window.__editMode) return false;
            const snapRounds = JSON.parse(window.__editSnapshot.roundAnswers || '[]');
            const currRounds = window.roundAnswers || [];
            const snapR = snapRounds.filter(a => a.roundNumber === roundNumber);
            const currR = currRounds.filter(a => a.roundNumber === roundNumber);
            return JSON.stringify(snapR) !== JSON.stringify(currR);
        }

        function cascadeResetFromNarrative() {
            window.roundAnswers = [];
            window.roundQuestions = null;
            window.currentRound = 0;
            if (window.__editSnapshot) {
                window.__editSnapshot.roundAnswers = '[]';
            }
        }

        function cascadeResetFromRound(roundNumber) {
            window.roundAnswers = (window.roundAnswers || []).filter(a => a.roundNumber <= roundNumber);
            window.currentRound = roundNumber;
            if (window.__editSnapshot) {
                window.__editSnapshot.roundAnswers = JSON.stringify(window.roundAnswers);
            }
        }

        function cascadeResetFromStep3() {
            followupAnswers = {};
        }

        // ============================================
        // 이력서 업로드 처리 (전공 추천)
        // ============================================
        async function handleResumeUpload(input) {
            const file = input.files[0];
            if (!file) return;
            
            if (file.type !== 'application/pdf') {
                showResumeError('PDF 파일만 업로드 가능합니다.');
                return;
            }
            
            if (file.size > 5 * 1024 * 1024) {
                showResumeError('파일 크기는 5MB 이하만 가능합니다.');
                return;
            }
            
            document.getElementById('resume-loading').classList.remove('hidden');
            document.getElementById('resume-status').classList.add('hidden');
            document.getElementById('resume-error').classList.add('hidden');
            
            try {
                await loadPdfJs();
                const pdfText = await extractTextFromPdf(file);
                
                if (pdfText.length < 100) {
                    showResumeError('문서에서 충분한 텍스트를 추출하지 못했습니다.');
                    return;
                }
                
                const response = await fetch('/api/ai-analyzer/resume/parse', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        text: pdfText,
                        session_id: currentSessionId,
                        save_to_draft: false,
                    }),
                });
                
                const data = await response.json();
                if (!response.ok) throw new Error(data.message || '파싱 실패');
                
                applyResumeParseResult(data.career_state, data.data);
                
                document.getElementById('resume-loading').classList.add('hidden');
                document.getElementById('resume-status').classList.remove('hidden');
                
                // 이력서 형식 확인 (추출된 데이터 기준)
                const extracted = data.data.extracted || {};
                const hasSkills = extracted.skills?.length > 0;
                const hasCerts = extracted.certifications?.length > 0;
                const hasEducation = !!extracted.education_level;
                const hasExperience = extracted.total_experience_years !== null;
                const hasRole = !!extracted.current_role_type;
                
                const extractedCount = [hasSkills, hasCerts, hasEducation, hasExperience, hasRole].filter(Boolean).length;
                
                if (extractedCount < 2) {
                    document.getElementById('resume-status-text').innerHTML = 
                        '<span class="text-amber-400">⚠️ 충분한 정보를 추출하지 못했어요. 그래도 입력하신 내용은 참고됩니다.</span>';
                } else {
                    const infoSummary = [];
                    if (hasSkills) infoSummary.push('스킬 ' + extracted.skills.length + '개');
                    if (hasCerts) infoSummary.push('자격증 ' + extracted.certifications.length + '개');
                    if (hasEducation) infoSummary.push(extracted.education_level);
                    if (hasExperience) infoSummary.push('경력 ' + extracted.total_experience_years + '년');
                    if (hasRole) infoSummary.push(extracted.current_role_type);
                    
                    document.getElementById('resume-status-text').innerHTML = 
                        '<span class="text-emerald-400">✓ 분석 완료! (' + infoSummary.slice(0, 3).join(', ') + ')</span>';
                }
                
            } catch (error) {
                showResumeError(error.message || '문서 분석 중 오류가 발생했습니다.');
            }
        }
        
        function showResumeError(message) {
            document.getElementById('resume-loading').classList.add('hidden');
            document.getElementById('resume-status').classList.add('hidden');
            document.getElementById('resume-error').classList.remove('hidden');
            document.getElementById('resume-error-text').textContent = message;
        }
        
        async function loadPdfJs() {
            return new Promise((resolve, reject) => {
                if (window.pdfjsLib) { resolve(); return; }
                const script = document.createElement('script');
                script.src = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js';
                script.onload = () => {
                    window.pdfjsLib = window['pdfjs-dist/build/pdf'];
                    window.pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';
                    resolve();
                };
                script.onerror = () => reject(new Error('PDF.js 로드 실패'));
                document.head.appendChild(script);
            });
        }
        
        async function extractTextFromPdf(file) {
            await loadPdfJs();
            const arrayBuffer = await file.arrayBuffer();
            const pdf = await window.pdfjsLib.getDocument({ data: arrayBuffer }).promise;
            let fullText = '';
            for (let i = 1; i <= pdf.numPages; i++) {
                const page = await pdf.getPage(i);
                const textContent = await page.getTextContent();
                const pageText = textContent.items.map(item => item.str).join(' ');
                fullText += pageText + '\\n';
            }
            return fullText.trim();
        }
        
        function applyResumeParseResult(careerStateFromResume, parsedData) {
            // 전환 상태 선택
            if (careerStateFromResume.transition_status) {
                const transBtn = document.querySelector(\`#transition-status-options [data-value="\${careerStateFromResume.transition_status}"]\`);
                if (transBtn && !transBtn.classList.contains('selected')) transBtn.click();
            }
            
        }
        
        // ============================================
        // 전공 추천용 비활성화 규칙
        // ============================================
        const STUDENT_TYPE_DISABLED_RULES = {
            middle: {
                career_stage: ['univ', 'grad', 'work_exp'],
                transition_status: ['major_change', 'double_major'],
                reasons: {
                    career_stage: '중학생은 선택할 수 없어요',
                    transition_status: '대학 입학 후 선택할 수 있어요'
                }
            },
            high: {
                career_stage: ['grad', 'work_exp'],
                transition_status: ['major_change', 'double_major'],
                reasons: {
                    career_stage: '고등학생은 선택할 수 없어요',
                    transition_status: '대학 입학 후 선택할 수 있어요'
                }
            },
            univ: {
                career_stage: [],
                transition_status: [],
                reasons: {}
            },
            grad: {
                career_stage: [],
                transition_status: [],
                reasons: {}
            }
        };
        
        let studentType = null;
        let majorPurpose = null;
        
        // ============================================
        // 5축 UI 렌더링 (전공 전용 - 프로페셔널 디자인)
        // ============================================
        function renderCareerStateForm() {
            renderStudentTypeOptions();
            renderMajorPurposeOptions();
            updateTransitionStatusOptionsMajor();
            renderConstraintOptionsMajor();
            renderUniversalQuestions();
            renderTransitionSignalForm();
        }
        
        // 학생 유형 선택 (다크 테마)
        function renderStudentTypeOptions() {
            const container = document.getElementById('student-type-options');
            if (!container) return;
            
            const studentTypes = [
                { value: 'child', label: '어린이', description: '호기심 탐색', emoji: '🌈' },
                { value: 'elementary', label: '초등학생', description: '관심사 발견', emoji: '🧒' },
                { value: 'middle', label: '중학생', description: '진로 탐색 중', emoji: '🎒' },
                { value: 'high', label: '고등학생', description: '대학 진학 준비', emoji: '📖' },
                { value: 'univ', label: '대학생', description: '전공 탐색/전과/대학원', emoji: '🎓' },
            ];
            
            container.innerHTML = studentTypes.map(opt => \`
                <button type="button" onclick="selectStudentType('\${opt.value}', this)"
                        class="student-type-card group relative overflow-hidden rounded-xl border border-wiki-border/50 bg-wiki-card/80 p-4 hover:bg-wiki-card hover:border-cyan-500/50 transition-all duration-300 transform hover:-translate-y-1 hover:shadow-lg hover:shadow-cyan-500/10"
                        data-value="\${opt.value}">
                    <div class="absolute top-0 right-0 w-16 h-16 bg-gradient-to-bl from-cyan-500/10 to-transparent rounded-bl-full"></div>
                    <div class="relative z-10">
                        <div class="text-3xl mb-2 transform group-hover:scale-110 transition-transform">\${opt.emoji}</div>
                        <div class="font-semibold text-white">\${opt.label}</div>
                        <div class="text-xs text-wiki-muted mt-1">\${opt.description}</div>
                    </div>
                </button>
            \`).join('');
        }
        
        function selectStudentType(value, btnEl) {
            studentType = value;
            careerState.role_identity = 'student'; // 전공 추천은 항상 student

            // studentType → selectedStage 매핑
            const stageMap = {
                child: 'major_child',
                elementary: 'major_elementary',
                middle: 'major_middle',
                high: 'major_high',
                univ: 'major_student',
            };
            selectedStage = stageMap[value] || 'major_high';

            // 선택 상태 업데이트
            document.querySelectorAll('#student-type-options .student-type-card').forEach(btn => {
                btn.classList.remove('border-cyan-500', 'bg-cyan-500/20', 'shadow-lg', 'shadow-cyan-500/20');
                btn.classList.add('border-wiki-border/50');
            });
            btnEl.classList.remove('border-wiki-border/50');
            btnEl.classList.add('border-cyan-500', 'bg-cyan-500/20', 'shadow-lg', 'shadow-cyan-500/20');

            // 하위옵션 표시/숨김
            const subContainer = document.getElementById('student-sub-options');
            if (subContainer) {
                if (value === 'high') {
                    subContainer.innerHTML = renderHighSubOptions();
                    subContainer.classList.remove('hidden');
                } else if (value === 'univ') {
                    subContainer.innerHTML = renderUnivSubOptions();
                    subContainer.classList.remove('hidden');
                } else {
                    subContainer.innerHTML = '';
                    subContainer.classList.add('hidden');
                    window.academicState = null;
                }
            }

            // 다른 축들 업데이트
            setTimeout(() => {
                updateTransitionStatusOptionsMajor();
            }, 150);

            checkStep1Completion();
        }

        // 고등학생 하위옵션 렌더링
        function renderHighSubOptions() {
            const options = [
                { value: 'high_school_early', label: '수시', description: '내신/학생부' },
                { value: 'high_school_regular', label: '정시', description: '수능 준비' },
                { value: 'high_school_undecided', label: '미정', description: '아직 결정 전' },
                { value: 'retake', label: '재수', description: '재수/반수' },
            ];
            return '<div class="mt-3 pl-2 border-l-2 border-cyan-500/30"><p class="text-xs text-wiki-muted mb-2">입시 전형 선택 (선택사항)</p><div class="flex flex-wrap gap-2">' +
                options.map(opt =>
                    '<button type="button" onclick="selectHighSubType(\\'' + opt.value + '\\', this)" class="sub-option-btn px-3 py-1.5 text-xs rounded-lg border border-wiki-border/50 bg-wiki-card/60 text-wiki-muted hover:border-cyan-500/50 hover:text-white transition-all" data-value="' + opt.value + '">' +
                    '<span class="font-medium">' + opt.label + '</span> <span class="text-wiki-muted/70">· ' + opt.description + '</span></button>'
                ).join('') +
                '</div></div>';
        }

        // 대학생 하위옵션 렌더링
        function renderUnivSubOptions() {
            const options = [
                { value: 'freshman', label: '신입생', description: '전공 탐색', stage: 'major_freshman' },
                { value: 'current', label: '재학생', description: '전과/복수전공', stage: 'major_student' },
                { value: 'graduate', label: '대학원 준비', description: '석·박사 진학', stage: 'major_graduate' },
            ];
            return '<div class="mt-3 pl-2 border-l-2 border-cyan-500/30"><p class="text-xs text-wiki-muted mb-2">상세 유형 선택 (선택사항)</p><div class="flex flex-wrap gap-2">' +
                options.map(opt =>
                    '<button type="button" onclick="selectUnivSubType(\\'' + opt.value + '\\', \\'' + opt.stage + '\\', this)" class="sub-option-btn px-3 py-1.5 text-xs rounded-lg border border-wiki-border/50 bg-wiki-card/60 text-wiki-muted hover:border-cyan-500/50 hover:text-white transition-all" data-value="' + opt.value + '">' +
                    '<span class="font-medium">' + opt.label + '</span> <span class="text-wiki-muted/70">· ' + opt.description + '</span></button>'
                ).join('') +
                '</div></div>';
        }

        // 고등학생 하위 선택
        function selectHighSubType(value, btnEl) {
            window.academicState = value;
            document.querySelectorAll('#student-sub-options .sub-option-btn').forEach(btn => {
                btn.classList.remove('border-cyan-500', 'bg-cyan-500/20', 'text-white');
                btn.classList.add('border-wiki-border/50', 'text-wiki-muted');
            });
            btnEl.classList.remove('border-wiki-border/50', 'text-wiki-muted');
            btnEl.classList.add('border-cyan-500', 'bg-cyan-500/20', 'text-white');
        }

        // 대학생 하위 선택
        function selectUnivSubType(value, stage, btnEl) {
            selectedStage = stage;
            window.academicState = null;
            document.querySelectorAll('#student-sub-options .sub-option-btn').forEach(btn => {
                btn.classList.remove('border-cyan-500', 'bg-cyan-500/20', 'text-white');
                btn.classList.add('border-wiki-border/50', 'text-wiki-muted');
            });
            btnEl.classList.remove('border-wiki-border/50', 'text-wiki-muted');
            btnEl.classList.add('border-cyan-500', 'bg-cyan-500/20', 'text-white');
        }
        
        // 전공 선택 목적 (다크 테마)
        function renderMajorPurposeOptions() {
            const container = document.getElementById('career-stage-options');
            if (!container) return;
            
            const purposes = [
                { value: 'explore', label: '진로 탐색', description: '다양한 전공 알아보기', emoji: '🔍' },
                { value: 'decide', label: '전공 결정', description: '입학/전과 준비', emoji: '✅' },
                { value: 'change', label: '전공 변경', description: '복수전공/전과 고려', emoji: '🔄' },
                { value: 'career', label: '진로 연계', description: '취업을 위한 전공', emoji: '💼' },
            ];
            
            container.innerHTML = purposes.map((opt, idx) => \`
                <button type="button" onclick="selectMajorPurpose('\${opt.value}', this)"
                        class="purpose-btn group relative overflow-hidden rounded-xl p-4 bg-wiki-card/80 border border-wiki-border/50 hover:border-purple-500/50 hover:bg-wiki-card transition-all duration-300"
                        data-value="\${opt.value}">
                    <div class="relative z-10">
                        <div class="text-2xl mb-2">\${opt.emoji}</div>
                        <div class="font-semibold text-sm text-white">\${opt.label}</div>
                        <div class="text-xs text-wiki-muted mt-0.5">\${opt.description}</div>
                    </div>
                </button>
            \`).join('');
        }
        
        function selectMajorPurpose(value, btnEl) {
            majorPurpose = value;
            careerState.career_stage_years = value === 'explore' ? 'none' : value === 'decide' ? '0_3' : value === 'change' ? '0_3' : '3_10';
            
            document.querySelectorAll('#career-stage-options .purpose-btn').forEach(btn => {
                btn.classList.remove('border-purple-500', 'bg-purple-500/20', 'shadow-lg', 'shadow-purple-500/20');
                btn.classList.add('border-wiki-border/50');
            });
            btnEl.classList.remove('border-wiki-border/50');
            btnEl.classList.add('border-purple-500', 'bg-purple-500/20', 'shadow-lg', 'shadow-purple-500/20');
            
            checkStep1Completion();
        }
        
        // 전환 상태 (다중 선택 - 다크 테마)
        function updateTransitionStatusOptionsMajor() {
            const container = document.getElementById('transition-status-options');
            if (!container) return;

            const MAJOR_TRANSITION_OPTIONS = [
                { value: 'first_choice', label: '첫 전공 선택', emoji: '🌱', description: '아직 전공을 정한 적 없어요' },
                { value: 'exploring', label: '여러 전공 탐색', emoji: '🔍', description: '관심 분야를 비교하는 중' },
                { value: 'major_change', label: '전과/전공 변경', emoji: '🔄', description: '현재 전공을 바꾸고 싶어요' },
                { value: 'career_linked', label: '목표 직업 연계', emoji: '🎯', description: '원하는 직업에 맞는 전공 탐색' },
                { value: 'double_major', label: '복수전공/부전공', emoji: '➕', description: '추가 전공을 고려하고 있어요' },
                { value: 'undecided', label: '아직 모르겠어요', emoji: '🤔', description: '방향을 정하지 못했어요' },
            ];

            const rules = studentType && STUDENT_TYPE_DISABLED_RULES[studentType]
                ? STUDENT_TYPE_DISABLED_RULES[studentType]
                : { transition_status: [], reasons: {} };
            const disabledValues = rules.transition_status || [];
            const reason = rules.reasons?.transition_status || '현재 상태에서 선택할 수 없어요';

            if (!Array.isArray(careerState.transition_status)) {
                careerState.transition_status = [];
            }
            careerState.transition_status = careerState.transition_status.filter(v => !disabledValues.includes(v));

            container.innerHTML = MAJOR_TRANSITION_OPTIONS.map(opt => {
                const isDisabled = disabledValues.includes(opt.value);
                const isSelected = careerState.transition_status.includes(opt.value);
                
                return \`
                    <button type="button" \${isDisabled ? '' : \`onclick="toggleTransitionStatusMajor('\${opt.value}', this)"\`}
                            class="goal-chip group relative rounded-xl p-4 transition-all duration-300 \${
                                isDisabled 
                                    ? 'bg-wiki-bg/50 cursor-not-allowed opacity-40' 
                                    : isSelected 
                                        ? 'bg-emerald-500/20 border border-emerald-500 shadow-lg shadow-emerald-500/20 transform scale-[1.02]' 
                                        : 'bg-wiki-card/80 border border-wiki-border/50 hover:border-emerald-500/50 hover:bg-wiki-card'
                            }"
                            data-value="\${opt.value}" \${isDisabled ? 'disabled' : ''}>
                        \${isDisabled ? \`
                            <div class="absolute top-2 right-2">
                                <svg class="w-4 h-4 text-wiki-muted/50" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        \` : isSelected ? \`
                            <div class="absolute top-2 right-2">
                                <svg class="w-5 h-5 text-emerald-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        \` : ''}
                        <div class="text-2xl mb-2 \${isDisabled ? 'grayscale opacity-50' : ''}">\${opt.emoji}</div>
                        <div class="font-semibold text-sm \${isDisabled ? 'text-wiki-muted/50' : isSelected ? 'text-emerald-400' : 'text-white'}">\${opt.label}</div>
                        <div class="text-xs mt-1 \${isDisabled ? 'text-wiki-muted/30' : isSelected ? 'text-emerald-300/80' : 'text-wiki-muted'}">\${opt.description}</div>
                        \${isDisabled ? \`
                            <div class="disabled-tooltip absolute left-1/2 -translate-x-1/2 bottom-full mb-2 px-3 py-1.5 bg-black/90 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-50 border border-wiki-border/30">
                                🔒 \${reason}
                            </div>
                        \` : ''}
                    </button>
                \`;
            }).join('');
        }
        
        function toggleTransitionStatusMajor(value, btnEl) {
            if (!Array.isArray(careerState.transition_status)) {
                careerState.transition_status = [];
            }
            
            const idx = careerState.transition_status.indexOf(value);
            if (idx === -1) {
                careerState.transition_status.push(value);
            } else {
                careerState.transition_status.splice(idx, 1);
            }
            
            updateTransitionStatusOptionsMajor();
            checkStep1Completion();
        }
        
        // 제약 조건 (다크 테마 아코디언 카드)
        let noConstraintSelectedMajor = false;
        
        function renderConstraintOptionsMajor() {
            const container = document.getElementById('constraint-options');
            if (!container) return;

            const MAJOR_CONSTRAINT_OPTIONS = [
                { type: 'grades', label: '성적/입시 제약', emoji: '📊', description: '성적 범위 내에서 선택해야 해요', placeholder: '예: 수학 과목이 약함, 내신 3등급 이내 필요 등', details: [{ value: 'gpa_limit', label: '내신 성적 제한' }, { value: 'exam_limit', label: '수능 점수 제한' }, { value: 'weak_subject', label: '특정 과목 약함' }] },
                { type: 'money', label: '경제적 제약', emoji: '💰', description: '학비·생활비 부담이 있어요', placeholder: '예: 등록금 500만원 이하, 장학금 가능한 곳만 등', details: [{ value: 'tuition_burden', label: '학비 부담' }, { value: 'scholarship_required', label: '장학금 필수' }, { value: 'living_cost', label: '자취비용 고려' }] },
                { type: 'location', label: '지역 제약', emoji: '📍', description: '통학 가능한 지역이 정해져 있어요', placeholder: '예: 서울/경기만 가능, 집에서 통학 가능한 거리 등', details: [{ value: 'capital_only', label: '수도권만 가능' }, { value: 'specific_region', label: '특정 지역만 가능' }, { value: 'commute_required', label: '자택 통학 필요' }] },
                { type: 'family', label: '가족 의견', emoji: '👨‍👩‍👧', description: '가족 의견을 고려해야 해요', placeholder: '예: 부모님이 특정 전공을 원하심, 가업이 있음 등', details: [{ value: 'parent_opinion', label: '부모님 의견 고려' }, { value: 'family_business', label: '가업 승계 고려' }, { value: 'family_care', label: '가족 돌봄 필요' }] },
                { type: 'subject', label: '과목/적성 제약', emoji: '📐', description: '특정 과목이나 활동이 부담돼요', placeholder: '예: 수학을 못함, 실험 수업이 부담됨 등', details: [{ value: 'math_science_hard', label: '수학/과학 기피' }, { value: 'language_hard', label: '외국어 어려움' }, { value: 'practical_hard', label: '실기/실험 부담' }] },
                { type: 'duration', label: '기간/과정 제약', emoji: '⏳', description: '수업 기간이나 과정이 부담돼요', placeholder: '예: 4년 이내 졸업 원함, 대학원 필수 전공 기피 등', details: [{ value: 'fast_graduation', label: '빠른 졸업 원함' }, { value: 'no_grad_required', label: '대학원 필수 기피' }, { value: 'internship_burden', label: '실습 기간 부담' }] },
                { type: 'health', label: '건강/장애 제약', emoji: '♿', description: '건강이나 장애로 인한 제약이 있어요', placeholder: '예: 장시간 실험이 어려움, 시각/청각 보조 필요 등', details: [{ value: 'visual_disability', label: '👁️ 시각 장애' }, { value: 'hearing_disability', label: '👂 청각 장애' }, { value: 'mobility_disability', label: '🦽 지체 장애' }, { value: 'energy_limit', label: '🔋 체력/에너지 제약' }] },
            ];

            container.innerHTML = \`
                <div class="mb-4">
                    <button type="button" onclick="toggleNoConstraintMajor(this)" id="no-constraint-btn"
                            class="w-full p-4 rounded-xl border border-dashed hover:border-emerald-500/50 transition-all duration-300 group"
                            style="border-color: rgba(42,42,62,0.5); background-color: rgba(26,26,46,0.5);">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full flex items-center justify-center text-2xl group-hover:scale-110 transition-transform" style="background-color: rgba(16,185,129,0.2);">✅</div>
                            <div class="text-left flex-1">
                                <div class="font-semibold text-white">제약 없음</div>
                                <div class="text-sm" style="color: rgb(148,163,184)">특별한 제약 조건 없이 모든 전공 고려</div>
                            </div>
                            <div class="w-6 h-6 rounded-full border flex items-center justify-center no-constraint-check opacity-0 transition-opacity" style="border-color: rgba(42,42,62,0.5);">
                                <svg class="w-4 h-4 text-emerald-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        </div>
                    </button>
                </div>
                <div class="flex items-center gap-4 mb-4">
                    <div class="flex-1 h-px" style="background-color: rgba(42,42,62,0.3)"></div>
                    <span class="text-xs font-medium" style="color: rgb(148,163,184)">또는 제약 조건 선택</span>
                    <div class="flex-1 h-px" style="background-color: rgba(42,42,62,0.3)"></div>
                </div>
                <div id="constraint-list" class="grid gap-3">
                    \${MAJOR_CONSTRAINT_OPTIONS.map(opt => \`
                        <div class="constraint-card rounded-xl border overflow-hidden transition-all duration-300" 
                             style="border-color: rgba(42,42,62,0.5); background-color: rgba(26,26,46,0.9);"
                             data-type="\${opt.type}">
                            <button type="button" onclick="toggleConstraintMajor('\${opt.type}', this)"
                                    class="constraint-header w-full p-4 flex items-center gap-4 text-left transition-colors"
                                    onmouseover="this.style.backgroundColor='rgba(26,26,46,1)';"
                                    onmouseout="this.style.backgroundColor='transparent';">
                                <div class="w-10 h-10 rounded-lg flex items-center justify-center text-xl flex-shrink-0" style="background-color: rgba(245,158,11,0.2);">\${opt.emoji}</div>
                                <div class="flex-1 min-w-0">
                                    <div class="font-semibold text-white">\${opt.label}</div>
                                    <div class="text-sm truncate" style="color: rgb(148,163,184)">\${opt.description}</div>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="constraint-badge hidden px-2 py-1 text-amber-400 text-xs font-medium rounded-full" style="background-color: rgba(245,158,11,0.2);">선택됨</div>
                                    <svg class="constraint-chevron w-5 h-5 transition-transform duration-300" style="color: rgb(148,163,184)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </div>
                            </button>
                            <div class="constraint-detail hidden border-t" style="border-color: rgba(42,42,62,0.3); background-color: rgba(15,15,35,0.5);">
                                <div class="p-4 space-y-4">
                <div>
                                        <label class="text-xs font-medium mb-2 block" style="color: rgb(148,163,184)">구체적인 상황 (선택)</label>
                                        <div class="flex flex-wrap gap-2">
                                            \${opt.details.map(d => \`
                                                <button type="button" onclick="selectConstraintDetailMajor('\${opt.type}', '\${d.value}', this)"
                                                        class="detail-tag px-3 py-1.5 text-sm rounded-full border"
                                                        data-value="\${d.value}">
                                                    \${d.label}
                                                </button>
                                            \`).join('')}
                </div>
                                    </div>
                                    <div>
                                        <label class="text-xs font-medium mb-2 block" style="color: rgb(148,163,184)">추가 설명 (선택)</label>
                                        <textarea class="w-full px-4 py-3 text-sm border rounded-lg transition-all resize-none"
                                                  style="border-color: rgba(42,42,62,0.5); background-color: rgba(15,15,35,1); color: #fff;"
                                                  rows="2" placeholder="\${opt.placeholder}"
                                                  onfocus="this.style.borderColor='rgba(245,158,11,0.5)';"
                                                  onblur="this.style.borderColor='rgba(42,42,62,0.5)';"
                                                  onchange="updateConstraintCustomDetailMajor('\${opt.type}', this.value)"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    \`).join('')}
                </div>
            \`;
        }
        
        function toggleNoConstraintMajor(btnEl) {
            noConstraintSelectedMajor = !noConstraintSelectedMajor;
            const checkEl = btnEl.querySelector('.no-constraint-check');
            const constraintList = document.getElementById('constraint-list');
            
            if (noConstraintSelectedMajor) {
                btnEl.classList.add('border-solid', 'shadow-lg');
                btnEl.classList.remove('border-dashed');
                btnEl.style.borderColor = '#10b981';
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                checkEl.classList.remove('opacity-0');
                checkEl.classList.add('opacity-100');
                checkEl.style.backgroundColor = '#10b981';
                checkEl.style.borderColor = '#10b981';
                careerState.constraints = {};
                document.querySelectorAll('.constraint-card').forEach(card => {
                    card.classList.add('opacity-30', 'pointer-events-none');
                    card.querySelector('.constraint-badge')?.classList.add('hidden');
                    card.querySelector('.constraint-detail')?.classList.add('hidden');
                    card.querySelector('.constraint-chevron')?.classList.remove('rotate-180');
                });
                constraintList.classList.add('opacity-50');
            } else {
                btnEl.classList.remove('border-solid', 'shadow-lg');
                btnEl.classList.add('border-dashed');
                btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                btnEl.style.backgroundColor = 'rgba(26,26,46,0.5)';
                checkEl.classList.add('opacity-0');
                checkEl.classList.remove('opacity-100');
                checkEl.style.backgroundColor = 'transparent';
                checkEl.style.borderColor = 'rgba(42,42,62,0.5)';
                document.querySelectorAll('.constraint-card').forEach(card => {
                    card.classList.remove('opacity-30', 'pointer-events-none');
                });
                constraintList.classList.remove('opacity-50');
            }
        }
        
        function toggleConstraintMajor(type, btnEl) {
            if (noConstraintSelectedMajor) {
                noConstraintSelectedMajor = false;
                const noBtn = document.getElementById('no-constraint-btn');
                const checkEl = noBtn.querySelector('.no-constraint-check');
                noBtn.classList.remove('border-solid', 'shadow-lg');
                noBtn.classList.add('border-dashed');
                noBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                noBtn.style.backgroundColor = 'rgba(26,26,46,0.5)';
                checkEl.classList.add('opacity-0');
                document.querySelectorAll('.constraint-card').forEach(card => {
                    card.classList.remove('opacity-30', 'pointer-events-none');
                });
                document.getElementById('constraint-list').classList.remove('opacity-50');
            }
            
            const card = btnEl.closest('.constraint-card');
            const badge = card.querySelector('.constraint-badge');
            const detail = card.querySelector('.constraint-detail');
            const chevron = card.querySelector('.constraint-chevron');
            const isSelected = careerState.constraints[type]?.has_constraint;
            
            if (isSelected) {
                delete careerState.constraints[type];
                card.classList.remove('shadow-lg');
                card.style.borderColor = 'rgba(42,42,62,0.5)';
                badge.classList.add('hidden');
                detail.classList.add('hidden');
                chevron.classList.remove('rotate-180');
                detail.querySelectorAll('.detail-tag').forEach(tag => {
                    tag.classList.remove('selected');
                    tag.style.backgroundColor = 'rgba(26,26,46,0.5)';
                    tag.style.borderColor = 'rgba(42,42,62,0.5)';
                    tag.style.color = 'rgb(148,163,184)';
                });
            } else {
                careerState.constraints[type] = { has_constraint: true };
                card.classList.add('shadow-lg');
                card.style.borderColor = '#f59e0b';
                badge.classList.remove('hidden');
                detail.classList.remove('hidden');
                chevron.classList.add('rotate-180');
            }
        }
        
        function selectConstraintDetailMajor(type, value, btnEl) {
            if (!careerState.constraints[type]) return;

            const isCurrentlySelected = btnEl.classList.contains('selected');

            // details 배열 초기화
            if (!careerState.constraints[type].details) {
                careerState.constraints[type].details = [];
            }
            if (!Array.isArray(careerState.constraints[type].details)) {
                careerState.constraints[type].details = careerState.constraints[type].details
                    ? [careerState.constraints[type].details] : [];
            }

            // 토글: 선택/해제
            if (isCurrentlySelected) {
                btnEl.classList.remove('selected');
                careerState.constraints[type].details = careerState.constraints[type].details.filter(v => v !== value);
            } else {
                btnEl.classList.add('selected');
                if (!careerState.constraints[type].details.includes(value)) {
                    careerState.constraints[type].details.push(value);
                }
            }
            
            // 스타일 즉시 적용
            applyDetailTagStyle(btnEl, !isCurrentlySelected);

            // 장애 유형 → miniModuleResult에 반영
            if (type === 'health') {
                const disabilityMap = { visual_disability: 'visual', hearing_disability: 'hearing', mobility_disability: 'mobility' };
                const details = careerState.constraints[type]?.details || [];
                const found = details.find(d => disabilityMap[d]);
                if (!window.miniModuleResult) window.miniModuleResult = {};
                window.miniModuleResult.disability_type = found ? disabilityMap[found] : undefined;
                // physical_constraint도 추가
                if (!window.miniModuleResult.constraint_flags) window.miniModuleResult.constraint_flags = [];
                if (found && !window.miniModuleResult.constraint_flags.includes('physical_constraint')) {
                    window.miniModuleResult.constraint_flags.push('physical_constraint');
                }
            }
        }

        function updateConstraintCustomDetailMajor(type, value) {
            if (!careerState.constraints[type]) return;
            careerState.constraints[type].custom_detail = value;
        }
        
        function selectAxis(axis, value, btnEl) {
            careerState[axis] = value;
            const container = btnEl.parentElement;
            container.querySelectorAll('.axis-btn').forEach(btn => {
                btn.classList.remove('ring-2', 'ring-wiki-primary', 'bg-wiki-primary/10', 'border-wiki-primary');
            });
            btnEl.classList.add('ring-2', 'ring-wiki-primary', 'bg-wiki-primary/10', 'border-wiki-primary');
            checkStep1Completion();
        }
        
        function toggleConstraint(type, btnEl) {
            const isSelected = careerState.constraints[type]?.has_constraint;
            if (isSelected) {
                delete careerState.constraints[type];
                btnEl.classList.remove('ring-2', 'ring-amber-400', 'bg-amber-400/10', 'border-amber-400');
            } else {
                careerState.constraints[type] = { has_constraint: true };
                btnEl.classList.add('ring-2', 'ring-amber-400', 'bg-amber-400/10', 'border-amber-400');
            }
        }
        
        function checkStep1Completion() {
            const hasStudentType = studentType !== null;
            const hasMajorPurpose = majorPurpose !== null;
            const hasTransition = Array.isArray(careerState.transition_status) && careerState.transition_status.length > 0;
            const isComplete = hasStudentType && hasMajorPurpose && hasTransition;
            const nextBtn = document.getElementById('step1-next-btn');
            nextBtn.disabled = !isComplete;
            if (isComplete) nextBtn.classList.add('hover-glow');
            else nextBtn.classList.remove('hover-glow');
        }
        
        function goToStep(step, skipRender = false) {
            document.querySelectorAll('.step-content').forEach(el => el.classList.add('hidden'));
            const target = document.getElementById('step' + step);
            if (target) target.classList.remove('hidden');
            currentStep = step;

            // 본인 계정 경고 배너: Step 1에서만 표시
            const warningBanner = document.getElementById('account-warning-banner');
            if (warningBanner) {
                warningBanner.style.display = step === 1 ? 'block' : 'none';
            }

            document.querySelectorAll('.step-dot').forEach(dot => {
                const dotStep = parseInt(dot.dataset.step);
                const circle = dot.querySelector('span');
                if (dotStep === step) {
                    dot.classList.add('active');
                    circle.classList.remove('bg-wiki-card', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-primary', 'text-white');
                } else if (dotStep < step) {
                    circle.classList.remove('bg-wiki-card', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-secondary', 'text-white');
                } else {
                    dot.classList.remove('active');
                    circle.classList.remove('bg-wiki-primary', 'bg-wiki-secondary', 'text-white');
                    circle.classList.add('bg-wiki-card', 'text-wiki-muted');
                }
            });
        }
        
        // ★ v3.24: miniModuleResult 구성 (전공용)
        // 직업 추천의 updateIntegratedUniversalAnswers() 에 대응
        function buildMiniModuleResultMajor() {
            // interest_top: univ_interest에서 상위 2개
            const interest_top = (universalAnswers.univ_interest || []).slice(0, 2);

            // value_top: univ_priority (radio → 배열로 변환)
            const rawPriority = universalAnswers.univ_priority;
            const value_top = rawPriority
                ? (Array.isArray(rawPriority) ? rawPriority : [rawPriority]).filter(Boolean).slice(0, 2)
                : [];

            // strength_top: 전공 추천에는 직접적인 강점 질문이 없으므로
            // univ_good_subjects + univ_workstyle 조합으로 추론
            const SUBJECT_TO_STRENGTH = {
                'math': 'analytical', 'science': 'analytical',
                'art': 'creative', 'music': 'creative',
                'english': 'communication', 'korean': 'communication',
                'social': 'structured_execution', 'history': 'persistence',
            };
            const goodSubjects = universalAnswers.univ_good_subjects || [];
            const strengthSet = new Set();
            for (const subj of goodSubjects) {
                if (SUBJECT_TO_STRENGTH[subj]) strengthSet.add(SUBJECT_TO_STRENGTH[subj]);
            }
            // workstyle도 강점 힌트로 활용
            const ws = universalAnswers.univ_workstyle;
            if (ws === 'theory') strengthSet.add('analytical');
            if (ws === 'practice') strengthSet.add('fast_learning');
            if (ws === 'discuss') strengthSet.add('communication');
            const strength_top = Array.from(strengthSet).slice(0, 2);

            // constraint_flags: careerState.constraints에서 추출
            const constraint_flags = [];
            if (careerState.constraints) {
                for (const [type, data] of Object.entries(careerState.constraints)) {
                    if (data && data.has_constraint) {
                        constraint_flags.push(type + '_constraint');
                    }
                }
            }

            window.miniModuleResult = {
                interest_top,
                value_top,
                strength_top,
                constraint_flags,
                raw_selections: {
                    interest: universalAnswers.univ_interest || [],
                    value: value_top,
                    strength: strength_top,
                    constraint: constraint_flags,
                    good_subjects: goodSubjects,
                    workstyle: ws || null,
                }
            };
        }

        async function goToStep2WithLoading() {
            // 편집 모드: 변경 감지 → 이후 단계 초기화
            if (window.__editMode && detectStep1Changes()) {
                cascadeResetFromStep1();
            }

            // 관심사 + 전이신호 답변 수집
            collectUniversalAnswers();

            // ★ v3.24: miniModuleResult 구성 (직업 추천 updateIntegratedUniversalAnswers에 대응)
            buildMiniModuleResultMajor();

            // 세션 ID 생성
            currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);

            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();

            // V3 모드: 서술형 심층 질문 → 3라운드 인터뷰
            goToStep(2);
            renderNarrativeStepMajor();
        }

        // 전공 전이 신호 질문 정의 (updateChipOrder에서도 접근 필요하므로 상위 스코프)
        const MAJOR_SIGNAL_QUESTIONS = [
                { question_id: 'trans_desired_type', text: '전공 선택 후 어떤 준비를 하고 싶나요?', help: '최대 3개까지 선택 (선택 순서 = 우선순위)', ui_type: 'chips', max_selections: 3, options: [
                    { value: 'campus_life', label: '대학생활 계획', emoji: '🏫' },
                    { value: 'certification', label: '자격증/스펙 준비', emoji: '📜' },
                    { value: 'internship', label: '인턴/현장경험', emoji: '🏢' },
                    { value: 'study_abroad', label: '유학/교환학생', emoji: '🌍' },
                    { value: 'grad_school', label: '대학원 진학', emoji: '🎓' },
                    { value: 'employment', label: '취업 준비', emoji: '💼' },
                    { value: 'double_major', label: '복수전공/부전공', emoji: '📚' },
                    { value: 'club_activity', label: '동아리/대외활동', emoji: '🤝' },
                    { value: 'research', label: '학부 연구', emoji: '🔬' },
                    { value: 'startup', label: '창업/프로젝트', emoji: '🚀' },
                ], fact_key: 'transition.desired_type' },
                { question_id: 'trans_motivation', text: '전공을 고민하는 가장 큰 이유는 뭔가요?', help: '가장 중요한 이유 하나를 선택해주세요.', ui_type: 'radio', options: [
                    { value: 'find_aptitude', label: '내 적성을 찾고 싶어서', emoji: '🔍' },
                    { value: 'employment', label: '취업이 잘 되는 전공을 찾고 싶어서', emoji: '💼' },
                    { value: 'interest', label: '좋아하는 분야를 공부하고 싶어서', emoji: '❤️' },
                    { value: 'parents', label: '부모님/주변 추천이 있어서', emoji: '👨‍👩‍👧' },
                    { value: 'grades', label: '성적에 맞는 전공을 찾고 싶어서', emoji: '📊' },
                    { value: 'change', label: '현재 전공/진로가 안 맞아서', emoji: '🔄' },
                ], fact_key: 'transition.motivation_primary' },
                { question_id: 'trans_blockers', text: '전공 선택에서 가장 걱정되는 건 뭔가요?', help: '해당하는 걱정을 모두 선택해주세요.', ui_type: 'checkbox', options: [
                    { value: 'aptitude', label: '적성에 안 맞을까 봐', emoji: '😰' },
                    { value: 'employment', label: '취업이 안 될까 봐', emoji: '💼' },
                    { value: 'grades', label: '성적이 부족할까 봐', emoji: '📉' },
                    { value: 'info_lack', label: '전공 정보가 부족해서', emoji: '❓' },
                    { value: 'difficulty', label: '전공 공부가 어려울까 봐', emoji: '📚' },
                    { value: 'regret', label: '나중에 후회할까 봐', emoji: '😥' },
                    { value: 'family', label: '가족 의견과 달라서', emoji: '👨‍👩‍👧' },
                ], fact_key: 'transition.blocker' },
                { question_id: 'trans_timeline', text: '전공/진학 결정은 언제까지 해야 하나요?', help: '시간 여유에 따라 추천이 달라져요.', ui_type: 'radio', options: [
                    { value: '1m', label: '1개월 내', emoji: '🔥' },
                    { value: '3m', label: '3개월 내', emoji: '⚡' },
                    { value: '6m', label: '6개월 내', emoji: '📆' },
                    { value: '1y', label: '1년 내', emoji: '📅' },
                    { value: '2y', label: '2년 이상', emoji: '🗓️' },
                    { value: 'no_rush', label: '천천히 해도 돼요', emoji: '🐢' },
                ], fact_key: 'transition.timeline' },
                { question_id: 'trans_time_invest', text: '일주일에 전공 탐색에 투자할 수 있는 시간은?', help: '현실적으로 가능한 시간을 선택해주세요.', ui_type: 'radio', options: [
                    { value: '0', label: '거의 없어요', emoji: '😓' },
                    { value: '5', label: '5시간 이하', emoji: '⏱️' },
                    { value: '10', label: '5~10시간', emoji: '📖' },
                    { value: '20', label: '10~20시간', emoji: '💪' },
                    { value: '40', label: '20시간 이상', emoji: '🏃' },
                ], fact_key: 'transition.time_invest_hours_bucket' },
        ];

        // 전이 신호 렌더링 (전공 전용)
        function renderTransitionSignalForm() {
            const container = document.getElementById('transition-signal-form');
            if (!container) {
                return;
            }
            container.innerHTML = MAJOR_SIGNAL_QUESTIONS.map(q => {
                if (q.ui_type === 'chips') {
                    return \`
                        <div class="trans-question p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);" data-question-id="\${q.question_id}">
                            <h4 class="font-semibold mb-2 text-white">\${q.text}</h4>
                            <p class="text-xs mb-3" style="color: rgb(100,116,139)">최대 \${q.max_selections || 3}개까지 선택 (선택 순서 = 우선순위)</p>
                            <div class="flex flex-wrap gap-2">
                                \${q.options.map((opt, idx) => \`
                                    <button type="button" onclick="selectTransitionChip('\${q.question_id}', '\${opt.value}', this, \${q.max_selections || 3})"
                                            class="trans-chip group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                            data-value="\${opt.value}">
                                        <span class="flex items-center gap-2">
                                            <span class="text-lg">\${opt.emoji}</span>
                                            <span>\${opt.label}</span>
                                        </span>
                                        <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden chip-rank"></div>
                                    </button>
                                \`).join('')}
                            </div>
                            <div class="selected-order mt-3 text-sm hidden p-3 rounded-lg" style="background-color: rgba(16,185,129,0.1); color: #34d399;"></div>
                        </div>
                    \`;
                } else if (q.ui_type === 'radio') {
                    return \`
                        <div class="trans-question p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);" data-question-id="\${q.question_id}">
                            <h4 class="font-semibold mb-4 text-white">\${q.text}</h4>
                            <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
                                \${q.options.map(opt => \`
                                    <button type="button" onclick="selectTransitionRadio('\${q.question_id}', '\${opt.value}', this)"
                                            class="trans-radio group relative p-4 rounded-xl border text-left transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                            data-value="\${opt.value}">
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 radio-circle"
                                                 style="border-color: rgba(100,100,120,0.5);">
                                                <div class="w-2.5 h-2.5 rounded-full bg-emerald-500 hidden radio-dot"></div>
                                            </div>
                                            <span style="color: rgb(148,163,184)"><span class="mr-1">\${opt.emoji}</span>\${opt.label}</span>
                                        </div>
                                    </button>
                                \`).join('')}
                            </div>
                        </div>
                    \`;
                } else if (q.ui_type === 'checkbox') {
                    return \`
                        <div class="trans-question p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);" data-question-id="\${q.question_id}">
                            <h4 class="font-semibold mb-4 text-white">\${q.text}</h4>
                            <div class="flex flex-wrap gap-2">
                                \${q.options.map(opt => \`
                                    <button type="button" onclick="toggleTransitionCheckbox('\${q.question_id}', '\${opt.value}', this)"
                                            class="trans-checkbox group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                            data-value="\${opt.value}">
                                        <span class="flex items-center gap-2">
                                            <span class="text-lg">\${opt.emoji}</span>
                                            <span>\${opt.label}</span>
                                        </span>
                                        <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden chip-check">✓</div>
                                    </button>
                                \`).join('')}
                            </div>
                        </div>
                    \`;
                }
                return '';
            }).join('');
        }
        
        function selectTransitionChip(questionId, value, btnEl, maxSelections) {
            if (!transitionSignalAnswers[questionId]) transitionSignalAnswers[questionId] = [];
            const arr = transitionSignalAnswers[questionId];
            const idx = arr.indexOf(value);
            
            if (idx > -1) {
                arr.splice(idx, 1);
                btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                btnEl.style.color = 'rgb(148,163,184)';
                btnEl.querySelector('.chip-rank')?.classList.add('hidden');
                btnEl.querySelector('.chip-rank')?.classList.remove('flex');
            } else if (arr.length < maxSelections) {
                arr.push(value);
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                btnEl.style.borderColor = '#10b981';
                btnEl.style.color = '#34d399';
            }
            updateChipOrder(questionId);
        }
        
        function updateChipOrder(questionId) {
            const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
            if (!container) {
                return;
            }
            const orderEl = container.querySelector('.selected-order');
            if (!orderEl) {
                return;
            }
            const arr = transitionSignalAnswers[questionId] || [];
            
            // 모든 순위 배지 초기화
            container.querySelectorAll('.trans-chip').forEach(btn => {
                const rank = btn.querySelector('.chip-rank');
                if (rank) {
                    rank.classList.add('hidden');
                    rank.classList.remove('flex');
                }
            });
            
            if (arr.length > 0) {
                const q = MAJOR_SIGNAL_QUESTIONS.find(q => q.question_id === questionId) || TRANSITION_SIGNAL_QUESTIONS.find(q => q.question_id === questionId);
                const labels = arr.map((v, i) => {
                    const opt = q?.options.find(o => o.value === v);
                    const btn = container.querySelector(\`[data-value="\${v}"]\`);
                    if (btn) {
                        const rank = btn.querySelector('.chip-rank');
                        if (rank) {
                            rank.textContent = i + 1;
                            rank.classList.remove('hidden');
                            rank.classList.add('flex');
                        }
                    }
                    return \`\${i + 1}순위: \${opt?.label || v}\`;
                });
                orderEl.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>' + labels.join(' → ');
                orderEl.classList.remove('hidden');
            } else {
                orderEl.classList.add('hidden');
            }
        }
        
        function selectTransitionRadio(questionId, value, btnEl) {
            const isSelected = transitionSignalAnswers[questionId] === value;
            const container = btnEl.parentElement;
            
            container.querySelectorAll('.trans-radio').forEach(btn => {
                btn.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.querySelector('.radio-circle').style.borderColor = 'rgba(100,100,120,0.5)';
                btn.querySelector('.radio-dot')?.classList.add('hidden');
            });
            
            if (!isSelected) {
                transitionSignalAnswers[questionId] = value;
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                btnEl.style.borderColor = '#10b981';
                btnEl.querySelector('.radio-circle').style.borderColor = '#10b981';
                btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
            } else {
                delete transitionSignalAnswers[questionId];
            }
        }
        
        function toggleTransitionCheckbox(questionId, value, btnEl) {
            if (!transitionSignalAnswers[questionId]) transitionSignalAnswers[questionId] = [];
            const arr = transitionSignalAnswers[questionId];
            const idx = arr.indexOf(value);
            
            if (idx > -1) {
                arr.splice(idx, 1);
                btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                btnEl.style.color = 'rgb(148,163,184)';
                btnEl.querySelector('.chip-check')?.classList.add('hidden');
                btnEl.querySelector('.chip-check')?.classList.remove('flex');
            } else {
                arr.push(value);
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                btnEl.style.borderColor = '#10b981';
                btnEl.style.color = '#34d399';
                btnEl.querySelector('.chip-check')?.classList.remove('hidden');
                btnEl.querySelector('.chip-check')?.classList.add('flex');
            }
        }
        
        async function submitUniversalAndGoToTransition() {
            collectUniversalAnswers();

            // 편집 모드: Step 2 변경 감지 → 이후 단계 초기화
            if (window.__editMode && detectStep2Changes()) {
                cascadeResetFromStep2();
            }

            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();

            showLoading('답변 저장 중...', '전이 신호 질문을 준비하고 있어요');
            setTimeout(() => {
                try {
                    renderTransitionSignalForm();
                    goToStep(3);
                } catch (error) {
                } finally {
                    hideLoading();
                }
            }, 600);
        }
        
        async function submitTransitionAndContinue() {
            // 편집 모드: Step 3 변경 감지 → followup 초기화
            if (window.__editMode && detectStep3Changes()) {
                cascadeResetFromStep3();
            }

            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();

            showLoading('분석 중...', '맞춤 심층 질문을 구성하고 있어요');
            
            try {
                currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage || 'major_high',
                        career_state: careerState,
                        transition_signal: transitionSignalAnswers,
                        universal_answers: universalAnswers,
                        academic_state: window.academicState || undefined,
                        debug: DEBUG_MODE,
                        ...getEditModePayloadExtras(),
                    })
                });

                const data = await response.json();
                hideLoading();

                if (data.result?.followup_questions?.length > 0) {
                    renderFollowupQuestions(data.result.followup_questions);
                    goToStep(2);
                } else {
                    // 편집 모드: 분석 완료 → 결과 페이지로 이동
                    if (window.__editMode && data.request_id) {
                        fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(window.__editSessionId), {
                            method: 'DELETE', credentials: 'same-origin'
                        }).catch(() => {});
                        window.location.href = '/user/ai-results/' + data.request_id;
                        return;
                    }
                    currentRequestId = data.request_id;
                    displayResults(data);
                    saveDraftAsCompletedMajor();  // 결과 저장
                    goToStep(3);
                }
            } catch (error) {
                hideLoading();
                alert('오류가 발생했습니다: ' + error.message);
            }
        }
        
        // Universal Questions 렌더링 (Major용 - 고급 UI)
        function renderUniversalQuestions() {
            const container = document.getElementById('universal-questions');
            container.innerHTML = UNIVERSAL_QUESTIONS.map(q => {
                const requiredMark = q.required ? '<span class="text-red-400 ml-1">*</span>' : '';
                
                if (q.ui_type === 'chips') {
                    return \`
                        <div class="question-block p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);">
                            <label class="block text-lg font-semibold mb-4 text-white">\${q.text}\${requiredMark}</label>
                            <div class="flex flex-wrap gap-2" data-question-id="\${q.id}" data-max-selections="\${q.max_selections || 99}">
                                \${q.options.map(opt => \`
                                    <button type="button" onclick="toggleChipOptionMajor('\${q.id}', '\${opt.value}', this, false)"
                                            class="chip-option group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                            data-value="\${opt.value}">
                                        <span class="flex items-center gap-2">
                                            \${opt.emoji ? \`<span class="text-lg">\${opt.emoji}</span>\` : ''}
                                            <span>\${opt.label}</span>
                                        </span>
                                        <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden chip-check">✓</div>
                                    </button>
                                \`).join('')}
                                \${q.allow_unknown ? \`
                                    <button type="button" onclick="toggleChipOptionMajor('\${q.id}', '_unknown', this, true)"
                                            class="chip-option chip-unknown group relative px-4 py-2.5 rounded-xl border border-dashed transition-all duration-200"
                                            style="background-color: rgba(15,15,35,0.5); border-color: rgba(100,100,120,0.5); color: rgb(120,120,140);"
                                            data-value="_unknown">
                                        <span class="flex items-center gap-2">
                                            <span class="text-lg">❓</span>
                                            <span>\${q.unknown_label}</span>
                                        </span>
                                        <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-slate-500 text-white items-center justify-center text-xs font-bold hidden chip-check">✓</div>
                                    </button>
                                \` : ''}
                            </div>
                            \${q.max_selections ? \`<p class="text-xs mt-2" style="color: rgb(100,116,139)">최대 \${q.max_selections}개 선택 가능</p>\` : ''}
                    </div>
                    \`;
                } else if (q.ui_type === 'radio') {
                    return \`
                        <div class="question-block p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);">
                            <label class="block text-lg font-semibold mb-4 text-white">\${q.text}\${requiredMark}</label>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-3" data-question-id="\${q.id}">
                                \${q.options.map(opt => \`
                                    <button type="button" onclick="selectRadioOptionMajor('\${q.id}', '\${opt.value}', this, false)"
                                            class="radio-option group relative p-4 rounded-xl border text-left transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                            data-value="\${opt.value}">
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 radio-circle"
                                                 style="border-color: rgba(100,100,120,0.5);">
                                                <div class="w-2.5 h-2.5 rounded-full bg-emerald-500 hidden radio-dot"></div>
                </div>
                                            <span style="color: rgb(148,163,184)">\${opt.emoji || ''} \${opt.label}</span>
                                        </div>
                                    </button>
                                \`).join('')}
                                \${q.allow_unknown ? \`
                                    <button type="button" onclick="selectRadioOptionMajor('\${q.id}', '_unknown', this, true)"
                                            class="radio-option radio-unknown group relative p-4 rounded-xl border border-dashed text-left transition-all duration-200"
                                            style="background-color: rgba(15,15,35,0.5); border-color: rgba(100,100,120,0.5);"
                                            data-value="_unknown">
                                        <div class="flex items-center gap-3">
                                            <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 radio-circle"
                                                 style="border-color: rgba(100,100,120,0.5);">
                                                <div class="w-2.5 h-2.5 rounded-full bg-slate-500 hidden radio-dot"></div>
                                            </div>
                                            <span style="color: rgb(120,120,140)">❓ \${q.unknown_label}</span>
                                        </div>
                                    </button>
                                \` : ''}
                            </div>
                        </div>
                    \`;
                }
                return '';
            }).join('');
        }
        
        // 칩 옵션 토글 (Major용)
        function toggleChipOptionMajor(questionId, value, btnEl, isUnknown) {
            const container = btnEl.parentElement;
            const maxSelections = parseInt(container.dataset.maxSelections) || 99;
            const isSelected = btnEl.classList.contains('selected');
            
            if (isUnknown) {
                container.querySelectorAll('.chip-option').forEach(btn => {
                    btn.classList.remove('selected');
                    btn.style.backgroundColor = btn.classList.contains('chip-unknown') ? 'rgba(15,15,35,0.5)' : 'rgba(26,26,46,0.9)';
                    btn.style.borderColor = btn.classList.contains('chip-unknown') ? 'rgba(100,100,120,0.5)' : 'rgba(42,42,62,0.5)';
                    btn.style.color = btn.classList.contains('chip-unknown') ? 'rgb(120,120,140)' : 'rgb(148,163,184)';
                    btn.querySelector('.chip-check')?.classList.add('hidden');
                    btn.querySelector('.chip-check')?.classList.remove('flex');
                });
                
                if (!isSelected) {
                    btnEl.classList.add('selected');
                    btnEl.style.backgroundColor = 'rgba(100,116,139,0.3)';
                    btnEl.style.borderColor = '#64748b';
                    btnEl.style.borderStyle = 'solid';
                    btnEl.style.color = '#94a3b8';
                    btnEl.querySelector('.chip-check')?.classList.remove('hidden');
                    btnEl.querySelector('.chip-check')?.classList.add('flex');
                    
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.add('disabled-by-unknown');
                        btn.style.opacity = '0.3';
                        btn.style.pointerEvents = 'none';
                    });
                    universalAnswers[questionId] = ['_unknown'];
                } else {
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.remove('disabled-by-unknown');
                        btn.style.opacity = '1';
                        btn.style.pointerEvents = 'auto';
                    });
                    delete universalAnswers[questionId];
                }
            } else {
                const unknownBtn = container.querySelector('.chip-unknown');
                if (unknownBtn && unknownBtn.classList.contains('selected')) {
                    unknownBtn.classList.remove('selected');
                    unknownBtn.style.backgroundColor = 'rgba(15,15,35,0.5)';
                    unknownBtn.style.borderColor = 'rgba(100,100,120,0.5)';
                    unknownBtn.style.borderStyle = 'dashed';
                    unknownBtn.style.color = 'rgb(120,120,140)';
                    unknownBtn.querySelector('.chip-check')?.classList.add('hidden');
                    unknownBtn.querySelector('.chip-check')?.classList.remove('flex');
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.remove('disabled-by-unknown');
                        btn.style.opacity = '1';
                        btn.style.pointerEvents = 'auto';
                    });
                }
                
                if (!universalAnswers[questionId]) universalAnswers[questionId] = [];
                
                if (isSelected) {
                    btnEl.classList.remove('selected');
                    btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                    btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                    btnEl.style.color = 'rgb(148,163,184)';
                    btnEl.querySelector('.chip-check')?.classList.add('hidden');
                    btnEl.querySelector('.chip-check')?.classList.remove('flex');
                    const idx = universalAnswers[questionId].indexOf(value);
                    if (idx > -1) universalAnswers[questionId].splice(idx, 1);
                } else {
                    if (universalAnswers[questionId].length >= maxSelections) {
                        const firstSelected = container.querySelector('.chip-option.selected:not(.chip-unknown)');
                        if (firstSelected) {
                            firstSelected.classList.remove('selected');
                            firstSelected.style.backgroundColor = 'rgba(26,26,46,0.9)';
                            firstSelected.style.borderColor = 'rgba(42,42,62,0.5)';
                            firstSelected.style.color = 'rgb(148,163,184)';
                            firstSelected.querySelector('.chip-check')?.classList.add('hidden');
                            firstSelected.querySelector('.chip-check')?.classList.remove('flex');
                            const removeVal = firstSelected.dataset.value;
                            const removeIdx = universalAnswers[questionId].indexOf(removeVal);
                            if (removeIdx > -1) universalAnswers[questionId].splice(removeIdx, 1);
                        }
                    }
                    
                    btnEl.classList.add('selected');
                    btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                    btnEl.style.borderColor = '#10b981';
                    btnEl.style.color = '#34d399';
                    btnEl.querySelector('.chip-check')?.classList.remove('hidden');
                    btnEl.querySelector('.chip-check')?.classList.add('flex');
                    universalAnswers[questionId].push(value);
                }
            }
        }
        
        // 라디오 옵션 선택 (Major용)
        function selectRadioOptionMajor(questionId, value, btnEl, isUnknown) {
            const container = btnEl.parentElement;
            const isSelected = btnEl.classList.contains('selected');
            
            container.querySelectorAll('.radio-option').forEach(btn => {
                btn.classList.remove('selected');
                btn.style.backgroundColor = btn.classList.contains('radio-unknown') ? 'rgba(15,15,35,0.5)' : 'rgba(26,26,46,0.9)';
                btn.style.borderColor = btn.classList.contains('radio-unknown') ? 'rgba(100,100,120,0.5)' : 'rgba(42,42,62,0.5)';
                btn.querySelector('.radio-circle').style.borderColor = 'rgba(100,100,120,0.5)';
                btn.querySelector('.radio-dot')?.classList.add('hidden');
                btn.classList.remove('disabled-by-unknown');
                btn.style.opacity = '1';
                btn.style.pointerEvents = 'auto';
            });
            
            if (!isSelected) {
                btnEl.classList.add('selected');
                
                if (isUnknown) {
                    btnEl.style.backgroundColor = 'rgba(100,116,139,0.3)';
                    btnEl.style.borderColor = '#64748b';
                    btnEl.style.borderStyle = 'solid';
                    btnEl.querySelector('.radio-circle').style.borderColor = '#64748b';
                    btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
                    
                    container.querySelectorAll('.radio-option:not(.radio-unknown)').forEach(btn => {
                        btn.classList.add('disabled-by-unknown');
                        btn.style.opacity = '0.3';
                        btn.style.pointerEvents = 'none';
                    });
                    universalAnswers[questionId] = '_unknown';
                } else {
                    btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                    btnEl.style.borderColor = '#10b981';
                    btnEl.querySelector('.radio-circle').style.borderColor = '#10b981';
                    btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
                    universalAnswers[questionId] = value;
                }
            } else {
                delete universalAnswers[questionId];
            }
        }
        
        function collectUniversalAnswers() {
            // 이미 universalAnswers에 수집됨
        }
        
        function renderFollowupQuestions(questions) {
            const container = document.getElementById('followup-questions-form');
            container.innerHTML = questions.map((q, i) => \`
                <div class="followup-question p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);" data-question-id="followup_\${q.id || i}">
                    <div class="flex items-start gap-4 mb-4">
                        <span class="flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold" style="background: linear-gradient(135deg, #a855f7, #6366f1); color: white;">\${i + 1}</span>
                        <h4 class="font-semibold text-white text-lg leading-relaxed">\${q.question}</h4>
                    </div>
                    \${q.options ? \`
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3 ml-12">
                            \${q.options.map(opt => \`
                                <button type="button" onclick="selectFollowup('\${q.id || i}', '\${opt.value || opt}', this)"
                                        class="followup-option group relative p-4 rounded-xl border text-left transition-all duration-200"
                                        style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                        data-value="\${opt.value || opt}">
                                    <div class="flex items-center gap-3">
                                        <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 radio-circle"
                                             style="border-color: rgba(100,100,120,0.5);">
                                            <div class="w-2.5 h-2.5 rounded-full hidden radio-dot" style="background: linear-gradient(135deg, #a855f7, #6366f1);"></div>
                                        </div>
                                        <span style="color: rgb(148,163,184)">\${opt.label || opt}</span>
                                    </div>
                    </button>
                            \`).join('')}
                </div>
                    \` : \`
                        <div class="ml-12">
                            <textarea onchange="followupAnswers['\${q.id || i}'] = this.value" rows="3"
                                      class="w-full px-4 py-3 rounded-xl border transition-all resize-none"
                                      style="background-color: rgba(15,15,35,1); border-color: rgba(42,42,62,0.5); color: #fff;"
                                      onfocus="this.style.borderColor='rgba(168,85,247,0.5)';"
                                      onblur="this.style.borderColor='rgba(42,42,62,0.5)';"></textarea>
        </div>
                    \`}
    </div>
            \`).join('');
        }
        
        function selectFollowup(qid, value, btnEl) {
            const container = btnEl.closest('[data-question-id]');
            const isSelected = btnEl.classList.contains('selected');
            
            container.querySelectorAll('.followup-option').forEach(btn => {
                btn.classList.remove('selected');
                btn.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.querySelector('.radio-circle').style.borderColor = 'rgba(100,100,120,0.5)';
                btn.querySelector('.radio-dot')?.classList.add('hidden');
            });
            
            if (!isSelected) {
                followupAnswers[qid] = value;
                btnEl.classList.add('selected');
                btnEl.style.backgroundColor = 'rgba(168,85,247,0.2)';
                btnEl.style.borderColor = '#a855f7';
                btnEl.querySelector('.radio-circle').style.borderColor = '#a855f7';
                btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
            } else {
                delete followupAnswers[qid];
            }
        }
        
        // ============================================
        // V3: 서술형 심층 질문 + 3라운드 인터뷰 시스템 (전공 추천)
        // ============================================

        // V3: 전공 전용 서술형 질문 선택
        function getNarrativeQuestionsMajor() {
            // 전과/전공 변경이면 changer 질문, 나머지는 explore 질문
            const transStatus = careerState.transition_status;
            if (transStatus === 'major_change') {
                return {
                    question1: {
                        id: 'change_reason',
                        text: '전공이나 진로를 바꾸고 싶은 이유가 뭔가요?',
                        placeholder: '예: 처음엔 부모님 권유로 선택했는데, 공부할수록 저랑 안 맞는다는 생각이 들었어요...',
                        emoji: '🔄',
                        color: 'from-blue-500 to-cyan-500',
                        fact_key: 'narrative.change_reason',
                    },
                    question2: {
                        id: 'new_interest',
                        text: '새로 도전하고 싶은 분야가 있나요? 왜 끌리나요?',
                        placeholder: '예: 디자인 쪽이요. 뭔가 만들어내는 일을 할 때 시간 가는 줄 모르거든요...',
                        emoji: '🎯',
                        color: 'from-violet-500 to-purple-500',
                        fact_key: 'narrative.new_interest',
                    },
                };
            }
            return {
                question1: {
                    id: 'dream_future',
                    text: '어떤 일을 하는 사람이 되고 싶나요? 왜 그런가요?',
                    placeholder: '예: 사람들에게 영감을 주는 일을 하고 싶어요. 어릴 때 좋은 선생님을 만나서 제 인생이 바뀌었거든요...',
                    emoji: '🌟',
                    color: 'from-yellow-500 to-orange-500',
                    fact_key: 'narrative.dream_future',
                },
                question2: {
                    id: 'fun_experience',
                    text: '학교나 일상에서 가장 재미있었던 활동은 뭐였나요? 왜 재미있었나요?',
                    placeholder: '예: 팀 프로젝트에서 발표를 맡았을 때요. 제 아이디어가 팀원들에게 인정받는 느낌이 좋았어요...',
                    emoji: '✨',
                    color: 'from-pink-500 to-rose-500',
                    fact_key: 'narrative.fun_experience',
                },
            };
        }

        // V3: 서술형 심층 질문 렌더링 (전공 전용)
        function renderNarrativeStepMajor() {
            const container = document.getElementById('followup-questions-form');
            if (!container) return;

            const questions = window.savedNarrativeQuestions || getNarrativeQuestionsMajor();
            const q1 = questions.question1;
            const q2 = questions.question2;
            window.savedNarrativeQuestions = questions;

            const savedQ0 = window.narrativeFacts?.storyAnswer || window.narrativeFacts?.life_story || '';
            const savedQ1 = window.narrativeFacts?.question1Answer || window.narrativeFacts?.highAliveMoment || '';
            const savedQ2 = window.narrativeFacts?.question2Answer || window.narrativeFacts?.lostMoment || '';
            const savedQ3 = window.narrativeFacts?.existentialAnswer || '';

            const isMinor = ['major_child', 'major_elementary', 'major_middle'].includes(selectedStage);

            // 색상 파싱
            const parseGradient = (color) => {
                const colors = color.replace('from-', '').replace(' to-', ',').split(',');
                const colorMap = {
                    'yellow-500': '234,179,8', 'orange-500': '249,115,22', 'red-500': '239,68,68',
                    'pink-500': '236,72,153', 'rose-500': '244,63,94', 'rose-600': '225,29,72',
                    'violet-500': '139,92,246', 'purple-500': '168,85,247', 'purple-600': '147,51,234',
                    'indigo-500': '99,102,241', 'indigo-600': '79,70,229', 'blue-500': '59,130,246',
                    'blue-600': '37,99,235', 'cyan-500': '6,182,212', 'cyan-600': '8,145,178',
                    'teal-500': '20,184,166', 'emerald-500': '16,185,129', 'green-500': '34,197,94',
                    'amber-500': '245,158,11', 'slate-500': '100,116,139',
                };
                return colors.map(c => colorMap[c.trim()] || '139,92,246');
            };

            const q1Colors = parseGradient(q1.color);
            const q2Colors = parseGradient(q2.color);

            // 미성년(중학생 이하)은 간단한 질문만
            const minLenQ = isMinor ? 20 : 50;
            const minLenStory = isMinor ? 20 : 30;

            container.innerHTML = \`
                <!-- 격려 문구 -->
                <div class="bg-gradient-to-r from-emerald-500/10 to-teal-500/10 border border-emerald-500/20 rounded-xl p-4 mb-6">
                    <p class="text-emerald-300 text-sm">
                        <i class="fas fa-lightbulb mr-2"></i>
                        자세히 (구체적인 상황, 감정, 이유를 솔직하게) 작성할수록 AI가 더 정확한 전공 추천을 드릴 수 있어요.
                    </p>
                </div>

                <!-- 스토리 질문 -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(100,116,139,0.1), rgba(59,130,246,0.05)); border: 1px solid rgba(100,116,139,0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">📖</span>
                        간략하게 지금까지의 이야기를 들려주세요
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">학교생활, 관심 분야, 고민 등 배경을 간략히 적어주세요. AI가 맥락을 이해하는 데 도움이 돼요.</p>
                    <textarea
                        id="narrative_q0"
                        name="narrative_q0"
                        data-fact-key="narrative.life_story"
                        rows="4"
                        minlength="\${minLenStory}"
                        maxlength="5000"
                        placeholder="예: 고등학교 2학년인데 이과 쪽이 좋긴 한데 정확히 뭘 해야 할지 모르겠어요. 수학이랑 과학은 괜찮은데 생물은 별로..."
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[100px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(100,116,139,0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(100,116,139,0.6)';"
                        onblur="this.style.borderColor='rgba(100,116,139,0.3)';"
                        oninput="updateNarrativeCounterMajor(this, 5000);">\${savedQ0}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q0_hint" class="text-xs text-wiki-muted">최소 \${minLenStory}자 / 현재 \${savedQ0.length}자</span>
                        <span id="narrative_q0_counter" class="text-xs text-wiki-muted">\${savedQ0.length}자</span>
                    </div>
                </div>

                <!-- 동적 질문 1 -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${q1Colors[0]},0.1), rgba(\${q1Colors[1]},0.05)); border: 1px solid rgba(\${q1Colors[0]},0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">\${q1.emoji}</span>
                        \${q1.text}
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">구체적인 상황, 감정, 이유를 자유롭게 적어주세요</p>
                    <textarea
                        id="narrative_q1"
                        name="narrative_q1"
                        data-fact-key="\${q1.fact_key}"
                        data-question-id="\${q1.id}"
                        rows="5"
                        minlength="\${minLenQ}"
                        maxlength="10000"
                        placeholder="\${q1.placeholder}"
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[120px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(\${q1Colors[0]},0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(\${q1Colors[0]},0.6)';"
                        onblur="this.style.borderColor='rgba(\${q1Colors[0]},0.3)';"
                        oninput="updateNarrativeCounterMajor(this, 10000);">\${savedQ1}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q1_hint" class="text-xs text-wiki-muted">최소 \${minLenQ}자 / 현재 \${savedQ1.length}자</span>
                        <span id="narrative_q1_counter" class="text-xs text-wiki-muted">\${savedQ1.length}자</span>
                    </div>
                </div>

                <!-- 동적 질문 2 -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${q2Colors[0]},0.1), rgba(\${q2Colors[1]},0.05)); border: 1px solid rgba(\${q2Colors[0]},0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">\${q2.emoji}</span>
                        \${q2.text}
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">구체적인 상황, 감정, 이유를 자유롭게 적어주세요</p>
                    <textarea
                        id="narrative_q2"
                        name="narrative_q2"
                        data-fact-key="\${q2.fact_key}"
                        data-question-id="\${q2.id}"
                        rows="5"
                        minlength="\${minLenQ}"
                        maxlength="10000"
                        placeholder="\${q2.placeholder}"
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[120px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(\${q2Colors[0]},0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(\${q2Colors[0]},0.6)';"
                        onblur="this.style.borderColor='rgba(\${q2Colors[0]},0.3)';"
                        oninput="updateNarrativeCounterMajor(this, 10000);">\${savedQ2}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q2_hint" class="text-xs text-wiki-muted">최소 \${minLenQ}자 / 현재 \${savedQ2.length}자</span>
                        <span id="narrative_q2_counter" class="text-xs text-wiki-muted">\${savedQ2.length}자</span>
                    </div>
                </div>

                <!-- 실존적 가치 질문 -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(168,85,247,0.1), rgba(236,72,153,0.05)); border: 1px solid rgba(168,85,247,0.2);">
                    <label class="block text-lg font-semibold mb-3 text-white">
                        <span class="mr-2">\u{1F30C}</span>
                        마지막 7일
                    </label>
                    <div class="text-sm text-slate-300 mb-4 leading-relaxed space-y-2">
                        <p>오늘 밤 9시, 모든 방송과 휴대폰에 긴급 뉴스가 뜹니다.</p>
                        <p>정확히 7일 뒤 지구는 사라집니다. 생존 가능성은 없습니다.</p>
                        <p class="text-white font-medium pt-1">이 소식을 듣는 순간, 가장 먼저 떠올릴 행동은 무엇일 것 같나요?</p>
                        <p class="text-white font-medium">어디로 가고 싶고, 누구를 만나고 싶고, 무엇을 하고 싶을 것 같나요?</p>
                    </div>
                    <textarea
                        id="narrative_q3"
                        name="narrative_q3"
                        data-fact-key="narrative.existential_answer"
                        rows="4"
                        minlength="20"
                        maxlength="5000"
                        placeholder="가장 먼저 떠오르는 행동, 가고 싶은 곳, 만나고 싶은 사람을 자유롭게 적어주세요..."
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[100px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(168,85,247,0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(168,85,247,0.6)';"
                        onblur="this.style.borderColor='rgba(168,85,247,0.3)';"
                        oninput="updateNarrativeCounterMajor(this, 5000);">\${savedQ3}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q3_hint" class="text-xs text-wiki-muted">최소 20자 / 현재 \${savedQ3.length}자</span>
                        <span id="narrative_q3_counter" class="text-xs text-wiki-muted">\${savedQ3.length}자</span>
                    </div>
                </div>

                <div class="text-center text-xs text-wiki-muted/60 mt-6">
                    <i class="fas fa-shield-alt mr-1"></i>
                    입력하신 내용은 추천에만 사용되며, 외부에 공개되지 않습니다.
                </div>
            \`;

            // Step 2 제목 업데이트
            const step2Title = document.querySelector('#step2 h2');
            if (step2Title) {
                step2Title.innerHTML = '<i class="fas fa-comments text-wiki-primary mr-2"></i>심층 질문 기초';
            }
            const step2Subtitle = document.getElementById('step2-subtitle');
            if (step2Subtitle) {
                step2Subtitle.textContent = '당신의 이야기를 자유롭게 들려주세요';
            }

            // 버튼 업데이트
            const analyzeBtn = document.getElementById('analyze-btn');
            if (analyzeBtn) {
                analyzeBtn.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>다음';
                analyzeBtn.onclick = submitNarrativeAndContinueV3Major;
            }

            const step2PrevBtn = document.getElementById('step2-prev-btn');
            if (step2PrevBtn) {
                step2PrevBtn.onclick = () => {
                    collectNarrativeAnswersMajor();
                    goToStep(1);
                };
            }

            // 카운터 초기화
            setTimeout(() => {
                ['narrative_q0', 'narrative_q1', 'narrative_q2', 'narrative_q3'].forEach(id => {
                    const el = document.getElementById(id);
                    if (el && el.value) updateNarrativeCounterMajor(el, id === 'narrative_q0' || id === 'narrative_q3' ? 5000 : 10000);
                });
            }, 100);
        }

        // V3: 서술형 글자수 카운터
        function updateNarrativeCounterMajor(textarea, maxLength) {
            const counter = document.getElementById(textarea.id + '_counter');
            const hint = document.getElementById(textarea.id + '_hint');
            const current = textarea.value.length;
            const minLength = parseInt(textarea.minLength) || 30;

            if (counter) {
                counter.textContent = current.toLocaleString() + '자';
                if (current >= maxLength * 0.9) {
                    counter.style.color = current >= maxLength ? 'rgb(239, 68, 68)' : 'rgb(251, 146, 60)';
                } else if (current >= minLength) {
                    counter.style.color = 'rgb(74, 222, 128)';
                } else {
                    counter.style.color = 'rgb(148, 163, 184)';
                }
            }
            if (hint) {
                if (current >= minLength) {
                    hint.textContent = '✓ 최소 ' + minLength + '자 충족';
                    hint.style.color = 'rgb(74, 222, 128)';
                } else {
                    hint.textContent = '최소 ' + minLength + '자 / 현재 ' + current + '자';
                    hint.style.color = 'rgb(148, 163, 184)';
                }
            }
        }

        // V3: 서술형 답변 수집
        function collectNarrativeAnswersMajor() {
            const q0 = document.getElementById('narrative_q0');
            const q1 = document.getElementById('narrative_q1');
            const q2 = document.getElementById('narrative_q2');
            const q3 = document.getElementById('narrative_q3');

            if (q1 && q2) {
                window.narrativeFacts = {
                    storyAnswer: q0?.value?.trim() || '',
                    life_story: q0?.value?.trim() || '',
                    highAliveMoment: q1.value.trim(),
                    lostMoment: q2.value.trim(),
                    existentialAnswer: q3?.value?.trim() || '',
                    question1Answer: q1.value.trim(),
                    question2Answer: q2.value.trim(),
                    question1FactKey: q1.dataset.factKey,
                    question2FactKey: q2.dataset.factKey,
                    question1Id: q1.dataset.questionId,
                    question2Id: q2.dataset.questionId,
                };
            }
            return window.narrativeFacts || null;
        }

        // V3: 서술형 필수 검증
        function validateNarrativeRequiredMajor() {
            const isMinor = ['major_child', 'major_elementary', 'major_middle'].includes(selectedStage);
            const minLenQ = isMinor ? 20 : 50;
            const minLenStory = isMinor ? 20 : 30;

            const q0 = document.getElementById('narrative_q0');
            const q1 = document.getElementById('narrative_q1');
            const q2 = document.getElementById('narrative_q2');

            if (!q1 || !q2) return true;

            if (q0 && q0.value.trim().length < minLenStory) {
                q0.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q0.focus();
                alert('지금까지의 이야기를 ' + minLenStory + '자 이상 작성해주세요.');
                return false;
            }
            if (q1.value.trim().length < minLenQ) {
                q1.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q1.focus();
                alert('첫 번째 질문에 ' + minLenQ + '자 이상 작성해주세요.');
                return false;
            }
            if (q2.value.trim().length < minLenQ) {
                q2.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q2.focus();
                alert('두 번째 질문에 ' + minLenQ + '자 이상 작성해주세요.');
                return false;
            }

            const q3 = document.getElementById('narrative_q3');
            if (q3 && q3.value.trim().length > 0 && q3.value.trim().length < 20) {
                q3.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q3.focus();
                alert('마지막 질문에 20자 이상 작성해주세요.');
                return false;
            }

            return true;
        }

        // V3: 서술형 답변 서버 저장
        async function saveNarrativeFactsMajor(facts) {
            try {
                currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);

                const response = await fetch('/api/ai-analyzer/v3/narrative-facts', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        high_alive_moment: facts.highAliveMoment || facts.question1Answer || '',
                        lost_moment: facts.lostMoment || facts.question2Answer || '',
                        existential_answer: facts.existentialAnswer || undefined,
                    })
                });

                if (!response.ok) {
                    const errorText = await response.text();
                    if (errorText.includes('error code: 1031') || errorText.includes('no such table')) {
                        return true;
                    }
                    showErrorToastMajor('서술형 답변 저장 실패: ' + errorText.substring(0, 100));
                    return false;
                }

                const data = await response.json();
                if (!data.success) {
                    showErrorToastMajor('서술형 답변 저장 실패: ' + (data.detail || data.error || 'Unknown error'));
                    return false;
                }
                return true;
            } catch (error) {
                if (error.message && error.message.includes('JSON')) return true;
                showErrorToastMajor('서술형 답변 저장 중 오류: ' + (error.message || 'Network error'));
                return false;
            }
        }

        // V3: 에러 토스트
        function showErrorToastMajor(message) {
            const existingToast = document.querySelector('.v3-error-toast');
            if (existingToast) existingToast.remove();

            const toast = document.createElement('div');
            toast.className = 'v3-error-toast';
            toast.innerHTML = \`
                <div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%);
                            background: #ef4444; color: white; padding: 12px 20px; border-radius: 8px;
                            box-shadow: 0 4px 12px rgba(0,0,0,0.3); z-index: 10000; max-width: 90vw;
                            font-size: 14px; display: flex; align-items: center; gap: 8px;">
                    <i class="fas fa-exclamation-circle"></i>
                    <span>\${message}</span>
                    <button onclick="this.parentElement.parentElement.remove()"
                            style="margin-left: 8px; background: none; border: none; color: white; cursor: pointer;">✕</button>
                </div>
            \`;
            document.body.appendChild(toast);
            setTimeout(() => toast.remove(), 5000);
        }

        // V3: 서술형 제출 후 라운드 시작
        async function submitNarrativeAndContinueV3Major() {
            if (!validateNarrativeRequiredMajor()) return;

            const narrativeFacts = collectNarrativeAnswersMajor();

            if (window.__editMode && detectNarrativeChanges()) {
                cascadeResetFromNarrative();
            }
            if (narrativeFacts) {
                await saveNarrativeFactsMajor(narrativeFacts);
            }

            saveDraftToServer();

            await startV3RoundQuestionsMajor(1);
        }

        // V3: 라운드 질문 시작
        async function startV3RoundQuestionsMajor(roundNumber) {
            const roundMeta = {
                1: { title: '내면의 에너지 탐색', subtitle: '무엇이 당신을 움직이게 하나요?', emoji: '🔥', color: 'from-orange-500 to-red-500' },
                2: { title: '경계선 확인', subtitle: '무엇을 피하고 싶으신가요?', emoji: '🛡️', color: 'from-purple-500 to-indigo-500' },
                3: { title: '실행 계획 설계', subtitle: '어떻게 시작할 수 있을까요?', emoji: '🚀', color: 'from-emerald-500 to-teal-500' },
            };

            const meta = roundMeta[roundNumber];
            showLoading('질문 구성 중...', meta.subtitle);

            try {
                currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);

                const response = await fetch('/api/ai-analyzer/v3/round-questions', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        round_number: roundNumber,
                        narrative_facts: window.narrativeFacts,
                        previous_round_answers: window.roundAnswers,
                        universal_answers: universalAnswers,
                        career_state: careerState,
                        transition_signal: transitionSignalAnswers,
                    })
                });

                hideLoading();

                if (!response.ok) {
                    alert('질문 생성 중 서버 오류가 발생했습니다 (HTTP ' + response.status + ')\\n\\n잠시 후 다시 시도해주세요.');
                    return;
                }

                const data = await response.json();
                if (data.error) {
                    alert('질문 생성 중 오류: ' + (data.error || 'Unknown error'));
                    return;
                }

                const questions = data.questions || [];
                if (questions.length > 0) {
                    window.currentRound = roundNumber;
                    window.roundQuestions = questions;
                    renderV3RoundUIMajor(roundNumber, questions, meta);
                    document.querySelectorAll('.step-content').forEach(s => s.classList.add('hidden'));
                    document.getElementById('step2')?.classList.remove('hidden');
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                } else {
                    alert('질문을 생성하지 못했습니다. 페이지를 새로고침하고 다시 시도해주세요.');
                }
            } catch (error) {
                hideLoading();
                alert('질문 생성 중 오류: ' + (error.message || 'Network error'));
            }
        }

        // V3: 라운드 UI 렌더링
        function renderV3RoundUIMajor(roundNumber, questions, meta) {
            const container = document.getElementById('followup-questions-form');
            if (!container) return;

            container.innerHTML = \`
                <!-- 라운드 헤더 -->
                <div class="text-center mb-8">
                    <div class="inline-flex items-center gap-3 px-6 py-3 rounded-2xl mb-4" style="background: linear-gradient(135deg, rgba(249,115,22,0.15), rgba(234,88,12,0.1));">
                        <span class="text-3xl">\${meta.emoji}</span>
                        <div class="text-left">
                            <div class="text-lg font-bold text-white">\${meta.title}</div>
                            <div class="text-sm text-wiki-muted">\${meta.subtitle}</div>
                        </div>
                    </div>

                    <!-- 라운드 진행 표시 -->
                    <div class="flex items-center justify-center gap-3 mb-4">
                        \${[1, 2, 3].map(r => \`
                            <div class="flex items-center gap-2">
                                <div class="w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold transition-all \${r === roundNumber ? 'bg-gradient-to-r ' + meta.color + ' text-white scale-110' : r < roundNumber ? 'bg-emerald-500 text-white' : 'bg-wiki-card text-wiki-muted'}">
                                    \${r < roundNumber ? '✓' : r}
                                </div>
                                \${r < 3 ? '<div class="w-8 h-0.5 ' + (r < roundNumber ? 'bg-emerald-500' : 'bg-wiki-border') + '"></div>' : ''}
                            </div>
                        \`).join('')}
                    </div>
                    <div class="text-xs text-wiki-muted">Round \${roundNumber} / 3</div>
                </div>

                <!-- 질문들 -->
                <div class="space-y-6" id="v3-round-questions">
                    \${questions.map((q, idx) => \`
                        <div class="question-block p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(26,26,46,0.8), rgba(36,36,56,0.5)); border: 1px solid rgba(67,97,238,0.2);">
                            <label class="block text-lg font-semibold mb-3 text-white">
                                <span class="inline-flex items-center justify-center w-6 h-6 rounded-full bg-wiki-primary/20 text-wiki-primary text-sm mr-2">\${idx + 1}</span>
                                \${q.questionText}
                            </label>
                            <textarea
                                id="v3_q_\${q.id}"
                                name="\${q.id}"
                                rows="4"
                                minlength="\${q.minLengthGuidance || 30}"
                                placeholder="자유롭게 적어주세요..."
                                class="w-full px-4 py-3 rounded-xl border transition-all resize-none"
                                style="background-color: rgba(15,15,35,1); border-color: rgba(67,97,238,0.3); color: #fff;"
                                onfocus="this.style.borderColor='rgba(67,97,238,0.6)';"
                                onblur="this.style.borderColor='rgba(67,97,238,0.3)';"
                                oninput="updateV3CounterMajor(this)"></textarea>
                            <div class="flex justify-between items-center mt-2">
                                <span class="text-xs text-wiki-muted">최소 \${q.minLengthGuidance || 30}자</span>
                                <span id="v3_q_\${q.id}_counter" class="text-xs text-wiki-muted">0자</span>
                            </div>
                        </div>
                    \`).join('')}
                </div>
            \`;

            // Step 2 제목 업데이트
            const step2Title = document.querySelector('#step2 h2');
            if (step2Title) {
                step2Title.innerHTML = \`<i class="fas fa-comments text-wiki-primary mr-2"></i>심층 질문 Round \${roundNumber}\`;
            }
            const step2Subtitle = document.getElementById('step2-subtitle');
            if (step2Subtitle) {
                const subtitleText = roundNumber === 1
                    ? '당신의 답변을 바탕으로 맞춤 질문을 준비했어요'
                    : roundNumber === 2
                    ? '더 깊이 있는 이해를 위한 질문이에요'
                    : '마지막으로 몇 가지만 더 여쭤볼게요';
                step2Subtitle.textContent = subtitleText;
            }

            // 버튼 업데이트
            const analyzeBtn = document.getElementById('analyze-btn');
            if (analyzeBtn) {
                if (roundNumber < 3) {
                    analyzeBtn.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>다음 라운드';
                    analyzeBtn.onclick = () => submitV3RoundAndContinueMajor(roundNumber, questions);
                } else {
                    analyzeBtn.innerHTML = '<i class="fas fa-magic mr-2"></i>AI 전공 추천 받기';
                    analyzeBtn.onclick = () => submitV3RoundAndAnalyzeMajor(questions);
                }
            }

            // 이전 버튼 동작
            const step2PrevBtn = document.getElementById('step2-prev-btn');
            if (step2PrevBtn) {
                step2PrevBtn.onclick = () => {
                    if (roundNumber === 1) {
                        showPrevWarningModalMajor(() => {
                            renderNarrativeStepMajor();
                        });
                    } else {
                        startV3RoundQuestionsMajor(roundNumber - 1);
                    }
                };
            }
        }

        // V3: 글자수 카운터
        function updateV3CounterMajor(textarea) {
            const counter = document.getElementById(textarea.id + '_counter');
            if (counter) {
                counter.textContent = textarea.value.length + '자';
                counter.style.color = textarea.value.length >= (parseInt(textarea.minLength) || 30) ? 'rgb(74, 222, 128)' : 'rgb(148,163,184)';
            }
        }

        // V3: 이전 버튼 경고 모달
        function showPrevWarningModalMajor(onConfirm) {
            const existingModal = document.getElementById('prev-warning-modal');
            if (existingModal) existingModal.remove();

            const modal = document.createElement('div');
            modal.id = 'prev-warning-modal';
            modal.className = 'fixed inset-0 z-50 flex items-center justify-center p-4';
            modal.style.backgroundColor = 'rgba(0,0,0,0.7)';
            modal.innerHTML = \`
                <div class="bg-wiki-card rounded-2xl p-6 max-w-md w-full border border-wiki-border shadow-2xl">
                    <div class="text-center mb-4">
                        <div class="w-14 h-14 mx-auto mb-3 rounded-full bg-yellow-500/20 flex items-center justify-center">
                            <i class="fas fa-exclamation-triangle text-2xl text-yellow-400"></i>
                        </div>
                        <h3 class="text-lg font-bold text-white mb-2">이전 단계로 돌아가시겠습니까?</h3>
                        <p class="text-wiki-muted text-sm">이전 단계의 내용을 수정하면 심층 질문이 새로 생성될 수 있습니다.</p>
                        <p class="text-yellow-400 text-sm mt-2"><i class="fas fa-info-circle mr-1"></i>기존 답변이 초기화될 수 있습니다.</p>
                    </div>
                    <div class="flex gap-3">
                        <button id="prev-warning-cancel" class="flex-1 px-4 py-3 bg-wiki-bg border border-wiki-border rounded-xl text-white hover:bg-wiki-card transition">
                            취소
                        </button>
                        <button id="prev-warning-confirm" class="flex-1 px-4 py-3 bg-yellow-600 hover:bg-yellow-500 rounded-xl text-white font-medium transition">
                            이전으로 돌아가기
                        </button>
                    </div>
                </div>
            \`;

            document.body.appendChild(modal);

            document.getElementById('prev-warning-cancel').onclick = () => modal.remove();
            document.getElementById('prev-warning-confirm').onclick = () => {
                modal.remove();
                window.currentRound = 0;
                window.roundQuestions = null;
                window.roundAnswers = [];
                onConfirm();
            };
        }

        // V3: 라운드 답변 수집
        function collectV3RoundAnswersMajor(questions) {
            return questions.map(q => {
                const textarea = document.getElementById('v3_q_' + q.id);
                return {
                    question_id: q.id,
                    question_text: q.questionText,
                    purpose_tag: q.purposeTag,
                    answer: textarea ? textarea.value.trim() : '',
                };
            });
        }

        // V3: 답변 검증
        function validateV3AnswersMajor(answers, questions) {
            for (let i = 0; i < answers.length; i++) {
                const minLen = questions[i].minLengthGuidance || 30;
                if (answers[i].answer.length < minLen) {
                    const textarea = document.getElementById('v3_q_' + questions[i].id);
                    if (textarea) {
                        textarea.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                        textarea.focus();
                    }
                    alert('질문 ' + (i + 1) + '에 ' + minLen + '자 이상 작성해주세요.');
                    return false;
                }
            }
            return true;
        }

        // V3: 라운드 답변 저장
        async function saveV3RoundAnswersMajor(roundNumber, answers) {
            for (const ans of answers) {
                window.roundAnswers.push({
                    questionId: ans.question_id,
                    questionText: ans.question_text,
                    roundNumber: roundNumber,
                    answer: ans.answer,
                    answeredAt: new Date().toISOString(),
                });
            }

            try {
                // 30초 타임아웃 — 서버가 응답하지 않으면 중단하고 계속 진행
                const controller = new AbortController();
                const timeoutId = setTimeout(() => controller.abort(), 30000);

                const response = await fetch('/api/ai-analyzer/v3/round-answers', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        round_number: roundNumber,
                        answers: answers,
                    }),
                    signal: controller.signal,
                });
                clearTimeout(timeoutId);

                if (!response.ok) {
                    showErrorToastMajor('라운드 ' + roundNumber + ' 답변 저장 실패 (HTTP ' + response.status + ')');
                    return false;
                }

                const data = await response.json();
                if (!data.success) {
                    showErrorToastMajor('라운드 ' + roundNumber + ' 답변 저장 실패: ' + (data.detail || data.error || 'Unknown error'));
                    return false;
                }
                return true;
            } catch (error) {
                if (error.name === 'AbortError') {
                    console.warn('Round ' + roundNumber + ' 답변 저장 타임아웃 — 분석 단계로 계속 진행');
                    return true; // 타임아웃이어도 서버에서는 DB 저장 완료됐을 가능성 높음
                }
                showErrorToastMajor('라운드 ' + roundNumber + ' 답변 저장 중 오류: ' + (error.message || 'Network error'));
                return false;
            }
        }

        // V3: 라운드 답변 제출 후 다음 라운드
        async function submitV3RoundAndContinueMajor(currentRound, questions) {
            const answers = collectV3RoundAnswersMajor(questions);
            if (!validateV3AnswersMajor(answers, questions)) return;

            if (window.__editMode && detectRoundChanges(currentRound)) {
                cascadeResetFromRound(currentRound);
            }

            showLoading('답변 저장 중...', '다음 라운드를 준비하고 있어요');

            try {
                await saveV3RoundAnswersMajor(currentRound, answers);
                await startV3RoundQuestionsMajor(currentRound + 1);
            } finally {
                hideLoading();
            }
        }

        // 전공 추천용 searchProfile 빌드
        function buildSearchProfileForMajor() {
            const miniModule = window.miniModuleResult || {};
            const interests = universalAnswers.univ_interest || [];
            return {
                desiredThemes: [
                    ...(miniModule.interest_top || []),
                    ...(miniModule.value_top || []),
                    ...interests,
                ].filter(Boolean),
                dislikedThemes: universalAnswers.univ_dislike || [],
                strengthsHypothesis: miniModule.strength_top || [],
                environmentPreferences: [],
                hardConstraints: miniModule.constraint_flags || [],
                riskSignals: [],
                keywords: [
                    ...(miniModule.interest_top || []),
                    ...interests,
                ].filter(Boolean),
            };
        }

        // V3: 마지막 라운드 후 분석 시작
        async function submitV3RoundAndAnalyzeMajor(questions) {
            const answers = collectV3RoundAnswersMajor(questions);
            if (!validateV3AnswersMajor(answers, questions)) return;

            // 3분 글로벌 타임아웃 안전장치
            var globalTimeout = setTimeout(function() {
                hideLoading();
                alert('요청 시간이 초과되었습니다 (3분). 페이지를 새로고침 후 다시 시도해주세요.');
            }, 180000);

            // skeleton 모드를 처음부터 사용 — progress bar 리셋 방지
            showLoading('AI가 분석 중...', '최적의 전공을 찾고 있어요', true);
            await saveV3RoundAnswersMajor(3, answers);

            try {
                // 150초 타임아웃 — recommend-major 엔드포인트 hang 방지
                var analyzeController = new AbortController();
                var analyzeTimeout = setTimeout(function() { analyzeController.abort(); }, 150000);

                const response = await fetch('/api/ai-analyzer/v3/recommend-major', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        searchProfile: buildSearchProfileForMajor(),
                        mini_module_result: window.miniModuleResult || {},
                        academic_state: window.academicState || undefined,
                        topK: 600,
                        judgeTopN: 15,
                        skipReport: false,
                        debug: DEBUG_MODE,
                    }),
                    signal: analyzeController.signal,
                });
                clearTimeout(analyzeTimeout);

                const recData = await response.json();

                if (!recData.success) {
                    throw new Error(recData.error || '전공 추천 결과를 생성할 수 없습니다.');
                }

                // displayResults가 기대하는 형식으로 변환
                const data = {
                    result: {
                        recommendations: recData.recommendations,
                        premium_report: recData.premium_report,
                        engine_version: recData.engine_version || 'v3',
                    },
                    request_id: recData.request_id,
                };

                if (window.__editMode && data.request_id) {
                    hideLoading();
                    clearTimeout(globalTimeout);
                    fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(window.__editSessionId), {
                        method: 'DELETE', credentials: 'same-origin'
                    }).catch(() => {});
                    window.location.href = '/user/ai-results/' + data.request_id;
                    return;
                }

                currentRequestId = data.request_id;
                displayResults(data);
                saveDraftAsCompletedMajor();
                hideSkeletonLoading();
            } catch (error) {
                hideLoading();
                if (error.name === 'AbortError') {
                    alert('분석 시간이 초과되었습니다 (2분 30초). 잠시 후 다시 시도해주세요.');
                } else {
                    alert('분석 중 오류가 발생했습니다: ' + error.message);
                }
            } finally {
                clearTimeout(globalTimeout);
            }
        }

        async function submitFollowupsAndAnalyze() {
            showLoading('AI가 분석 중...', '최적의 전공을 찾고 있어요', true);

            try {
                const response = await fetch('/api/ai-analyzer/v3/recommend-major', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        searchProfile: buildSearchProfileForMajor(),
                        mini_module_result: window.miniModuleResult || {},
                        academic_state: window.academicState || undefined,
                        topK: 600,
                        judgeTopN: 15,
                        skipReport: false,
                        debug: DEBUG_MODE,
                    })
                });

                const recData = await response.json();

                if (!recData.success) {
                    throw new Error(recData.error || '전공 추천 결과를 생성할 수 없습니다.');
                }

                const data = {
                    result: {
                        recommendations: recData.recommendations,
                        premium_report: recData.premium_report,
                        engine_version: recData.engine_version || 'v3',
                    },
                    request_id: recData.request_id,
                };

                // 편집 모드: 분석 완료 → 결과 페이지로 이동
                if (window.__editMode && data.request_id) {
                    hideLoading();
                    fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(window.__editSessionId), {
                        method: 'DELETE', credentials: 'same-origin'
                    }).catch(() => {});
                    window.location.href = '/user/ai-results/' + data.request_id;
                    return;
                }

                currentRequestId = data.request_id;
                displayResults(data);
                saveDraftAsCompletedMajor();
                hideSkeletonLoading();
            } catch (error) {
                hideLoading();
                alert('오류가 발생했습니다: ' + error.message);
            }
        }
        
        function displayResults(data) {
            const result = data.result || data;

            // V3 프리미엄 리포트가 있으면 4탭 UI 표시
            if (result.premium_report) {
                displayPremiumReportV3Major(result);
                return;
            }

            const container = document.getElementById('major-results');

            // Confidence UI 표시
            displayConfidenceUI(result);

            // 추천 전공 배열 추출 (라이브 응답 vs 저장된 결과 둘 다 처리)
            let majors = [];
            if (result.recommendations && result.recommendations.top_majors) {
                majors = result.recommendations.top_majors;
            } else if (result.fit_top_majors) {
                majors = result.fit_top_majors;
            } else if (Array.isArray(result.recommendations)) {
                majors = result.recommendations;
            }

            if (!majors || majors.length === 0) {
                container.innerHTML = '<p class="text-center text-wiki-muted">추천 결과가 없습니다. 다시 시도해주세요.</p>';
                return;
            }

            container.innerHTML = majors.map((rec, i) => \`
                <a href="/major/\${rec.slug || rec.major_id || rec.id || encodeURIComponent(rec.major_name || rec.name)}" class="block p-4 bg-wiki-bg rounded-lg border border-wiki-border hover:border-wiki-primary transition group \${i === 0 ? 'border-wiki-primary ring-2 ring-wiki-primary/20' : ''}">
                    \${rec.image_url ? \`
                        <div class="mb-3 overflow-hidden rounded-lg">
                            <img src="\${rec.image_url}" alt="\${rec.major_name || rec.name}" class="w-full h-32 object-cover group-hover:scale-105 transition-transform" />
                        </div>
                    \` : ''}
                    <div class="flex items-center gap-3 mb-2">
                        <span class="text-2xl font-bold text-wiki-primary">#\${i + 1}</span>
                        <h3 class="text-lg font-bold group-hover:text-wiki-primary transition">\${rec.major_name || rec.name || '추천 전공'}</h3>
                    </div>
                    <p class="text-wiki-muted text-sm mb-2">\${rec.reason || rec.match_reason || ''}</p>
                    \${rec.fit_score ? \`<div class="text-sm text-wiki-secondary">적합도: \${Math.round(rec.fit_score)}점</div>\` : ''}
                    \${rec.field_category ? \`<div class="text-xs text-wiki-muted mt-1">\${rec.field_category}</div>\` : ''}
                    <div class="text-xs text-wiki-primary mt-2 opacity-0 group-hover:opacity-100 transition">자세히 보기 →</div>
                </a>
            \`).join('');
        }
        

        // ============================================
// V3 Premium Report - Major (전공) Analyzer
// ============================================

function addReportStylesMajor() {
    if (document.getElementById('report-v3-styles-major')) return;

    const style = document.createElement('style');
    style.id = 'report-v3-styles-major';
    style.textContent = \`
        .report-tab {
            background-color: rgba(26,26,46,0.5);
            color: rgb(148,163,184);
        }
        .report-tab:hover {
            background-color: rgba(42,42,62,0.5);
        }
        .report-tab.active {
            background: linear-gradient(135deg, rgba(99,102,241,0.3), rgba(168,85,247,0.2));
            color: white;
            border: 1px solid rgba(99,102,241,0.5);
        }
        .major-set-tab {
            background: linear-gradient(135deg, rgba(26,26,46,0.7), rgba(42,42,62,0.5));
            color: rgb(148,163,184);
            border: 1px solid rgba(148,163,184,0.15);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .major-set-tab:hover {
            background: linear-gradient(135deg, rgba(42,42,62,0.8), rgba(62,62,82,0.6));
            color: rgb(200,210,220);
            border-color: rgba(148,163,184,0.3);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .major-set-tab.active {
            background: linear-gradient(135deg, rgba(99,102,241,0.4), rgba(168,85,247,0.25));
            color: white;
            border: 1px solid rgba(99,102,241,0.5);
            box-shadow: 0 4px 16px rgba(99,102,241,0.25);
        }
    \`;
    document.head.appendChild(style);
}

// ── 한국어 번역 레이블 (전공 리포트용) ──
const STAGE_LABELS_M = {
    job_explore: '탐색 단계', job_student: '학생 단계', job_prepare: '취업 준비',
    job_early: '초기 커리어 (0~3년)', job_mid: '경력자 (3년+)',
    job_transition: '전환/복귀', job_second: '세컨드 커리어',
    major_child: '어린이', major_elementary: '초등학생', major_middle: '중학생',
    major_high: '고등학생', major_freshman: '대학 신입생',
    major_student: '대학 재학생', major_graduate: '대학원 준비',
};
const VALUE_LABELS_M = {
    recognition: '인정받고 영향력 발휘', stability: '안정성', income: '높은 수입',
    growth: '성장', autonomy: '자율성', meaning: '의미/사회 기여',
    wlb: '워라밸', balance: '일과 삶의 균형', expertise: '전문성', creativity: '창의성',
};
const WORKSTYLE_LABELS_M = {
    solo: '혼자 집중', solo_deep: '혼자 깊이 집중', team: '팀 협업',
    team_harmony: '팀 조화', mixed: '상황에 따라', structured: '체계적 환경', flexible: '자유로운 환경',
};
const INTEREST_LABELS_M = {
    problem_solving: '문제 해결', data_numbers: '데이터/숫자', tech: '기술/IT',
    creative: '창작/예술', people: '사람/소통', helping: '돌봄/봉사', helping_teaching: '교육/봉사',
    business: '비즈니스/경영', nature: '자연/환경', physical: '신체 활동',
    research: '연구/탐구', teaching: '교육/가르침', analysis: '분석',
    design: '디자인', writing: '글쓰기', hands_on: '손으로 만들기',
    creating: '창작 활동', organizing: '조직/관리', influencing: '영향력 발휘',
};
const STRENGTH_LABELS_M = {
    analytical: '분석력', creative: '창의력', communication: '소통력',
    structured_execution: '실행력', persistence: '끈기', fast_learning: '학습력',
    leadership: '리더십', detail_oriented: '꼼꼼함', patience: '인내심',
    empathy: '공감 능력', organization: '체계적 정리', adaptability: '적응력',
    perseverance: '끈기', creativity: '창의성', strategic: '전략적 사고',
    teamwork: '팀워크', independence: '독립적 업무',
};
const DRAIN_LABELS_M = {
    people_drain: '대인관계 스트레스', cognitive_drain: '인지 피로',
    time_pressure_drain: '시간 압박 스트레스', responsibility_drain: '책임 스트레스',
    repetition_drain: '반복 피로', unpredictability_drain: '불확실성 스트레스',
    routine_drain: '반복 업무 피로', bureaucracy_drain: '관료주의 스트레스',
    pressure_drain: '마감 압박', conflict_drain: '갈등 상황',
    isolation_drain: '고립된 환경', physical_drain: '신체적 피로', uncertainty_drain: '불확실성',
};
const SACRIFICE_LABELS_M = {
    low_initial_income: '낮은 초봉 감수', willing_to_study: '재학습 감수',
    field_change_ok: '분야 전환 감수', ignore_social_pressure: '주변 시선 감수',
    no_sacrifice: '포기 불가', unstable_hours: '불규칙한 시간 감수',
    long_hours_ok: '긴 근무시간 감수', long_hours: '긴 근무시간',
    relocation: '거주지 이동', unstable_early: '초기 불안정 감수',
};
const CONSTRAINT_LABELS_M = {
    time_constraint: '시간 제약', income_constraint: '수입 조건',
    location_constraint: '위치 제약', physical_constraint: '체력 제약',
    qualification_constraint: '자격 제약', uncertainty_constraint: '불확실성 회피',
    health_constraint: '건강 제약', math_impossible: '수학 불가',
    low_employment_avoid: '낮은 취업률 회피',
    work_hours_strict: '불규칙한 근무시간', no_travel: '출장 불가',
    no_overtime: '야근 불가', remote_only: '재택만 가능',
    remote_preferred: '재택 선호', prefer_remote: '재택 선호',
};

function escapeTemplateStringM(str) {
    if (!str) return str;
    const backtick = String.fromCharCode(96);
    return String(str).replace(/\\$/g, '&#36;').replace(new RegExp(backtick, 'g'), '&#96;');
}

function translateToKorean(text) {
    if (!text) return text;
    let result = String(text);
    const ALL_LABELS = {
        ...STAGE_LABELS_M, ...VALUE_LABELS_M, ...WORKSTYLE_LABELS_M,
        ...INTEREST_LABELS_M, ...STRENGTH_LABELS_M, ...DRAIN_LABELS_M,
        ...SACRIFICE_LABELS_M, ...CONSTRAINT_LABELS_M,
    };
    if (ALL_LABELS[result]) return ALL_LABELS[result];
    const sortedEntries = Object.entries(ALL_LABELS).sort((a, b) => b[0].length - a[0].length);
    for (const [eng, kor] of sortedEntries) {
        result = result.replace(new RegExp(eng.replace(/_/g, '[_\\\\s]?'), 'gi'), kor);
    }
    return escapeTemplateStringM(result);
}

function displayPremiumReportV3Major(result) {
    // 결과 단계: step indicator와 페이지 타이틀 숨김
    const stepIndicator = document.getElementById('step-indicator');
    if (stepIndicator) stepIndicator.style.display = 'none';
    const pageTitle = document.querySelector('h1.text-3xl');
    if (pageTitle) pageTitle.style.display = 'none';
    const accountBanner = document.getElementById('account-warning-banner');
    if (accountBanner) accountBanner.style.display = 'none';

    const report = result.premium_report || {};

    // PremiumReport 타입 데이터 매핑
    const summary = {
        headline: report.executiveSummary || report.summary_one_page?.headline || '',
        top_takeaways: report.lifeVersionStatement?.expanded || report.summary_one_page?.top_takeaways || [],
        recommended_next_step: report.studyGuidance?.doNow?.[0] || report.summary_one_page?.recommended_next_step || '',
    };

    const mm = window.miniModuleResult || {};

    // learningStyleNarrative 텍스트 정리 함수
    function cleanLearningStyleNarrative(text) {
        if (!text) return null;
        let cleaned = text;
        cleaned = cleaned.replace(/\\([^)]*(?:Top2|선호|강점)[^)]*\\)/g, '');
        const parts = cleaned.split('당신은');
        if (parts.length > 2) {
            cleaned = parts[0] + '당신은' + parts.slice(1).join('');
        }
        cleaned = cleaned.replace(/\\s+/g, ' ').trim();
        return cleaned;
    }

    const personal = {
        personality_summary: cleanLearningStyleNarrative(report.learningStyleNarrative) ||
            (report.lifeVersionStatement?.oneLiner) ||
            (mm.interest_top?.length ? generatePersonalitySummaryMajor(mm) : null),
        work_style_insights: [
            report.learningStyleMap?.solo_vs_collaborative ? \`\${translateToKorean(report.learningStyleMap.solo_vs_collaborative > 0 ? '협업학습' : '독립학습')} 학습 스타일을 선호합니다\` : null,
            report.learningStyleMap?.structured_vs_exploratory ? \`학습 시 \${translateToKorean(report.learningStyleMap.structured_vs_exploratory > 0 ? '탐구적' : '체계적')} 접근을 취합니다\` : null,
            report.growthCurveDescription || null,
            ...(report.personal_analysis?.work_style_insights || []),
        ].filter(Boolean),
        value_priorities: mm.value_top?.map(v => translateToKorean(v)) ||
            report.personal_analysis?.value_priorities || [],
        potential_challenges: [
            ...(report.stressTriggers || []),
            ...(report.conflictPatterns || []),
            ...(report.personal_analysis?.potential_challenges || []),
        ].slice(0, 3),
        blind_spots_to_check: report.failurePattern ? [report.failurePattern] :
            (report.personal_analysis?.blind_spots_to_check || []),
    };

    // 한국어 받침 판별
    function hasBatchim(word) {
        if (!word || word.length === 0) return false;
        const last = word.charCodeAt(word.length - 1);
        if (last >= 0xAC00 && last <= 0xD7A3) return (last - 0xAC00) % 28 !== 0;
        if (last >= 0x30 && last <= 0x39) return [0, 1, 3, 6, 7, 8].includes(last - 0x30);
        return false;
    }

    // 성격 요약 생성 헬퍼
    function generatePersonalitySummaryMajor(mm) {
        const parts = [];
        if (mm.interest_top?.length) {
            const items = mm.interest_top.map(t => translateToKorean(t));
            const joined = items.length > 1 ? items.slice(0, -1).join(', ') + (hasBatchim(items[items.length - 2]) ? '과 ' : '와 ') + items[items.length - 1] : items[0];
            parts.push(\`\${joined}에 관심을 가지고 있으며\`);
        }
        if (mm.value_top?.length) {
            const items = mm.value_top.map(t => translateToKorean(t));
            const lastItem = items[items.length - 1];
            const joined = items.length > 1 ? items.slice(0, -1).join(', ') + (hasBatchim(items[items.length - 2]) ? '과 ' : '와 ') + lastItem : lastItem;
            const particle = hasBatchim(lastItem) ? '을' : '를';
            parts.push(\`\${joined}\${particle} 중요하게 여기는\`);
        }
        if (mm.strength_top?.length) {
            const items = mm.strength_top.map(t => translateToKorean(t));
            parts.push(\`\${items.join(', ')}에서 강점을 보이는\`);
        }
        if (parts.length === 0) return null;
        return parts.join(' ') + ' 분입니다.';
    }

    // V3 심리 분석 데이터 매핑
    const innerConflict = {
        analysis: report.innerConflictAnalysis || '',
        patterns: report.conflictPatterns || [],
    };
    const growthCurve = {
        type: report.growthCurveType || '',
        description: report.growthCurveDescription || '',
    };
    const stressProfile = {
        profile: report.stressProfile || '',
        triggers: report.stressTriggers || [],
        failurePattern: report.failurePattern || '',
    };
    const profileInterpretation = report.profileInterpretation || null;

    // 학기별 로드맵
    const academicTimeline = report.academicTimeline || {
        semester1: { goal: '', actions: [], milestone: '' },
        semester2: { goal: '', actions: [], milestone: '' },
        semester3_4: { goal: '', actions: [], milestone: '' },
        beyond: { goal: '', actions: [], milestone: '' },
    };

    // 인생 버전 선언문
    const lifeVersion = {
        oneLiner: report.lifeVersionStatement?.oneLiner || '',
        expanded: report.lifeVersionStatement?.expanded || [],
    };

    // 학습 가이드
    const studyGuidance = report.studyGuidance || {
        doNow: [],
        stopDoing: [],
        experiment: [],
        studyTips: [],
    };

    // 학습 스타일 맵 (5축)
    const learningStyleMap = report.learningStyleMap || {
        theoretical_vs_practical: 0,
        solo_vs_collaborative: 0,
        structured_vs_exploratory: 0,
        depth_vs_breadth: 0,
        guided_vs_autonomous: 0,
    };

    // 메타인지 분석 결과
    const metaCognition = report.metaCognition || null;

    // 전공 추천 데이터 (라이브 응답: recommendations.top_majors, 저장된 결과: fit_top_majors)
    const recs = result.recommendations || {};
    const fitTopMajors = result.fit_top_majors || recs.top_majors || recs.fit_top10 || [];
    const majorRecs = report.majorRecommendations || {};

    const overallTop5 = fitTopMajors.length > 0 ? fitTopMajors.slice(0, 5) : (majorRecs.overallTop5 || []);
    const fitTop10 = (recs.can_top10 || result.can_top10 || fitTopMajors || []).slice(0, 10);
    const likeTop10 = (recs.like_top10 || result.like_top10 || majorRecs.desireTop10 || []).slice(0, 10);

    // 결과 컨테이너 초기화
    const container = document.getElementById('step3');
    if (!container) return;

    // 전공 비전 섹션 HTML 사전 계산
    let careerVisionHtml = '';
    if (lifeVersion.oneLiner) {
        let profileDesc = '';
        if (profileInterpretation) {
            const pi = profileInterpretation;
            const parts = [];
            if (pi.interests?.length > 0) {
                parts.push('<span class="text-green-400">' + translateToKorean(pi.interests[0].label) + '</span>에 관심이 있고');
            }
            if (pi.strengths?.length > 0) {
                parts.push('<span class="text-blue-400">' + translateToKorean(pi.strengths[0].label) + '</span>이 강점이며');
            }
            if (pi.values?.length > 0) {
                parts.push('<span class="text-purple-400">' + translateToKorean(pi.values[0].label) + '</span>을 중시하는 당신을 위한 맞춤 분석입니다.');
            }
            if (parts.length > 0) {
                const joined = parts.join(', ');
                const finalText = joined.endsWith('.') ? joined : joined + '의 프로필입니다.';
                profileDesc = '<p class="text-[15px] text-wiki-muted mt-3 leading-relaxed">' + finalText + '</p>';
            }
        }
        careerVisionHtml = '<div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.15), rgba(245,158,11,0.1)); border: 1px solid rgba(251,191,36,0.3);"><p class="text-lg md:text-xl font-semibold leading-relaxed" style="color: rgb(251,191,36);">"' + translateToKorean(lifeVersion.oneLiner) + '"</p>' + profileDesc + '</div>';
    } else if (personal.personality_summary) {
        const highlightedText = personal.personality_summary.replace(/'([^']+)'/g, '<strong class="text-wiki-secondary font-bold">&#39;$1&#39;</strong>');
        careerVisionHtml = '<div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);"><p class="text-lg leading-relaxed text-white">💫 ' + highlightedText + '</p></div>';
    } else if (profileInterpretation) {
        const pi = profileInterpretation;
        const parts = [];
        if (pi.interests?.length > 0) {
            parts.push('<span class="text-green-400">' + translateToKorean(pi.interests[0].label) + '</span>을 좋아하고');
        }
        if (pi.strengths?.length > 0) {
            parts.push('<span class="text-blue-400">' + translateToKorean(pi.strengths[0].label) + '</span>에 강점을 가진');
        }
        if (pi.values?.length > 0) {
            const valLabel = translateToKorean(pi.values[0].label);
            parts.push('<span class="text-purple-400">' + valLabel + '</span>' + (hasBatchim(valLabel) ? '을' : '를') + ' 중요하게 여기는');
        }
        const summaryText = parts.length > 0 ? '당신은 ' + parts.join(', ') + ' 사람입니다.' : '당신의 전공 프로필을 분석했습니다.';
        careerVisionHtml = '<div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);"><p class="text-lg leading-relaxed text-white">💫 ' + summaryText + '</p></div>';
    }

    // 탭 UI 생성
    container.innerHTML = \`
        <!-- 리포트 헤더 -->
        <div class="text-center mb-6">
            <h2 class="text-2xl md:text-3xl font-bold mb-2 flex items-center justify-center gap-2">
                <span class="text-2xl">✨</span>
                당신만의 전공 분석 리포트
            </h2>
            <p class="text-wiki-muted text-sm">AI가 분석한 당신의 전공 방향성</p>
            <div class="flex justify-center items-center gap-2 mt-3">
                <button onclick="shareReportMajor()" id="share-report-btn" class="inline-flex items-center gap-2 px-5 py-2 rounded-full text-sm font-medium transition" style="background: linear-gradient(135deg, #6366f1, #a855f7); color: white; border: none; cursor: pointer;">
                    <i class="fas fa-share-alt"></i> 공유
                </button>
                \${DEBUG_MODE ? \`
                <button onclick="copyAllReportContent()" class="inline-flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition" style="background: rgba(67, 97, 238, 0.2); color: #64b5f6; border: 1px solid rgba(67, 97, 238, 0.3);">
                    <i class="fas fa-copy"></i> 결과 전체 복사
                </button>
                \` : ''}
            </div>
        </div>

        <!-- 탭 네비게이션 -->
        <div class="flex justify-center gap-1 mb-6 flex-wrap" id="report-tabs">
            <button onclick="showReportTabMajor('summary')" class="report-tab active px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="summary">요약</button>
            <button onclick="showReportTabMajor('psychology')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="psychology">메타인지</button>
            <button onclick="showReportTabMajor('recommendations')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="recommendations">추천 전공</button>
            <button onclick="showReportTabMajor('details')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="details" title="분석 상세">
                <i class="fas fa-info-circle"></i>
            </button>
        </div>

        <!-- 탭 컨텐츠: 요약 -->
        <div id="tab-summary" class="report-tab-content glass-card p-6 rounded-2xl mb-6">
            <div class="mb-8 pb-6">
                <h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">
                    <span class="text-3xl">📋</span>
                    <span class="bg-gradient-to-r from-amber-400 to-yellow-500 bg-clip-text text-transparent">요약</span>
                </h2>
                <p class="text-center text-wiki-muted text-sm mt-2">당신의 전공 분석 핵심을 한눈에 확인하세요.</p>
                <div class="mt-6 h-px bg-gradient-to-r from-transparent via-amber-500/50 to-transparent"></div>
            </div>

            <!-- 전공 비전 -->
            <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                <span>✨</span> 전공 비전
            </h4>
            \${careerVisionHtml}

            <!-- 메타인지 요약 (요약 탭) -->
            \${metaCognition ? \`
                <div class="mt-8 mb-8">
                    <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                        <span>📊</span> 메타인지
                        <button onclick="showReportTabMajor('psychology')" class="ml-auto px-3 py-1.5 rounded-lg text-[13px] font-medium text-wiki-primary bg-wiki-primary/10 hover:bg-wiki-primary/20 transition-all flex items-center gap-1.5">
                            <span>자세히 보기</span>
                            <i class="fas fa-chevron-right text-[10px]"></i>
                        </button>
                    </h4>

                    \${(() => {
                        const metaSummarySections = [
                            metaCognition.myArsenal?.strengths?.length > 0 ? 'strengths' : null,
                            profileInterpretation?.values?.length > 0 ? 'values' : null,
                            metaCognition.stressRecovery?.stressFactors?.length > 0 ? 'stress' : null,
                        ].filter(Boolean);
                        const metaSummaryCount = metaSummarySections.length;
                        const metaSummaryGridClass = metaSummaryCount <= 1 ? 'grid grid-cols-1 gap-4' : metaSummaryCount === 2 ? 'grid grid-cols-1 md:grid-cols-2 gap-4' : 'grid grid-cols-1 md:grid-cols-3 gap-4';
                        return '<div class="' + metaSummaryGridClass + '">';
                    })()}
                        <!-- 핵심 강점 -->
                        \${metaCognition.myArsenal?.strengths?.length > 0 ? \`
                            <div class="p-4 rounded-xl" style="background: rgba(34,197,94,0.08); border: 1px solid rgba(34,197,94,0.2);">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-lg">💪</span>
                                    <h5 class="font-bold text-green-400 text-[15px]">핵심 강점</h5>
                                </div>
                                <div class="flex flex-wrap gap-1.5">
                                    \${metaCognition.myArsenal.strengths.slice(0, 3).map(s => \`
                                        <span class="px-2.5 py-1 rounded text-[15px] font-medium" style="background-color: rgba(34,197,94,0.15); color: rgb(134,239,172);">\${translateToKorean(s.trait)}</span>
                                    \`).join('')}
                                </div>
                            </div>
                        \` : ''}

                        <!-- 핵심 가치 -->
                        \${profileInterpretation?.values?.length > 0 ? \`
                            <div class="p-4 rounded-xl" style="background: rgba(168,85,247,0.08); border: 1px solid rgba(168,85,247,0.2);">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-lg">⭐</span>
                                    <h5 class="font-bold text-purple-400 text-[15px]">핵심 가치</h5>
                                </div>
                                <div class="flex flex-wrap gap-1.5">
                                    \${profileInterpretation.values.slice(0, 3).map(v => \`
                                        <span class="px-2.5 py-1 rounded text-[15px] font-medium" style="background-color: rgba(168,85,247,0.15); color: rgb(216,180,254);">\${translateToKorean(v.label)}</span>
                                    \`).join('')}
                                </div>
                            </div>
                        \` : ''}

                        <!-- 스트레스 주의점 -->
                        \${metaCognition.stressRecovery?.stressFactors?.length > 0 ? \`
                            <div class="p-4 rounded-xl" style="background: rgba(239,68,68,0.08); border: 1px solid rgba(239,68,68,0.2);">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="text-lg">⚠️</span>
                                    <h5 class="font-bold text-red-400 text-[15px]">주의점</h5>
                                    <span class="relative group cursor-help">
                                        <i class="fas fa-question-circle text-wiki-muted text-xs"></i>
                                        <span class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-2 rounded-lg text-xs text-white whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50" style="background: rgba(30,30,40,0.95); border: 1px solid rgba(255,255,255,0.1);">이 항목들은 에너지가 소모되거나 스트레스를 유발할 수 있는 요인입니다.<br/>전공 선택 시 이 요인들을 고려하면 번아웃을 예방할 수 있습니다.</span>
                                    </span>
                                </div>
                                <div class="flex flex-wrap gap-1.5">
                                    \${metaCognition.stressRecovery.stressFactors.slice(0, 2).map(s => \`
                                        <span class="px-2.5 py-1 rounded text-[15px] font-medium" style="background-color: rgba(239,68,68,0.15); color: rgb(252,165,165);">\${translateToKorean(s.factor)}</span>
                                    \`).join('')}
                                </div>
                            </div>
                        \` : ''}
                    </div>
                </div>
            \` : ''}

            <!-- 나의 전공 프로필 (프로필 해석) -->
            \${profileInterpretation ? \`
                <div class="mt-8 mb-8">
                    <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                        <span>🧬</span> 나의 전공 프로필
                    </h4>

                    \${(() => {
                        const profileSections = [
                            profileInterpretation.interests?.length > 0 ? 'interests' : null,
                            profileInterpretation.strengths?.length > 0 ? 'strengths' : null,
                            profileInterpretation.values?.length > 0 ? 'values' : null,
                            profileInterpretation.constraints?.length > 0 ? 'constraints' : null
                        ].filter(Boolean);
                        const profileCount = profileSections.length;
                        const profileGridClass = profileCount <= 1 ? 'grid grid-cols-1 gap-4' : 'grid grid-cols-1 md:grid-cols-2 gap-4';
                        const profileIsOdd = profileCount > 1 && profileCount % 2 === 1;
                        const profileLastSection = profileSections[profileCount - 1];
                        const interestsSpan = profileIsOdd && profileLastSection === 'interests' ? 'md:col-span-2' : '';
                        const strengthsSpan = profileIsOdd && profileLastSection === 'strengths' ? 'md:col-span-2' : '';
                        const valuesSpan = profileIsOdd && profileLastSection === 'values' ? 'md:col-span-2' : '';
                        const constraintsSpan = profileIsOdd && profileLastSection === 'constraints' ? 'md:col-span-2' : '';
                        return '<div class="' + profileGridClass + '">' +

                        (profileInterpretation.interests?.length > 0 ? '<div class="p-4 rounded-xl ' + interestsSpan + '" style="background: rgba(34,197,94,0.08); border: 1px solid rgba(34,197,94,0.2);"><div class="flex items-center gap-2 mb-3"><span class="text-lg">💚</span><h5 class="font-bold text-green-400 text-[15px]">좋아하는 것</h5></div><p class="text-[15px] text-wiki-muted mb-3">' + translateToKorean(profileInterpretation.interests_summary || '') + '</p><div class="space-y-3">' + profileInterpretation.interests.map(item => '<div class="pl-3 border-l-2 border-green-500/30"><div class="font-medium text-green-300 text-[15px]">' + translateToKorean(item.label) + '</div><div class="text-[15px] text-wiki-muted mt-1 leading-relaxed">' + translateToKorean(item.meaning || item.label + '에 대한 관심이 높습니다.') + '</div></div>').join('') + '</div></div>' : '') +

                        (profileInterpretation.strengths?.length > 0 ? '<div class="p-4 rounded-xl ' + strengthsSpan + '" style="background: rgba(59,130,246,0.08); border: 1px solid rgba(59,130,246,0.2);"><div class="flex items-center gap-2 mb-3"><span class="text-lg">💪</span><h5 class="font-bold text-blue-400 text-[15px]">잘하는 것</h5></div><p class="text-[15px] text-wiki-muted mb-3">' + translateToKorean(profileInterpretation.strengths_summary || '') + '</p><div class="space-y-3">' + profileInterpretation.strengths.map(item => '<div class="pl-3 border-l-2 border-blue-500/30"><div class="font-medium text-blue-300 text-[15px]">' + translateToKorean(item.label) + '</div><div class="text-[15px] text-wiki-muted mt-1 leading-relaxed">' + translateToKorean(item.meaning || item.label + '이(가) 강점입니다.') + '</div></div>').join('') + '</div></div>' : '') +

                        (profileInterpretation.values?.length > 0 ? '<div class="p-4 rounded-xl ' + valuesSpan + '" style="background: rgba(168,85,247,0.08); border: 1px solid rgba(168,85,247,0.2);"><div class="flex items-center gap-2 mb-3"><span class="text-lg">⭐</span><h5 class="font-bold text-purple-400 text-[15px]">중요한 가치</h5></div><p class="text-[15px] text-wiki-muted mb-3">' + translateToKorean(profileInterpretation.values_summary || '') + '</p><div class="space-y-3">' + profileInterpretation.values.map(item => '<div class="pl-3 border-l-2 border-purple-500/30"><div class="font-medium text-purple-300 text-[15px]">' + translateToKorean(item.label) + '</div><div class="text-[15px] text-wiki-muted mt-1 leading-relaxed">' + translateToKorean(item.meaning || item.label + '을(를) 중요하게 여깁니다.') + '</div></div>').join('') + '</div></div>' : '') +

                        (profileInterpretation.constraints?.length > 0 ? '<div class="p-4 rounded-xl ' + constraintsSpan + '" style="background: rgba(239,68,68,0.08); border: 1px solid rgba(239,68,68,0.2);"><div class="flex items-center gap-2 mb-3"><span class="text-lg">🚫</span><h5 class="font-bold text-red-400 text-[15px]">피하고 싶은 것</h5></div><p class="text-[15px] text-wiki-muted mb-3">' + translateToKorean(profileInterpretation.constraints_summary || '') + '</p><div class="space-y-3">' + profileInterpretation.constraints.map(item => '<div class="pl-3 border-l-2 border-red-500/30"><div class="font-medium text-red-300 text-[15px]">' + translateToKorean(item.label) + '</div><div class="text-[15px] text-wiki-muted mt-1 leading-relaxed">' + translateToKorean(item.meaning) + '</div></div>').join('') + '</div></div>' : '') +

                        '</div>';
                    })()}
                </div>
            \` : ''}

            <!-- 학습 스타일 힌트 -->
            \${learningStyleMap && (learningStyleMap.theoretical_vs_practical !== undefined || learningStyleMap.solo_vs_collaborative !== undefined) ? \`
                <div class="mt-6 flex flex-wrap gap-2 justify-center">
                    \${[
                        learningStyleMap.theoretical_vs_practical < 0 ? '📖 이론 중심' : learningStyleMap.theoretical_vs_practical > 0 ? '🔧 실습 중심' : null,
                        learningStyleMap.solo_vs_collaborative < 0 ? '🧘 독립 학습 선호' : learningStyleMap.solo_vs_collaborative > 0 ? '🤝 협업 학습 선호' : null,
                        learningStyleMap.structured_vs_exploratory < 0 ? '📋 체계적 학습' : learningStyleMap.structured_vs_exploratory > 0 ? '🔍 탐구적 학습' : null,
                        learningStyleMap.guided_vs_autonomous > 0 ? '🚀 자기주도 학습' : null,
                    ].filter(Boolean).map(hint => \`
                        <span class="px-3 py-1.5 rounded-full text-[13px] font-medium" style="background: rgba(99,102,241,0.1); color: rgb(165,180,252); border: 1px solid rgba(99,102,241,0.2);">\${hint}</span>
                    \`).join('')}
                </div>
            \` : ''}

            <!-- 프로필 → 추천 브릿지 문장 -->
            \${profileInterpretation && overallTop5.length > 0 ? \`
                <div class="mt-4 mb-2 p-4 rounded-xl text-center" style="background: linear-gradient(135deg, rgba(251,191,36,0.1), rgba(245,158,11,0.05)); border: 1px solid rgba(251,191,36,0.2);">
                    <p class="text-base md:text-lg" style="color: rgb(253,224,71);">
                        <span class="font-medium">🎯 이런 당신에게 맞는 전공</span>
                    </p>
                    <p class="text-[15px] text-wiki-muted mt-2">
                        \${(() => {
                            const parts = [];
                            const pi = profileInterpretation;
                            if (pi.interests?.length > 0) {
                                parts.push('<span class="text-green-400">"' + translateToKorean(pi.interests[0].label) + '"</span>을 좋아하고');
                            }
                            if (pi.strengths?.length > 0) {
                                parts.push('<span class="text-blue-400">"' + translateToKorean(pi.strengths[0].label) + '"</span>이 강점인 당신');
                            }
                            if (pi.constraints?.length > 0) {
                                parts.push('<span class="text-red-400">"' + translateToKorean(pi.constraints[0].label) + '"</span> 없이 성장할 수 있는 전공을 찾았습니다.');
                            } else if (parts.length > 0) {
                                parts.push('에게 맞는 전공을 찾았습니다.');
                            }
                            return parts.length > 0 ? parts.join(' ') : '당신의 프로필을 바탕으로 전공을 추천합니다.';
                        })()}
                    </p>
                </div>
            \` : ''}

            <!-- TOP 3 전공 카드 (요약 탭) -->
            \${overallTop5.length > 0 ? \`
                <div class="mt-6 pt-4 border-t border-wiki-border/30">
                    <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                        <span>🏆</span> 추천 전공 Top 3
                        <button onclick="showReportTabMajor('recommendations')" class="ml-auto px-3 py-1.5 rounded-lg text-[13px] font-medium text-wiki-primary bg-wiki-primary/10 hover:bg-wiki-primary/20 transition-all flex items-center gap-1.5">
                            <span>더보기</span>
                            <i class="fas fa-chevron-right text-[10px]"></i>
                        </button>
                    </h4>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                        \${overallTop5.slice(0, 3).map((major, idx) => {
                            const majorName = major.major_name || major.major_id || '전공';
                            const majorSlug = major.slug || encodeURIComponent(majorName);
                            const rationale = major.rationale || major.one_line_why || '';
                            const imageUrl = major.image_url || '';
                            const description = (major.major_description || major.description || major.summary || '').replace(/\\n\\n/g, ' ').replace(/\\n/g, ' ').trim();
                            const displayDescription = description || '';
                            const fitScore = major.scores?.fit || major.fit_score || '-';
                            const likeReason = major.like_reason || '';
                            const canReason = major.can_reason || '';
                            const feasibilityReason = major.feasibility_reason || '';
                            const hasReasons = likeReason || canReason || feasibilityReason;

                            return \`
                                <a href="/major/\${majorSlug}" target="_blank" rel="noopener noreferrer" class="block p-4 rounded-xl transition-all hover:scale-[1.02] group"
                                   style="background: linear-gradient(135deg, rgba(\${idx === 0 ? '245,158,11' : idx === 1 ? '100,116,139' : '180,83,9'},0.15), rgba(\${idx === 0 ? '251,191,36' : idx === 1 ? '148,163,184' : '217,119,6'},0.05)); border: 1px solid rgba(\${idx === 0 ? '245,158,11' : idx === 1 ? '100,116,139' : '180,83,9'},0.3);">
                                        <div class="mb-3 overflow-hidden rounded-lg" style="aspect-ratio: 16/10;">
                                            \${imageUrl ? \`
                                                <img src="\${imageUrl}" alt="\${majorName}"
                                                     class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                <div class="hidden w-full h-full items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.2), rgba(168,85,247,0.1));">
                                                    <i class="fas fa-graduation-cap text-3xl text-wiki-muted"></i>
                                                </div>
                                            \` : \`
                                                <div class="w-full h-full flex items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.2), rgba(168,85,247,0.1));">
                                                    <i class="fas fa-graduation-cap text-3xl text-wiki-muted"></i>
                                                </div>
                                            \`}
                                        </div>
                                        <div class="flex items-center gap-3 mb-3">
                                            <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : '🥉'}</span>
                                            <span class="font-bold text-lg text-white flex-1 line-clamp-1">\${majorName}</span>
                                            <span class="text-base font-bold" style="color: rgb(\${idx === 0 ? '251,191,36' : idx === 1 ? '148,163,184' : '217,119,6'});">Fit \${fitScore}</span>
                                        </div>
                                        \${major.field_category ? \`<div class="text-xs text-wiki-muted mb-2">\${{engineering:'공학',natural_science:'자연과학',social_science:'사회과학',humanities:'인문학',arts:'예술/체육',medical:'의약/보건',education:'교육',business:'경영/경제',law:'법학',agriculture:'농림/수산',general:'기타'}[major.field_category] || major.field_category}</div>\` : ''}
                                        \${displayDescription ? \`<p class="text-base text-wiki-muted line-clamp-3 mb-3">\${displayDescription}</p>\` : ''}
                                        \${hasReasons ? \`
                                            <div class="space-y-1.5 mt-3 p-3 rounded-lg" style="background: rgba(0,0,0,0.2);">
                                                \${likeReason ? \`<p class="text-[13px] leading-relaxed text-purple-300/90"><span class="text-purple-400 font-medium">💜 Like:</span> \${likeReason}</p>\` : ''}
                                                \${canReason ? \`<p class="text-[13px] leading-relaxed text-blue-300/90"><span class="text-blue-400 font-medium">💪 Can:</span> \${canReason}</p>\` : ''}
                                                \${feasibilityReason ? \`<p class="text-[13px] leading-relaxed text-amber-300/90"><span class="text-amber-400 font-medium">🎯 배경:</span> \${feasibilityReason}</p>\` : ''}
                                            </div>
                                        \` : (rationale && !rationale.includes('자동 생성된 결과') ? \`
                                            <p class="text-[13px] text-emerald-400/80 mt-3">💡 \${rationale}</p>
                                        \` : '')}
                                </a>
                            \`;
                        }).join('')}
                    </div>
                </div>
            \` : ''}

        </div>

        <!-- TAB_PSYCHOLOGY_PLACEHOLDER -->

    \`;

    // --- Phase 2: Psychology tab will be appended ---
    // We build the rest via string concatenation to avoid template literal nesting issues

    // Build psychology tab HTML
    var psychologyHtml = buildPsychologyTabMajor(personal, metaCognition, profileInterpretation, learningStyleMap, innerConflict, growthCurve, academicTimeline, studyGuidance, stressProfile);

    // Build recommendations tab HTML
    var recommendationsHtml = buildRecommendationsTabMajor(profileInterpretation, overallTop5, fitTop10, likeTop10);

    // Build details tab HTML
    var detailsHtml = buildDetailsTabMajor(result, report);

    // Build bottom buttons HTML
    var bottomHtml = buildBottomButtonsMajor();

    // Replace placeholder and append remaining tabs
    var currentHtml = container.innerHTML;
    currentHtml = currentHtml.replace('<!-- TAB_PSYCHOLOGY_PLACEHOLDER -->', psychologyHtml + recommendationsHtml + detailsHtml + bottomHtml);
    container.innerHTML = currentHtml;

    // 스타일 추가
    addReportStylesMajor();

    // 전역 데이터 저장
    window.currentReportData = {
        report,
        overallTop5,
        fitTop10,
        likeTop10,
        profileInterpretation,
    };
}

// ============================================
// Psychology Tab Builder
// ============================================
function buildPsychologyTabMajor(personal, metaCognition, profileInterpretation, learningStyleMap, innerConflict, growthCurve, academicTimeline, studyGuidance, stressProfile) {
    var html = '';

    html += '<div id="tab-psychology" class="report-tab-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">';
    html += '<div class="mb-8 pb-6">';
    html += '<h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">';
    html += '<span class="text-3xl">📊</span>';
    html += '<span class="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">메타인지</span>';
    html += '</h2>';
    html += '<p class="text-center text-wiki-muted text-sm mt-2">자기 자신에 대한 깊은 이해와 내면 탐구.</p>';
    html += '<div class="mt-6 h-px bg-gradient-to-r from-transparent via-purple-500/50 to-transparent"></div>';
    html += '</div>';

    // 핵심 요약
    if (personal.personality_summary || metaCognition?.innerExploration?.identityInsight) {
        html += '<div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);">';
        html += '<h4 class="text-xl font-bold mb-3" style="color: rgb(165,180,252);">💫 핵심 요약</h4>';
        html += '<p class="text-base md:text-lg leading-relaxed text-white mb-4">';
        var rawText = metaCognition?.innerExploration?.identityInsight || personal.personality_summary || '';
        var styled = rawText.replace(/'([^']+)'/g, '<strong class="text-wiki-secondary font-bold">$1</strong>');
        if (profileInterpretation) {
            var pi = profileInterpretation;
            (pi.interests || []).forEach(function(i) {
                var label = translateToKorean(i.label);
                styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-green-400">' + label + '</strong>');
            });
            (pi.strengths || []).forEach(function(s) {
                var label = translateToKorean(s.label);
                styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-blue-400">' + label + '</strong>');
            });
            (pi.values || []).forEach(function(v) {
                var label = translateToKorean(v.label);
                styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-purple-400">' + label + '</strong>');
            });
        }
        html += styled;
        html += '</p>';

        if (metaCognition?.innerExploration?.innerConflicts) {
            html += '<div class="p-4 rounded-xl mb-4" style="background-color: rgba(236,72,153,0.08); border-left: 3px solid rgba(236,72,153,0.5);">';
            html += '<div class="text-[15px] font-medium text-pink-300 mb-2">🎭 알아두면 좋은 내적 갈등</div>';
            html += '<p class="text-[15px] text-wiki-muted leading-relaxed">' + translateToKorean(metaCognition.innerExploration.innerConflicts) + '</p>';
            html += '</div>';
        }
        if (metaCognition?.innerExploration?.valueAnalysis) {
            html += '<details class="group">';
            html += '<summary class="cursor-pointer text-[15px] text-violet-400 font-medium hover:text-violet-300 flex items-center gap-2">';
            html += '<span>📖</span><span class="group-open:hidden">▶ 추가 설명</span><span class="hidden group-open:inline">▼ 추가 설명</span>';
            html += '</summary>';
            html += '<div class="mt-3 p-4 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(139,92,246,0.05);">' + translateToKorean(metaCognition.innerExploration.valueAnalysis) + '</div>';
            html += '</details>';
        }
        html += '</div>';
    } else {
        html += '<div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.2);">';
        html += '<h4 class="text-xl font-bold mb-3" style="color: rgb(165,180,252);">💫 핵심 요약</h4>';
        html += '<p class="text-base md:text-lg leading-relaxed text-wiki-muted">심층 분석을 위해 더 많은 정보가 필요합니다. 심층 질문에 자세히 답변해주시면 더 정확한 분석이 가능합니다.</p>';
        html += '</div>';
    }

    // 메타인지 5개 섹션
    if (metaCognition) {
        html += buildMetaCognitionSectionsMajor(metaCognition, profileInterpretation);
    }

    // 작업 스타일 인사이트
    if (personal.work_style_insights?.length > 0) {
        html += '<div class="mb-8">';
        html += '<h4 class="text-xl font-bold mb-4 flex items-center gap-2"><span>🎨</span> 학습 스타일</h4>';
        html += '<div class="grid gap-3">';
        personal.work_style_insights.forEach(function(ws) {
            var text = translateToKorean(ws).trim();
            if (!text.endsWith('.') && !text.endsWith('다.') && !text.endsWith('요.') && !text.endsWith('니다.')) text += '.';
            text = text.replace(/(성장|도전|학습|몰입|성취감|자율|창의성|분석|문제|해결|독립|협업|리더십|꼼꼼|유연|안정|전문성|체계)/g, '<strong class="text-indigo-400">$1</strong>');
            html += '<div class="p-4 rounded-xl bg-wiki-bg/50 flex items-start gap-4" style="border: 1px solid rgba(99,102,241,0.1);"><span class="text-wiki-primary text-lg mt-0.5">✓</span><span class="text-[15px] leading-relaxed text-wiki-text">' + text + '</span></div>';
        });
        html += '</div></div>';
    }

    // 가치 우선순위
    if (personal.value_priorities?.length > 0) {
        html += '<div class="mb-8">';
        html += '<h4 class="text-xl font-bold mb-4 flex items-center gap-2"><span>⭐</span> 가치 우선순위</h4>';
        var gridCols = Math.min(personal.value_priorities.length, 3);
        html += '<div class="grid grid-cols-' + gridCols + ' gap-3">';
        var colors = ['rgba(168,85,247,0.2)', 'rgba(99,102,241,0.2)', 'rgba(59,130,246,0.2)', 'rgba(6,182,212,0.2)', 'rgba(16,185,129,0.2)'];
        var textColors = ['rgb(216,180,254)', 'rgb(165,180,252)', 'rgb(147,197,253)', 'rgb(103,232,249)', 'rgb(110,231,183)'];
        personal.value_priorities.slice(0, 5).forEach(function(v, i) {
            var text = translateToKorean(v).trim();
            if (text.length < 10) text = text.replace(/\\.$/, '');
            else if (!text.endsWith('.')) text += '.';
            html += '<div class="p-3 md:p-4 rounded-xl flex items-center gap-2 justify-center" style="background-color: ' + colors[i % colors.length] + '; border: 1px solid ' + colors[i % colors.length].replace('0.2', '0.3') + ';"><span class="text-sm font-bold" style="color: ' + textColors[i % textColors.length] + ';">#' + (i + 1) + '</span><span class="text-[15px] font-semibold text-wiki-text">' + text + '</span></div>';
        });
        html += '</div></div>';
    }

    // 잠재적 도전
    if (personal.potential_challenges?.length > 0) {
        html += '<div class="mb-8 p-5 rounded-xl" style="background-color: rgba(251,146,60,0.1); border: 1px solid rgba(251,146,60,0.2);">';
        html += '<h4 class="text-xl font-bold mb-4 text-orange-400 flex items-center gap-2"><span>⚠️</span> 주의할 점</h4>';
        html += '<ul class="space-y-3">';
        personal.potential_challenges.forEach(function(c) {
            html += '<li class="flex items-center gap-3"><span class="text-orange-400">•</span><span class="text-[15px] leading-relaxed text-wiki-text">' + c + '</span></li>';
        });
        html += '</ul></div>';
    }

    // 블라인드 스팟
    if (personal.blind_spots_to_check?.length > 0) {
        html += '<div class="mb-8 p-5 rounded-xl" style="background-color: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.2);">';
        html += '<h4 class="text-xl font-bold mb-4 text-red-400 flex items-center gap-2"><span>🔍</span> 점검할 블라인드 스팟</h4>';
        html += '<ul class="space-y-3">';
        personal.blind_spots_to_check.forEach(function(b) {
            html += '<li class="flex items-center gap-3"><span class="text-red-400">•</span><span class="text-[15px] leading-relaxed text-wiki-text">' + b + '</span></li>';
        });
        html += '</ul></div>';
    }

    // 학습 스타일 5축 시각화
    if (learningStyleMap && (learningStyleMap.theoretical_vs_practical !== 0 || learningStyleMap.solo_vs_collaborative !== 0)) {
        html += '<div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(6,182,212,0.1), rgba(59,130,246,0.1)); border: 1px solid rgba(6,182,212,0.2);">';
        html += '<h4 class="text-xl font-bold mb-2 text-cyan-400 flex items-center gap-2"><span>📊</span> 학습 스타일 5축 분석</h4>';
        html += '<p class="text-sm text-wiki-muted mb-5">각 축의 중앙은 균형 상태이며, 좌우로 치우칠수록 해당 성향이 강합니다.</p>';
        html += '<div class="space-y-5">';

        var axes = [
            { left: '이론형', right: '실습형', value: learningStyleMap.theoretical_vs_practical, color: 'cyan', leftDesc: '이론과 개념 이해를 통한 학습을 선호합니다', rightDesc: '실험과 실습 중심의 체험적 학습을 선호합니다', balanceDesc: '이론과 실습을 균형 있게 활용합니다' },
            { left: '독립학습', right: '협업학습', value: learningStyleMap.solo_vs_collaborative, color: 'blue', leftDesc: '혼자 깊이 파고드는 학습에서 에너지를 얻습니다', rightDesc: '동료들과 함께 토론하고 협력할 때 시너지를 냅니다', balanceDesc: '상황에 따라 독립 학습과 협업을 유연하게 전환합니다' },
            { left: '체계적', right: '탐구적', value: learningStyleMap.structured_vs_exploratory, color: 'violet', leftDesc: '명확한 커리큘럼과 계획 안에서 안정감을 느낍니다', rightDesc: '자유로운 탐구와 발견 중심의 학습을 선호합니다', balanceDesc: '체계와 탐구를 상황에 맞게 조합합니다' },
            { left: '심화형', right: '융합형', value: learningStyleMap.depth_vs_breadth, color: 'amber', leftDesc: '한 분야를 깊이 파고들어 전문성을 키우는 것을 선호합니다', rightDesc: '다양한 분야를 융합하며 학제간 연결을 즐깁니다', balanceDesc: '깊이와 넓이를 균형 있게 추구합니다' },
            { left: '교수주도', right: '자기주도', value: learningStyleMap.guided_vs_autonomous, color: 'emerald', leftDesc: '교수의 체계적 가르침과 피드백이 있을 때 성장이 빠릅니다', rightDesc: '스스로 학습 방향을 설정하고 주도적으로 공부합니다', balanceDesc: '적절한 가이드와 자율성의 균형을 추구합니다' },
        ];

        axes.forEach(function(axis) {
            var val = axis.value || 0;
            html += '<div>';
            html += '<div class="flex items-center gap-4">';
            html += '<span class="text-sm w-24 text-right ' + (val < 0 ? 'text-' + axis.color + '-400 font-semibold' : 'text-wiki-muted') + '">' + axis.left + '</span>';
            html += '<div class="flex-1 h-3 bg-wiki-border/20 rounded-full relative overflow-hidden">';
            html += '<div class="absolute top-0 left-1/2 w-px h-full bg-wiki-muted/40 z-10"></div>';
            if (val === 0) {
                html += '<div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-3 h-3 bg-gray-400 rounded-full border-2 border-wiki-bg z-20"></div>';
            } else {
                var barStyle = val >= 0
                    ? 'left: 50%; width: ' + Math.max(val / 2, 3) + '%;'
                    : 'right: 50%; width: ' + Math.max(Math.abs(val) / 2, 3) + '%;';
                html += '<div class="absolute top-0 h-full bg-' + axis.color + '-400/80 rounded-full transition-all" style="' + barStyle + '"></div>';
            }
            html += '</div>';
            html += '<span class="text-sm w-24 ' + (val > 0 ? 'text-' + axis.color + '-400 font-semibold' : 'text-wiki-muted') + '">' + axis.right + '</span>';
            html += '</div>';
            html += '<p class="text-xs text-wiki-muted mt-1 text-center">' + (Math.abs(val) >= 15 ? (val < 0 ? axis.leftDesc : axis.rightDesc) : axis.balanceDesc) + '</p>';
            html += '</div>';
        });

        html += '</div></div>';
    }

    // 내면 갈등 + 성장 곡선
    if ((innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts) || growthCurve.type) {
        var bothExist = (innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts) && growthCurve.type;
        html += '<div class="grid grid-cols-1 ' + (bothExist ? 'md:grid-cols-2' : '') + ' gap-6 mb-8">';
        if (innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts) {
            html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(168,85,247,0.1), rgba(236,72,153,0.1)); border: 1px solid rgba(168,85,247,0.2);">';
            html += '<h4 class="text-xl font-bold mb-4 text-purple-400 flex items-center gap-2"><span>💭</span> 내면 갈등 분석</h4>';
            if (innerConflict.patterns?.length > 0) {
                html += '<p class="text-lg font-bold mb-3" style="color: rgb(216,180,254);">' + innerConflict.patterns[0] + '</p>';
            }
            html += '<p class="text-[15px] leading-relaxed text-wiki-text mb-4">' + innerConflict.analysis + '</p>';
            if (innerConflict.patterns?.length > 1) {
                html += '<div class="mt-4 pt-4 border-t border-purple-400/20"><span class="text-sm text-purple-300 font-semibold">기타 갈등 패턴:</span><ul class="mt-3 space-y-2">';
                innerConflict.patterns.slice(1).forEach(function(p) {
                    html += '<li class="flex items-center gap-3"><span class="text-purple-400">•</span><span class="text-[15px] leading-relaxed text-wiki-muted">' + p + '</span></li>';
                });
                html += '</ul></div>';
            }
            html += '</div>';
        }
        if (growthCurve.type) {
            html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(16,185,129,0.1), rgba(52,211,153,0.1)); border: 1px solid rgba(16,185,129,0.2);">';
            html += '<h4 class="text-xl font-bold mb-4 text-emerald-400 flex items-center gap-2"><span>📈</span> 성장 곡선 유형</h4>';
            html += '<p class="text-lg font-bold mb-3" style="color: rgb(52,211,153);">' + translateToKorean(growthCurve.type) + '</p>';
            if (growthCurve.description) {
                html += '<p class="text-[15px] leading-relaxed text-wiki-text">' + growthCurve.description + '</p>';
            }
            html += '</div>';
        }
        html += '</div>';
    }

    // 학기별 로드맵
    if (academicTimeline.semester1?.goal || academicTimeline.semester2?.goal || academicTimeline.semester3_4?.goal || academicTimeline.beyond?.goal) {
        html += '<div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(59,130,246,0.1), rgba(99,102,241,0.1)); border: 1px solid rgba(59,130,246,0.2);">';
        html += '<h4 class="text-xl font-bold mb-2 text-blue-400 flex items-center gap-2"><span>📅</span> 학기별 로드맵</h4>';
        html += '<p class="text-sm text-wiki-muted mb-5">학기별 목표와 실행 계획을 통해 체계적으로 학업을 준비하세요.</p>';
        html += '<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">';

        var semesters = [
            { key: 'semester1', data: academicTimeline.semester1, label: '1학기', num: '1', color: 'blue', colorText: 'text-blue-300', colorBg: 'rgba(59,130,246,' },
            { key: 'semester2', data: academicTimeline.semester2, label: '2학기', num: '2', color: 'indigo', colorText: 'text-indigo-300', colorBg: 'rgba(99,102,241,' },
            { key: 'semester3_4', data: academicTimeline.semester3_4, label: '3-4학기', num: '3+', color: 'violet', colorText: 'text-violet-300', colorBg: 'rgba(139,92,246,' },
            { key: 'beyond', data: academicTimeline.beyond, label: '졸업 이후', num: '∞', color: 'purple', colorText: 'text-purple-300', colorBg: 'rgba(168,85,247,' },
        ];

        semesters.forEach(function(sem) {
            if (sem.data?.goal) {
                html += '<div class="p-4 rounded-xl" style="background-color: ' + sem.colorBg + '0.1); border: 1px solid ' + sem.colorBg + '0.15);">';
                html += '<div class="text-sm font-bold ' + sem.colorText + ' mb-3 flex items-center gap-2">';
                html += '<span class="w-8 h-8 rounded-full bg-' + sem.color + '-500/20 flex items-center justify-center text-' + sem.color + '-400 font-bold">' + sem.num + '</span>';
                html += sem.label;
                html += '</div>';
                html += '<div class="text-base font-semibold text-white mb-3">' + sem.data.goal + '</div>';
                if (sem.data.actions?.length > 0) {
                    html += '<ul class="text-sm text-wiki-muted space-y-2 mb-3">';
                    sem.data.actions.slice(0, 2).forEach(function(a) {
                        html += '<li class="flex items-center gap-2"><span class="text-' + sem.color + '-400">•</span> ' + a + '</li>';
                    });
                    html += '</ul>';
                }
                if (sem.data.milestone) {
                    html += '<div class="text-sm text-' + sem.color + '-400 font-medium">✓ ' + sem.data.milestone + '</div>';
                }
                html += '</div>';
            }
        });

        html += '</div></div>';
    }

    // 학습 가이드
    if (studyGuidance.doNow?.length > 0 || studyGuidance.stopDoing?.length > 0 || studyGuidance.experiment?.length > 0 || studyGuidance.studyTips?.length > 0) {
        html += '<div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(34,197,94,0.1), rgba(16,185,129,0.1)); border: 1px solid rgba(34,197,94,0.2);">';
        html += '<h4 class="text-xl font-bold mb-2 text-green-400 flex items-center gap-2"><span>🧭</span> 학습 가이드</h4>';
        html += '<p class="text-[15px] text-wiki-muted mb-5">지금 당장 실천할 수 있는 구체적인 조언입니다.</p>';

        var activeSections = [];
        if (studyGuidance.doNow?.length > 0) activeSections.push('doNow');
        if (studyGuidance.stopDoing?.length > 0) activeSections.push('stopDoing');
        if (studyGuidance.experiment?.length > 0) activeSections.push('experiment');
        if (studyGuidance.studyTips?.length > 0) activeSections.push('studyTips');
        var count = activeSections.length;
        var lastSection = activeSections[count - 1];
        var isOdd = count % 2 === 1;
        var gridClass = count <= 1 ? 'grid grid-cols-1 gap-4' : 'grid grid-cols-1 md:grid-cols-2 gap-4';

        var doNowSpan = isOdd && lastSection === 'doNow' ? 'md:col-span-2' : '';
        var stopSpan = isOdd && lastSection === 'stopDoing' ? 'md:col-span-2' : '';
        var experimentSpan = isOdd && lastSection === 'experiment' ? 'md:col-span-2' : '';
        var tipsSpan = isOdd && lastSection === 'studyTips' ? 'md:col-span-2' : '';

        html += '<div class="' + gridClass + '">';

        if (studyGuidance.doNow?.length > 0) {
            html += '<div class="p-5 rounded-xl ' + doNowSpan + '" style="background-color: rgba(34,197,94,0.1); border: 1px solid rgba(34,197,94,0.15);"><div class="text-base font-bold text-green-400 mb-3 flex items-center gap-2"><span class="text-xl">✅</span> 지금 시작할 것</div><ul class="space-y-2">';
            studyGuidance.doNow.slice(0, 3).forEach(function(d) {
                html += '<li class="flex items-center gap-3"><span class="text-green-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(d) + '</span></li>';
            });
            html += '</ul></div>';
        }
        if (studyGuidance.stopDoing?.length > 0) {
            html += '<div class="p-5 rounded-xl ' + stopSpan + '" style="background-color: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.15);"><div class="text-base font-bold text-red-400 mb-3 flex items-center gap-2"><span class="text-xl">🚫</span> 그만해야 할 것</div><ul class="space-y-2">';
            studyGuidance.stopDoing.slice(0, 3).forEach(function(s) {
                html += '<li class="flex items-center gap-3"><span class="text-red-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(s) + '</span></li>';
            });
            html += '</ul></div>';
        }
        if (studyGuidance.experiment?.length > 0) {
            html += '<div class="p-5 rounded-xl ' + experimentSpan + '" style="background-color: rgba(251,191,36,0.1); border: 1px solid rgba(251,191,36,0.15);"><div class="text-base font-bold text-amber-400 mb-3 flex items-center gap-2"><span class="text-xl">🧪</span> 시도해볼 것</div><ul class="space-y-2">';
            studyGuidance.experiment.slice(0, 3).forEach(function(e) {
                html += '<li class="flex items-center gap-3"><span class="text-amber-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(e) + '</span></li>';
            });
            html += '</ul></div>';
        }
        if (studyGuidance.studyTips?.length > 0) {
            html += '<div class="p-5 rounded-xl ' + tipsSpan + '" style="background-color: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.15);"><div class="text-base font-bold text-blue-400 mb-3 flex items-center gap-2"><span class="text-xl">📚</span> 학습 팁</div><ul class="space-y-2">';
            studyGuidance.studyTips.slice(0, 3).forEach(function(t) {
                html += '<li class="flex items-center gap-3"><span class="text-blue-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(t) + '</span></li>';
            });
            html += '</ul></div>';
        }

        html += '</div></div>';
    }

    // 스트레스 프로필 상세
    if (stressProfile.profile) {
        html += '<div class="p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(251,146,60,0.1)); border: 1px solid rgba(239,68,68,0.2);">';
        html += '<h4 class="text-xl font-bold mb-4 text-red-400 flex items-center gap-2"><span>😰</span> 스트레스 프로필</h4>';
        html += '<p class="text-[15px] leading-relaxed text-wiki-text mb-4">' + stressProfile.profile + '</p>';
        if (stressProfile.triggers?.length > 0) {
            html += '<div class="mt-4 pt-4 border-t border-red-400/20"><span class="text-sm text-red-300 font-semibold">주요 트리거:</span><div class="mt-3 flex flex-wrap gap-2">';
            stressProfile.triggers.forEach(function(t) {
                html += '<span class="px-3 py-1.5 rounded-lg text-sm font-medium" style="background-color: rgba(239,68,68,0.15); color: rgb(252,165,165);">' + t + '</span>';
            });
            html += '</div></div>';
        }
        html += '</div>';
    }

    html += '</div>'; // close tab-psychology

    return html;
}

// ============================================
// MetaCognition Sections Builder (identical to job version)
// ============================================
function buildMetaCognitionSectionsMajor(metaCognition, profileInterpretation) {
    var html = '';

    // 강점 + 선호도 (2열 그리드)
    html += '<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">';

    // 1. 나의 무기고 (강점 + 약점)
    html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(59,130,246,0.08), rgba(99,102,241,0.05)); border: 1px solid rgba(59,130,246,0.15);">';
    html += '<h4 class="text-lg font-bold mb-4 text-blue-400 flex items-center gap-2"><span>💪</span> 나의 강점</h4>';

    if (metaCognition.myArsenal?.strengths?.length > 0) {
        html += '<div class="flex flex-wrap gap-2 mb-4">';
        metaCognition.myArsenal.strengths.forEach(function(s, i) {
            var icons = { '분석력': '🔍', '창작/예술': '🎨', '소통력': '💬', '체계적 실행력': '📋', '끈기': '💪', '빠른 학습': '⚡', '리더십': '👑', '공감 능력': '🤝', '꼼꼼함': '🔬', '적응력': '🌊' };
            var icon = icons[translateToKorean(s.trait)] || '✨';
            html += '<button onclick="document.getElementById(\\'strength-detail-' + i + '\\').classList.toggle(\\'hidden\\'); this.classList.toggle(\\'ring-2\\')" class="px-4 py-2 rounded-full text-[15px] font-semibold cursor-pointer transition-all hover:scale-105" style="background-color: rgba(34,197,94,0.15); color: rgb(134,239,172);">' + icon + ' ' + translateToKorean(s.trait) + '</button>';
        });
        html += '</div>';
        metaCognition.myArsenal.strengths.forEach(function(s, i) {
            html += '<div id="strength-detail-' + i + '" class="hidden mb-3 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed animate-fadeIn" style="background-color: rgba(34,197,94,0.05); border-left: 2px solid rgba(34,197,94,0.3);"><span class="font-medium text-green-300">' + translateToKorean(s.trait) + ':</span><span class="ml-1">' + s.meaning + '</span></div>';
        });
        if (metaCognition.myArsenal.counselorNote) {
            html += '<div class="mt-3 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);"><div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div><p class="text-[15px] text-wiki-text leading-relaxed italic">' + translateToKorean(metaCognition.myArsenal.counselorNote) + '</p></div>';
        }
    } else {
        html += '<p class="text-[15px] text-wiki-muted">강점 분석을 위해 더 많은 정보가 필요합니다.</p>';
    }

    if (metaCognition.myArsenal?.weaknesses?.length > 0) {
        html += '<div class="mt-5 pt-4 border-t border-wiki-border/20">';
        html += '<div class="text-[15px] font-medium text-orange-400 mb-3 flex items-center gap-2"><span>⚠️</span> 개선 가능 영역</div>';
        html += '<div class="flex flex-wrap gap-2 mb-3">';
        metaCognition.myArsenal.weaknesses.forEach(function(w) {
            html += '<span class="px-3 py-1.5 rounded-full text-[15px]" style="background-color: rgba(251,146,60,0.1); color: rgb(253,186,116);">' + translateToKorean(w.trait) + '</span>';
        });
        html += '</div>';
        html += '<details class="group"><summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1"><span class="group-open:hidden">▶ 극복 방향 보기</span><span class="hidden group-open:inline">▼ 접기</span></summary>';
        html += '<div class="mt-3 space-y-2 pl-2 border-l-2 border-orange-500/20">';
        metaCognition.myArsenal.weaknesses.forEach(function(w) {
            html += '<div class="text-[15px]"><span class="font-medium text-orange-300">' + translateToKorean(w.trait) + ':</span><span class="text-wiki-muted ml-1">' + w.meaning + '</span></div>';
        });
        html += '</div></details></div>';
    }

    html += '</div>'; // close 나의 강점

    // 2. 선호도 지도
    html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(168,85,247,0.08), rgba(236,72,153,0.05)); border: 1px solid rgba(168,85,247,0.15);">';
    html += '<h4 class="text-lg font-bold mb-4 text-purple-400 flex items-center gap-2"><span>🎯</span> 선호도 요약</h4>';
    html += '<div class="space-y-4">';

    // 좋아하는 것
    if (metaCognition.preferenceMap?.likes?.length > 0) {
        html += '<div><div class="text-[15px] font-medium text-green-400 mb-2">💚 좋아하는 것</div><div class="flex flex-wrap gap-1.5 mb-2">';
        metaCognition.preferenceMap.likes.forEach(function(l, i) {
            var icons = { '기술/IT': '💻', '문제해결': '🧩', '창작/예술': '🎨', '데이터/숫자': '📊', '사람 돕기': '🤲', '조직/관리': '📋', '영향력': '📢', '연구/탐구': '🔬', '리딩': '👑', '빌딩': '🏗️' };
            var icon = icons[translateToKorean(l.item)] || '💚';
            html += '<button onclick="document.getElementById(\\'like-detail-' + i + '\\').classList.toggle(\\'hidden\\'); this.classList.toggle(\\'ring-2\\')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(34,197,94,0.12); color: rgb(134,239,172);">' + icon + ' ' + translateToKorean(l.item) + '</button>';
        });
        html += '</div>';
        metaCognition.preferenceMap.likes.forEach(function(l, i) {
            html += '<div id="like-detail-' + i + '" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(34,197,94,0.05); border-left: 2px solid rgba(34,197,94,0.3);"><span class="font-medium text-green-300">' + translateToKorean(l.item) + ':</span><span class="ml-1">' + translateToKorean(l.why) + '</span></div>';
        });
        html += '</div>';
    }

    // 피하고 싶은 것
    if (metaCognition.preferenceMap?.dislikes?.length > 0) {
        html += '<div><div class="text-[15px] font-medium text-red-400 mb-2">🚫 피하고 싶은 것</div><div class="flex flex-wrap gap-1.5 mb-2">';
        metaCognition.preferenceMap.dislikes.forEach(function(d, i) {
            var icons = { '불규칙한 근무시간': '⏰', '재택 선호': '🏠', '야근 없음': '🌙', '출장 없음': '✈️', '교대근무 없음': '🔄', '시간 제약': '⏳', '수입 제약': '💰', '체력 제약': '🏋️', '불확실성 제약': '❓' };
            var icon = icons[translateToKorean(d.item)] || '🚫';
            html += '<button onclick="document.getElementById(\\'dislike-detail-' + i + '\\').classList.toggle(\\'hidden\\'); this.classList.toggle(\\'ring-2\\')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(239,68,68,0.12); color: rgb(252,165,165);">' + icon + ' ' + translateToKorean(d.item) + '</button>';
        });
        html += '</div>';
        metaCognition.preferenceMap.dislikes.forEach(function(d, i) {
            html += '<div id="dislike-detail-' + i + '" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(239,68,68,0.05); border-left: 2px solid rgba(239,68,68,0.3);"><span class="font-medium text-red-300">' + translateToKorean(d.item) + ':</span><span class="ml-1">' + translateToKorean(d.why) + '</span></div>';
        });
        html += '</div>';
    }

    // 잘 맞는 것
    if (metaCognition.preferenceMap?.fits?.length > 0) {
        html += '<div><div class="text-[15px] font-medium text-blue-400 mb-2">💙 잘 맞는 것</div><div class="flex flex-wrap gap-1.5 mb-2">';
        metaCognition.preferenceMap.fits.forEach(function(f, i) {
            html += '<button onclick="document.getElementById(\\'fit-detail-' + i + '\\').classList.toggle(\\'hidden\\'); this.classList.toggle(\\'ring-2\\')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(59,130,246,0.12); color: rgb(147,197,253);">💙 ' + translateToKorean(f.item) + '</button>';
        });
        html += '</div>';
        metaCognition.preferenceMap.fits.forEach(function(f, i) {
            html += '<div id="fit-detail-' + i + '" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(59,130,246,0.05); border-left: 2px solid rgba(59,130,246,0.3);"><span class="font-medium text-blue-300">' + translateToKorean(f.item) + ':</span><span class="ml-1">' + translateToKorean(f.why) + '</span></div>';
        });
        html += '</div>';
    }

    html += '</div>'; // close space-y-4

    // 상담사 노트
    if (metaCognition.preferenceMap?.counselorNote) {
        html += '<div class="mt-4 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);"><div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div><p class="text-[15px] text-wiki-text leading-relaxed italic">' + translateToKorean(metaCognition.preferenceMap.counselorNote) + '</p></div>';
    }

    html += '</div>'; // close 선호도 요약
    html += '</div>'; // close 2-col grid

    // 스트레스 + 성장 (2열 그리드)
    var hasStress = metaCognition.stressRecovery?.stressFactors?.length > 0;
    var hasGrowth = !!metaCognition.growthPotential;
    html += '<div class="grid grid-cols-1 ' + (hasStress && hasGrowth ? 'md:grid-cols-2' : '') + ' gap-6 mb-6">';

    // 4. 스트레스 & 회복
    if (hasStress) {
        html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(239,68,68,0.08), rgba(251,146,60,0.05)); border: 1px solid rgba(239,68,68,0.15);">';
        html += '<h4 class="text-lg font-bold mb-4 text-red-400 flex items-center gap-2"><span>⚡</span> 스트레스 요인</h4>';
        html += '<div class="flex flex-wrap gap-2 mb-4">';
        metaCognition.stressRecovery.stressFactors.forEach(function(s, i) {
            var icons = { '반복 업무 피로': '🔄', '관료주의 스트레스': '📑', '사람 상대 피로': '👥', '인지 과부하': '🧠', '시간 압박': '⏰', '책임감 부담': '⚖️', '예측 불가': '🌪️', '갈등 상황': '💢', '멀티태스킹': '🔀', '불확실성': '❓' };
            var icon = icons[translateToKorean(s.factor)] || '⚡';
            html += '<button onclick="document.getElementById(\\'stress-detail-' + i + '\\').classList.toggle(\\'hidden\\'); this.classList.toggle(\\'ring-2\\')" class="px-3 py-1.5 rounded-full text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(239,68,68,0.12); color: rgb(252,165,165);">' + icon + ' ' + translateToKorean(s.factor) + '</button>';
        });
        html += '</div>';
        metaCognition.stressRecovery.stressFactors.forEach(function(s, i) {
            html += '<div id="stress-detail-' + i + '" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(239,68,68,0.05); border-left: 2px solid rgba(239,68,68,0.3);"><span class="font-medium text-red-300">' + translateToKorean(s.factor) + ':</span><span class="ml-1">' + translateToKorean(s.why) + '</span></div>';
        });
        if (metaCognition.stressRecovery.counselorNote) {
            html += '<div class="mt-3 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);"><div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div><p class="text-[15px] text-wiki-text leading-relaxed italic">' + translateToKorean(metaCognition.stressRecovery.counselorNote) + '</p></div>';
        }
        if (metaCognition.stressRecovery?.recoveryMethods?.length > 0) {
            html += '<div class="mt-4 pt-4 border-t border-wiki-border/20">';
            html += '<div class="text-[15px] font-medium text-emerald-400 mb-2 flex items-center gap-2"><span>🌿</span> 회복 방법</div>';
            html += '<div class="flex flex-wrap gap-2 mb-3">';
            metaCognition.stressRecovery.recoveryMethods.forEach(function(r) {
                html += '<span class="px-3 py-1.5 rounded-full text-[15px] font-medium" style="background-color: rgba(16,185,129,0.12); color: rgb(110,231,183);">' + translateToKorean(r.factor) + '</span>';
            });
            html += '</div>';
            html += '<details class="group"><summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1"><span class="group-open:hidden">▶ 왜 회복되는지 이해하기</span><span class="hidden group-open:inline">▼ 접기</span></summary>';
            html += '<div class="mt-3 space-y-2 text-[15px]">';
            metaCognition.stressRecovery.recoveryMethods.forEach(function(r) {
                html += '<div class="p-3 rounded-lg" style="background-color: rgba(16,185,129,0.05);"><span class="font-medium text-emerald-300">' + translateToKorean(r.factor) + ':</span><span class="text-wiki-muted ml-1">' + translateToKorean(r.why) + '</span></div>';
            });
            html += '</div></details></div>';
        }
        html += '</div>';
    }

    // 5. 성장 가능성
    if (hasGrowth) {
        html += '<div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(16,185,129,0.08), rgba(52,211,153,0.05)); border: 1px solid rgba(16,185,129,0.15);">';
        html += '<h4 class="text-lg font-bold mb-4 text-emerald-400 flex items-center gap-2"><span>🌱</span> 성장 가능성</h4>';
        if (metaCognition.growthPotential.leveragePoints?.length > 0) {
            html += '<div class="flex flex-wrap gap-2 mb-4">';
            metaCognition.growthPotential.leveragePoints.forEach(function(p) {
                var icons = { '분석력': '🔍', '창작/예술': '🎨', '소통력': '💬', '체계적 실행력': '📋', '끈기': '💪', '빠른 학습': '⚡', '리더십': '👑', '공감 능력': '🤝', '꼼꼼함': '🔬', '적응력': '🌊' };
                var icon = icons[translateToKorean(p)] || '✨';
                html += '<span class="px-3 py-1.5 rounded-full text-[15px] font-medium" style="background-color: rgba(16,185,129,0.12); color: rgb(110,231,183);">' + icon + ' ' + translateToKorean(p) + '</span>';
            });
            html += '</div>';
        }
        if (metaCognition.growthPotential.counselorNote) {
            html += '<div class="p-4 rounded-xl mb-4" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);"><div class="text-[15px] font-medium mb-2" style="color: rgb(251,191,36);">💡 상담사 노트</div><p class="text-[15px] text-wiki-text leading-relaxed italic">' + translateToKorean(metaCognition.growthPotential.counselorNote) + '</p></div>';
        }
        if (metaCognition.growthPotential.direction) {
            html += '<details class="group"><summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1"><span class="group-open:hidden">▶ 성장 방향 상세 보기</span><span class="hidden group-open:inline">▼ 접기</span></summary>';
            html += '<div class="mt-3 p-4 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(16,185,129,0.05);">🎯 ' + translateToKorean(metaCognition.growthPotential.direction) + '</div>';
            html += '</details>';
        }
        html += '</div>';
    }

    html += '</div>'; // close stress+growth grid
    html += '<hr class="border-wiki-border/20 my-8" />';

    return html;
}

// ============================================
// Recommendations Tab Builder
// ============================================
function buildRecommendationsTabMajor(profileInterpretation, overallTop5, fitTop10, likeTop10) {
    var html = '';

    html += '<div id="tab-recommendations" class="report-tab-content hidden glass-card p-6 rounded-2xl mb-6">';
    html += '<div class="mb-8 pb-6">';
    html += '<h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">';
    html += '<span class="text-3xl">🎓</span>';
    html += '<span class="bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">추천 전공</span>';
    html += '</h2>';
    html += '<p class="text-center text-wiki-muted text-sm mt-2">당신에게 맞는 전공을 AI가 분석했습니다.</p>';
    html += '<div class="mt-6 h-px bg-gradient-to-r from-transparent via-emerald-500/50 to-transparent"></div>';
    html += '</div>';

    // 프로필 기반 추천 요약
    if (profileInterpretation) {
        html += '<div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.08)); border: 1px solid rgba(99,102,241,0.2);">';
        html += '<h4 class="text-lg font-bold mb-3 flex items-center gap-2" style="color: rgb(165,180,252);"><span>📌</span> 당신의 프로필 기반 추천</h4>';
        html += '<div class="grid grid-cols-2 md:grid-cols-4 gap-3 mb-4">';
        if (profileInterpretation.interests?.length > 0) {
            html += '<div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(34,197,94,0.1);"><span class="text-green-400">💚</span><div><div class="text-base font-semibold text-green-400">흥미</div><div class="text-[15px] text-white">' + profileInterpretation.interests.slice(0, 2).map(function(i) { return i.label; }).join(', ') + '</div></div></div>';
        }
        if (profileInterpretation.strengths?.length > 0) {
            html += '<div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(59,130,246,0.1);"><span class="text-blue-400">💪</span><div><div class="text-base font-semibold text-blue-400">강점</div><div class="text-[15px] text-white">' + profileInterpretation.strengths.slice(0, 2).map(function(s) { return s.label; }).join(', ') + '</div></div></div>';
        }
        if (profileInterpretation.values?.length > 0) {
            html += '<div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(168,85,247,0.1);"><span class="text-purple-400">⭐</span><div><div class="text-base font-semibold text-purple-400">가치</div><div class="text-[15px] text-white">' + profileInterpretation.values.slice(0, 2).map(function(v) { return v.label; }).join(', ') + '</div></div></div>';
        }
        if (profileInterpretation.constraints?.length > 0) {
            html += '<div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(239,68,68,0.1);"><span class="text-red-400">🚫</span><div><div class="text-base font-semibold text-red-400">제약</div><div class="text-[15px] text-white">' + profileInterpretation.constraints.slice(0, 2).map(function(c) { return c.label; }).join(', ') + '</div></div></div>';
        }
        html += '</div>';
        html += '<p class="text-[15px] text-wiki-muted">이 조건들을 종합하여 <span class="text-wiki-primary font-medium">' + (fitTop10.length || overallTop5.length) + '개</span>의 전공을 추천합니다.</p>';
        html += '</div>';
    }

    // 3세트 탭
    html += '<div class="flex gap-3 mb-6">';
    html += '<button onclick="showMajorSet(\\'overall\\')" class="major-set-tab active flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="overall"><span class="flex items-center justify-center gap-2"><span class="text-lg">🏆</span><span>종합 추천</span></span></button>';
    html += '<button onclick="showMajorSet(\\'fit\\')" class="major-set-tab flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="fit"><span class="flex items-center justify-center gap-2"><span class="text-lg">💪</span><span>잘 맞을 것 같은 전공</span></span></button>';
    html += '<button onclick="showMajorSet(\\'desire\\')" class="major-set-tab flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="desire"><span class="flex items-center justify-center gap-2"><span class="text-lg">💖</span><span>좋아할만한 전공</span></span></button>';
    html += '</div>';

    // 전공 카드들
    html += '<div id="major-cards-container">';
    var initialMajors = (fitTop10.length > 0 ? fitTop10 : overallTop5).slice(0, 10);
    html += renderMajorCardsV3(initialMajors, 'overall', profileInterpretation);
    html += '</div>';

    html += '</div>'; // close tab-recommendations

    return html;
}

// ============================================
// Details Tab Builder
// ============================================
function buildDetailsTabMajor(result, report) {
    var html = '';

    html += '<div id="tab-details" class="report-tab-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">';
    html += '<div class="mb-8 pb-6">';
    html += '<h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3"><span class="text-3xl">📊</span><span class="bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">분석 상세 정보</span></h2>';
    html += '<p class="text-center text-wiki-muted text-sm mt-2">AI 추천의 근거와 기술적 분석을 확인하세요.</p>';
    html += '<p class="text-center text-wiki-muted text-xs mt-1">엔진 버전: ' + (result.engine_version || 'unknown') + '</p>';
    html += '<div class="mt-6 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>';
    html += '</div>';
    html += '<p class="text-base text-wiki-muted mb-6">이 섹션은 AI 추천의 근거, 사용된 알고리즘, 그리고 점수 산출 과정을 상세히 보여줍니다.</p>';

    // 분석 파이프라인 설명
    html += '<div class="mb-8 p-5 rounded-xl" style="background: linear-gradient(135deg, rgba(34,197,94,0.1), rgba(16,185,129,0.05)); border: 1px solid rgba(34,197,94,0.2);">';
    html += '<h4 class="text-xl font-bold mb-4 text-emerald-400">🔬 분석 파이프라인</h4>';
    html += '<div class="space-y-4 text-base">';
    html += '<div class="flex items-start gap-3"><span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">1</span><div><p class="font-medium text-white">벡터 검색 (Vectorize)</p><p class="text-wiki-muted text-[15px]">당신의 답변을 임베딩으로 변환하여 전공 DB에서 의미적으로 유사한 후보를 검색합니다.</p></div></div>';
    html += '<div class="flex items-start gap-3"><span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">2</span><div><p class="font-medium text-white">TAG 필터링 (Hard Constraints)</p><p class="text-wiki-muted text-[15px]">학습 환경, 선호도 등 절대 조건에 맞지 않는 전공을 제외합니다.</p></div></div>';
    html += '<div class="flex items-start gap-3"><span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">3</span><div><p class="font-medium text-white">LLM Judge (GPT-4o-mini)</p><p class="text-wiki-muted text-[15px]">남은 후보 전공에 대해 AI가 Like/Can/Fit 점수를 계산하고, 추천 이유를 생성합니다.</p></div></div>';
    html += '<div class="flex items-start gap-3"><span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">4</span><div><p class="font-medium text-white">LLM Reporter (심리분석)</p><p class="text-wiki-muted text-[15px]">당신의 미니모듈 결과를 바탕으로 학습 스타일과 전공 방향을 분석합니다.</p></div></div>';
    html += '</div></div>';

    // 입력 데이터 요약
    html += '<div class="mb-8">';
    html += '<h4 class="text-xl font-bold mb-4">📝 분석에 사용된 입력 데이터</h4>';
    html += '<div class="grid grid-cols-2 md:grid-cols-4 gap-4">';
    html += '<div class="p-4 rounded-xl bg-wiki-bg/50 text-center"><div class="text-3xl font-bold text-wiki-primary">' + (report._factsCount || 0) + '</div><div class="text-base text-wiki-muted mt-1">수집된 팩트</div></div>';
    html += '<div class="p-4 rounded-xl bg-wiki-bg/50 text-center"><div class="text-3xl font-bold text-emerald-400">' + (report._answeredQuestions || 0) + '</div><div class="text-base text-wiki-muted mt-1">답변한 질문</div></div>';
    html += '<div class="p-4 rounded-xl bg-wiki-bg/50 text-center"><div class="text-3xl font-bold text-purple-400">' + (report._totalJobCount || report._candidatesScored || 0).toLocaleString() + '</div><div class="text-base text-wiki-muted mt-1">분석 대상 전공</div></div>';
    html += '<div class="p-4 rounded-xl bg-wiki-bg/50 text-center"><div class="text-3xl font-bold text-amber-400">6</div><div class="text-base text-wiki-muted mt-1">LLM 호출 횟수</div></div>';
    html += '</div></div>';

    // AI 추천 시스템 작동 원리
    html += '<div class="mb-8 p-5 rounded-xl" style="background-color: rgba(99,102,241,0.1); border: 1px solid rgba(99,102,241,0.2);">';
    html += '<h4 class="text-xl font-bold mb-4" style="color: rgb(165,180,252);">🎯 AI 추천은 이렇게 만들어집니다</h4>';
    html += '<p class="text-[15px] text-wiki-muted mb-5">이 리포트는 단순 키워드 매칭이 아닌, 3단계 AI 시스템을 거쳐 생성됩니다.</p>';

    // STEP 1 RAG
    html += '<div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);"><div class="flex items-center gap-2 mb-2"><span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(34,197,94,0.2); color: rgb(34,197,94);">STEP 1</span><span class="font-bold text-white text-base">RAG — 의미 기반 후보 검색</span></div><p class="text-[14px] text-wiki-muted leading-relaxed mb-2">당신의 답변 전체를 AI 임베딩(숫자 벡터)으로 변환한 뒤, 전공 DB에서 <span class="text-emerald-400">의미적으로 가장 가까운 전공들</span>을 찾습니다.</p><p class="text-[13px] text-wiki-muted/70">"데이터 분석을 좋아한다"고 답하면, 전공명에 \\'분석\\'이 없더라도 데이터 관련 학습을 하는 전공이 후보에 포함됩니다.</p></div>';

    // STEP 2 TAG
    html += '<div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);"><div class="flex items-center gap-2 mb-2"><span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(251,191,36,0.2); color: rgb(251,191,36);">STEP 2</span><span class="font-bold text-white text-base">TAG — 절대 조건 필터링</span></div><p class="text-[14px] text-wiki-muted leading-relaxed mb-2">후보 전공들의 속성 태그를 당신의 <span class="text-amber-400">제약 조건</span>과 대조합니다.</p><p class="text-[13px] text-wiki-muted/70">"절대 안 돼" 수준의 제약은 해당 전공을 후보에서 완전히 제거합니다.</p></div>';

    // STEP 3 CAG
    html += '<div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);"><div class="flex items-center gap-2 mb-2"><span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(99,102,241,0.2); color: rgb(129,140,248);">STEP 3</span><span class="font-bold text-white text-base">CAG — AI가 직접 평가</span></div><p class="text-[14px] text-wiki-muted leading-relaxed mb-2">남은 후보 전공 각각에 대해, GPT-4o-mini가 당신의 프로필 전체를 읽고 <span class="text-indigo-400">Like(좋아할 가능성)</span>와 <span class="text-blue-400">Can(잘할 가능성)</span> 점수를 매깁니다.</p><p class="text-[13px] text-wiki-muted/70">AI는 단순히 숫자만 매기는 것이 아니라, "왜 이 전공을 좋아할지", "왜 잘할 수 있는지"에 대한 구체적인 이유도 함께 생성합니다.</p></div>';

    // 최종 점수
    html += '<div class="p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);"><div class="flex items-center gap-2 mb-2"><span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(168,85,247,0.2); color: rgb(192,132,252);">최종</span><span class="font-bold text-white text-base">종합 점수 계산 (Fit)</span></div><p class="text-[14px] text-wiki-muted leading-relaxed mb-3">AI가 매긴 점수를 아래 공식으로 조합하여 최종 순위를 결정합니다.</p>';
    html += '<div class="p-3 rounded-lg text-center" style="background: rgba(99,102,241,0.15); border: 1px solid rgba(99,102,241,0.3);"><p class="text-base font-bold text-white" style="font-family: monospace;">Fit = Like + Can + Background</p></div>';
    html += '<div class="mt-3 space-y-1 text-[13px] text-wiki-muted/80"><p><span class="text-purple-400 font-medium">Like</span> — 좋아할 전공을 중요하게 반영합니다. 흥미와 가치관이 맞아야 오래 갈 수 있기 때문입니다.</p><p><span class="text-blue-400 font-medium">Can</span> — 잘할 수 있는 전공도 함께 반영합니다. 강점과 역량이 맞아야 성과를 낼 수 있습니다.</p><p><span class="text-amber-400 font-medium">Background</span> — 경력, 학력, 경험이 전공과 얼마나 관련 있는지 평가합니다.</p></div>';
    html += '</div></div>';

    // 점수 계산 방식
    html += '<div class="mb-8 rounded-xl overflow-hidden" style="border: 1px solid rgba(255,255,255,0.08);">';
    html += '<div class="px-5 py-3" style="background: rgba(255,255,255,0.04); border-bottom: 1px solid rgba(255,255,255,0.08);"><h4 class="text-base font-bold text-wiki-text">💡 점수 계산 방식</h4></div>';
    html += '<div class="divide-y" style="--tw-divide-opacity: 0.06; --tw-divide-color: rgba(255,255,255,var(--tw-divide-opacity));">';
    html += '<div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(52,211,153);"><span class="text-emerald-400 font-bold text-sm w-10 shrink-0 text-center">Fit</span><span class="text-white text-sm font-medium w-20 shrink-0">종합 적합도</span><span class="text-wiki-muted text-[13px]">Like + Can + Background 종합</span></div>';
    html += '<div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(168,85,247);"><span class="text-purple-400 font-bold text-sm w-10 shrink-0 text-center">Like</span><span class="text-white text-sm font-medium w-20 shrink-0">좋아할 가능성</span><span class="text-wiki-muted text-[13px]">관심 분야, 가치관, 우선순위와 전공 특성의 일치도</span></div>';
    html += '<div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(96,165,250);"><span class="text-blue-400 font-bold text-sm w-10 shrink-0 text-center">Can</span><span class="text-white text-sm font-medium w-20 shrink-0">잘할 가능성</span><span class="text-wiki-muted text-[13px]">강점, 학습 스타일, 경험과 전공 요구사항의 적합도</span></div>';
    html += '<div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(251,191,36);"><span class="text-amber-400 font-bold text-sm w-10 shrink-0 text-center">Bg</span><span class="text-white text-sm font-medium w-20 shrink-0">배경 적합도</span><span class="text-wiki-muted text-[13px]">경력, 학력, 자격증, 경험 등 배경의 도움 정도</span></div>';
    html += '</div></div>';

    // 데이터 소스
    html += '<div class="p-5 rounded-xl" style="background: linear-gradient(135deg, rgba(139,92,246,0.1), rgba(99,102,241,0.05)); border: 1px solid rgba(139,92,246,0.2);">';
    html += '<h4 class="text-xl font-bold mb-4 text-purple-400">📚 데이터 소스</h4>';
    html += '<div class="grid md:grid-cols-2 gap-4 text-base">';
    html += '<div><p class="font-medium text-white mb-1">전공 정보</p><p class="text-wiki-muted text-[15px]">커리어넷 + 대학 정보 데이터 통합</p></div>';
    html += '<div><p class="font-medium text-white mb-1">전공 속성 태깅</p><p class="text-wiki-muted text-[15px]">major_attributes 테이블: 학습환경, 진로 방향 등 속성</p></div>';
    html += '<div><p class="font-medium text-white mb-1">임베딩 모델</p><p class="text-wiki-muted text-[15px]">OpenAI text-embedding-3-small (1536차원)</p></div>';
    html += '<div><p class="font-medium text-white mb-1">판단 모델</p><p class="text-wiki-muted text-[15px]">GPT-4o-mini (Like/Can/Fit 점수 및 추천 이유 생성)</p></div>';
    html += '</div></div>';

    html += '</div>'; // close tab-details

    return html;
}

// ============================================
// Bottom Buttons Builder
// ============================================
function buildBottomButtonsMajor() {
    var html = '';

    html += '<div class="flex flex-col sm:flex-row gap-3 justify-center mt-8">';
    html += '<button onclick="showEditWarningModal()" class="inline-flex items-center justify-center gap-2 px-5 py-3 rounded-xl text-sm font-medium transition hover:opacity-80" style="background: rgba(251, 191, 36, 0.15); color: #fbbf24; border: 1px solid rgba(251, 191, 36, 0.3);"><i class="fas fa-edit"></i> 입력한 내용 수정</button>';
    html += '<button onclick="showAddContextModal()" class="inline-flex items-center justify-center gap-2 px-5 py-3 rounded-xl text-sm font-medium transition hover:opacity-80" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3);"><i class="fas fa-plus"></i> 새로운 내용 추가</button>';
    html += '</div>';

    // 입력 수정 경고 모달
    html += '<div id="edit-warning-modal" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center hidden">';
    html += '<div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-lg mx-4 shadow-2xl w-full max-h-[90vh] overflow-y-auto">';
    html += '<div class="mb-5"><div class="w-12 h-12 mx-auto mb-4 bg-amber-500/20 rounded-full flex items-center justify-center"><i class="fas fa-exclamation-triangle text-xl text-amber-400"></i></div>';
    html += '<h3 class="text-lg font-bold text-white text-center mb-2">입력 내용 수정 안내</h3>';
    html += '<p class="text-sm text-wiki-muted text-center">기존에 입력했던 내용을 수정할 수 있습니다.<br>단, 수정 범위에 따라 이후 단계의 답변이 초기화될 수 있습니다.</p></div>';
    html += '<div class="space-y-4 mb-6">';
    html += '<div class="p-3 rounded-lg" style="background: rgba(251, 191, 36, 0.08); border: 1px solid rgba(251, 191, 36, 0.2);"><p class="text-sm font-medium text-amber-300 mb-1">Step 1 (프로필 기본정보) 수정 시</p><p class="text-xs text-wiki-muted">Step 2(심층 질문)의 질문이 새로 생성되며, 기존 심층 질문 답변이 모두 초기화됩니다.</p></div>';
    html += '<div class="p-3 rounded-lg" style="background: rgba(251, 191, 36, 0.08); border: 1px solid rgba(251, 191, 36, 0.2);"><p class="text-sm font-medium text-amber-300 mb-1">Step 2 (심층 질문) 답변 수정 시</p><p class="text-xs text-wiki-muted">수정한 라운드 이후의 질문들이 새로 생성되며, 해당 라운드 이후 답변이 초기화됩니다.</p></div>';
    html += '</div>';
    html += '<div class="flex gap-3">';
    html += '<button onclick="hideEditWarningModal()" class="flex-1 px-4 py-2.5 bg-wiki-bg border border-wiki-border text-white rounded-xl hover:bg-wiki-card transition text-sm font-medium">취소</button>';
    html += '<button onclick="navigateToEditMode()" class="flex-1 px-4 py-2.5 bg-gradient-to-r from-amber-500 to-orange-500 text-white rounded-xl hover:opacity-90 transition text-sm font-medium">수정 시작하기</button>';
    html += '</div></div></div>';

    // 내용 추가 모달
    html += '<div id="add-context-modal" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center hidden">';
    html += '<div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-md mx-4 shadow-2xl w-full">';
    html += '<div class="mb-5"><h3 class="text-lg font-bold text-white mb-2"><i class="fas fa-plus text-emerald-400 mr-2"></i>추가 정보 입력</h3>';
    html += '<p class="text-sm text-wiki-muted">현재 분석에 반영하고 싶은 추가 정보를 자유롭게 작성해주세요.</p></div>';
    html += '<textarea id="additional-context-text" class="w-full h-32 p-3 rounded-xl text-sm text-white placeholder-wiki-muted resize-none focus:outline-none focus:ring-2 focus:ring-emerald-500/50" style="background: rgba(15, 15, 35, 0.6); border: 1px solid rgba(148, 163, 184, 0.2);" placeholder="예: 수학에 관심이 많고 프로그래밍을 좋아합니다. 실험보다는 이론 학습을 선호합니다." minlength="30"></textarea>';
    html += '<p id="context-char-count" class="text-xs mt-1 text-wiki-muted">0 / 최소 30자</p>';
    html += '<div class="flex gap-3 mt-4">';
    html += '<button onclick="hideAddContextModal()" class="flex-1 px-4 py-2.5 bg-wiki-bg border border-wiki-border text-white rounded-xl hover:bg-wiki-card transition text-sm font-medium">취소</button>';
    html += '<button id="submit-context-btn" onclick="submitAdditionalContext()" disabled class="flex-1 px-4 py-2.5 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-xl hover:opacity-90 transition text-sm font-medium disabled:opacity-50 disabled:cursor-not-allowed">추가 후 재분석</button>';
    html += '</div></div></div>';

    return html;
}

// ============================================
// Tab Switching (Major)
// ============================================
function showReportTabMajor(tabId) {
    document.querySelectorAll('.report-tab-content').forEach(function(el) { el.classList.add('hidden'); });
    document.querySelectorAll('.report-tab').forEach(function(el) { el.classList.remove('active'); });

    var tab = document.getElementById('tab-' + tabId);
    if (tab) tab.classList.remove('hidden');
    var btn = document.querySelector('.report-tab[data-tab="' + tabId + '"]');
    if (btn) btn.classList.add('active');
}

// ============================================
// Major Set Switching (recommendation sub-tabs)
// ============================================
function showMajorSet(setId) {
    var data = window.currentReportData;
    if (!data) return;

    var majorList = [];

    if (setId === 'overall') majorList = (data.fitTop10 || data.overallTop5 || []).slice(0, 10);
    else if (setId === 'fit') majorList = (data.fitTop10 || []).slice(0, 10);
    else if (setId === 'desire') majorList = (data.likeTop10 || data.fitTop10 || []).slice(0, 10);

    var container = document.getElementById('major-cards-container');
    if (container) container.innerHTML = renderMajorCardsV3(majorList, setId, data.profileInterpretation);

    document.querySelectorAll('.major-set-tab').forEach(function(el) { el.classList.remove('active'); });
    var activeBtn = document.querySelector('.major-set-tab[data-set="' + setId + '"]');
    if (activeBtn) activeBtn.classList.add('active');
}

function escapeHtmlMajor(str) {
    if (!str) return '';
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

// ============================================
// Major Card Rendering (V3 compact design)
// ============================================
function renderMajorCardsV3(majors, setId, profileInterp) {
    if (!majors || majors.length === 0) {
        return '<p class="text-wiki-muted text-center py-8">추천 결과가 없습니다.</p>';
    }

    setId = setId || 'overall';
    profileInterp = profileInterp || null;

    return majors.map(function(major, idx) {
        // 종합 추천 탭: 2단 섹션 구분 (Top 5 + 탐색해볼 전공)
        var sectionHeader = '';
        if (setId === 'overall' && majors.length > 5) {
            if (idx === 0) {
                sectionHeader = '<div class="mb-4"><h3 class="text-lg font-bold flex items-center gap-2"><span>🎯</span><span class="bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">당신에게 맞는 전공</span></h3><p class="text-sm mt-1" style="color: rgba(148,163,184,0.7);">AI가 분석한 최적의 전공 추천</p></div>';
            } else if (idx === 5) {
                sectionHeader = '<div class="mt-8 mb-4 pt-5" style="border-top: 1px solid rgba(99,102,241,0.15);"><h3 class="text-lg font-bold flex items-center gap-2"><span>🧭</span><span class="text-wiki-muted">탐색해볼 전공</span></h3><p class="text-sm mt-1" style="color: rgba(148,163,184,0.7);">관심을 넓혀볼 수 있는 전공들이에요</p></div>';
            }
        }

        var majorName = major.major_name || major.major_id || '전공';
        var majorSlug = major.slug || major.major_id || '';
        var imageUrl = major.image_url || '';
        // 브라우저가 <img src>에서 한글 URL 인코딩을 자동 처리 — encodeURIComponent 불필요
        var rationale = major.rationale || major.one_line_why || '';
        var description = (major.major_description || major.description || major.summary || '').replace(/\\n\\n/g, ' ').replace(/\\n/g, ' ').trim();
        var displayDescription = description || '';
        var fitScore = major.scores?.fit || major.fit_score || '-';
        var likeScore = major.scores?.like || major.like_score || '-';
        var canScore = major.scores?.can || major.can_score || '-';
        var fieldCategory = major.field_category || '';

        // 탭별 주점수 결정
        var mainScore, mainScoreLabel, mainScoreColor;
        var likeReasonText = major.like_reason || '';
        var canReasonText = major.can_reason || '';
        var feasibilityReasonText = major.feasibility_reason || '';

        var isAutoGenerated = rationale.includes('자동 생성된 결과') || rationale.includes('LLM 분석이 진행되지');
        if (likeReasonText.includes('자동 생성된 결과')) likeReasonText = '';
        if (canReasonText.includes('자동 생성된 결과')) canReasonText = '';

        if (!likeReasonText && !isAutoGenerated && rationale && !rationale.includes('[')) {
            likeReasonText = rationale;
        }
        if (!likeReasonText && likeScore !== '-') {
            var ls = parseInt(likeScore) || 0;
            if (ls >= 70) likeReasonText = '당신의 관심사와 가치관에 잘 맞는 전공입니다.';
            else if (ls >= 50) likeReasonText = '흥미로운 학습 환경을 제공할 수 있습니다.';
        }
        if (!canReasonText && canScore !== '-') {
            var cs = parseInt(canScore) || 0;
            if (cs >= 70) canReasonText = '당신의 강점을 잘 발휘할 수 있는 분야입니다.';
            else if (cs >= 50) canReasonText = '성장 가능성이 있는 분야입니다.';
        }

        if (setId === 'desire') {
            mainScore = likeScore; mainScoreLabel = 'Like'; mainScoreColor = 'text-purple-400';
        } else if (setId === 'fit') {
            mainScore = canScore; mainScoreLabel = 'Can'; mainScoreColor = 'text-blue-400';
        } else {
            mainScore = fitScore; mainScoreLabel = 'Fit'; mainScoreColor = 'text-emerald-400';
        }

        // 이유 HTML 생성
        var reasonOuterHtml = '';
        if (setId === 'overall') {
            if (likeReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-purple-400 font-medium shrink-0 text-[13px] w-12">💜 Like</span><p class="text-[14px] text-purple-300/90 leading-relaxed">' + likeReasonText + '</p></div>';
            if (canReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-blue-400 font-medium shrink-0 text-[13px] w-12">💪 Can</span><p class="text-[14px] text-blue-300/90 leading-relaxed">' + canReasonText + '</p></div>';
            if (feasibilityReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-amber-400 font-medium shrink-0 text-[13px] w-12">🎯 배경</span><p class="text-[14px] text-amber-300/90 leading-relaxed">' + feasibilityReasonText + '</p></div>';
        } else if (setId === 'desire') {
            if (likeReasonText) reasonOuterHtml = '<div class="flex gap-3 items-start"><span class="text-purple-400 font-medium shrink-0 text-[13px] w-12">💜 Like</span><p class="text-[14px] text-purple-300/90 leading-relaxed">' + likeReasonText + '</p></div>';
        } else {
            if (canReasonText) reasonOuterHtml = '<div class="flex gap-3 items-start"><span class="text-blue-400 font-medium shrink-0 text-[13px] w-12">💪 Can</span><p class="text-[14px] text-blue-300/90 leading-relaxed">' + canReasonText + '</p></div>';
            if (feasibilityReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-amber-400 font-medium shrink-0 text-[13px] w-12">🎯 배경</span><p class="text-[14px] text-amber-300/90 leading-relaxed">' + feasibilityReasonText + '</p></div>';
        }

        var rankBadge = idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : '' + (idx + 1);

        // 프로필 매칭 포인트
        var matchingTags = [];
        var likeNum = parseInt(likeScore) || 0;
        var canNum = parseInt(canScore) || 0;
        var pi = profileInterp || {};
        var interestLabels = (pi.interests || []).slice(0, 2).map(function(i) { return i.label; });
        var strengthLabels = (pi.strengths || []).slice(0, 2).map(function(s) { return s.label; });

        if (likeNum >= 65 && interestLabels.length > 0) {
            matchingTags.push({ icon: '💚', label: interestLabels[0] + ' 흥미', color: 'green' });
        }
        if (canNum >= 65 && strengthLabels.length > 0) {
            matchingTags.push({ icon: '💪', label: strengthLabels[0] + ' 강점', color: 'blue' });
        }

        var matchingTagsHtml = '';
        if (matchingTags.length > 0) {
            matchingTagsHtml = '<div class="flex flex-wrap gap-1.5 mt-2">';
            matchingTags.forEach(function(tag) {
                var rgb = tag.color === 'green' ? '34,197,94' : '59,130,246';
                var textRgb = tag.color === 'green' ? '134,239,172' : '147,197,253';
                matchingTagsHtml += '<span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs" style="background: rgba(' + rgb + ',0.15); color: rgb(' + textRgb + ');"><span>' + tag.icon + '</span><span>' + tag.label + '</span></span>';
            });
            matchingTagsHtml += '</div>';
        }

        // 점수 바
        var fitNum = parseInt(fitScore) || 0;
        var likeNum2 = parseInt(likeScore) || 0;
        var canNum2 = parseInt(canScore) || 0;
        var bgScore = major.feasibility_score || major.feasibilityScore || 0;

        var cardHtml = '';
        cardHtml += '<div class="rounded-2xl overflow-hidden group transition-all mb-4" style="background: linear-gradient(135deg, rgba(30,30,50,0.9), rgba(25,25,45,0.95)); border: 1px solid rgba(99,102,241,' + (idx < 3 ? '0.25' : '0.12') + ');">';

        // 상단: 썸네일 + 전공 정보
        cardHtml += '<div class="flex items-stretch">';

        // 썸네일
        if (imageUrl && imageUrl.trim()) {
            cardHtml += '<div class="flex-shrink-0 w-28 sm:w-32 relative overflow-hidden">';
            cardHtml += '<img src="' + escapeHtmlMajor(imageUrl) + '" alt="' + escapeHtmlMajor(majorName) + '" class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-300" onerror="this.onerror=null; this.parentElement.innerHTML=\\'<div class=\\\\\\'w-full h-full flex items-center justify-center\\\\\\' style=\\\\\\'background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(139,92,246,0.1));\\\\\\' ><i class=\\\\\\'fas fa-graduation-cap text-2xl text-wiki-muted\\\\\\'></i></div>\\';" />';
            cardHtml += '<div class="absolute top-2 left-2 w-7 h-7 flex items-center justify-center rounded-full" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(4px);"><span class="' + (idx < 3 ? 'text-sm' : 'text-xs font-bold text-wiki-muted') + '">' + rankBadge + '</span></div>';
            cardHtml += '</div>';
        } else {
            cardHtml += '<div class="flex-shrink-0 w-28 sm:w-32 relative flex items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(139,92,246,0.1));">';
            cardHtml += '<i class="fas fa-graduation-cap text-2xl text-wiki-muted"></i>';
            cardHtml += '<div class="absolute top-2 left-2 w-7 h-7 flex items-center justify-center rounded-full" style="background: rgba(0,0,0,0.6);"><span class="' + (idx < 3 ? 'text-sm' : 'text-xs font-bold text-wiki-muted') + '">' + rankBadge + '</span></div>';
            cardHtml += '</div>';
        }

        // 전공 정보 + 점수
        cardHtml += '<div class="flex-1 min-w-0 p-4 flex flex-col justify-between"><div>';
        cardHtml += '<div class="flex items-start justify-between gap-3 mb-1.5">';
        cardHtml += '<a href="/major/' + encodeURIComponent(majorSlug) + '" target="_blank" rel="noopener noreferrer" class="group-hover:text-wiki-primary transition"><h4 class="font-bold text-lg text-white leading-tight">' + escapeHtmlMajor(majorName) + '</h4></a>';
        cardHtml += '<div class="flex-shrink-0 text-right"><span class="text-xl font-bold ' + mainScoreColor + '">' + mainScore + '</span><span class="text-xs text-wiki-muted ml-0.5">' + mainScoreLabel + '</span></div>';
        cardHtml += '</div>';

        if (fieldCategory) {
            var fieldCategoryKr = {engineering:'공학',natural_science:'자연과학',social_science:'사회과학',humanities:'인문학',arts:'예술/체육',medical:'의약/보건',education:'교육',business:'경영/경제',law:'법학',agriculture:'농림/수산',general:'기타'}[fieldCategory] || fieldCategory;
            cardHtml += '<div class="text-xs text-wiki-muted mb-1.5">' + escapeHtmlMajor(fieldCategoryKr) + '</div>';
        }
        if (displayDescription) {
            cardHtml += '<p class="text-[14px] text-wiki-muted line-clamp-2 leading-relaxed mb-2">' + escapeHtmlMajor(displayDescription) + '</p>';
        }
        cardHtml += matchingTagsHtml;
        cardHtml += '</div>';

        // 점수 바
        cardHtml += '<div class="flex items-center gap-3 mt-3 pt-2.5" style="border-top: 1px solid rgba(255,255,255,0.06);">';
        cardHtml += '<div class="flex-1"><div class="flex items-center justify-between mb-1"><span class="text-[11px] text-emerald-400/80 font-medium">Fit</span><span class="text-[11px] text-emerald-400 font-semibold">' + fitScore + '</span></div><div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);"><div class="h-full rounded-full transition-all" style="width: ' + Math.min(fitNum, 100) + '%; background: rgb(52,211,153);"></div></div></div>';
        cardHtml += '<div class="flex-1"><div class="flex items-center justify-between mb-1"><span class="text-[11px] text-purple-400/80 font-medium">Like</span><span class="text-[11px] text-purple-400 font-semibold">' + likeScore + '</span></div><div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);"><div class="h-full rounded-full transition-all" style="width: ' + Math.min(likeNum2, 100) + '%; background: rgb(168,85,247);"></div></div></div>';
        cardHtml += '<div class="flex-1"><div class="flex items-center justify-between mb-1"><span class="text-[11px] text-blue-400/80 font-medium">Can</span><span class="text-[11px] text-blue-400 font-semibold">' + canScore + '</span></div><div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);"><div class="h-full rounded-full transition-all" style="width: ' + Math.min(canNum2, 100) + '%; background: rgb(96,165,250);"></div></div></div>';
        if (parseInt(bgScore) > 0) {
            cardHtml += '<div class="flex-1"><div class="flex items-center justify-between mb-1"><span class="text-[11px] text-amber-400/80 font-medium">Bg</span><span class="text-[11px] text-amber-400 font-semibold">' + bgScore + '</span></div><div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);"><div class="h-full rounded-full transition-all" style="width: ' + Math.min(parseInt(bgScore) || 0, 100) + '%; background: rgb(251,191,36);"></div></div></div>';
        }
        cardHtml += '</div>';

        cardHtml += '</div></div>'; // close flex items-stretch + info div

        // 하단: 추천 이유
        if (reasonOuterHtml) {
            cardHtml += '<div class="px-4 pb-4 pt-0"><div class="p-3 rounded-xl space-y-2" style="background: rgba(99,102,241,0.06); border: 1px solid rgba(99,102,241,0.1);">' + reasonOuterHtml + '</div></div>';
        }

        // 하단 액션 바
        cardHtml += '<div class="flex items-center justify-between px-4 pb-3 ' + (reasonOuterHtml ? '' : 'pt-0') + '">';
        cardHtml += '<button onclick="event.stopPropagation(); toggleMajorScoresCompact(this)" class="text-[13px] text-wiki-muted hover:text-wiki-primary transition flex items-center gap-1.5" title="상세 점수"><i class="fas fa-chart-bar"></i><span>상세 점수</span></button>';
        if (majorSlug) {
            cardHtml += '<a href="/major/' + encodeURIComponent(majorSlug) + '" target="_blank" rel="noopener noreferrer" class="text-[13px] text-wiki-primary hover:text-indigo-300 font-medium transition flex items-center gap-1"><span>상세 보기</span><i class="fas fa-arrow-right text-[11px]"></i></a>';
        }
        cardHtml += '</div>';

        // 점수 상세 (기본 숨김)
        cardHtml += '<div class="score-details-compact hidden px-4 pb-3"><div class="p-3 rounded-lg" style="background-color: rgba(26,26,46,0.5);">';
        cardHtml += getScoreExplanationMajor(likeScore, canScore, fitScore, bgScore);
        cardHtml += '</div></div>';

        cardHtml += '</div>'; // close card

        return sectionHeader + cardHtml;
    }).join('');
}

// ============================================
// Score Explanation (Major - no risk_penalty)
// ============================================
function getScoreExplanationMajor(likeVal, canVal, fitVal, bgVal) {
    var like = parseInt(likeVal) || 0;
    var can = parseInt(canVal) || 0;
    var fit = parseInt(fitVal) || 0;
    var bg = parseInt(bgVal) || 0;
    var html = '<div class="space-y-2.5 text-[13px]">';
    html += '<div class="flex items-center justify-between"><span class="text-purple-400">💜 흥미(Like)</span><span class="text-purple-300 font-medium">' + like + '점</span></div>';
    html += '<div class="flex items-center justify-between"><span class="text-blue-400">💪 역량(Can)</span><span class="text-blue-300 font-medium">' + can + '점</span></div>';
    if (bg > 0) {
        html += '<div class="flex items-center justify-between"><span class="text-amber-400">🎓 배경(Background)</span><span class="text-amber-300 font-medium">' + bg + '점</span></div>';
    }
    html += '<div class="border-t border-wiki-border/30 pt-2 mt-1 flex items-center justify-between"><span class="text-emerald-400 font-medium">= 적합도(Fit)</span><span class="text-emerald-400 font-bold text-base">' + fit + '점</span></div>';
    html += '</div>';
    return html;
}

// ============================================
// Toggle Major Scores (compact)
// ============================================
function toggleMajorScoresCompact(btn) {
    var card = btn.closest('.rounded-2xl');
    if (!card) return;
    var details = card.querySelector('.score-details-compact');
    if (details) {
        details.classList.toggle('hidden');
    }
}
window.toggleMajorScoresCompact = toggleMajorScoresCompact;

        // ============================================
        // 입력 수정 / 내용 추가 (전공 리포트 하단)
        // ============================================
        function showEditWarningModal() {
            document.getElementById('edit-warning-modal')?.classList.remove('hidden');
        }
        function hideEditWarningModal() {
            document.getElementById('edit-warning-modal')?.classList.add('hidden');
        }
        function navigateToEditMode() {
            if (!currentSessionId) { alert('세션 정보가 없습니다.'); return; }
            const params = new URLSearchParams({
                session_id: currentSessionId,
                edit_mode: 'true',
            });
            if (currentRequestId) params.set('source_request_id', String(currentRequestId));
            window.location.href = '/analyzer/major?' + params.toString();
        }
        function showAddContextModal() {
            document.getElementById('add-context-modal')?.classList.remove('hidden');
        }
        function hideAddContextModal() {
            document.getElementById('add-context-modal')?.classList.add('hidden');
            const textarea = document.getElementById('additional-context-text');
            if (textarea) textarea.value = '';
            updateContextCharCount();
        }
        function updateContextCharCount() {
            const textarea = document.getElementById('additional-context-text');
            if (!textarea) return;
            const count = textarea.value.length;
            const countEl = document.getElementById('context-char-count');
            if (countEl) countEl.textContent = count + ' / 최소 30자';
            const btn = document.getElementById('submit-context-btn');
            if (btn) btn.disabled = count < 30;
        }
        document.addEventListener('input', function(e) {
            if (e.target && e.target.id === 'additional-context-text') {
                updateContextCharCount();
            }
        });

        async function submitAdditionalContext() {
            const textarea = document.getElementById('additional-context-text');
            const text = textarea ? textarea.value.trim() : '';
            if (text.length < 30) return;
            if (!currentRequestId) { alert('분석 결과 ID가 없습니다.'); return; }

            const btn = document.getElementById('submit-context-btn');
            if (btn) {
                btn.disabled = true;
                btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>재분석 중...';
            }

            try {
                // 1. 추가 컨텍스트 저장
                const res = await fetch('/api/ai-analyzer/add-context', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ request_id: currentRequestId, additional_text: text })
                });
                const data = await res.json();
                if (!data.success) {
                    alert('재분석 요청 실패: ' + (data.message || '알 수 없는 오류'));
                    if (btn) { btn.disabled = false; btn.innerHTML = '추가 후 재분석'; }
                    return;
                }

                // 2. session_id 복원
                if (!currentSessionId && data.session_id) {
                    currentSessionId = data.session_id;
                }
                if (!currentSessionId) {
                    alert('세션 정보가 없습니다. 페이지를 새로고침 후 다시 시도해주세요.');
                    if (btn) { btn.disabled = false; btn.innerHTML = '추가 후 재분석'; }
                    return;
                }

                // 3. 모달 닫기 + 로딩 표시
                hideAddContextModal();
                showLoading('재분석 중...', '추가 정보를 반영하여 다시 분석하고 있어요', true);

                // 4. /v3/recommend-major 호출 (세션 데이터는 이미 DB에 있음)
                const miniModule = window.miniModuleResult || {};
                const searchProfile = {
                    desiredThemes: [
                        ...(miniModule.interest_top || []),
                        ...(miniModule.value_top || []),
                        ...(universalAnswers.univ_interest || []),
                    ].filter(Boolean),
                    dislikedThemes: universalAnswers.univ_dislike || [],
                    strengthsHypothesis: miniModule.strength_top || [],
                    environmentPreferences: [],
                    hardConstraints: miniModule.constraint_flags || [],
                    riskSignals: [],
                    keywords: [
                        ...(miniModule.interest_top || []),
                        ...(universalAnswers.univ_interest || []),
                    ].filter(Boolean),
                };

                const response = await fetch('/api/ai-analyzer/v3/recommend-major', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        searchProfile: searchProfile,
                        mini_module_result: miniModule,
                        academic_state: window.academicState || undefined,
                        topK: 600,
                        judgeTopN: 15,
                        skipReport: false,
                        debug: DEBUG_MODE,
                    })
                });
                const recData = await response.json();

                if (!recData.success) {
                    throw new Error(recData.error || '추천 결과를 생성할 수 없습니다.');
                }

                // displayResults가 기대하는 형식으로 변환
                const analyzeData = {
                    result: {
                        recommendations: recData.recommendations,
                        premium_report: recData.premium_report,
                        engine_version: recData.engine_version || 'v3',
                    },
                    request_id: recData.request_id,
                };

                hideLoading();
                currentRequestId = analyzeData.request_id;
                displayResults(analyzeData);
                // success toast
                const toast = document.createElement('div');
                toast.className = 'fixed top-4 left-1/2 -translate-x-1/2 z-[10000] px-6 py-3 rounded-xl text-sm font-medium border border-emerald-500/50 bg-emerald-900/80 text-emerald-200 shadow-lg backdrop-blur-sm';
                toast.textContent = '추가 정보가 반영된 새로운 분석 결과입니다.';
                document.body.appendChild(toast);
                setTimeout(() => toast.remove(), 5000);
            } catch (err) {
                hideLoading();
                alert('재분석 중 오류가 발생했습니다: ' + err.message);
            }
        }

        // ============================================
        // 공유 기능 (전공)
        // ============================================
        let _shareUrlMajor = null;
        let _shareTokenMajor = null;

        async function shareReportMajor() {
            const urlParams = new URLSearchParams(window.location.search);
            const requestId = urlParams.get('request_id') || urlParams.get('view') || currentRequestId;
            if (!requestId) { alert('결과 ID가 없습니다.'); return; }

            try {
                const res = await fetch('/api/ai-analyzer/share', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ request_id: parseInt(requestId) }),
                });
                const json = await res.json();
                if (!json.success) {
                    alert(json.error || '공유 생성에 실패했습니다.');
                    return;
                }

                _shareUrlMajor = json.share_url;
                _shareTokenMajor = json.token;

                // 글로벌 공유 모달 열기
                var ogImage = json.share_url + '/og.png';
                if (window.__openShareModal) {
                    window.__openShareModal(json.share_url, 'AI가 분석한 나의 전공 적성', ogImage);
                } else {
                    // fallback: 클립보드 복사
                    try {
                        await navigator.clipboard.writeText(json.share_url);
                        alert('공유 링크가 복사되었습니다!');
                    } catch(e) {
                        prompt('아래 링크를 복사하세요:', json.share_url);
                    }
                }
            } catch (err) {
                alert('공유 생성 중 오류가 발생했습니다.');
            }
        }

        function displayConfidenceUI(result) {
            const card = document.getElementById('confidence-card');
            if (!card) return;

            // confidence_score 계산
            let confidenceScore = result?.confidence_score;
            if (confidenceScore === undefined) {
                const answeredCount = Object.keys(universalAnswers).length + 
                                     Object.keys(transitionSignalAnswers).length + 
                                     Object.keys(followupAnswers).length;
                confidenceScore = Math.min(0.4 + (answeredCount * 0.06), 0.95);
            }
            
            const percentage = Math.round(confidenceScore * 100);
            
            document.getElementById('confidence-score-text').textContent = percentage + '%';
            document.getElementById('confidence-bar').style.width = percentage + '%';
            
            let description = '';
            if (percentage >= 80) {
                description = '충분한 정보를 바탕으로 신뢰도 높은 추천이에요.';
            } else if (percentage >= 60) {
                description = '기본적인 추천은 가능하지만, 더 많은 정보가 있으면 정확도가 올라가요.';
            } else {
                description = '제한된 정보로 추천했어요. 추가 질문에 답변하시면 더 정확해져요.';
            }
            document.getElementById('confidence-description').textContent = description;
            
            // 결정 변수
            const keyDecisions = result?.key_decision_variables || generateKeyDecisions();
            const decisionsHtml = keyDecisions.map(kd => \`
                <div class="flex items-start gap-3 p-2 bg-wiki-bg/50 rounded-lg">
                    <span class="text-amber-400">•</span>
                    <div class="flex-1">
                        <span class="text-sm">\${kd.label || kd.fact_key || kd}</span>
                    </div>
                </div>
            \`).join('');
            document.getElementById('key-decisions').innerHTML = decisionsHtml || '<p class="text-wiki-muted text-sm">결정 변수 정보가 없습니다.</p>';
            
            card.classList.remove('hidden');
        }
        
        function generateKeyDecisions() {
            const decisions = [];
            
            if (careerState.role_identity) {
                const opt = ROLE_IDENTITY_OPTIONS.find(o => o.value === careerState.role_identity);
                decisions.push({ label: '현재 상태: ' + (opt?.label || careerState.role_identity) });
            }
            if (careerState.transition_status && careerState.transition_status.length > 0) {
                const MAJOR_TR_LABELS = { first_choice: '첫 전공 선택', exploring: '여러 전공 탐색', major_change: '전과/전공 변경', career_linked: '목표 직업 연계', double_major: '복수전공/부전공', undecided: '아직 모르겠어요' };
                const labels = (Array.isArray(careerState.transition_status) ? careerState.transition_status : [careerState.transition_status]).map(v => MAJOR_TR_LABELS[v] || v);
                decisions.push({ label: '전공 선택 상황: ' + labels.join(', ') });
            }
            if (universalAnswers.univ_interest?.length > 0) {
                decisions.push({ label: '관심 분야: ' + universalAnswers.univ_interest.slice(0, 3).join(', ') });
            }
            if (universalAnswers.univ_priority) {
                decisions.push({ label: '우선순위: ' + universalAnswers.univ_priority });
            }
            if (transitionSignalAnswers.trans_motivation) {
                decisions.push({ label: '변화 동기: ' + transitionSignalAnswers.trans_motivation });
            }
            
            return decisions.slice(0, 5);
        }
        
        function resetAnalysis() {
            currentStep = 1;
            selectedStage = null;
            universalAnswers = {};
            followupAnswers = {};
            transitionSignalAnswers = {};
            careerState = { role_identity: null, career_stage_years: null, transition_status: null, constraints: {} };

            document.querySelectorAll('.axis-btn, .constraint-btn, .chip-btn, .radio-btn, .trans-chip, .trans-radio, .trans-checkbox').forEach(btn => {
                btn.classList.remove('ring-2', 'ring-wiki-primary', 'ring-emerald-400', 'ring-amber-400', 'bg-wiki-primary/10', 'bg-emerald-400/10', 'bg-amber-400/10', 'border-wiki-primary', 'border-emerald-400', 'border-amber-400');
            });
            
            document.getElementById('step1-next-btn').disabled = true;
            goToStep(1);
        }
        
        // 자동 복원 기능 (모달 사용) - 전공용
        let pendingDraft = null;
        let pendingServerDraft = null;
        
        async function autoRestoreDraft() {
            try {
                // 1. 서버에서 진행중인 draft 확인 (major 타입, 캐시 방지!)
                const serverResponse = await fetch('/api/ai-analyzer/draft/load?_t=' + Date.now(), {
                    method: 'GET',
                    credentials: 'same-origin',
                    cache: 'no-store',  // 브라우저 캐시 완전 무시
                    headers: {
                        'Cache-Control': 'no-cache, no-store, must-revalidate',
                        'Pragma': 'no-cache'
                    }
                });
                const serverData = await serverResponse.json();
                
                if (serverResponse.ok && serverData.found && serverData.draft && serverData.draft.analysis_type === 'major') {
                    const serverDraft = serverData.draft;
                    pendingServerDraft = serverDraft;

                    const stepNamesMap = { 1: '프로필', 2: '프로필', 3: '프로필', 4: '심층 질문', 5: '결과' };
                    const savedDate = new Date(serverDraft.updated_at);
                    const dateStr = savedDate.toLocaleDateString('ko-KR') + ' ' +
                                   savedDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });

                    document.getElementById('continue-modal-info').innerHTML =
                        '<strong class="text-white">' + (stepNamesMap[serverDraft.current_step] || '프로필') + '</strong>까지 진행됨<br>' +
                        '<span class="text-xs">마지막 작업: ' + dateStr + '</span>';
                    
                    document.getElementById('continue-modal').classList.remove('hidden');
                    return 'modal';
                }
                
                // 서버에 major draft가 없으면 로컬 스토리지도 정리
                if (serverResponse.ok && !serverData.found) {
                    localStorage.removeItem('analyzer_draft_major');
                    localStorage.removeItem('analyzer_draft_major_timestamp');
                    return false;
                }
                
                // 2. 로컬 스토리지 확인 (서버 오류 시 폴백)
                const draftStr = localStorage.getItem('analyzer_draft_major');
                const timestamp = localStorage.getItem('analyzer_draft_major_timestamp');
                
                if (!draftStr) return false;
                
                const savedTime = parseInt(timestamp, 10);
                if (Date.now() - savedTime > 24 * 60 * 60 * 1000) {
                    localStorage.removeItem('analyzer_draft_major');
                    localStorage.removeItem('analyzer_draft_major_timestamp');
                    return false;
                }
                
                const draft = JSON.parse(draftStr);
                pendingDraft = draft;

                if (draft.currentStep >= 1) {
                    const stepNamesMap = { 1: '프로필', 2: '프로필', 3: '프로필', 4: '심층 질문', 5: '결과' };
                    const savedDate = new Date(savedTime);
                    const dateStr = savedDate.toLocaleDateString('ko-KR') + ' ' +
                                   savedDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });

                    document.getElementById('continue-modal-info').innerHTML =
                        '<strong class="text-white">' + (stepNamesMap[draft.currentStep] || '프로필') + '</strong>까지 진행됨<br>' +
                        '<span class="text-xs">마지막 작업: ' + dateStr + '</span>';
                    
                    document.getElementById('continue-modal').classList.remove('hidden');
                    return 'modal';
                }
                
                return false;
            } catch (e) {
                return false;
            }
        }
        
        // 이어서 하기
        function continueFromDraft() {
            if (pendingServerDraft) {
                const draft = pendingServerDraft;
                currentSessionId = draft.session_id;
                
                if (draft.step1_answers?.careerState || draft.career_state) {
                    Object.assign(careerState, draft.step1_answers?.careerState || draft.career_state);
                }
                if (draft.step2_answers) {
                    universalAnswers = draft.step2_answers;
                }
                if (draft.step3_answers) {
                    transitionSignalAnswers = draft.step3_answers;
                }
                // step4_answers 통합 구조에서 개별 필드 추출
                if (draft.step4_answers && typeof draft.step4_answers === 'object' && Object.keys(draft.step4_answers).length > 0) {
                    const step4Data = draft.step4_answers;
                    window.roundAnswers = Array.isArray(step4Data.round_answers) ? step4Data.round_answers : [];
                    if (step4Data.narrative_facts) window.narrativeFacts = step4Data.narrative_facts;
                    if (step4Data.narrative_questions) window.savedNarrativeQuestions = step4Data.narrative_questions;
                    if (step4Data.round_questions) window.roundQuestions = step4Data.round_questions;
                    if (step4Data.current_round > 0) window.currentRound = step4Data.current_round;
                } else {
                    // 하위호환: step4_answers가 비어있으면 top-level 필드에서 복원
                    if (Array.isArray(draft.round_answers) && draft.round_answers.length > 0) {
                        window.roundAnswers = draft.round_answers;
                    }
                    if (draft.narrative_facts) {
                        window.narrativeFacts = draft.narrative_facts;
                    }
                    if (draft.saved_narrative_questions) {
                        window.savedNarrativeQuestions = draft.saved_narrative_questions;
                    }
                    if (draft.current_round > 0) {
                        window.currentRound = draft.current_round;
                    }
                }
                if (draft.step1_answers?.stage) {
                    selectedStage = draft.step1_answers.stage;
                }
                if (draft.step1_answers?.studentType) {
                    studentType = draft.step1_answers.studentType;
                }
                if (draft.step1_answers?.academicState) {
                    window.academicState = draft.step1_answers.academicState;
                }

                // mini_module_result 복원
                if (draft.mini_module_result) {
                    window.miniModuleResult = draft.mini_module_result;
                }

                document.getElementById('continue-modal').classList.remove('hidden');
                document.getElementById('continue-modal').classList.add('hidden');

                setTimeout(() => {
                    updateStep1Selection();
                    // 하위옵션 UI 복원
                    if (studentType === 'high' || studentType === 'univ') {
                        const subContainer = document.getElementById('student-sub-options');
                        if (subContainer) {
                            subContainer.innerHTML = studentType === 'high' ? renderHighSubOptions() : renderUnivSubOptions();
                            subContainer.classList.remove('hidden');
                            // 하위옵션 선택 상태 복원
                            const savedAcademicState = window.academicState;
                            if (savedAcademicState) {
                                const subBtn = subContainer.querySelector('[data-value="' + savedAcademicState + '"]');
                                if (subBtn) {
                                    subBtn.classList.remove('border-wiki-border/50', 'text-wiki-muted');
                                    subBtn.classList.add('border-cyan-500', 'bg-cyan-500/20', 'text-white');
                                }
                            }
                            // 대학생 하위: selectedStage로 복원
                            if (studentType === 'univ' && selectedStage) {
                                const stageToValue = { major_freshman: 'freshman', major_student: 'current', major_graduate: 'graduate' };
                                const subVal = stageToValue[selectedStage];
                                if (subVal) {
                                    const subBtn = subContainer.querySelector('[data-value="' + subVal + '"]');
                                    if (subBtn) {
                                        subBtn.classList.remove('border-wiki-border/50', 'text-wiki-muted');
                                        subBtn.classList.add('border-cyan-500', 'bg-cyan-500/20', 'text-white');
                                    }
                                }
                            }
                        }
                    }
                    // Step 2 (심층 질문) 복원
                    if (draft.current_step >= 2 && window.currentRound > 0) {
                        setTimeout(() => {
                            if (typeof startV3RoundQuestions === 'function') {
                                startV3RoundQuestions(window.currentRound);
                            }
                        }, 300);
                    }
                }, 200);

                // 기존 5단계 → 3단계 매핑: old 1→1, old 2-3→1, old 4→2, old 5→3
                const mappedStep = draft.current_step <= 3 ? 1 : draft.current_step === 4 ? 2 : 3;
                goToStep(mappedStep, true);
                pendingServerDraft = null;
                return;
            }
            
            if (!pendingDraft) return;
            
            if (pendingDraft.collectedCareerState) {
                Object.assign(careerState, pendingDraft.collectedCareerState);
            }
            if (pendingDraft.universalAnswers) {
                universalAnswers = pendingDraft.universalAnswers;
            }
            if (pendingDraft.narrativeAnswers) {
                transitionSignalAnswers = pendingDraft.narrativeAnswers;
            }
            if (pendingDraft.roundAnswers) {
                window.roundAnswers = pendingDraft.roundAnswers;
            }
            if (pendingDraft.selectedStage) {
                selectedStage = pendingDraft.selectedStage;
            }
            
            document.getElementById('continue-modal').classList.add('hidden');
            
            setTimeout(() => {
                updateStep1Selection();
            }, 200);

            // 기존 5단계 → 3단계 매핑
            const mappedStep = pendingDraft.currentStep <= 3 ? 1 : pendingDraft.currentStep === 4 ? 2 : 3;
            goToStep(mappedStep, true);
            pendingDraft = null;
        }
        
        // 새로 시작 경고 표시
        function showRestartWarning() {
            document.getElementById('restart-warning-modal').classList.remove('hidden');
        }
        
        // 새로 시작 경고 숨기기
        function hideRestartWarning() {
            document.getElementById('restart-warning-modal').classList.add('hidden');
        }

        // 저장 버튼 리셋 (내용 변경 시 호출)
        function resetSaveButtons() {
            document.querySelectorAll('[id$="-save-btn"]').forEach(btn => {
                if (btn.dataset.saved === 'true') {
                    btn.innerHTML = '<i class="fas fa-save mr-2 text-emerald-400"></i>임시저장';
                    btn.dataset.saved = 'false';
                    window.analyzerUnsavedChanges = true;
                }
            });
        }

        // beforeunload 핸들러 (저장 확인)
        window.addEventListener('beforeunload', (e) => {
            if (window.analyzerUnsavedChanges) {
                e.preventDefault();
                e.returnValue = '저장하지 않은 변경사항이 있습니다. 페이지를 떠나시겠습니까?';
                return e.returnValue;
            }
        });

        // 서버에 자동 저장 (백그라운드, UI 업데이트 없음)
        async function saveDraftToServer() {
            try {
                // 세션 ID 확보
                if (!currentSessionId) {
                    currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                }
                
                // 최신 답변 수집
                const currentUniversalAnswers = typeof collectUniversalAnswers === 'function'
                    ? collectUniversalAnswers()
                    : (universalAnswers || {});
                const currentTransitionAnswers = transitionSignalAnswers || {};

                // 서술형 심층 질문 현재 값 수집
                const narrativeQ0 = document.getElementById('narrative_q0');
                const narrativeQ1 = document.getElementById('narrative_q1');
                const narrativeQ2 = document.getElementById('narrative_q2');
                const narrativeCareerBg = document.getElementById('narrative_career_bg');
                if (narrativeQ0 || narrativeQ1 || narrativeQ2) {
                    const currentQuestions = typeof getNarrativeQuestionsMajor === 'function' ? getNarrativeQuestionsMajor() : null;
                    window.narrativeFacts = {
                        storyAnswer: narrativeQ0?.value || '',
                        life_story: narrativeQ0?.value || '',
                        question1Answer: narrativeQ1?.value || '',
                        question2Answer: narrativeQ2?.value || '',
                        highAliveMoment: narrativeQ1?.value || '',
                        lostMoment: narrativeQ2?.value || '',
                        career_background: narrativeCareerBg?.value || '',
                    };
                    if (currentQuestions) {
                        window.savedNarrativeQuestions = currentQuestions;
                    }
                }

                // step4_answers 통합 데이터
                const step4Data = {
                    round_answers: window.roundAnswers || [],
                    narrative_facts: window.narrativeFacts || null,
                    narrative_questions: window.savedNarrativeQuestions || null,
                    round_questions: window.roundQuestions || null,
                    current_round: window.currentRound || 0
                };

                const draftData = {
                    session_id: currentSessionId,
                    analysis_type: 'major',
                    current_step: window.currentStep || currentStep || 1,
                    profile_sub_step: profileSubStep || 1,
                    current_round: window.currentRound || 0,
                    career_state: careerState || {},
                    step1_answers: {
                        stage: selectedStage,
                        studentType: studentType,
                        academicState: window.academicState || null,
                        careerState: careerState || {},
                        profileSubStep: profileSubStep || 1,
                        currentRound: window.currentRound || 0
                    },
                    mini_module_result: window.miniModuleResult || null,
                    mini_module_selections: typeof miniModuleSelections !== 'undefined' ? miniModuleSelections : null,
                    step2_answers: currentUniversalAnswers,
                    step3_answers: currentTransitionAnswers,
                    step4_answers: step4Data,
                    narrative_facts: window.narrativeFacts || null,
                    round_answers: window.roundAnswers || [],
                    saved_narrative_questions: window.savedNarrativeQuestions || null,
                };
                
                
                const response = await fetch('/api/ai-analyzer/draft/save', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(draftData)
                });
                
                if (response.ok) {
                    window.analyzerUnsavedChanges = false;
                }
            } catch (error) {
            }
        }

        // 결과 도달 시 서버에 완료 상태 저장 (major)
        async function saveDraftAsCompletedMajor() {
            if (!currentSessionId) return;
            
            try {
                const draftData = {
                    session_id: currentSessionId,
                    analysis_type: 'major',
                    current_step: 3,  // major는 step 3이 결과
                    career_state: careerState || {},
                    step1_answers: { 
                        stage: selectedStage,
                        careerState: careerState || {},
                        profileSubStep: profileSubStep || 2,
                        completed: true
                    },
                    mini_module_result: window.miniModuleResult || null
                };
                
                const response = await fetch('/api/ai-analyzer/draft/save', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(draftData)
                });
                
                if (response.ok) {
                    window.analyzerUnsavedChanges = false;
                    localStorage.removeItem('analyzer_draft_major');
                    localStorage.removeItem('analyzer_draft_major_timestamp');
                }
            } catch (error) {
            }
        }
        
        // 새로 시작 확정
        async function confirmRestart() {
            
            // 1. 로컬 스토리지 삭제
            localStorage.removeItem('analyzer_draft_major');
            localStorage.removeItem('analyzer_draft_major_timestamp');
            
            // 2. 서버의 모든 draft 삭제 (다른 세션 포함)
            try {
                const response = await fetch('/api/ai-analyzer/draft/delete-all', {
                    method: 'DELETE',
                    credentials: 'same-origin'
                });
                if (response.ok) {
                    const result = await response.json();
                } else {
                }
            } catch (e) {
            }
            
            // 3. 모달 닫기
            document.getElementById('restart-warning-modal').classList.add('hidden');
            document.getElementById('continue-modal').classList.add('hidden');
            
            // 4. 모든 상태 초기화
            pendingDraft = null;
            pendingServerDraft = null;
            currentSessionId = '';  // 세션 ID 초기화
            careerState = { role_identity: null, career_stage_years: null, transition_status: null, constraints: {} };
            universalAnswers = {};
            transitionSignalAnswers = {};
            window.roundAnswers = [];
            selectedStage = '';
            
            // 5. Step 1부터 시작
            goToStep(1);
        }
        
        // Step 1 UI 복원
        function updateStep1Selection() {
            // 5축 좌표 UI 복원 (간단 버전)
        }
        
        document.addEventListener('DOMContentLoaded', async () => {
            renderCareerStateForm();

            const urlParams = new URLSearchParams(window.location.search);
            const urlSessionId = urlParams.get('session_id');

            // ============================================
            // 편집 모드 초기화 (Major)
            // ============================================
            const urlEditMode = urlParams.get('edit_mode') === 'true';
            const urlSourceRequestId = urlParams.get('source_request_id');

            if (urlSessionId && urlEditMode && urlSourceRequestId) {
                const serverDraft = await loadDraftFromServer(urlSessionId);
                if (!serverDraft) {
                    alert('원본 데이터를 불러올 수 없습니다.');
                    window.location.href = '/user/ai-results';
                    return;
                }

                const editSessionId = 'edit-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);

                // Draft 적용
                currentSessionId = editSessionId;
                if (serverDraft.step1_answers?.careerState || serverDraft.career_state) {
                    Object.assign(careerState, serverDraft.step1_answers?.careerState || serverDraft.career_state);
                }
                if (serverDraft.step2_answers) {
                    universalAnswers = serverDraft.step2_answers;
                }
                if (serverDraft.step3_answers) {
                    transitionSignalAnswers = serverDraft.step3_answers;
                }
                if (serverDraft.step1_answers?.stage) {
                    selectedStage = serverDraft.step1_answers.stage;
                }

                // 편집 모드 전역 상태
                window.__editMode = true;
                window.__originalSessionId = urlSessionId;
                window.__editSessionId = editSessionId;
                window.__sourceRequestId = parseInt(urlSourceRequestId, 10);

                // 변경 감지용 스냅샷
                window.__editSnapshot = {
                    careerState: JSON.stringify(careerState),
                    universalAnswers: JSON.stringify(universalAnswers),
                    transitionSignalAnswers: JSON.stringify(transitionSignalAnswers),
                    narrativeFacts: JSON.stringify(window.narrativeFacts || {}),
                    roundAnswers: JSON.stringify(window.roundAnswers || []),
                };

                // UI 복원 + 배너
                setTimeout(() => {
                    updateStep1Selection();
                    showEditModeBanner();
                }, 200);

                goToStep(1);
                return;
            }

            if (urlSessionId) {
                const serverDraft = await loadDraftFromServer(urlSessionId);
                if (serverDraft) {
                    currentSessionId = serverDraft.session_id;
                    if (serverDraft.step1_answers?.careerState || serverDraft.career_state) {
                        Object.assign(careerState, serverDraft.step1_answers?.careerState || serverDraft.career_state);
                    }
                    setTimeout(() => updateStep1Selection(), 200);
                    // 기존 5단계 → 3단계 매핑
                    const ms = serverDraft.current_step <= 3 ? 1 : serverDraft.current_step === 4 ? 2 : 3;
                    goToStep(ms, true);
                    return;
                }
            }

            // 저장된 리포트 뷰 모드 확인 (?view=requestId)
            const viewResultId = urlParams.get('view');
            if (viewResultId) {
                showLoading('리포트 불러오는 중...', '잠시만 기다려주세요');
                try {
                    const res = await fetch('/api/ai-analyzer/saved-result/' + viewResultId);
                    if (!res.ok) {
                        hideLoading();
                        console.error('[view] API error:', res.status, res.statusText);
                        showErrorToastMajor('결과 API 오류: ' + res.status);
                        goToStep(1);
                    } else {
                        const data = await res.json();
                        hideLoading();
                        if (data.success && data.result) {
                            currentRequestId = data.request_id;
                            // mini_module_result 복원 (프리미엄 리포트 렌더에 필요)
                            if (data.result.mini_module_result) {
                                window.miniModuleResult = data.result.mini_module_result;
                            }
                            try {
                                displayResults({ result: data.result, request_id: data.request_id });
                            } catch (renderErr) {
                                console.error('[view] displayResults error:', renderErr);
                                showErrorToastMajor('리포트 렌더링 실패: ' + renderErr.message);
                            }
                            goToStep(3);
                        } else {
                            console.error('[view] API returned:', data);
                            showErrorToastMajor('결과를 불러올 수 없습니다: ' + (data.error || 'unknown'));
                            goToStep(1);
                        }
                    }
                } catch (e) {
                    hideLoading();
                    console.error('[view] Exception:', e);
                    showErrorToastMajor('결과 로딩 실패: ' + (e.message || e));
                    goToStep(1);
                }
            } else {
            const restoredStep = await autoRestoreDraft();
            if (restoredStep === 'modal') {
                goToStep(1);
            } else {
                goToStep(1);
            }
            }

            // 입력 변경 감지 - 저장 버튼 리셋 (저장 버튼 자체 제외)
            document.addEventListener('click', (e) => {
                const target = e.target;
                if (target.closest('[id$="-save-btn"]') || target.closest('#analyze-btn')) return;
                if (target.closest('.student-option, .role-card, .career-stage-btn, .goal-chip, .skill-btn, .constraint-option, .trans-chip, .trans-radio, .radio-option, .trans-checkbox')) {
                    resetSaveButtons();
                }
            });
            document.addEventListener('input', (e) => {
                if (e.target.matches('input, textarea, select')) {
                    resetSaveButtons();
                }
            });
        });
        
        async function loadDraftFromServer(sessionId) {
            try {
                const response = await fetch('/api/ai-analyzer/draft/load?session_id=' + sessionId, {
                    method: 'GET', credentials: 'same-origin'
                });
                const data = await response.json();
                return response.ok && data.found ? data.draft : null;
            } catch (e) {
                return null;
            }
        }
    </script>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 전공 추천 - Careerwiki', 'AI 기반 맞춤형 전공 추천 서비스', false, {
    robots: 'noindex, nofollow'
  }))
})


export { analyzerMajorPage }
