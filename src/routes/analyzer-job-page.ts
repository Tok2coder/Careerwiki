/**
 * AI 직업 추천 분석기 페이지
 * index.tsx에서 추출: /analyzer/job 거대 핸들러 (10,000+ 줄)
 */
import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  isAdminRole, renderLayoutWithContext, escapeHtml, serializeForScript,
  isDevEnv, parseNumberParam
} from '../utils/shared-helpers'
import {
  ROLE_IDENTITY_OPTIONS, CAREER_STAGE_OPTIONS, TRANSITION_STATUS_OPTIONS,
  SKILL_LEVEL_OPTIONS, SKILL_LEVEL_NOTICE, CONSTRAINT_OPTIONS,
  TRANSITION_SIGNAL_QUESTIONS, IDENTITY_ANCHOR_PATTERNS
} from '../services/ai-analyzer/career-tree-types'

const analyzerJobPage = new Hono<AppEnv>()

// AI Job Analyzer v2.0.0 (Stage-based Universal Intake + Follow-up) - 로그인 필수
analyzerJobPage.get('/', requireAuth, (c) => {
  const user = c.get('user')
  const debugMode = c.req.query('debug') === 'true' || isAdminRole(user?.role)
  
  // ============================================
  // 통합 질문 데이터 (3단계 구조: 프로필 → 심층 → 결과)
  // Step 1 프로필에서 5축 상태 + 아래 통합 질문을 함께 수집
  // ============================================
  const universalQuestionsJson = JSON.stringify([
    // ============================================
    // 1. 관심분야 (통합: 미니모듈 interest + 기존 univ_interest)
    // ============================================
    { id: 'univ_interest', order: 1, text: '어떤 것에 관심이 있거나 재미있다고 느끼나요?', ui_type: 'chips', options: [
      { value: 'problem_solving', label: '문제해결/분석', emoji: '🔍', token: 'problem_solving' },
      { value: 'creating', label: '창작/디자인', emoji: '🎨', token: 'creating' },
      { value: 'helping', label: '사람/소통/돕기', emoji: '🤝', token: 'helping_teaching' },
      { value: 'data', label: '데이터/숫자', emoji: '📊', token: 'data_numbers' },
      { value: 'tech', label: '기술/IT', emoji: '💻', token: 'tech' },
      { value: 'organizing', label: '조직/관리', emoji: '📋', token: 'organizing' },
      { value: 'influencing', label: '영향력/설득', emoji: '📢', token: 'influencing' },
      { value: 'nature', label: '자연/환경', emoji: '🌿', token: 'nature' },
      { value: 'health', label: '건강/의료', emoji: '🏥', token: 'health' },
      { value: 'media', label: '미디어/콘텐츠', emoji: '📱', token: 'media' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.interest.keywords', required: true, max_selections: 3 },

    // ============================================
    // 2. 중요 가치 (통합: 미니모듈 value + 기존 univ_priority)
    // ============================================
    { id: 'univ_priority', order: 2, text: '일에서 가장 중요하게 생각하는 건 뭔가요?', ui_type: 'chips', options: [
      { value: 'autonomy', label: '자율/자유', emoji: '🦋', token: 'autonomy' },
      { value: 'growth', label: '성장/발전', emoji: '🌱', token: 'growth' },
      { value: 'stability', label: '안정/예측가능', emoji: '🏠', token: 'stability' },
      { value: 'income', label: '높은 수입', emoji: '💰', token: 'income' },
      { value: 'meaning', label: '의미/사회기여', emoji: '🌍', token: 'meaning' },
      { value: 'recognition', label: '인정/영향력', emoji: '⭐', token: 'recognition' },
      { value: 'wlb', label: '워라밸', emoji: '⚖️', token: 'wlb' },
    ], allow_unknown: true, unknown_label: '아직 모르겠어요', fact_key: 'priority.top1', required: true, max_selections: 2 },

    // ============================================
    // 3. 강점 (통합: 미니모듈 strength + 기존 univ_strength)
    // ============================================
    { id: 'univ_strength', order: 3, text: '실제로 잘하거나 남들이 인정해준 것은?', ui_type: 'chips', options: [
      { value: 'analytical', label: '분석/논리', emoji: '🧠', token: 'analytical' },
      { value: 'creative', label: '창의/아이디어', emoji: '💡', token: 'creative' },
      { value: 'communication', label: '소통/설명', emoji: '💬', token: 'communication' },
      { value: 'structured_execution', label: '계획/실행', emoji: '📑', token: 'structured_execution' },
      { value: 'persistence', label: '끈기/인내', emoji: '🏋️', token: 'persistence' },
      { value: 'fast_learning', label: '빠른 학습', emoji: '📖', token: 'fast_learning' },
      { value: 'empathy', label: '공감/배려', emoji: '❤️', token: 'empathy' },
      { value: 'leadership', label: '리더십', emoji: '👑', token: 'leadership' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.strength.keywords', required: true, max_selections: 3 },

    // ============================================
    // 4. 피하고 싶은 것 (Soft Dislike - 선호도 반영)
    // ============================================
    { id: 'univ_dislike', order: 4, text: '이건 피하고 싶다고 느끼는 게 있나요?', ui_type: 'chips', options: [
      { value: 'meeting', label: '회의 많음', emoji: '🗣️' },
      { value: 'sales', label: '영업/설득', emoji: '🤝' },
      { value: 'routine', label: '단순 반복', emoji: '🔄' },
      { value: 'pressure', label: '압박/마감', emoji: '⏰' },
      { value: 'public', label: '발표/앞에 서기', emoji: '🎤' },
      { value: 'conflict', label: '갈등/대립', emoji: '⚡' },
      { value: 'uncertainty', label: '불확실함', emoji: '❓' },
    ], allow_unknown: true, unknown_label: '딱히 없어요', fact_key: 'profile.dislike.keywords', required: true, max_selections: 3 },

    // ============================================
    // 5. 업무 스타일 (협업+환경 통합)
    // ============================================
    { id: 'univ_workstyle_social', order: 5, text: '일할 때 어떤 방식이 더 편한가요?', ui_type: 'chips', options: [
      // 협업 방식
      { value: 'solo', label: '혼자 집중', emoji: '🧘', group: 'collaboration' },
      { value: 'team', label: '팀워크', emoji: '👫', group: 'collaboration' },
      // 환경 구조 선호
      { value: 'structured', label: '규칙/절차 있는 환경', emoji: '📋', group: 'structure' },
      { value: 'flexible', label: '자유로운 환경', emoji: '🦋', group: 'structure' },
    ], allow_unknown: true, unknown_label: '모르겠어요', fact_key: 'profile.workstyle', required: true, max_selections: 2 },

    // ============================================
    // 6. 배경 정보 (선택)
    // ============================================
    { id: 'univ_special_experience', order: 6, text: '특별한 경험이나 배경이 있나요?', ui_type: 'chips', options: [
      { value: 'overseas_living', label: '해외 거주/유학', emoji: '🌍' },
      { value: 'license_cert', label: '전문 자격증/면허', emoji: '📜' },
      { value: 'startup_experience', label: '창업/사업 경험', emoji: '🚀' },
      { value: 'research_academic', label: '연구/학술 경험', emoji: '🔬' },
      { value: 'volunteer_ngo', label: '봉사/NGO 활동', emoji: '🤝' },
    ], allow_unknown: true, unknown_label: '없어요', allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.background.special_experience', required: true, max_selections: 3 },

    // ============================================
    // 7. 언어 능력 (복원) - 수준 선택 포함
    // ============================================
    { id: 'univ_language', order: 7, text: '한국어 외에 사용 가능한 언어가 있나요?', ui_type: 'language_chips', options: [
      { value: 'english', label: '영어', emoji: '🇺🇸' },
      { value: 'chinese', label: '중국어', emoji: '🇨🇳' },
      { value: 'japanese', label: '일본어', emoji: '🇯🇵' },
      { value: 'spanish', label: '스페인어', emoji: '🇪🇸' },
      { value: 'french', label: '프랑스어', emoji: '🇫🇷' },
      { value: 'german', label: '독일어', emoji: '🇩🇪' },
      { value: 'vietnamese', label: '베트남어', emoji: '🇻🇳' },
      { value: 'thai', label: '태국어', emoji: '🇹🇭' },
    ], other_languages: [
      { value: 'indonesian', label: '인도네시아어' },
      { value: 'russian', label: '러시아어' },
      { value: 'portuguese', label: '포르투갈어' },
      { value: 'arabic', label: '아랍어' },
      { value: 'hindi', label: '힌디어' },
      { value: 'italian', label: '이탈리아어' },
      { value: 'dutch', label: '네덜란드어' },
      { value: 'polish', label: '폴란드어' },
      { value: 'turkish', label: '터키어' },
      { value: 'swedish', label: '스웨덴어' },
    ], levels: [
      { value: 'basic', label: '일상회화', emoji: '💬' },
      { value: 'business', label: '업무가능', emoji: '💼' },
      { value: 'native', label: '원어민급', emoji: '🏆' },
    ], allow_unknown: true, unknown_label: '없어요', fact_key: 'profile.background.language', required: true, max_selections: 5 },

    // ============================================
    // 🔥 Q8. 포기 가능성 (Hard Bias - 매우 중요)
    // 전공 vs 직업, 안정 vs 성장, 현실 vs 이상 분기
    // ============================================
    { id: 'mm_sacrifice', order: 8, text: '진로를 위해 감수할 수 있는 것은?', ui_type: 'chips', options: [
      { value: 'low_initial_income', label: '초반 연봉이 낮아도 괜찮다', emoji: '📉', token: 'low_initial_income' },
      { value: 'willing_to_study', label: '다시 공부/훈련하는 건 괜찮다', emoji: '📚', token: 'willing_to_study' },
      { value: 'field_change_ok', label: '완전히 다른 분야로 가도 괜찮다', emoji: '🔄', token: 'field_change_ok' },
      { value: 'social_pressure_ok', label: '주변의 시선을 감수할 수 있다', emoji: '🧑‍🤝‍🧑', token: 'social_pressure_ok' },
      { value: 'no_sacrifice', label: '아무것도 포기하고 싶지 않다', emoji: '⛔', token: 'no_sacrifice' },
    ], allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.sacrifice_flags', required: true, max_selections: 2,
       help_text: '💡 이 질문 하나로 추천 방향이 크게 달라져요' },

    // ============================================
    // ⚡ Q9. 에너지 소모원 (Hard Bias - 스트레스 타입)
    // ============================================
    { id: 'mm_energy_drain', order: 9, text: '이럴 때 가장 빨리 지치나요?', ui_type: 'chips', options: [
      { value: 'people_drain', label: '사람 상대', emoji: '😵', token: 'people_drain' },
      { value: 'cognitive_drain', label: '계속 생각해야 하는 일', emoji: '🧠', token: 'cognitive_drain' },
      { value: 'time_pressure_drain', label: '시간 압박', emoji: '⏱️', token: 'time_pressure_drain' },
      { value: 'responsibility_drain', label: '책임이 큰 결정', emoji: '📊', token: 'responsibility_drain' },
      { value: 'repetition_drain', label: '반복 작업', emoji: '🔁', token: 'repetition_drain' },
      { value: 'unpredictability_drain', label: '예측 불가한 상황', emoji: '❓', token: 'unpredictability_drain' },
    ], allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.energy_drain_flags', required: true, max_selections: 2,
       help_text: '💡 버틸 수 있는 직업을 찾는 핵심 질문이에요' },

    // ============================================
    // 🧭 Q10. 성취 피드백 타입 (Soft Bias)
    // 직업 만족도 예측 정확도 향상
    // ============================================
    { id: 'mm_achievement', order: 10, text: '일을 잘하고 있다는 느낌은 언제 드나요?', ui_type: 'chips', options: [
      { value: 'metric_feedback', label: '결과가 수치로 보일 때', emoji: '🏆', token: 'metric_feedback' },
      { value: 'helping_feedback', label: '누군가에게 직접 도움이 됐을 때', emoji: '🙌', token: 'helping_feedback' },
      { value: 'problem_solved_feedback', label: '어려운 문제를 해결했을 때', emoji: '🧩', token: 'problem_solved_feedback' },
      { value: 'tangible_output_feedback', label: '내가 만든 결과물이 남을 때', emoji: '🎨', token: 'tangible_output_feedback' },
      { value: 'growth_feedback', label: '시간이 지날수록 성장할 때', emoji: '📈', token: 'growth_feedback' },
    ], allow_unknown: true, unknown_label: '잘 모르겠어요', fact_key: 'profile.achievement_feedback_top', required: true, max_selections: 2 },

    // ============================================
    // 🏃 Q11. 실행 속도 성향 (Soft Bias)
    // 스타트업/기획 vs 운영/관리/전문직 분기
    // ============================================
    { id: 'mm_execution', order: 11, text: '새로운 일을 시작할 때 나는?', ui_type: 'radio', options: [
      { value: 'action_first', label: '일단 해보며 배우는 편', emoji: '🚀', token: 'action_first' },
      { value: 'plan_first', label: '계획이 서야 시작하는 편', emoji: '🧱', token: 'plan_first' },
      { value: 'depends', label: '둘 다 상황 따라 다름', emoji: '🔄', token: 'execution_depends' },
    ], fact_key: 'profile.execution_style', required: true },

    // ============================================
    // 🌍 Q12. 영향 범위 선호 (Soft Bias)
    // 의미 지향 직업 추천 정확도 보강
    // ============================================
    { id: 'mm_impact', order: 12, text: '내 일이 영향을 미치길 바라는 범위는?', ui_type: 'radio', options: [
      { value: 'impact_individual', label: '개인 한 명', emoji: '👤', token: 'impact_individual' },
      { value: 'impact_team', label: '작은 팀/조직', emoji: '🧑‍🤝‍🧑', token: 'impact_team' },
      { value: 'impact_industry', label: '회사/산업', emoji: '🏢', token: 'impact_industry' },
      { value: 'impact_society', label: '사회 전반', emoji: '🌏', token: 'impact_society' },
      { value: 'impact_unsure', label: '잘 모르겠다', emoji: '🤷', token: 'impact_unsure' },
    ], fact_key: 'profile.impact_scope', required: true },

    // ============================================
    // 💥 Q13. 실패 반응 (Hard Bias급 보정자)
    // '버틸 수 있는 직업' 결정 핵심
    // ============================================
    { id: 'mm_failure', order: 13, text: '일이 잘 안 됐을 때, 나는 보통 어떤 반응에 가깝나요?', ui_type: 'radio', options: [
      { value: 'iterate_on_failure', label: '다시 구조를 고쳐본다', emoji: '🔄', token: 'iterate_on_failure' },
      { value: 'pivot_on_failure', label: '다른 방식으로 빠르게 바꾼다', emoji: '🧪', token: 'pivot_on_failure' },
      { value: 'pause_on_failure', label: '잠시 멈추고 정리한다', emoji: '⏸️', token: 'pause_on_failure' },
      { value: 'emotionally_affected', label: '크게 흔들린다', emoji: '💥', token: 'emotionally_affected' },
    ], allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.failure_response', required: true,
       help_text: '💡 스트레스 질문과 함께 버틸 수 있는 직업을 찾아요' },

    // ============================================
    // 🛡️ Q14. 버팀 앵커 (Desire ↔ Feasibility 갈등 해소)
    // ============================================
    { id: 'mm_anchor', order: 14, text: '아래 중 하나만 유지된다면, 힘들어도 일을 계속할 수 있다면?', ui_type: 'radio', options: [
      { value: 'reward_anchor', label: '보상이 명확함', emoji: '💰', token: 'reward_anchor' },
      { value: 'growth_anchor', label: '성장 체감', emoji: '📈', token: 'growth_anchor' },
      { value: 'people_anchor', label: '함께하는 사람', emoji: '🤝', token: 'people_anchor' },
      { value: 'meaning_anchor', label: '의미/방향성', emoji: '🧭', token: 'meaning_anchor' },
      { value: 'stability_anchor', label: '안정성', emoji: '🛡️', token: 'stability_anchor' },
    ], allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.persistence_anchor', required: true,
       help_text: '💡 싫은 게 많지만 이건 견딘다를 알려주세요' },

    // ============================================
    // 👁️ Q15. 타인 기대 반응 (직업 형태 분기)
    // 전문직 / 조직 / 프리랜서 / 창작직 분기
    // ============================================
    { id: 'mm_expectation', order: 15, text: '주변의 기대나 기준이 있을 때 나는?', ui_type: 'radio', options: [
      { value: 'external_structure_ok', label: '기준이 있으면 편하다', emoji: '🧱', token: 'external_structure_ok' },
      { value: 'neutral_to_expectation', label: '상관없다', emoji: '😐', token: 'neutral_to_expectation' },
      { value: 'expectation_pressure', label: '부담이 된다', emoji: '😣', token: 'expectation_pressure' },
    ], allow_other: true, other_label: '기타 (직접 입력)', fact_key: 'profile.external_expectation', required: true },
  ])
  
  // Job Stages 메타데이터
  const jobStagesJson = JSON.stringify([
    { id: 'job_explore', label: '탐색 단계', description: '아직 경험이 거의 없어요', emoji: '🔍' },
    { id: 'job_student', label: '학생 (전공 연계)', description: '현재 학생이에요', emoji: '🎓' },
    { id: 'job_prepare', label: '취업 준비 중', description: '곧 취업 예정이에요', emoji: '📝' },
    { id: 'job_early', label: '초기 커리어 (0~3년)', description: '일 시작한 지 얼마 안 됐어요', emoji: '🌱' },
    { id: 'job_mid', label: '경력자 (3년+)', description: '경력이 좀 쌓였어요', emoji: '🚀' },
    { id: 'job_transition', label: '전환/복귀', description: '업종 전환 또는 재취업', emoji: '🔄' },
    { id: 'job_second', label: '세컨드 커리어', description: '은퇴 후 새 시작', emoji: '🌅' },
  ])
  
  // 미성년/탐색 단계 목록
  const minorStages = ['job_explore', 'major_child', 'major_elementary', 'major_middle']
  
  // 5축 상태좌표 데이터 (Career Tree)
  const roleIdentityOptionsJson = JSON.stringify(ROLE_IDENTITY_OPTIONS)
  const careerStageOptionsJson = JSON.stringify(CAREER_STAGE_OPTIONS)
  const transitionStatusOptionsJson = JSON.stringify(TRANSITION_STATUS_OPTIONS)
  const skillLevelOptionsJson = JSON.stringify(SKILL_LEVEL_OPTIONS)
  const constraintOptionsJson = JSON.stringify(CONSTRAINT_OPTIONS)
  
  // 전이 신호 질문 데이터
  const transitionSignalQuestionsJson = JSON.stringify(TRANSITION_SIGNAL_QUESTIONS)
  
  // identity anchor 질문 데이터
  const identityAnchorPatternsJson = JSON.stringify(IDENTITY_ANCHOR_PATTERNS)
  
  const content = `
    <div class="max-w-6xl mx-auto px-4 md:px-6 pt-0 md:pt-2">
        <h1 class="text-3xl md:text-4xl font-bold mb-6 text-center text-white">
            <i class="fas fa-briefcase mr-2 text-wiki-primary"></i>AI 직업 추천
            ${debugMode ? '<span class="ml-2 text-sm bg-yellow-500 text-black px-2 py-1 rounded">DEBUG MODE</span>' : ''}
        </h1>

        <!-- Step Indicator (3단계: 프로필→심층→결과) -->
        <div class="flex justify-center items-center gap-2 md:gap-4 mb-6 flex-wrap" id="step-indicator">
            <div class="step-dot flex flex-col items-center active" data-step="1">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-primary text-white rounded-full font-bold text-sm md:text-base">1</span>
                <span class="text-xs mt-1">프로필</span>
            </div>
            <div class="w-8 md:w-12 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="2">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm md:text-base">2</span>
                <span class="text-xs mt-1">심층</span>
            </div>
            <div class="w-8 md:w-12 h-0.5 bg-wiki-border"></div>
            <div class="step-dot flex flex-col items-center" data-step="3">
                <span class="w-8 h-8 md:w-10 md:h-10 flex items-center justify-center bg-wiki-border text-wiki-muted rounded-full font-bold text-sm md:text-base">3</span>
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
        
        <!-- ============================================ -->
        <!-- 로딩 오버레이 -->
        <!-- ============================================ -->
        <div id="loading-overlay" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <div class="glass-card p-8 rounded-2xl text-center max-w-sm mx-4">
                <div class="relative w-16 h-16 mx-auto mb-4">
                    <div class="absolute inset-0 border-4 border-wiki-primary/30 rounded-full"></div>
                    <div class="absolute inset-0 border-4 border-transparent border-t-wiki-primary rounded-full animate-spin"></div>
                </div>
                <p id="loading-message" class="text-lg font-semibold text-white mb-2">처리 중...</p>
                <p id="loading-submessage" class="text-sm text-wiki-muted">잠시만 기다려주세요</p>
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
                    <p class="text-wiki-muted text-sm" id="continue-modal-info">
                        <!-- 동적으로 채워짐 -->
                    </p>
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
        <div id="restart-warning-modal" class="hidden fixed inset-0 z-[60] flex items-center justify-center bg-black/70 backdrop-blur-sm">
            <div class="glass-card p-6 rounded-2xl max-w-md mx-4 border border-amber-500/50">
                <div class="text-center mb-6">
                    <div class="w-16 h-16 mx-auto mb-4 bg-gradient-to-br from-amber-500 to-orange-500 rounded-full flex items-center justify-center">
                        <i class="fas fa-exclamation-triangle text-2xl text-white"></i>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-2">정말 새로 시작하시겠습니까?</h3>
                    <p class="text-wiki-muted text-sm">
                        이전에 입력한 모든 내용이 삭제됩니다.<br>
                        이 작업은 되돌릴 수 없습니다.
                    </p>
                </div>
                <div class="flex gap-3">
                    <button type="button" onclick="hideRestartWarning()"
                            class="flex-1 px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition whitespace-nowrap">
                        취소
                    </button>
                    <button type="button" onclick="confirmRestart()"
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-amber-500 to-orange-500 text-white font-bold rounded-xl hover:opacity-90 transition whitespace-nowrap">
                        삭제 후 시작
                    </button>
                </div>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 0: 추천 유형 선택 (이미 /analyzer에서 선택됨 - 숨김) -->
        <!-- ============================================ -->
        <div id="step0" class="step-content hidden glass-card p-8 rounded-2xl mb-6">
            <!-- /analyzer/job으로 직접 접근했으므로 유형 선택은 생략 -->
        </div>
        
        <!-- ============================================ -->
        <!-- Step 1: 프로필 단계 (2라운드 구조) -->
        <!-- ============================================ -->
        <div id="step1" class="step-content">
            <!-- ========================================== -->
            <!-- 프로필 1-1: 당신에 대해 알려주세요 (5축 상태좌표) -->
            <!-- ========================================== -->
            <div id="profile-step-1" class="glass-card p-6 md:p-8 rounded-2xl mb-6">
                <div class="text-center mb-8">
                    <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-4" style="background: linear-gradient(135deg, rgba(99,102,241,0.2), rgba(168,85,247,0.2));">
                        <span class="text-xs text-purple-300">프로필 1/2</span>
                    </div>
                    <h2 class="text-2xl md:text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-300">
                        <i class="fas fa-user-circle text-wiki-primary mr-3"></i>당신에 대해 알려주세요
                    </h2>
                    <p class="text-wiki-muted mt-2">현재 상황을 파악해요 (1~2분)</p>
                </div>
                
                <!-- 이력서 업로드 섹션 (선택사항) -->
                <div class="mb-8 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.1)); border: 1px dashed rgba(99,102,241,0.3);">
                    <div class="flex items-center gap-3 mb-3">
                        <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-500 rounded-xl flex items-center justify-center shadow-lg">
                            <i class="fas fa-file-alt text-white"></i>
                        </div>
                        <div>
                            <h3 class="font-bold text-white">이력서로 빠르게 시작하기</h3>
                            <p class="text-xs" style="color: rgb(148,163,184)">PDF 이력서를 업로드하면 아래 항목을 자동으로 채워드려요</p>
                        </div>
                        <span class="ml-auto px-3 py-1 text-xs rounded-full" style="background-color: rgba(99,102,241,0.2); color: rgb(165,180,252);">선택사항</span>
                    </div>
                    
                    <div class="flex items-center gap-4">
                        <label class="flex-1 cursor-pointer">
                            <input type="file" id="resume-upload" accept=".pdf" class="hidden" onchange="handleResumeUpload(this)">
                            <div class="flex items-center justify-center gap-3 px-4 py-3 rounded-xl border-2 border-dashed transition-all hover:border-indigo-400"
                                 style="background-color: rgba(26,26,46,0.5); border-color: rgba(99,102,241,0.3);">
                                <i class="fas fa-cloud-upload-alt text-xl" style="color: rgb(165,180,252);"></i>
                                <span style="color: rgb(148,163,184);">PDF 파일 선택</span>
                            </div>
                        </label>
                        
                        <div id="resume-status" class="hidden flex items-center gap-2 px-4 py-3 rounded-xl" style="background-color: rgba(16,185,129,0.1); border: 1px solid rgba(16,185,129,0.3);">
                            <i class="fas fa-check-circle text-emerald-400"></i>
                            <span class="text-emerald-400 text-sm" id="resume-status-text">분석 완료!</span>
                        </div>
                    </div>
                    
                    <p class="text-xs mt-2" style="color: rgb(100,116,139);">
                        <i class="fas fa-info-circle mr-1"></i>
                        파일은 저장되지 않으며, 분석 참고용으로만 사용됩니다. 임시저장 시 분석 결과만 저장됩니다.
                    </p>
                    
                    <div id="resume-loading" class="hidden mt-3 flex items-center justify-center gap-3 py-3">
                        <i class="fas fa-spinner fa-spin text-indigo-400"></i>
                        <span style="color: rgb(165,180,252);">이력서 분석 중...</span>
                    </div>
                    
                    <div id="resume-error" class="hidden mt-3 p-3 rounded-lg" style="background-color: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3);">
                        <p class="text-red-400 text-sm"><i class="fas fa-exclamation-circle mr-2"></i><span id="resume-error-text"></span></p>
                    </div>
                </div>
                
                <!-- 5축 상태좌표 입력 영역 -->
                <div class="space-y-8" id="career-state-form">
                
                <!-- 축 1: 역할 정체성 -->
                <div class="state-axis-section" data-axis="role_identity">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-wiki-primary to-wiki-secondary rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">1</div>
                        <h3 class="text-lg font-bold">현재 나는?</h3>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-5 gap-3" id="role-options">
                <!-- JS로 동적 생성 -->
                    </div>
            </div>
            
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 축 2: 경력 연차 -->
                <div class="state-axis-section" data-axis="career_stage_years">
                    <div class="flex items-center gap-3 mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-blue-500 to-cyan-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">2</div>
                        <h3 class="text-lg font-bold">경력은?</h3>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-3" id="career-stage-options">
                        <!-- JS로 동적 생성 -->
                    </div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 축 3: 현재 목표 (다중 선택) -->
                <div class="state-axis-section" data-axis="transition_status">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">3</div>
                        <h3 class="text-lg font-bold">현재 목표는?</h3>
                        <span class="px-2 py-0.5 bg-emerald-500/20 text-emerald-400 text-xs rounded-full">복수 선택</span>
                    </div>
                    <p class="text-sm text-wiki-muted mb-4 ml-11">원하는 목표를 모두 선택해주세요</p>
                    <div class="grid grid-cols-2 md:grid-cols-3 gap-3" id="transition-status-options">
                        <!-- JS로 동적 생성 -->
                    </div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 축 4: 숙련도 (관심 분야 기준) -->
                <div class="state-axis-section" data-axis="skill_level">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-violet-500 to-purple-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">4</div>
                        <h3 class="text-lg font-bold">관심 분야에서의 숙련도는?</h3>
                    </div>
                    <div class="ml-11 mb-4 p-3 bg-violet-500/10 rounded-lg border border-violet-500/20">
                        <p class="text-sm text-violet-300">
                            <i class="fas fa-lightbulb mr-2"></i>
                            현재 경력과 무관하게, <strong>앞으로 가고 싶은 분야</strong> 기준으로 선택해주세요
                        </p>
                    </div>
                    <div class="grid grid-cols-3 md:grid-cols-5 gap-3" id="skill-level-options">
                        <!-- JS로 동적 생성 -->
                    </div>
                </div>
                
                <!-- 구분선 -->
                <div class="border-t border-wiki-border/30"></div>
                
                <!-- 축 5: 제약 조건 (다중 선택) -->
                <div class="state-axis-section" data-axis="constraints">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-8 h-8 bg-gradient-to-br from-amber-500 to-orange-500 rounded-full flex items-center justify-center text-sm font-bold text-white shadow-lg">5</div>
                        <h3 class="text-lg font-bold">현재 제약이 있나요?</h3>
                        <span class="px-2 py-0.5 bg-amber-500/20 text-amber-400 text-xs rounded-full">선택사항</span>
                    </div>
                    <p class="text-sm text-wiki-muted mb-4 ml-11">해당하는 제약을 선택하면 맞춤 추천에 반영됩니다</p>
                    <div class="max-w-2xl mx-auto" id="constraint-options">
                        <!-- JS로 동적 생성 (카드형 아코디언) -->
                    </div>
                </div>
                
                </div>
                
                <!-- 프로필 1-1 하단 버튼 -->
                <div class="flex justify-center gap-3 pt-8 mt-6 border-t border-wiki-border/30">
                    <a href="/analyzer"
                       class="px-6 py-3 bg-wiki-card/50 border border-wiki-border text-gray-300 rounded-xl hover:bg-wiki-card hover:text-white transition inline-flex items-center">
                        <i class="fas fa-arrow-left mr-2"></i>유형 다시 선택
                    </a>
                    <button type="button" onclick="saveDraftNow()" id="profile1-save-btn"
                            class="px-5 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg hover:border-emerald-500/50 transition inline-flex items-center">
                        <i class="fas fa-save mr-2 text-emerald-400"></i>임시저장
                    </button>
                    <button type="button" id="profile1-next-btn" onclick="goToProfileStep2()"
                            class="px-10 py-4 bg-gradient-to-r from-wiki-primary to-wiki-secondary text-white font-bold rounded-xl shadow-lg shadow-wiki-primary/25 transition disabled:opacity-40 disabled:cursor-not-allowed disabled:shadow-none hover:shadow-wiki-primary/40 hover:scale-[1.02] active:scale-[0.98]">
                        <i class="fas fa-arrow-right mr-2"></i>다음
                    </button>
                </div>
            </div>
            
            <!-- ========================================== -->
            <!-- 프로필 1-2: 나를 알아가기 (통합 질문) -->
            <!-- ========================================== -->
            <div id="profile-step-2" class="glass-card p-6 md:p-8 rounded-2xl mb-6 hidden">
                <div class="text-center mb-8">
                    <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-4" style="background: linear-gradient(135deg, rgba(245,158,11,0.2), rgba(249,115,22,0.2));">
                        <span class="text-xs text-amber-300">프로필 2/2</span>
                    </div>
                    <h2 class="text-2xl md:text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-amber-200 to-orange-300">
                        <i class="fas fa-compass text-amber-400 mr-3"></i>나를 알아가기
                    </h2>
                    <p class="text-wiki-muted mt-2">각 질문에서 가장 끌리는 것을 선택해주세요 (2~3분)</p>
                </div>
                
                <!-- 통합 질문 컨테이너 -->
                <div class="space-y-6" id="integrated-questions-section">
                    <div id="integrated-questions-container">
                        <!-- JS로 동적 생성 -->
                    </div>
                </div>
                
                <!-- 프로필 1-2 하단 버튼 -->
                <div class="flex justify-center gap-3 pt-8 mt-6 border-t border-wiki-border/30">
                    <button type="button" onclick="goToProfileStep1()"
                            class="px-6 py-3 bg-wiki-card/50 border border-wiki-border text-gray-300 rounded-xl hover:bg-wiki-card hover:text-white transition inline-flex items-center">
                        <i class="fas fa-arrow-left mr-2"></i>이전
                    </button>
                    <button type="button" onclick="saveDraftNow()" id="profile2-save-btn"
                            class="px-5 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg hover:border-emerald-500/50 transition inline-flex items-center">
                        <i class="fas fa-save mr-2 text-emerald-400"></i>임시저장
                    </button>
                    <button type="button" id="step1-next-btn" onclick="goToStep2Direct()" disabled
                            class="px-10 py-4 bg-gradient-to-r from-amber-500 to-orange-500 text-white font-bold rounded-xl shadow-lg shadow-amber-500/25 transition disabled:opacity-40 disabled:cursor-not-allowed disabled:shadow-none hover:shadow-amber-500/40 hover:scale-[1.02] active:scale-[0.98]">
                        <i class="fas fa-arrow-right mr-2"></i>심층 질문으로
                    </button>
                </div>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 2: 심층 질문 (LLM Follow-up) -->
        <!-- ============================================ -->
        <div id="step2" class="step-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">
            <h2 class="text-xl font-bold mb-2 text-center">
                <i class="fas fa-user-astronaut text-purple-400 mr-2"></i>심층 질문 (1~2분)
            </h2>
            <p class="text-center text-wiki-muted mb-6 text-sm" id="step2-subtitle">
                더 정확한 추천을 위한 맞춤 질문이에요
            </p>
            
            <div id="followup-questions-form" class="space-y-6">
                <!-- JS로 동적 생성 -->
            </div>
            
            <div class="flex justify-center gap-3 pt-6">
                <button type="button" id="step2-prev-btn"
                        class="px-6 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg transition">
                    <i class="fas fa-arrow-left mr-2"></i>이전
                </button>
                <button type="button" onclick="saveDraftNow()" id="step2-save-btn"
                        class="px-5 py-3 bg-wiki-card border border-wiki-border text-white rounded-xl hover:bg-wiki-bg hover:border-emerald-500/50 transition inline-flex items-center">
                    <i class="fas fa-save mr-2 text-emerald-400"></i>임시저장
                </button>
                <button type="button" id="analyze-btn"
                        class="px-12 py-4 bg-gradient-to-r from-purple-500 to-wiki-secondary text-white font-bold rounded-xl hover-glow transition transform hover:scale-105">
                    <i class="fas fa-magic mr-2"></i>AI 추천 받기
                </button>
            </div>
        </div>
        
        <!-- ============================================ -->
        <!-- Step 3: 결과 영역 -->
        <!-- ============================================ -->
        <div id="step3" class="step-content hidden">
            <!-- User Insight 카드 -->
            <div id="user-insight-card" class="glass-card p-6 rounded-2xl mb-6 border border-purple-500/50 hidden">
                <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
                    <span class="text-2xl">✨</span>
                    <span class="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
                        당신에 대한 인사이트
                    </span>
                </h2>
                <p id="insight-summary" class="text-lg mb-4">-</p>
                
                <div id="insight-traits" class="space-y-3 mb-4">
                    <!-- JS로 채워짐 -->
                </div>
                
                <div id="insight-applied-facts" class="text-sm text-wiki-muted border-t border-wiki-border pt-3 hidden">
                    <span class="font-semibold">적용된 정보:</span>
                    <span id="insight-facts-list">-</span>
                </div>
            </div>
            
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
                
                <!-- 결정 변수 (Key Decision Variables) -->
                <div>
                    <h3 class="text-sm font-semibold mb-3 flex items-center gap-2">
                        <i class="fas fa-key text-amber-400"></i>
                        <span>이 답변들이 결과에 영향을 주었어요</span>
                    </h3>
                    <div id="key-decisions" class="space-y-2">
                        <!-- JS로 채워짐 -->
                    </div>
                </div>
            </div>
            
            <!-- TOP3 추천 결과 -->
            <div class="glass-card p-8 rounded-2xl mb-6">
                <h2 class="text-2xl font-bold mb-6 text-center">
                    <i class="fas fa-trophy text-yellow-400 mr-2"></i>TOP 3 추천 직업
                </h2>
                <div id="top3-results" class="grid md:grid-cols-3 gap-4">
                    <!-- JS로 채워짐 -->
                </div>
            </div>
            
            <!-- 디버그 패널 (debug=true일 때만) -->
            ${debugMode ? `
            <div class="glass-card p-6 rounded-2xl mb-6 border border-yellow-500/50">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-bold text-yellow-400">
                        <i class="fas fa-bug mr-2"></i>디버그 패널 (Stage-based V3)
                    </h3>
                    <button onclick="toggleDebugPanel()" class="text-sm text-wiki-muted hover:text-white">접기/펼치기</button>
                </div>
                <div id="debug-panel-content">
                    <!-- 1. Candidate Source -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-database mr-1"></i>1. Candidate Source
                        </h4>
                        <div id="debug-candidate-source" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 2. 점수 분해 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-chart-bar mr-1"></i>2. 점수 분해 (TOP3)
                        </h4>
                        <div id="debug-score-breakdown" class="text-white font-mono text-xs overflow-x-auto">-</div>
                    </div>
                    
                    <!-- 3. Follow-up 근거 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-question mr-1"></i>3. Follow-up 근거
                        </h4>
                        <div id="debug-followup-rationale" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 4. Rank Change -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-exchange-alt mr-1"></i>4. Rank Change
                        </h4>
                        <div id="debug-rank-change" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- 5. Applied Facts & Rules -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-cog mr-1"></i>5. Applied Facts & Rules
                        </h4>
                        <div id="debug-applied-facts" class="text-white font-mono text-xs max-h-32 overflow-y-auto">-</div>
                    </div>
                    
                    <!-- 6. 버전 정보 -->
                    <div class="mb-4 p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-code-branch mr-1"></i>6. 버전 정보
                        </h4>
                        <div id="debug-versions" class="text-white font-mono text-sm">-</div>
                    </div>
                    
                    <!-- Diversity/Phase4 상태 -->
                    <div class="p-3 bg-slate-800/50 rounded-lg">
                        <h4 class="text-sm font-semibold text-slate-400 mb-2">
                            <i class="fas fa-shield-alt mr-1"></i>Phase4 상태
                        </h4>
                        <div id="debug-phase4-status" class="text-white font-mono text-sm">-</div>
                    </div>
                </div>
            </div>
            ` : ''}
            
            <!-- 추가 Follow-up 질문 (결과 후) -->
            <div id="result-followup-section" class="glass-card p-6 rounded-2xl mb-6 hidden">
                <h3 class="text-xl font-bold mb-4">
                    <i class="fas fa-question-circle text-blue-400 mr-2"></i>더 정확한 추천을 위해
                </h3>
                <p id="result-followup-question" class="text-lg mb-4">-</p>
                <div id="result-followup-options" class="flex flex-wrap gap-3">
                    <!-- JS로 채워짐 -->
                </div>
            </div>
            
            <!-- 새 분석 버튼 -->
            <div class="text-center">
                <button onclick="resetAnalysis()" class="px-6 py-3 bg-wiki-card text-white rounded-lg hover:bg-wiki-primary transition">
                    <i class="fas fa-redo mr-2"></i>새로 분석하기
                </button>
            </div>
        </div>
    </div>
    
    <script>
        // ============================================
        // V3 Stage-based AI Analyzer
        // ============================================
        const DEBUG_MODE = ${debugMode};
        const UNIVERSAL_QUESTIONS = ${universalQuestionsJson};
        const JOB_STAGES = ${jobStagesJson};
        const MINOR_STAGES = ${JSON.stringify(minorStages)};
        
        // 5축 상태좌표 데이터 (Career Tree)
        const ROLE_IDENTITY_OPTIONS = ${roleIdentityOptionsJson};
        const CAREER_STAGE_OPTIONS = ${careerStageOptionsJson};
        const TRANSITION_STATUS_OPTIONS = ${transitionStatusOptionsJson};
        const SKILL_LEVEL_OPTIONS = ${skillLevelOptionsJson};
        const CONSTRAINT_OPTIONS = ${constraintOptionsJson};
        
        // 전이 신호 질문 데이터
        const TRANSITION_SIGNAL_QUESTIONS = ${transitionSignalQuestionsJson};

        // identity anchor 질문 데이터
        const IDENTITY_ANCHOR_PATTERNS = ${identityAnchorPatternsJson};

        // ============================================
        // 동적 서술형 질문 시스템 (상황 + 경력 + 목표 기반)
        // ============================================
        const NARRATIVE_QUESTIONS = {
            'student_explore': {
                question1: { id: 'dream_future', text: '어떤 일을 하는 사람이 되고 싶나요? 왜 그런가요?', placeholder: '예: 사람들에게 영감을 주는 일을 하고 싶어요. 어릴 때 좋은 선생님을 만나서 제 인생이 바뀌었거든요...', emoji: '🌟', color: 'from-yellow-500 to-orange-500', fact_key: 'narrative.dream_future' },
                question2: { id: 'fun_experience', text: '학교나 일상에서 가장 재미있었던 활동은 뭐였나요? 왜 재미있었나요?', placeholder: '예: 팀 프로젝트에서 발표를 맡았을 때요. 제 아이디어가 팀원들에게 인정받는 느낌이 좋았어요...', emoji: '✨', color: 'from-pink-500 to-rose-500', fact_key: 'narrative.fun_experience' },
            },
            'student_changer': {
                question1: { id: 'change_reason', text: '전공이나 진로를 바꾸고 싶은 이유가 뭔가요?', placeholder: '예: 처음엔 부모님 권유로 선택했는데, 공부할수록 저랑 안 맞는다는 생각이 들었어요...', emoji: '🔄', color: 'from-blue-500 to-cyan-500', fact_key: 'narrative.change_reason' },
                question2: { id: 'new_interest', text: '새로 도전하고 싶은 분야가 있나요? 왜 끌리나요?', placeholder: '예: 디자인 쪽이요. 뭔가 만들어내는 일을 할 때 시간 가는 줄 모르거든요...', emoji: '🎯', color: 'from-violet-500 to-purple-500', fact_key: 'narrative.new_interest' },
            },
            // === student + first_job 시나리오 (새로 추가) ===
            'student_first_job': {
                question1: { id: 'student_first_job_dream', text: '졸업 후 어떤 회사나 환경에서 일하고 싶나요?', placeholder: '예: 스타트업에서 일해보고 싶어요. 빠르게 배우면서 여러 일을 경험할 수 있을 것 같아서...', emoji: '🏢', color: 'from-emerald-500 to-teal-500', fact_key: 'narrative.student_first_job_dream' },
                question2: { id: 'student_first_job_prep', text: '취업 준비를 위해 지금 하고 있는 것이 있나요?', placeholder: '예: 인턴 경험을 쌓으려고 해요. 자격증도 준비 중이고, 포트폴리오도 만들고 있어요...', emoji: '📝', color: 'from-blue-500 to-indigo-500', fact_key: 'narrative.student_first_job_prep' },
            },
            'worker_junior': {
                question1: { id: 'rewarding_moment', text: '현재 일에서 가장 보람 있는 순간은 언제인가요?', placeholder: '예: 제가 맡은 기능이 실제로 배포되고 사용자 반응을 볼 때요. 내가 만든 게 누군가에게 도움이 된다는 게...', emoji: '💪', color: 'from-emerald-500 to-teal-500', fact_key: 'narrative.rewarding_moment' },
                question2: { id: 'future_vision', text: '3년 후 어떤 모습이고 싶나요? 구체적으로 상상해본다면?', placeholder: '예: 팀에서 인정받는 중간 역할이요. 후배도 가르치고, 제 의견이 반영되는 위치...', emoji: '🔮', color: 'from-indigo-500 to-blue-500', fact_key: 'narrative.future_vision' },
            },
            'worker_junior_changer': {
                question1: { id: 'change_trigger', text: '이직이나 전환을 생각하게 된 계기가 있나요?', placeholder: '예: 반복되는 업무에 성장이 멈춘 느낌이 들었어요. 매일 같은 일만 하니까...', emoji: '💭', color: 'from-amber-500 to-orange-500', fact_key: 'narrative.change_trigger' },
                question2: { id: 'next_must_have', text: '다음 직장에서 꼭 얻고 싶은 것은 뭔가요?', placeholder: '예: 새로운 기술을 배울 수 있는 환경이요. 그리고 야근 없이 제 시간을 가질 수 있으면...', emoji: '🎁', color: 'from-green-500 to-emerald-500', fact_key: 'narrative.next_must_have' },
            },
            'worker_mid': {
                question1: { id: 'proud_achievement', text: '지금까지 커리어에서 가장 자랑스러운 성과가 있다면?', placeholder: '예: 처음으로 프로젝트 리드를 맡아서 성공적으로 마무리했을 때요. 힘들었지만 뿌듯했어요...', emoji: '🏆', color: 'from-yellow-500 to-amber-500', fact_key: 'narrative.proud_achievement' },
                question2: { id: 'current_gap', text: '현재 위치에서 아쉬운 점이 있다면 뭔가요?', placeholder: '예: 관리 업무가 늘면서 실무 역량이 정체된 느낌이에요. 예전처럼 깊이 파고들 시간이 없어서...', emoji: '🤔', color: 'from-slate-500 to-gray-600', fact_key: 'narrative.current_gap' },
            },
            'worker_mid_changer': {
                question1: { id: 'change_motivation', text: '변화를 생각하게 된 계기가 있나요? (작은 불편함이든 큰 전환점이든)', placeholder: '예: 최근 프로젝트가 끝나고 나니 다음 단계를 고민하게 됐어요. 성장이 정체된 느낌도 있고...', emoji: '💭', color: 'from-blue-500 to-indigo-500', fact_key: 'narrative.change_motivation' },
                question2: { id: 'must_avoid', text: '다음 단계에서 반드시 피하고 싶은 것은?', placeholder: '예: 정치가 심한 조직이요. 실력보다 눈치가 중요한 환경에서는 못 버틸 것 같아요...', emoji: '🚫', color: 'from-orange-600 to-red-500', fact_key: 'narrative.must_avoid' },
            },
            'worker_senior': {
                question1: { id: 'legacy', text: '지금까지 쌓아온 것 중 가장 소중한 것은 뭔가요?', placeholder: '예: 업계에서의 네트워크요. 어디서든 도움 주고받을 수 있는 관계들이 큰 자산이에요...', emoji: '💎', color: 'from-purple-600 to-indigo-600', fact_key: 'narrative.legacy' },
                question2: { id: 'remaining_goal', text: '남은 커리어에서 꼭 이루고 싶은 것이 있다면?', placeholder: '예: 후배들을 키우는 일이요. 제가 받은 도움을 다음 세대에 돌려주고 싶어요...', emoji: '🌱', color: 'from-teal-600 to-cyan-600', fact_key: 'narrative.remaining_goal' },
            },
            'worker_senior_changer': {
                question1: { id: 'senior_change_reason', text: '이 시점에서 변화를 생각하게 된 이유는 뭔가요?', placeholder: '예: 더 이상 이 분야에서 성장할 게 없다는 생각이 들었어요. 새로운 도전이 필요한 시기...', emoji: '🔄', color: 'from-blue-600 to-purple-600', fact_key: 'narrative.senior_change_reason' },
                question2: { id: 'non_negotiable', text: '새로운 시작에서 절대 포기할 수 없는 조건은?', placeholder: '예: 연봉 수준은 유지해야 해요. 가족 부양 책임이 있어서 너무 큰 리스크는 못 져요...', emoji: '⚖️', color: 'from-slate-600 to-zinc-600', fact_key: 'narrative.non_negotiable' },
            },
            'entrepreneur': {
                question1: { id: 'entrepreneur_why', text: '왜 독립적인 일을 선택하셨나요? (혹은 선택하려 하나요?)', placeholder: '예: 제 아이디어를 직접 실현하고 싶었어요. 조직에서는 항상 누군가의 결정을 기다려야 해서...', emoji: '🚀', color: 'from-orange-500 to-red-500', fact_key: 'narrative.entrepreneur_why' },
                question2: { id: 'entrepreneur_challenge', text: '독립적으로 일하면서 가장 힘든 점은 뭔가요?', placeholder: '예: 수입이 불안정한 거요. 잘될 때와 안 될 때의 차이가 너무 커서 스트레스...', emoji: '🏔️', color: 'from-slate-500 to-gray-600', fact_key: 'narrative.entrepreneur_challenge' },
            },
            'inactive_returner': {
                question1: { id: 'gap_reflection', text: '경력 단절 기간 동안 어떤 생각이 들었나요?', placeholder: '예: 처음엔 쉬는 게 좋았는데, 시간이 지나니까 불안해졌어요. 사회와 단절된 느낌...', emoji: '💭', color: 'from-blue-500 to-indigo-500', fact_key: 'narrative.gap_reflection' },
                question2: { id: 'comeback_worry', text: '복귀하면서 가장 걱정되는 부분은 뭔가요?', placeholder: '예: 기술이 많이 바뀌었을 것 같아요. 따라갈 수 있을지, 나이 때문에 편견이 있을지...', emoji: '😰', color: 'from-amber-500 to-yellow-500', fact_key: 'narrative.comeback_worry' },
            },
            'manager_10plus_second': {
                question1: { id: 'accumulated_value', text: '지금까지 쌓은 것 중 가장 가치 있는 것은 뭔가요?', placeholder: '예: 사람을 보는 눈이요. 수많은 면접과 평가를 하면서 인재를 알아보는 감각이 생겼어요...', emoji: '💎', color: 'from-purple-600 to-pink-600', fact_key: 'narrative.accumulated_value' },
                question2: { id: 'second_career_dream', text: '은퇴 후 또는 다음 단계에서 꼭 해보고 싶은 일은?', placeholder: '예: 컨설팅이요. 제 경험을 후배 경영자들에게 나눠주고 싶어요. 돈보다는 의미가 중요...', emoji: '🌅', color: 'from-amber-500 to-orange-500', fact_key: 'narrative.second_career_dream' },
            },
            // === manager 역할 추가 시나리오 (새로 추가) ===
            'manager_growth': {
                question1: { id: 'leadership_proudest', text: '리더로서 가장 뿌듯했던 순간은 언제인가요?', placeholder: '예: 팀원이 성장해서 독립적으로 프로젝트를 이끌게 됐을 때요. 제가 한 것이 아닌데도 뿌듯했어요...', emoji: '👑', color: 'from-amber-500 to-yellow-500', fact_key: 'narrative.leadership_proudest' },
                question2: { id: 'leadership_challenge', text: '리더십에서 가장 어려운 점은 뭔가요?', placeholder: '예: 팀원들의 서로 다른 기대를 조율하는 거요. 모두를 만족시킬 수 없다는 걸 알면서도...', emoji: '🤔', color: 'from-slate-500 to-gray-600', fact_key: 'narrative.leadership_challenge' },
            },
            'manager_changer': {
                question1: { id: 'manager_change_reason', text: '관리자로서 새로운 분야로 전환하려는 이유는 뭔가요?', placeholder: '예: 현재 조직에서 더 성장하기 어려워요. 새로운 도전이 필요한 시점인 것 같아요...', emoji: '🔄', color: 'from-blue-600 to-purple-600', fact_key: 'narrative.manager_change_reason' },
                question2: { id: 'manager_transferable', text: '다른 분야에서도 활용 가능한 본인의 강점은 뭘까요?', placeholder: '예: 사람을 이끄는 경험이요. 어떤 분야든 팀을 만들고 키우는 건 비슷할 것 같아요...', emoji: '💼', color: 'from-emerald-500 to-teal-500', fact_key: 'narrative.manager_transferable' },
            },
            'worker_changer': {
                question1: { id: 'change_trigger_general', text: '이직이나 전환을 생각하게 된 계기가 있나요?', placeholder: '예: 성장이 멈춘 느낌이 들었어요. 매일 같은 일만 반복하니까 무기력해지더라고요...', emoji: '💭', color: 'from-blue-500 to-cyan-500', fact_key: 'narrative.change_trigger' },
                question2: { id: 'next_priority', text: '다음 직장/커리어에서 가장 중요하게 생각하는 것은?', placeholder: '예: 배울 수 있는 환경이요. 정체되지 않고 계속 성장할 수 있는 곳이면 좋겠어요...', emoji: '⭐', color: 'from-yellow-500 to-amber-500', fact_key: 'narrative.next_priority' },
            },
            // === job_seeker 역할 시나리오 (새로 추가) ===
            'job_seeker_first': {
                question1: { id: 'first_job_expectation', text: '첫 직장에서 가장 기대하는 것은 뭔가요?', placeholder: '예: 실무 경험을 쌓으면서 전문성을 키우고 싶어요. 좋은 멘토를 만났으면 좋겠어요...', emoji: '🌟', color: 'from-yellow-500 to-amber-500', fact_key: 'narrative.first_job_expectation' },
                question2: { id: 'first_job_worry', text: '취업 준비 중 가장 걱정되거나 어려운 점은 뭔가요?', placeholder: '예: 스펙이 부족한 것 같아서 걱정이에요. 어디서부터 시작해야 할지 막막하고...', emoji: '😰', color: 'from-slate-500 to-gray-600', fact_key: 'narrative.first_job_worry' },
            },
            'job_seeker_return': {
                question1: { id: 'return_gap_experience', text: '경력 공백 기간 동안 어떤 경험을 하셨나요?', placeholder: '예: 육아에 집중했어요. 힘들었지만 아이와 함께한 시간이 소중했어요. 그 외에도...', emoji: '💭', color: 'from-blue-500 to-indigo-500', fact_key: 'narrative.return_gap_experience' },
                question2: { id: 'return_concern', text: '복귀하면서 가장 걱정되는 부분은 뭔가요?', placeholder: '예: 업계가 많이 변했을 것 같아요. 제 경력이 아직 유효한지, 적응할 수 있을지...', emoji: '🤔', color: 'from-amber-500 to-yellow-500', fact_key: 'narrative.return_concern' },
            },
            'job_seeker_second': {
                question1: { id: 'second_career_motivation', text: '새로운 커리어를 시작하려는 이유는 뭔가요?', placeholder: '예: 은퇴 후에도 의미 있는 일을 하고 싶어요. 그동안 쌓은 경험을 다른 방식으로 활용하고...', emoji: '🌅', color: 'from-orange-500 to-amber-500', fact_key: 'narrative.second_career_motivation' },
                question2: { id: 'second_career_vision', text: '새로운 커리어에서 이루고 싶은 것이 있다면?', placeholder: '예: 젊은 세대에게 도움이 되고 싶어요. 컨설팅이나 강의 같은 것도 생각하고 있어요...', emoji: '🎯', color: 'from-purple-500 to-pink-500', fact_key: 'narrative.second_career_vision' },
            },
            'job_seeker_explore': {
                question1: { id: 'explore_interest', text: '요즘 관심이 가거나 끌리는 분야가 있나요?', placeholder: '예: IT 쪽에 관심이 가요. 비전공자도 할 수 있는 것들이 있다고 들어서...', emoji: '🔍', color: 'from-cyan-500 to-blue-500', fact_key: 'narrative.explore_interest' },
                question2: { id: 'explore_blocker', text: '방향을 정하기 어려운 이유가 뭘까요?', placeholder: '예: 뭘 좋아하는지 잘 모르겠어요. 이것저것 해보고 싶은데 어디서부터 시작해야 할지...', emoji: '❓', color: 'from-violet-500 to-purple-500', fact_key: 'narrative.explore_blocker' },
            },
            'default': {
                question1: { id: 'high_alive', text: '최근 6개월 중 가장 "살아있다"고 느낀 순간은 언제였나요? 왜 그랬나요?', placeholder: '예: 팀 프로젝트에서 제 아이디어가 채택됐을 때요. 처음으로 제 생각이 인정받은 느낌이었고...', emoji: '🔥', color: 'from-orange-500 to-red-500', fact_key: 'narrative.high_alive_moment' },
                question2: { id: 'lost_moment', text: '반대로 가장 "나를 잃었다"고 느낀 순간은 언제였나요? 왜 그랬나요?', placeholder: '예: 매일 같은 보고서를 작성할 때요. 제가 누군지, 왜 이 일을 하는지 모르겠었어요...', emoji: '🌫️', color: 'from-violet-500 to-purple-500', fact_key: 'narrative.lost_moment' },
            },
        };
        
        // 컨텍스트 키 생성 함수
        function getNarrativeContextKey(roleIdentity, careerStage, transitionStatus) {
            // transitionStatus를 배열로 정규화 (문자열/배열 모두 지원)
            const statusArray = Array.isArray(transitionStatus) 
                ? transitionStatus 
                : (transitionStatus ? [transitionStatus] : []);
            const hasStatus = (status) => statusArray.includes(status);
            
            // 1. job_seeker 역할 전용 (새로 추가)
            if (roleIdentity === 'job_seeker') {
                if (hasStatus('first_job')) return 'job_seeker_first';
                if (hasStatus('return_work')) return 'job_seeker_return';
                if (hasStatus('second_career')) return 'job_seeker_second';
                if (hasStatus('explore')) return 'job_seeker_explore';
                return 'job_seeker_first'; // 기본값
            }
            
            // 2. manager 역할 처리 (확장)
            if (roleIdentity === 'manager') {
                if (careerStage === '10_plus' && hasStatus('second_career')) return 'manager_10plus_second';
                if (hasStatus('field_change')) return 'manager_changer';
                return 'manager_growth';
            }
            
            // 3. 특수 역할 처리
            // Note: 'inactive' 역할은 UI에 존재하지 않으므로 inactive_returner 체크 제거
            // 경력 복귀자는 job_seeker + return_work → job_seeker_return 시나리오 사용
            if (roleIdentity === 'entrepreneur') return 'entrepreneur';
            
            // 4. 학생 역할 처리 (확장)
            if (roleIdentity === 'student') {
                if (hasStatus('first_job')) return 'student_first_job';
                if (hasStatus('field_change')) return 'student_changer';
                return 'student_explore';
            }
            
            // 5. 이직/전환 의사가 있는 경우 (worker)
            if (hasStatus('field_change') || transitionStatus === 'changer') {
                if (careerStage === '0_3') return 'worker_junior_changer';
                if (careerStage === '3_10') return 'worker_mid_changer';
                if (careerStage === '10_plus') return 'worker_senior_changer';
                return 'worker_changer';
            }
            
            // 6. 경력 기반
            if (careerStage === 'none' || careerStage === '0_3') return 'worker_junior';
            if (careerStage === '3_10') return 'worker_mid';
            if (careerStage === '10_plus') return 'worker_senior';
            
            // 7. 기본값
            return 'default';
        }
        
        // 서술형 질문 가져오기
        function getNarrativeQuestions() {
            const key = getNarrativeContextKey(
                careerState.role_identity,
                careerState.career_stage_years,
                careerState.transition_status
            );
            return NARRATIVE_QUESTIONS[key] || NARRATIVE_QUESTIONS['default'];
        }
        
        // 상태 관리 - /analyzer/job으로 진입했으므로 Step 1(상태 선택)부터 시작
        let currentStep = 1;
        let profileSubStep = 1;  // 프로필 서브스텝 (1: 5축 상태, 2: 나를 알아가기)
        let selectedAnalysisType = 'job';
        let selectedStage = null;  // 기존 호환성
        let universalAnswers = {};
        let followupAnswers = {};
        let transitionSignalAnswers = {};  // 전이 신호 답변
        let currentSessionId = null;
        let currentRequestId = null;
        let previousTop3 = [];

        // ============================================
        // Phase 3: 편집 모드 유틸리티
        // ============================================
        function showEditModeBanner() {
            if (!window.__editMode) return;
            const banner = document.createElement('div');
            banner.id = 'edit-mode-banner';
            banner.className = 'mb-4 p-3 rounded-xl border';
            banner.style.cssText = 'border-color:rgba(251,191,36,0.4);background:rgba(251,191,36,0.08);';
            banner.innerHTML = '<div class="flex items-center justify-between flex-wrap gap-2"><div class="flex items-center gap-2"><i class="fas fa-edit text-amber-400"></i><span class="text-amber-300 text-sm font-medium">수정 모드</span><span class="text-amber-200/70 text-xs">변경사항이 있으면 이후 단계가 초기화됩니다</span></div><button onclick="cancelEditMode()" class="px-3 py-1 text-xs rounded-lg border border-wiki-border text-wiki-muted hover:text-white transition">취소</button></div>';
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

        // 편집 모드 변경 감지
        function detectStep1Changes() {
            if (!window.__editMode) return false;
            return JSON.stringify(careerState) !== window.__editSnapshot.careerState
                || JSON.stringify(universalAnswers) !== window.__editSnapshot.universalAnswers;
        }
        function detectNarrativeChanges() {
            if (!window.__editMode) return false;
            return JSON.stringify(window.narrativeFacts || {}) !== window.__editSnapshot.narrativeFacts;
        }
        function detectRoundChanges(roundNumber) {
            if (!window.__editMode) return false;
            const snapRounds = JSON.parse(window.__editSnapshot.roundAnswers);
            const currRounds = window.roundAnswers || [];
            const snapR = snapRounds.filter(a => a.roundNumber === roundNumber);
            const currR = currRounds.filter(a => a.roundNumber === roundNumber);
            return JSON.stringify(snapR) !== JSON.stringify(currR);
        }

        // 캐스케이드 리셋
        function cascadeResetFromStep1() {
            window.narrativeFacts = null;
            window.roundAnswers = [];
            window.roundQuestions = null;
            window.currentRound = 0;
            window.savedNarrativeQuestions = null;
            window.__editSnapshot.narrativeFacts = '{}';
            window.__editSnapshot.roundAnswers = '[]';
        }
        function cascadeResetFromNarrative() {
            window.roundAnswers = [];
            window.roundQuestions = null;
            window.currentRound = 0;
            window.__editSnapshot.roundAnswers = '[]';
        }
        function cascadeResetFromRound(roundNumber) {
            window.roundAnswers = (window.roundAnswers || []).filter(a => a.roundNumber <= roundNumber);
            window.currentRound = roundNumber;
            window.__editSnapshot.roundAnswers = JSON.stringify(window.roundAnswers);
        }
        // ============================================

        // 프로필 서브스텝 이동 함수
        function goToProfileStep1() {
            profileSubStep = 1;
            document.getElementById('profile-step-1')?.classList.remove('hidden');
            document.getElementById('profile-step-2')?.classList.add('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
        
        function goToProfileStep2() {
            // 5축 중 최소 1개 선택 확인
            if (!careerState.role_identity) {
                alert('현재 상태를 선택해주세요.');
                return;
            }
            
            profileSubStep = 2;
            document.getElementById('profile-step-1')?.classList.add('hidden');
            document.getElementById('profile-step-2')?.classList.remove('hidden');
            
            // 통합 질문 렌더링 (학생/어른에 따라 항상 다시 렌더링)
            renderIntegratedQuestions();
            
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
        
        // 5축 상태좌표 저장
        let careerState = {
            role_identity: null,
            career_stage_years: null,
            transition_status: null,
            skill_level: null,
            constraints: {}
        };
        
        // ============================================
        // 로딩 오버레이
        // ============================================
        function showLoading(message, submessage = '잠시만 기다려주세요') {
            const overlay = document.getElementById('loading-overlay');
            const msgEl = document.getElementById('loading-message');
            const subEl = document.getElementById('loading-submessage');
            if (msgEl) msgEl.textContent = message;
            if (subEl) subEl.textContent = submessage;
            if (overlay) overlay.classList.remove('hidden');
        }
        
        function hideLoading() {
            const overlay = document.getElementById('loading-overlay');
            if (overlay) overlay.classList.add('hidden');
        }
        
        // ============================================
        // 이력서 업로드 처리
        // ============================================
        async function handleResumeUpload(input) {
            const file = input.files[0];
            if (!file) return;
            
            // PDF 파일 확인
            if (file.type !== 'application/pdf') {
                showResumeError('PDF 파일만 업로드 가능합니다.');
                return;
            }
            
            // 파일 크기 제한 (5MB)
            if (file.size > 5 * 1024 * 1024) {
                showResumeError('파일 크기는 5MB 이하만 가능합니다.');
                return;
            }
            
            // UI 상태 변경
            document.getElementById('resume-loading').classList.remove('hidden');
            document.getElementById('resume-status').classList.add('hidden');
            document.getElementById('resume-error').classList.add('hidden');
            
            try {
                // pdf.js로 텍스트 추출 (CDN 사용)
                const pdfjsLib = window['pdfjs-dist/build/pdf'];
                if (!pdfjsLib) {
                    // pdf.js 동적 로드
                    await loadPdfJs();
                }
                
                const pdfText = await extractTextFromPdf(file);
                
                if (pdfText.length < 100) {
                    showResumeError('이력서에서 충분한 텍스트를 추출하지 못했습니다. 텍스트 기반 PDF인지 확인해주세요.');
                    return;
                }
                
                // 서버로 파싱 요청
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
                
                if (!response.ok) {
                    throw new Error(data.message || '파싱 실패');
                }
                
                // 파싱 결과로 UI 업데이트
                applyResumeParseResult(data.career_state, data.data);
                
                // 성공 상태 표시
                document.getElementById('resume-loading').classList.add('hidden');
                document.getElementById('resume-status').classList.remove('hidden');
                
                // 이력서 형식 확인 (추출된 데이터 기준)
                const extracted = data.data.extracted || {};
                const hasSkills = extracted.skills?.length > 0;
                const hasCerts = extracted.certifications?.length > 0;
                const hasEducation = !!extracted.education_level;
                const hasExperience = extracted.total_experience_years !== null;
                const hasRole = !!extracted.current_role_type;
                
                // 2개 이상의 정보가 추출되었으면 이력서로 인정
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
                showResumeError(error.message || '이력서 분석 중 오류가 발생했습니다.');
            }
        }
        
        function showResumeError(message) {
            document.getElementById('resume-loading').classList.add('hidden');
            document.getElementById('resume-status').classList.add('hidden');
            document.getElementById('resume-error').classList.remove('hidden');
            document.getElementById('resume-error-text').textContent = message;
        }
        
        // pdf.js 동적 로드
        async function loadPdfJs() {
            return new Promise((resolve, reject) => {
                if (window.pdfjsLib) {
                    resolve();
                    return;
                }
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
        
        // PDF에서 텍스트 추출
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
        
        // 파싱 결과를 UI에 적용
        function applyResumeParseResult(careerStateFromResume, parsedData) {
            // 이력서 업로드 플래그 설정
            window.resumeUploaded = true;
            
            // 이력서에서 추출한 배경 정보 저장 (심층 질문에서 사용)
            const extracted = parsedData.extracted || {};
            const bgParts = [];
            if (extracted.education_level) bgParts.push(extracted.education_level);
            if (extracted.major) bgParts.push(extracted.major + ' 전공');
            if (extracted.current_role_type) bgParts.push(extracted.current_role_type);
            if (extracted.total_experience_years) bgParts.push('경력 ' + extracted.total_experience_years + '년');
            if (extracted.industry) bgParts.push(extracted.industry + ' 분야');
            if (extracted.skills?.length > 0) bgParts.push('스킬: ' + extracted.skills.slice(0, 3).join(', '));
            
            window.resumeCareerBackground = bgParts.join(', ');
            
            // 역할 정체성 선택
            if (careerStateFromResume.role_identity) {
                const roleBtn = document.querySelector(\`#role-options [data-value="\${careerStateFromResume.role_identity}"]\`);
                if (roleBtn) roleBtn.click();
            }
            
            // 경력 연차 선택
            if (careerStateFromResume.career_stage_years) {
                const stageBtn = document.querySelector(\`#career-stage-options [data-value="\${careerStateFromResume.career_stage_years}"]\`);
                if (stageBtn) stageBtn.click();
            }
            
            // 전환 상태 선택
            if (careerStateFromResume.transition_status) {
                const transBtn = document.querySelector(\`#transition-status-options [data-value="\${careerStateFromResume.transition_status}"]\`);
                if (transBtn && !transBtn.classList.contains('selected')) transBtn.click();
            }
            
            // 숙련도 선택
            if (careerStateFromResume.skill_level !== undefined && careerStateFromResume.skill_level !== null) {
                const skillBtn = document.querySelector(\`#skill-level-options [data-value="\${careerStateFromResume.skill_level}"]\`);
                if (skillBtn) skillBtn.click();
            }
            
        }
        
        // ============================================
        // Step 네비게이션
        // ============================================
        const visitedSteps = {};  // 방문 기록 및 스크롤 위치 저장
        
        // ============================================
        // Summary Banner: 누적 메모리 요약 표시
        // ============================================
        function renderSummaryBanner(containerId, memory) {
            const container = document.getElementById(containerId);
            if (!container || !memory) return;
            
            // 기존 배너 제거
            const existingBanner = container.querySelector('.summary-banner');
            if (existingBanner) existingBanner.remove();
            
            const summaryItems = [];
            
            // 안정적 동기 (confidence 높은 것)
            if (memory.stable_drivers && memory.stable_drivers.length > 0) {
                const topDrivers = memory.stable_drivers
                    .filter(d => d.confidence >= 0.6)
                    .slice(0, 2)
                    .map(d => d.text);
                if (topDrivers.length > 0) {
                    summaryItems.push('✨ 에너지 올라가는 순간: ' + topDrivers.join(', '));
                }
            }
            
            // 반복 두려움
            if (memory.recurring_fears && memory.recurring_fears.length > 0) {
                const topFears = memory.recurring_fears
                    .filter(f => f.confidence >= 0.6)
                    .slice(0, 2)
                    .map(f => f.text);
                if (topFears.length > 0) {
                    summaryItems.push('💭 피하고 싶은 것: ' + topFears.join(', '));
                }
            }
            
            // 가치 충돌
            if (memory.contradictions && memory.contradictions.length > 0) {
                summaryItems.push('⚡ 탐색 중인 갈등: ' + memory.contradictions[0].text);
            }
            
            // 의사결정 기준
            if (memory.decision_rules && memory.decision_rules.length > 0) {
                const topRule = memory.decision_rules.find(r => r.confidence >= 0.7);
                if (topRule) {
                    summaryItems.push('📋 확인된 기준: ' + topRule.text);
                }
            }
            
            if (summaryItems.length === 0) return;
            
            const banner = document.createElement('div');
            banner.className = 'summary-banner bg-wiki-card/50 border border-wiki-border/50 rounded-xl p-4 mb-6';
            banner.innerHTML = \`
                <div class="text-sm text-wiki-muted mb-2 font-medium">💡 지금까지 파악된 당신의 기준</div>
                <div class="space-y-1">
                    \${summaryItems.map(item => \`<div class="text-wiki-text text-sm">\${item}</div>\`).join('')}
                </div>
            \`;
            
            // 컨테이너 최상단에 삽입
            const firstChild = container.firstChild;
            container.insertBefore(banner, firstChild);
        }
        
        function goToStep(step, skipRender = false) {
            // 현재 Step의 스크롤 위치 저장 (떠나기 전)
            if (currentStep && visitedSteps[currentStep] !== undefined) {
                visitedSteps[currentStep] = window.scrollY;
            }
            
            currentStep = step;
            window.currentStep = step; // 전역 변수도 업데이트 (임시저장용)
            document.querySelectorAll('.step-content').forEach(el => el.classList.add('hidden'));
            const stepEl = document.getElementById('step' + step);
            if (stepEl) stepEl.classList.remove('hidden');
            
            // 본인 계정 경고 배너: Step 1에서만 표시
            const warningBanner = document.getElementById('account-warning-banner');
            if (warningBanner) {
                warningBanner.style.display = step === 1 ? 'block' : 'none';
            }
            
            // ============================================
            // 요약 배너 표시 (Step 2 이상 + memory 있을 때)
            // 3단계 구조: Step 1 = 프로필, Step 2 = 심층, Step 3 = 결과
            // ============================================
            if (step >= 2 && window.aggregatedProfile?.memory) {
                const containerMap = { 2: 'step2', 3: 'step3' };
                const containerId = containerMap[step];
                if (containerId) {
                    setTimeout(() => {
                        renderSummaryBanner(containerId, window.aggregatedProfile.memory);
                    }, 100);
                }
            }

            // Step별 렌더링 복원 (3단계 구조)
            if (!skipRender) {
                try {
                    if (step === 1) {
                        setTimeout(() => {
                            restoreConstraintDetails();
                            // profileSubStep이 2인 경우에만 나를알아가기 질문 렌더링
                            if (profileSubStep === 2) {
                                renderIntegratedQuestions();
                            }
                        }, 100);
                    }
                    // Step 2는 심층 질문 (generateFollowupQuestions에서 렌더링)
                    // Step 3는 결과 (submitFollowupsAndAnalyze에서 렌더링)
                } catch (error) {
                }
            }

            // 인디케이터 업데이트
            document.querySelectorAll('.step-dot').forEach((el) => {
                const circle = el.querySelector('span:first-child');
                const stepNum = parseInt(el.dataset.step, 10);
                if (stepNum <= step) {
                    circle.classList.remove('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-primary', 'text-white');
                } else {
                    circle.classList.add('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.remove('bg-wiki-primary', 'text-white');
                }
            });
            
            // 스크롤 위치 관리: 처음 방문 → 맨 위, 재방문 → 이전 위치
            setTimeout(() => {
                if (visitedSteps[step] !== undefined) {
                    window.scrollTo(0, visitedSteps[step]);
                } else {
                    window.scrollTo(0, 0);
                    visitedSteps[step] = 0;
                }
            }, 50);
        }
        
        // ============================================
        // Step 0: 분석 유형 선택
        // ============================================
        function selectAnalysisType(type) {
            selectedAnalysisType = type;
            if (type === 'job') {
                renderStageOptions();
                goToStep(1);
            }
        }
        
        // ============================================
        // Step 1: Stage 선택
        // ============================================
        // ============================================
        // Step 1: 5축 상태좌표 UI 렌더링
        // ============================================
        // ============================================
        // 비활성화 규칙 + 비활성화 사유
        // ============================================
        const ROLE_DISABLED_RULES = {
            student: {
                career_stage: ['3_10', '10_plus'],
                transition_status: ['return_work', 'second_career'],
                skill_level: [3, 4],
                reasons: {
                    career_stage: '학생 상태에서는 선택할 수 없어요',
                    transition_status: '학생 상태에서는 해당하지 않아요',
                    skill_level: '학생 상태에서는 선택할 수 없어요'
                }
            },
            worker: {
                career_stage: [],
                transition_status: ['first_job'],
                skill_level: [],
                reasons: { transition_status: '이미 직장인이에요' }
            },
            manager: {
                career_stage: ['none'],
                transition_status: ['first_job'],
                skill_level: [0],
                reasons: {
                    career_stage: '관리자는 경험이 있어야 해요',
                    transition_status: '이미 직장인이에요',
                    skill_level: '관리자는 경험이 있어야 해요'
                }
            },
            entrepreneur: {
                career_stage: [],
                transition_status: ['first_job'],
                skill_level: [],
                reasons: { transition_status: '이미 사업을 운영 중이에요' }
            },
            job_seeker: {
                career_stage: [],
                transition_status: [],
                skill_level: [],
                reasons: {}
            }
        };
        
        // ============================================
        // 전문적인 UI 렌더링 함수들
        // ============================================
        function renderCareerStateForm() {
            renderRoleOptions();
            updateCareerStageOptions();
            updateTransitionStatusOptions();
            updateSkillLevelOptions();
            renderConstraintOptions();
            // 통합 질문은 goToProfileStep2()에서 학생/직장인 선택 후 렌더링
        }
        
        // 축 1: 역할 정체성 (다크 테마 카드 디자인)
        function renderRoleOptions() {
            const container = document.getElementById('role-options');
            if (!container) return;
            
            container.innerHTML = ROLE_IDENTITY_OPTIONS.map((opt, idx) => \`
                <button type="button" onclick="selectRole('\${opt.value}', this)"
                        class="role-card group relative overflow-hidden rounded-xl border p-4 transition-all duration-300 transform hover:-translate-y-1 hover:shadow-lg"
                        style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                        data-value="\${opt.value}"
                        onmouseover="this.style.borderColor='rgba(67,97,238,0.5)'; this.style.backgroundColor='rgba(26,26,46,1)';"
                        onmouseout="if(!this.classList.contains('selected')){this.style.borderColor='rgba(42,42,62,0.5)'; this.style.backgroundColor='rgba(26,26,46,0.9)';}">
                    <div class="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-blue-500/10 to-transparent rounded-bl-full"></div>
                    <div class="relative z-10">
                        <div class="text-3xl mb-2 transform group-hover:scale-110 transition-transform">\${opt.emoji}</div>
                        <div class="font-semibold text-white">\${opt.label}</div>
                        <div class="text-xs text-slate-400 mt-1 leading-relaxed">\${opt.description}</div>
                    </div>
                    <div class="tooltip-content absolute left-1/2 -translate-x-1/2 bottom-full mb-3 px-4 py-2 bg-black/95 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-200 pointer-events-none w-56 text-center z-50 shadow-xl border border-slate-700">
                        \${opt.help}
                    </div>
                </button>
            \`).join('');
        }
        
        function selectRole(value, btnEl) {
            careerState.role_identity = value;
            
            // 애니메이션과 함께 선택 상태 업데이트
            document.querySelectorAll('#role-options .role-card').forEach(btn => {
                btn.classList.remove('selected', 'shadow-lg');
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.style.backgroundColor = 'rgba(26,26,46,0.9)';
            });
            btnEl.classList.add('selected', 'shadow-lg');
            btnEl.style.borderColor = '#4361ee';
            btnEl.style.backgroundColor = 'rgba(67,97,238,0.2)';
            
            // 다른 축들 업데이트 (애니메이션 효과)
            setTimeout(() => {
                updateCareerStageOptions();
                updateTransitionStatusOptions();
                updateSkillLevelOptions();
            }, 150);
            
            updateSelectedStageFromCareerState();
            checkStep1Completion();
        }
        
        // 축 2: 경력 기간 (다크 테마 프로그레스 바)
        function updateCareerStageOptions() {
            const container = document.getElementById('career-stage-options');
            if (!container) return;
            
            const role = careerState.role_identity;
            const rules = role && ROLE_DISABLED_RULES[role] ? ROLE_DISABLED_RULES[role] : { career_stage: [], reasons: {} };
            const disabledValues = rules.career_stage || [];
            const reason = rules.reasons?.career_stage || '현재 상태에서 선택할 수 없어요';
            
            container.innerHTML = CAREER_STAGE_OPTIONS.map((opt, idx) => {
                const isDisabled = disabledValues.includes(opt.value);
                const isSelected = careerState.career_stage_years === opt.value;
                const progressWidth = [0, 33, 66, 100][idx];
                
                const bgStyle = isDisabled 
                    ? 'background-color: rgba(15,15,35,0.5);' 
                    : isSelected 
                        ? 'background-color: rgba(67,97,238,0.2); border-color: #4361ee;' 
                        : 'background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);';
                
                return \`
                    <button type="button" \${isDisabled ? '' : \`onclick="selectCareerStage('\${opt.value}', this)"\`}
                            class="career-stage-btn group relative overflow-hidden rounded-xl p-4 border transition-all duration-300 \${isDisabled ? 'cursor-not-allowed opacity-40' : ''}"
                            style="\${bgStyle}"
                            data-value="\${opt.value}" \${isDisabled ? 'disabled' : ''}>
                        
                        \${isDisabled ? \`
                            <div class="absolute inset-0 bg-stripes opacity-20"></div>
                            <div class="absolute top-2 right-2">
                                <svg class="w-4 h-4 text-slate-500" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        \` : ''}
                        
                        <div class="relative z-10">
                            <div class="flex items-center justify-between mb-2">
                                <span class="font-semibold" style="color: \${isDisabled ? 'rgba(148,163,184,0.5)' : isSelected ? '#4361ee' : '#fff'}">\${opt.label}</span>
                                \${isSelected ? '<span style="color: #4361ee" class="text-lg">✓</span>' : ''}
                            </div>
                            <div class="text-xs mb-3" style="color: \${isDisabled ? 'rgba(148,163,184,0.3)' : 'rgb(148,163,184)'}">\${opt.description}</div>
                            
                            <!-- 프로그레스 바 -->
                            <div class="h-1.5 rounded-full overflow-hidden" style="background-color: rgba(42,42,62,0.3)">
                                <div class="h-full rounded-full transition-all duration-500" 
                                     style="width: \${progressWidth}%; background-color: \${isDisabled ? 'rgba(148,163,184,0.3)' : isSelected ? '#4361ee' : 'rgba(148,163,184,0.5)'}"></div>
                            </div>
                        </div>
                        
                        \${isDisabled ? \`
                            <div class="disabled-tooltip absolute left-1/2 -translate-x-1/2 bottom-full mb-2 px-3 py-1.5 bg-black/95 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-50 border border-slate-700">
                                🔒 \${reason}
                            </div>
                        \` : ''}
                    </button>
                \`;
            }).join('');
            
            // 선택값 초기화 (비활성화된 경우)
            if (disabledValues.includes(careerState.career_stage_years)) {
                careerState.career_stage_years = null;
            }
        }
        
        function selectCareerStage(value, btnEl) {
            careerState.career_stage_years = value;
            updateCareerStageOptions();
            updateSelectedStageFromCareerState();
            checkStep1Completion();
        }
        
        // 축 3: 현재 목표 (다크 테마 칩 스타일)
        function updateTransitionStatusOptions() {
            const container = document.getElementById('transition-status-options');
            if (!container) return;
            
            const role = careerState.role_identity;
            const rules = role && ROLE_DISABLED_RULES[role] ? ROLE_DISABLED_RULES[role] : { transition_status: [], reasons: {} };
            const disabledValues = rules.transition_status || [];
            const reason = rules.reasons?.transition_status || '현재 상태에서 선택할 수 없어요';
            
            if (!Array.isArray(careerState.transition_status)) {
                careerState.transition_status = careerState.transition_status ? [careerState.transition_status] : [];
            }
            
            // 비활성화된 값 제거
            careerState.transition_status = careerState.transition_status.filter(v => !disabledValues.includes(v));
            
            container.innerHTML = TRANSITION_STATUS_OPTIONS.map(opt => {
                const isDisabled = disabledValues.includes(opt.value);
                const isSelected = careerState.transition_status.includes(opt.value);
                
                const bgStyle = isDisabled 
                    ? 'background-color: rgba(15,15,35,0.5);' 
                    : isSelected 
                        ? 'background-color: rgba(16,185,129,0.2); border-color: #10b981;' 
                        : 'background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);';
                
                return \`
                    <button type="button" \${isDisabled ? '' : \`onclick="toggleTransitionStatus('\${opt.value}', this)"\`}
                            class="goal-chip group relative rounded-xl p-4 border transition-all duration-300 \${isDisabled ? 'cursor-not-allowed opacity-40' : isSelected ? 'shadow-lg transform scale-[1.02]' : ''}"
                            style="\${bgStyle}"
                            data-value="\${opt.value}" \${isDisabled ? 'disabled' : ''}>
                        
                        \${isDisabled ? \`
                            <div class="absolute top-2 right-2">
                                <svg class="w-4 h-4 text-slate-500" fill="currentColor" viewBox="0 0 20 20">
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
                        <div class="font-semibold text-sm" style="color: \${isDisabled ? 'rgba(148,163,184,0.5)' : isSelected ? '#34d399' : '#fff'}">\${opt.label}</div>
                        <div class="text-xs mt-1" style="color: \${isDisabled ? 'rgba(148,163,184,0.3)' : isSelected ? 'rgba(110,231,183,0.8)' : 'rgb(148,163,184)'}">\${opt.description}</div>
                        
                        \${isDisabled ? \`
                            <div class="disabled-tooltip absolute left-1/2 -translate-x-1/2 bottom-full mb-2 px-3 py-1.5 bg-black/95 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-50 border border-slate-700">
                                🔒 \${reason}
                            </div>
                        \` : ''}
                    </button>
                \`;
            }).join('');
        }
        
        function toggleTransitionStatus(value, btnEl) {
            if (!Array.isArray(careerState.transition_status)) {
                careerState.transition_status = [];
            }
            
            const idx = careerState.transition_status.indexOf(value);
            if (idx === -1) {
                careerState.transition_status.push(value);
            } else {
                careerState.transition_status.splice(idx, 1);
            }
            
            updateTransitionStatusOptions();
            updateSelectedStageFromCareerState();
            checkStep1Completion();
        }
        
        // 축 4: 숙련도 (다크 테마 레벨 게이지)
        function updateSkillLevelOptions() {
            const container = document.getElementById('skill-level-options');
            if (!container) return;
            
            const role = careerState.role_identity;
            const rules = role && ROLE_DISABLED_RULES[role] ? ROLE_DISABLED_RULES[role] : { skill_level: [], reasons: {} };
            const disabledValues = rules.skill_level || [];
            const reason = rules.reasons?.skill_level || '현재 상태에서 선택할 수 없어요';
            
            // 비활성화된 값 초기화
            if (disabledValues.includes(careerState.skill_level)) {
                careerState.skill_level = null;
            }
            
            container.innerHTML = SKILL_LEVEL_OPTIONS.map((opt, idx) => {
                const isDisabled = disabledValues.includes(opt.value);
                const isSelected = careerState.skill_level === opt.value;
                const levelBars = idx + 1;
                
                const bgStyle = isDisabled 
                    ? 'background-color: rgba(15,15,35,0.5);' 
                    : isSelected 
                        ? 'background-color: rgba(139,92,246,0.2); border-color: #8b5cf6;' 
                        : 'background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);';
                
                return \`
                    <button type="button" \${isDisabled ? '' : \`onclick="selectSkillLevel(\${opt.value}, this)"\`}
                            class="skill-btn group relative rounded-xl p-3 border transition-all duration-300 \${isDisabled ? 'cursor-not-allowed opacity-40' : isSelected ? 'shadow-lg' : ''}"
                            style="\${bgStyle}"
                            data-value="\${opt.value}" \${isDisabled ? 'disabled' : ''}>
                        
                        \${isDisabled ? \`
                            <div class="absolute top-2 right-2">
                                <svg class="w-3.5 h-3.5 text-slate-500" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        \` : ''}
                        
                        <!-- 레벨 바 -->
                        <div class="flex gap-1 mb-2 justify-center">
                            \${[1,2,3,4,5].map(i => \`
                                <div class="w-3 h-6 rounded-sm transition-all duration-300" 
                                     style="background-color: \${i <= levelBars 
                                        ? isDisabled ? 'rgba(148,163,184,0.3)' : isSelected ? '#8b5cf6' : 'rgba(148,163,184,0.5)'
                                        : 'rgba(42,42,62,0.3)'}"></div>
                            \`).join('')}
                        </div>
                        
                        <div class="font-semibold text-sm" style="color: \${isDisabled ? 'rgba(148,163,184,0.5)' : isSelected ? '#a78bfa' : '#fff'}">\${opt.label}</div>
                        <div class="text-xs mt-0.5" style="color: \${isDisabled ? 'rgba(148,163,184,0.3)' : 'rgb(148,163,184)'}">\${opt.description}</div>
                        
                        \${isDisabled ? \`
                            <div class="disabled-tooltip absolute left-1/2 -translate-x-1/2 bottom-full mb-2 px-3 py-1.5 bg-black/95 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-50 border border-slate-700">
                                🔒 \${reason}
                            </div>
                        \` : ''}
                    </button>
                \`;
            }).join('');
        }
        
        function selectSkillLevel(value, btnEl) {
            careerState.skill_level = value;
            updateSkillLevelOptions();
            checkStep1Completion();
        }
        
        function selectAxis(axis, value, btnEl) {
            careerState[axis] = value;
            const container = btnEl.parentElement;
            container.querySelectorAll('.axis-btn').forEach(btn => {
                btn.classList.remove('ring-2', 'ring-wiki-primary', 'bg-wiki-primary/10', 'border-wiki-primary');
            });
            btnEl.classList.add('ring-2', 'ring-wiki-primary', 'bg-wiki-primary/10', 'border-wiki-primary');
            updateSelectedStageFromCareerState();
            checkStep1Completion();
        }
        
        // ============================================
        // 축 5: 제약 조건 (다크 테마 아코디언 카드)
        // ============================================
        let noConstraintSelected = false;
        
        function renderConstraintOptions() {
            const container = document.getElementById('constraint-options');
            if (!container) return;
            
            container.innerHTML = \`
                <!-- 제약 없음 카드 -->
                <div class="mb-4">
                    <button type="button" onclick="toggleNoConstraint(this)" id="no-constraint-btn"
                            class="w-full p-4 rounded-xl border border-dashed hover:border-emerald-500/50 transition-all duration-300 group"
                            style="border-color: rgba(42,42,62,0.5); background-color: rgba(26,26,46,0.5);">
                        <div class="flex items-center gap-4">
                            <div class="w-12 h-12 rounded-full flex items-center justify-center text-2xl group-hover:scale-110 transition-transform" style="background-color: rgba(16,185,129,0.2);">
                                ✅
                            </div>
                            <div class="text-left flex-1">
                                <div class="font-semibold text-white">제약 없음</div>
                                <div class="text-sm" style="color: rgb(148,163,184)">특별한 제약 조건 없이 모든 옵션을 고려해요</div>
                            </div>
                            <div class="w-6 h-6 rounded-full border flex items-center justify-center no-constraint-check opacity-0 transition-opacity" style="border-color: rgba(42,42,62,0.5);">
                                <svg class="w-4 h-4 text-emerald-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                        </div>
                    </button>
                </div>
                
                <!-- 구분선 -->
                <div class="flex items-center gap-4 mb-4">
                    <div class="flex-1 h-px" style="background-color: rgba(42,42,62,0.3)"></div>
                    <span class="text-xs font-medium" style="color: rgb(148,163,184)">또는 제약 조건 선택</span>
                    <div class="flex-1 h-px" style="background-color: rgba(42,42,62,0.3)"></div>
                </div>
                
                <!-- 제약 조건 카드들 -->
                <div id="constraint-list" class="grid gap-3 transition-all duration-300">
                    \${CONSTRAINT_OPTIONS.map(opt => \`
                        <div class="constraint-card rounded-xl border overflow-hidden transition-all duration-300" 
                             style="border-color: rgba(42,42,62,0.5); background-color: rgba(26,26,46,0.9);"
                             data-type="\${opt.type}">
                            
                            <!-- 헤더 (클릭 영역) -->
                            <button type="button" onclick="toggleConstraint('\${opt.type}', this)"
                                    class="constraint-header w-full p-4 flex items-center gap-4 text-left transition-colors"
                                    onmouseover="this.style.backgroundColor='rgba(26,26,46,1)';"
                                    onmouseout="this.style.backgroundColor='transparent';">
                                <div class="w-10 h-10 rounded-lg flex items-center justify-center text-xl flex-shrink-0" style="background-color: rgba(245,158,11,0.2);">
                                    \${opt.emoji}
                                </div>
                                <div class="flex-1 min-w-0">
                                    <div class="font-semibold text-white">\${opt.label}</div>
                                    <div class="text-sm truncate" style="color: rgb(148,163,184)">\${opt.description}</div>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="constraint-badge hidden px-2 py-1 text-amber-400 text-xs font-medium rounded-full" style="background-color: rgba(245,158,11,0.2);">
                                        선택됨
                                    </div>
                                    <svg class="constraint-chevron w-5 h-5 transition-transform duration-300" style="color: rgb(148,163,184)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </div>
                            </button>
                            
                            <!-- 상세 내용 (펼침) -->
                            <div class="constraint-detail hidden border-t" style="border-color: rgba(42,42,62,0.3); background-color: rgba(15,15,35,0.5);">
                                <div class="p-4 space-y-4">
                                    <!-- 빠른 선택 태그 -->
                                    <div>
                                        <label class="text-xs font-medium mb-2 block" style="color: rgb(148,163,184)">구체적인 상황 (선택)</label>
                                        <div class="flex flex-wrap gap-2">
                                            \${opt.details.map(d => \`
                                                <button type="button" onclick="selectConstraintDetail('\${opt.type}', '\${d.value}', this)"
                                                        class="detail-tag px-3 py-1.5 text-sm rounded-full border"
                                                        data-value="\${d.value}">
                                                    \${d.label}
                                                </button>
                                            \`).join('')}
                                        </div>
                                    </div>
                                    
                                    <!-- 상세 설명 입력 -->
                                    <div>
                                        <label class="text-xs font-medium mb-2 block" style="color: rgb(148,163,184)">추가 설명 (선택)</label>
                                        <div class="relative">
                                            <textarea class="constraint-textarea w-full px-4 py-3 text-sm border rounded-lg transition-all resize-none"
                                                      style="border-color: rgba(42,42,62,0.5); background-color: rgba(15,15,35,1); color: #fff;"
                                                      rows="2"
                                                      placeholder="\${opt.placeholder}"
                                                      onfocus="this.style.borderColor='rgba(245,158,11,0.5)';"
                                                      onblur="this.style.borderColor='rgba(42,42,62,0.5)';"
                                                      onchange="updateConstraintCustomDetail('\${opt.type}', this.value)"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    \`).join('')}
                </div>
            \`;
        }
        
        function toggleNoConstraint(btnEl) {
            noConstraintSelected = !noConstraintSelected;
            const checkEl = btnEl.querySelector('.no-constraint-check');
            const constraintList = document.getElementById('constraint-list');
            
            if (noConstraintSelected) {
                // 선택 상태
                btnEl.classList.add('border-solid', 'shadow-lg');
                btnEl.classList.remove('border-dashed');
                btnEl.style.borderColor = '#10b981';
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                checkEl.classList.remove('opacity-0');
                checkEl.classList.add('opacity-100');
                checkEl.style.backgroundColor = '#10b981';
                checkEl.style.borderColor = '#10b981';
                
                // 모든 제약 해제
                careerState.constraints = {};
                document.querySelectorAll('.constraint-card').forEach(card => {
                    card.classList.add('opacity-30', 'pointer-events-none');
                    card.querySelector('.constraint-badge')?.classList.add('hidden');
                    card.querySelector('.constraint-detail')?.classList.add('hidden');
                    card.querySelector('.constraint-chevron')?.classList.remove('rotate-180');
                });
                constraintList.classList.add('opacity-50');
            } else {
                // 선택 해제
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
        
        function toggleConstraint(type, btnEl) {
            // "제약 없음" 자동 해제
            if (noConstraintSelected) {
                noConstraintSelected = false;
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
                // 제약 해제
                delete careerState.constraints[type];
                card.classList.remove('shadow-lg');
                card.style.borderColor = 'rgba(42,42,62,0.5)';
                badge.classList.add('hidden');
                detail.classList.add('hidden');
                chevron.classList.remove('rotate-180');
                
                // 태그 선택 초기화
                detail.querySelectorAll('.detail-tag').forEach(tag => {
                    tag.classList.remove('selected');
                    tag.style.backgroundColor = 'rgba(26,26,46,0.5)';
                    tag.style.borderColor = 'rgba(42,42,62,0.5)';
                    tag.style.color = 'rgb(148,163,184)';
                });
            } else {
                // 제약 선택
                careerState.constraints[type] = { has_constraint: true };
                card.classList.add('shadow-lg');
                card.style.borderColor = '#f59e0b';
                badge.classList.remove('hidden');
                detail.classList.remove('hidden');
                chevron.classList.add('rotate-180');
            }
        }
        
        function selectConstraintDetail(type, value, btnEl) {
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
            
            // 스타일 즉시 적용 (브라우저 리페인트 지연 방지)
            applyDetailTagStyle(btnEl, !isCurrentlySelected);
        }
        
        // 제약조건 세부 버튼 스타일 적용 (requestAnimationFrame으로 즉시 반영)
        function applyDetailTagStyle(btn, isSelected) {
            const styles = isSelected
                ? { bg: 'rgba(245,158,11,0.2)', border: 'rgba(245,158,11,0.5)', color: '#f59e0b' }
                : { bg: 'rgba(26,26,46,0.5)', border: 'rgba(42,42,62,0.5)', color: 'rgb(148,163,184)' };
            
            const applyStyles = () => {
                btn.style.setProperty('background-color', styles.bg, 'important');
                btn.style.setProperty('border-color', styles.border, 'important');
                btn.style.setProperty('color', styles.color, 'important');
            };
            
            applyStyles();
            requestAnimationFrame(applyStyles);
        }
        
        function updateConstraintCustomDetail(type, value) {
            if (!careerState.constraints[type]) return;
            careerState.constraints[type].custom_detail = value;
        }
        
        // 제약조건 세부사항 복원 함수
        function restoreConstraintDetails() {
            if (!careerState.constraints) return;
            
            for (const [type, constraint] of Object.entries(careerState.constraints)) {
                const card = document.querySelector(\`.constraint-card[data-type="\${type}"]\`);
                if (card && constraint.has_constraint) {
                    const detail = card.querySelector('.constraint-detail');
                    const chevron = card.querySelector('.constraint-chevron');
                    const badge = card.querySelector('.constraint-badge');
                    
                    // 카드 선택 상태 표시
                    card.style.borderColor = 'rgba(245,158,11,0.5)';
                    card.style.backgroundColor = 'rgba(245,158,11,0.05)';
                    
                    if (badge) badge.classList.remove('hidden');
                    if (detail && chevron) {
                        detail.classList.remove('hidden');
                        chevron.classList.add('rotate-180');
                    }
                    
                    // 세부사항 버튼 선택 상태 복원
                    if (constraint.details && Array.isArray(constraint.details)) {
                        for (const value of constraint.details) {
                            const btn = card.querySelector(\`.detail-tag[data-value="\${value}"]\`);
                            if (btn && !btn.classList.contains('selected')) {
                                btn.classList.add('selected');
                                applyDetailTagStyle(btn, true);
                            }
                        }
                    }
                    
                    // 추가 설명 복원
                    if (constraint.custom_detail) {
                        const textarea = card.querySelector('.constraint-textarea');
                        if (textarea) textarea.value = constraint.custom_detail;
                    }
                }
            }
        }
        
        function updateSelectedStageFromCareerState() {
            // 기존 로직과 호환성을 위해 careerState를 기반으로 selectedStage 설정
            const { role_identity, career_stage_years, transition_status } = careerState;
            
            if (role_identity === 'student') {
                selectedStage = 'job_student';
            } else if (transition_status === 'changer' || transition_status === 'returner') {
                selectedStage = 'job_transition';
            } else if (transition_status === 'second_career') {
                selectedStage = 'job_second';
            } else if (career_stage_years === 'none') {
                selectedStage = 'job_explore';
            } else if (career_stage_years === '0_3') {
                selectedStage = 'job_early';
            } else {
                selectedStage = 'job_mid';
            }
        }
        
        function checkStep1Completion() {
            const { role_identity, career_stage_years, transition_status, skill_level } = careerState;
            
            // 5축 상태 확인
            const stateComplete = role_identity && career_stage_years && transition_status && skill_level !== null;
            
            // 통합 질문 확인 (필수: 관심분야, 가치, 업무스타일)
            const hasInterest = integratedAnswers.univ_interest && integratedAnswers.univ_interest.length > 0;
            const hasPriority = integratedAnswers.univ_priority && 
                (Array.isArray(integratedAnswers.univ_priority) ? integratedAnswers.univ_priority.length > 0 : !!integratedAnswers.univ_priority);
            const hasWorkstyle = !!integratedAnswers.univ_workstyle_social;
            
            const questionsComplete = hasInterest && hasPriority && hasWorkstyle;
            const isComplete = stateComplete && questionsComplete;
            
            const nextBtn = document.getElementById('step1-next-btn');
            if (nextBtn) {
                nextBtn.disabled = !isComplete;
                if (isComplete) {
                    nextBtn.classList.add('hover-glow');
                } else {
                    nextBtn.classList.remove('hover-glow');
                }
            }
        }
        
        // validateStep1은 checkStep1Completion의 별칭
        function validateStep1() {
            checkStep1Completion();
        }
        
        // 기존 함수 (하위 호환성)
        function renderStageOptions() {
            renderCareerStateForm();
        }
        
        function selectStage(stageId) {
            selectedStage = stageId;
        }
        
        // ============================================
        // 통합 질문 데이터 (기존 미니모듈 토큰 매핑 유지)
        // ============================================
        const TOKEN_MAPPING = {
            // interest 매핑
            problem_solving: 'problem_solving',
            creating: 'creating',
            helping: 'helping_teaching',
            data: 'data_numbers',
            tech: 'tech',
            organizing: 'organizing',
            influencing: 'influencing',
            nature: 'nature',
            health: 'health',
            media: 'media',
            // value 매핑
            autonomy: 'autonomy',
            growth: 'growth',
            stability: 'stability',
            income: 'income',
            meaning: 'meaning',
            recognition: 'recognition',
            wlb: 'wlb',
            // strength 매핑
            analytical: 'analytical',
            creative: 'creative',
            communication: 'communication',
            structured_execution: 'structured_execution',
            persistence: 'persistence',
            fast_learning: 'fast_learning',
            empathy: 'empathy',
            leadership: 'leadership',
        };
        
        // 통합 질문 결과 저장 (기존 미니모듈과 호환)
        window.miniModuleResult = null;
        let integratedAnswers = {};
        
        // 통합 질문 렌더링 함수
        // 학생용 질문 텍스트 변환 매핑
        const studentQuestionTexts = {
            'univ_priority': '나중에 일을 하게 된다면 가장 중요하게 생각하는 건 뭔가요?',
            'univ_workstyle_social': '무언가를 할 때 어떤 방식이 더 편한가요?',
            'mm_sacrifice': '꿈을 위해 감수할 수 있는 것은?',
            'mm_energy_drain': '어떨 때 가장 빨리 지치나요?',
            'mm_achievement': '잘하고 있다는 느낌은 언제 드나요?',
            'mm_execution': '새로운 것을 시작할 때 나는?',
            'mm_failure': '일이나 공부가 잘 안 됐을 때, 나는 보통 어떤 반응에 가깝나요?',
            'mm_anchor': '힘들어도 계속할 수 있게 해주는 건?',
        };
        
        function renderIntegratedQuestions() {
            const container = document.getElementById('integrated-questions-container');
            if (!container) return;
            
            const questions = JSON.parse('${universalQuestionsJson}');
            
            // 학생 여부 확인
            const isStudent = careerState.role_identity === 'student';
            
            container.innerHTML = questions.map((q, idx) => {
                const isRequired = q.required;
                const maxSel = q.max_selections || 3;
                
                // 학생용 질문 텍스트 적용
                const questionText = isStudent && studentQuestionTexts[q.id] 
                    ? studentQuestionTexts[q.id] 
                    : q.text;
                
                return \`
                    <div class="integrated-question mb-6 p-5 rounded-xl" 
                         style="background: linear-gradient(135deg, rgba(99,102,241,0.05), rgba(168,85,247,0.05)); border: 1px solid rgba(99,102,241,0.2);"
                         data-question-id="\${q.id}">
                        <div class="flex items-center gap-2 mb-2">
                            <span class="w-6 h-6 bg-wiki-primary/30 text-wiki-primary rounded-full flex items-center justify-center text-xs font-bold">\${idx + 1}</span>
                            <h4 class="font-semibold text-white">\${questionText}</h4>
                            \${isRequired ? '<span class="text-red-400 text-xs">*필수</span>' : ''}
                        </div>
                        \${q.help_text ? \`<p class="text-xs text-emerald-400 mb-3 ml-8">\${q.help_text}</p>\` : ''}
                        \${q.ui_type === 'chips' ? \`
                            <div class="flex flex-wrap gap-2">
                                \${q.options.map(opt => \`
                                    <button type="button" 
                                            onclick="toggleIntegratedChip('\${q.id}', '\${opt.value}', this, \${maxSel})"
                                            class="int-chip px-3 py-2 rounded-lg border transition-all text-sm"
                                            style="background: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                            data-value="\${opt.value}"
                                            data-token="\${opt.token || opt.value}">
                                        <span class="mr-1">\${opt.emoji || ''}</span>\${opt.label}
                                    </button>
                                \`).join('')}
                                \${q.allow_unknown ? \`
                                    <button type="button" 
                                            onclick="toggleIntegratedChip('\${q.id}', 'unknown', this, \${maxSel})"
                                            class="int-chip px-3 py-2 rounded-lg border transition-all text-sm"
                                            style="background: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                            data-value="unknown">
                                        <span class="mr-1">❓</span>\${q.unknown_label || '모르겠어요'}
                                    </button>
                                \` : ''}
                                \${q.allow_other ? \`
                                    <button type="button" 
                                            onclick="showIntegratedOtherInput('\${q.id}', this)"
                                            class="int-chip int-other-btn px-3 py-2 rounded-lg border transition-all text-sm"
                                            style="background: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                            data-value="other">
                                        <span class="mr-1">✏️</span>\${q.other_label || '기타'}
                                    </button>
                                \` : ''}
                            </div>
                            \${q.allow_other ? \`
                            <div id="\${q.id}-other-input" class="hidden mt-3">
                                <input type="text" 
                                       id="\${q.id}-other-text"
                                       placeholder="직접 입력해주세요" 
                                       class="w-full px-3 py-2 rounded-lg border text-sm"
                                       style="background: rgba(15,15,35,0.8); border-color: rgba(99,102,241,0.5); color: white;"
                                       onkeyup="updateIntegratedOtherValue('\${q.id}')"
                                       maxlength="50">
                            </div>
                            \` : ''}
                            <p class="text-xs text-wiki-muted mt-2">최대 \${maxSel}개 선택</p>
                        \` : q.ui_type === 'radio' ? \`
                            <div class="flex flex-wrap gap-2">
                                \${q.options.map(opt => \`
                                    <button type="button" 
                                            onclick="selectIntegratedRadio('\${q.id}', '\${opt.value}', this)"
                                            class="int-radio px-3 py-2 rounded-lg border transition-all text-sm"
                                            style="background: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                            data-value="\${opt.value}">
                                        <span class="mr-1">\${opt.emoji || ''}</span>\${opt.label}
                                    </button>
                                \`).join('')}
                                \${q.allow_other ? \`
                                    <button type="button" 
                                            onclick="showIntegratedOtherInput('\${q.id}', this, true)"
                                            class="int-radio int-other-btn px-3 py-2 rounded-lg border transition-all text-sm"
                                            style="background: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                            data-value="other">
                                        <span class="mr-1">✏️</span>\${q.other_label || '기타'}
                                    </button>
                                \` : ''}
                            </div>
                            \${q.allow_other ? \`
                            <div id="\${q.id}-other-input" class="hidden mt-3">
                                <input type="text" 
                                       id="\${q.id}-other-text"
                                       placeholder="직접 입력해주세요" 
                                       class="w-full px-3 py-2 rounded-lg border text-sm"
                                       style="background: rgba(15,15,35,0.8); border-color: rgba(99,102,241,0.5); color: white;"
                                       onkeyup="updateIntegratedOtherValue('\${q.id}', true)"
                                       maxlength="50">
                            </div>
                            \` : ''}
                        \` : q.ui_type === 'language_chips' ? \`
                            <div class="language-selector-integrated" data-question-id="\${q.id}">
                                <!-- 주요 언어 버튼들 -->
                                <div class="flex flex-wrap gap-2 mb-3">
                                    \${q.options.map(opt => \`
                                        <button type="button" 
                                                onclick="toggleIntegratedLanguage('\${q.id}', '\${opt.value}', '\${opt.label}', this)"
                                                class="int-lang-chip group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                                style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                                data-value="\${opt.value}">
                                            <span class="flex items-center gap-2">
                                                <span class="text-lg">\${opt.emoji || ''}</span>
                                                <span style="color: rgb(148,163,184);">\${opt.label}</span>
                                            </span>
                                            <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden lang-check">✓</div>
                                        </button>
                                    \`).join('')}
                                    \${q.allow_unknown ? \`
                                        <button type="button" 
                                                onclick="toggleIntegratedLanguageNone('\${q.id}', this)"
                                                class="int-lang-chip int-lang-none px-4 py-2.5 rounded-xl border transition-all duration-200"
                                                style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                                data-value="none">
                                            <span class="flex items-center gap-2">
                                                <span class="text-lg">❌</span>
                                                <span style="color: rgb(148,163,184);">\${q.unknown_label || '없어요'}</span>
                                            </span>
                                        </button>
                                    \` : ''}
                                    <button type="button" 
                                            onclick="showIntegratedOtherLanguages('\${q.id}')"
                                            class="int-lang-other-btn px-4 py-2.5 rounded-xl border transition-all duration-200"
                                            style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);">
                                        <span class="flex items-center gap-2">
                                            <span class="text-lg">🌐</span>
                                            <span style="color: rgb(148,163,184);">기타 언어</span>
                                        </span>
                                    </button>
                                </div>
                                
                                <!-- 수준 선택 패널 -->
                                <div id="\${q.id}-level-panel" class="hidden mt-3 p-4 rounded-xl animate-fadeIn" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);">
                                    <p class="text-sm mb-3" style="color: rgb(148,163,184);">
                                        <span id="\${q.id}-level-label" class="font-semibold text-white">영어</span> 수준을 선택해주세요:
                                    </p>
                                    <div class="flex flex-wrap gap-3">
                                        <button type="button" onclick="selectIntegratedLanguageLevel('\${q.id}', 'basic')" 
                                                class="int-level-btn flex items-center gap-2 px-4 py-2.5 rounded-xl border transition-all duration-200"
                                                style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);" data-level="basic">
                                            <span class="text-lg">💬</span>
                                            <span style="color: rgb(148,163,184);">일상회화</span>
                                        </button>
                                        <button type="button" onclick="selectIntegratedLanguageLevel('\${q.id}', 'business')" 
                                                class="int-level-btn flex items-center gap-2 px-4 py-2.5 rounded-xl border transition-all duration-200"
                                                style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);" data-level="business">
                                            <span class="text-lg">💼</span>
                                            <span style="color: rgb(148,163,184);">업무가능</span>
                                        </button>
                                        <button type="button" onclick="selectIntegratedLanguageLevel('\${q.id}', 'native')" 
                                                class="int-level-btn flex items-center gap-2 px-4 py-2.5 rounded-xl border transition-all duration-200"
                                                style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);" data-level="native">
                                            <span class="text-lg">🏆</span>
                                            <span style="color: rgb(148,163,184);">원어민급</span>
                                        </button>
                                    </div>
                                </div>
                                
                                <!-- 기타 언어 선택 패널 -->
                                <div id="\${q.id}-other-panel" class="hidden mt-3 p-4 rounded-xl animate-fadeIn" style="background: linear-gradient(135deg, rgba(34,197,94,0.1), rgba(16,185,129,0.1)); border: 1px solid rgba(34,197,94,0.3);">
                                    <p class="text-sm mb-3" style="color: rgb(148,163,184);">어떤 언어인가요?</p>
                                    <div class="flex flex-wrap gap-2">
                                        \${(q.other_languages || []).map(lang => \`
                                            <button type="button" onclick="selectIntegratedOtherLanguage('\${q.id}', '\${lang.value}', '\${lang.label}')"
                                                    class="int-other-lang-btn px-3 py-2 rounded-lg border transition-all duration-200 text-sm"
                                                    style="background: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);">
                                                \${lang.label}
                                            </button>
                                        \`).join('')}
                                    </div>
                                </div>
                                
                                <!-- 선택된 언어 표시 -->
                                <div id="\${q.id}-selected" class="mt-3 flex flex-wrap gap-2"></div>
                            </div>
                        \` : ''}
                    </div>
                \`;
            }).join('');
            
            // 기존 선택 답변 복원
            restoreIntegratedAnswers();
        }
        
        // 기존 통합 질문 답변 복원 함수
        function restoreIntegratedAnswers() {
            if (!integratedAnswers || Object.keys(integratedAnswers).length === 0) return;
            
            
            Object.keys(integratedAnswers).forEach(questionId => {
                const value = integratedAnswers[questionId];
                if (!value) return;
                
                const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
                if (!container) return;
                
                // 배열인 경우 (chips)
                if (Array.isArray(value)) {
                    value.forEach(v => {
                        const btn = container.querySelector(\`[data-value="\${v}"]\`);
                        if (btn && !btn.classList.contains('selected')) {
                            btn.classList.add('selected');
                            btn.style.background = 'linear-gradient(135deg, rgba(67,97,238,0.3), rgba(168,85,247,0.2))';
                            btn.style.borderColor = 'rgba(67,97,238,0.5)';
                        }
                    });
                } 
                // 문자열인 경우 (radio)
                else if (typeof value === 'string') {
                    const btn = container.querySelector(\`[data-value="\${value}"]\`);
                    if (btn && !btn.classList.contains('selected')) {
                        btn.classList.add('selected');
                        btn.style.background = 'linear-gradient(135deg, rgba(67,97,238,0.3), rgba(168,85,247,0.2))';
                        btn.style.borderColor = 'rgba(67,97,238,0.5)';
                    }
                }
            });
        }
        
        function toggleIntegratedChip(questionId, value, btn, maxSel) {
            if (!integratedAnswers[questionId]) {
                integratedAnswers[questionId] = [];
            }
            
            const arr = integratedAnswers[questionId];
            const idx = arr.indexOf(value);
            
            if (idx >= 0) {
                // 선택 해제
                arr.splice(idx, 1);
                btn.style.background = 'rgba(26,26,46,0.7)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.classList.remove('selected');
            } else {
                // 선택 추가
                if (arr.length >= maxSel) {
                    // 가장 오래된 선택 제거
                    const oldValue = arr.shift();
                    const container = btn.closest('.integrated-question');
                    const oldBtn = container.querySelector(\`[data-value="\${oldValue}"]\`);
                    if (oldBtn) {
                        oldBtn.style.background = 'rgba(26,26,46,0.7)';
                        oldBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                        oldBtn.classList.remove('selected');
                    }
                }
                arr.push(value);
                btn.style.background = 'rgba(99,102,241,0.2)';
                btn.style.borderColor = 'rgba(99,102,241,0.5)';
                btn.classList.add('selected');
            }
            
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        function selectIntegratedRadio(questionId, value, btn) {
            // 같은 질문의 다른 라디오 버튼 해제
            const container = btn.closest('.integrated-question');
            container.querySelectorAll('.int-radio').forEach(b => {
                b.style.background = 'rgba(26,26,46,0.7)';
                b.style.borderColor = 'rgba(42,42,62,0.5)';
                b.classList.remove('selected');
            });
            
            // 선택
            btn.style.background = 'rgba(99,102,241,0.2)';
            btn.style.borderColor = 'rgba(99,102,241,0.5)';
            btn.classList.add('selected');
            
            integratedAnswers[questionId] = value;
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        // 통합 질문 언어 선택 (수준 선택 포함)
        let integratedLanguageSelection = {};  // { questionId: { lang: { level, label } } }
        let currentIntegratedLangQuestion = null;
        let currentIntegratedLangValue = null;
        let currentIntegratedLangLabel = null;
        
        function toggleIntegratedLanguage(questionId, langValue, langLabel, btn) {
            if (!integratedLanguageSelection[questionId]) {
                integratedLanguageSelection[questionId] = {};
            }
            
            const langData = integratedLanguageSelection[questionId];
            
            // '없어요' 선택 해제
            const noneBtn = btn.closest('.language-selector-integrated')?.querySelector('.int-lang-none');
            if (noneBtn) {
                noneBtn.style.background = 'rgba(26,26,46,0.9)';
                noneBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                noneBtn.classList.remove('selected');
            }
            integratedAnswers[questionId + '_none'] = false;
            
            if (langData[langValue]) {
                // 이미 선택된 언어 → 선택 해제
                delete langData[langValue];
                btn.style.background = 'rgba(26,26,46,0.9)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.querySelector('.lang-check')?.classList.add('hidden');
                
                // 패널 숨기기
                document.getElementById(questionId + '-level-panel')?.classList.add('hidden');
                document.getElementById(questionId + '-other-panel')?.classList.add('hidden');
            } else {
                // 새 언어 선택 → 수준 선택 UI 표시
                currentIntegratedLangQuestion = questionId;
                currentIntegratedLangValue = langValue;
                currentIntegratedLangLabel = langLabel;
                
                // 라벨 업데이트
                const labelEl = document.getElementById(questionId + '-level-label');
                if (labelEl) labelEl.textContent = langLabel;
                
                // 기타 패널 숨기고 수준 패널 표시
                document.getElementById(questionId + '-other-panel')?.classList.add('hidden');
                const levelPanel = document.getElementById(questionId + '-level-panel');
                if (levelPanel) {
                    levelPanel.classList.remove('hidden');
                    levelPanel.querySelectorAll('.int-level-btn').forEach(b => {
                        b.style.background = 'rgba(26,26,46,0.9)';
                        b.style.borderColor = 'rgba(42,42,62,0.5)';
                    });
                }
            }
            
            updateIntegratedLanguageDisplay(questionId);
            updateIntegratedLanguageAnswers(questionId);
        }
        
        function toggleIntegratedLanguageNone(questionId, btn) {
            const container = btn.closest('.language-selector-integrated');
            
            // 모든 언어 선택 해제
            integratedLanguageSelection[questionId] = {};
            container?.querySelectorAll('.int-lang-chip').forEach(b => {
                b.style.background = 'rgba(26,26,46,0.9)';
                b.style.borderColor = 'rgba(42,42,62,0.5)';
                b.querySelector('.lang-check')?.classList.add('hidden');
            });
            
            // '없어요' 버튼 선택
            btn.style.background = 'rgba(239,68,68,0.2)';
            btn.style.borderColor = 'rgba(239,68,68,0.5)';
            btn.classList.add('selected');
            
            // 패널 숨기기
            document.getElementById(questionId + '-level-panel')?.classList.add('hidden');
            document.getElementById(questionId + '-other-panel')?.classList.add('hidden');
            
            integratedAnswers[questionId] = ['none'];
            updateIntegratedLanguageDisplay(questionId);
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        function showIntegratedOtherLanguages(questionId) {
            // 수준 패널 숨기기
            document.getElementById(questionId + '-level-panel')?.classList.add('hidden');
            // 기타 언어 패널 표시
            const otherPanel = document.getElementById(questionId + '-other-panel');
            if (otherPanel) {
                otherPanel.classList.toggle('hidden');
            }
        }
        
        function selectIntegratedOtherLanguage(questionId, langValue, langLabel) {
            currentIntegratedLangQuestion = questionId;
            currentIntegratedLangValue = langValue;
            currentIntegratedLangLabel = langLabel;
            
            // 라벨 업데이트
            const labelEl = document.getElementById(questionId + '-level-label');
            if (labelEl) labelEl.textContent = langLabel;
            
            // 기타 패널 숨기고 수준 패널 표시
            document.getElementById(questionId + '-other-panel')?.classList.add('hidden');
            const levelPanel = document.getElementById(questionId + '-level-panel');
            if (levelPanel) {
                levelPanel.classList.remove('hidden');
                levelPanel.querySelectorAll('.int-level-btn').forEach(b => {
                    b.style.background = 'rgba(26,26,46,0.9)';
                    b.style.borderColor = 'rgba(42,42,62,0.5)';
                });
            }
        }
        
        function selectIntegratedLanguageLevel(questionId, level) {
            if (!currentIntegratedLangValue) return;
            
            const langValue = currentIntegratedLangValue;
            const langLabel = currentIntegratedLangLabel;
            
            if (!integratedLanguageSelection[questionId]) {
                integratedLanguageSelection[questionId] = {};
            }
            
            // '없어요' 선택 해제
            const container = document.querySelector(\`.language-selector-integrated[data-question-id="\${questionId}"]\`);
            const noneBtn = container?.querySelector('.int-lang-none');
            if (noneBtn) {
                noneBtn.style.background = 'rgba(26,26,46,0.9)';
                noneBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                noneBtn.classList.remove('selected');
            }
            
            // 언어에 수준 설정
            integratedLanguageSelection[questionId][langValue] = { level, label: langLabel };
            
            // 버튼 스타일 업데이트 (주요 언어인 경우)
            const langBtn = container?.querySelector(\`.int-lang-chip[data-value="\${langValue}"]\`);
            if (langBtn) {
                langBtn.style.background = 'rgba(99,102,241,0.2)';
                langBtn.style.borderColor = 'rgba(99,102,241,0.5)';
                langBtn.querySelector('.lang-check')?.classList.remove('hidden');
            }
            
            // 수준 버튼 강조
            const levelPanel = document.getElementById(questionId + '-level-panel');
            levelPanel?.querySelectorAll('.int-level-btn').forEach(b => {
                if (b.dataset.level === level) {
                    b.style.background = 'rgba(99,102,241,0.2)';
                    b.style.borderColor = 'rgba(99,102,241,0.5)';
                } else {
                    b.style.background = 'rgba(26,26,46,0.9)';
                    b.style.borderColor = 'rgba(42,42,62,0.5)';
                }
            });
            
            // 잠시 후 패널 숨기기
            setTimeout(() => {
                document.getElementById(questionId + '-level-panel')?.classList.add('hidden');
            }, 300);
            
            updateIntegratedLanguageDisplay(questionId);
            updateIntegratedLanguageAnswers(questionId);
            currentIntegratedLangValue = null;
            currentIntegratedLangLabel = null;
        }
        
        function updateIntegratedLanguageDisplay(questionId) {
            const selectedContainer = document.getElementById(questionId + '-selected');
            if (!selectedContainer) return;
            
            const langData = integratedLanguageSelection[questionId] || {};
            const levelLabels = { basic: '일상회화', business: '업무가능', native: '원어민급' };
            
            selectedContainer.innerHTML = Object.entries(langData).map(([lang, data]) => \`
                <div class="flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm" 
                     style="background: rgba(99,102,241,0.2); border: 1px solid rgba(99,102,241,0.3);">
                    <span class="text-white font-medium">\${data.label || lang}</span>
                    <span style="color: rgb(148,163,184);">·</span>
                    <span style="color: rgb(129,140,248);">\${levelLabels[data.level] || data.level}</span>
                    <button type="button" onclick="removeIntegratedLanguage('\${questionId}', '\${lang}')" 
                            class="ml-1 text-red-400 hover:text-red-300">×</button>
                </div>
            \`).join('');
        }
        
        function removeIntegratedLanguage(questionId, langValue) {
            if (integratedLanguageSelection[questionId]) {
                delete integratedLanguageSelection[questionId][langValue];
            }
            
            // 버튼 스타일 복원
            const container = document.querySelector(\`.language-selector-integrated[data-question-id="\${questionId}"]\`);
            const langBtn = container?.querySelector(\`.int-lang-chip[data-value="\${langValue}"]\`);
            if (langBtn) {
                langBtn.style.background = 'rgba(26,26,46,0.9)';
                langBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                langBtn.querySelector('.lang-check')?.classList.add('hidden');
            }
            
            updateIntegratedLanguageDisplay(questionId);
            updateIntegratedLanguageAnswers(questionId);
        }
        
        function updateIntegratedLanguageAnswers(questionId) {
            const langData = integratedLanguageSelection[questionId] || {};
            const values = Object.entries(langData).map(([lang, data]) => \`\${lang}_\${data.level}\`);
            
            if (values.length > 0) {
                integratedAnswers[questionId] = values;
            } else {
                delete integratedAnswers[questionId];
            }
            
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        // 통합 질문 '기타' 입력 처리
        let integratedOtherValues = {};  // { questionId: '기타 입력값' }
        
        function showIntegratedOtherInput(questionId, btn, isRadio = false) {
            const container = btn.closest('.integrated-question');
            const inputDiv = document.getElementById(questionId + '-other-input');
            const textInput = document.getElementById(questionId + '-other-text');
            
            if (isRadio) {
                // radio: 기존 선택 해제
                container.querySelectorAll('.int-radio').forEach(b => {
                    b.style.background = 'rgba(26,26,46,0.7)';
                    b.style.borderColor = 'rgba(42,42,62,0.5)';
                    b.classList.remove('selected');
                });
            }
            
            // 버튼 선택 표시
            btn.style.background = 'rgba(99,102,241,0.2)';
            btn.style.borderColor = 'rgba(99,102,241,0.5)';
            btn.classList.add('selected');
            
            // 입력 필드 표시
            if (inputDiv) {
                inputDiv.classList.remove('hidden');
                textInput?.focus();
            }
            
            // 기존 값 있으면 설정
            if (isRadio) {
                integratedAnswers[questionId] = integratedOtherValues[questionId] 
                    ? 'other:' + integratedOtherValues[questionId] 
                    : 'other';
            }
            
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        function updateIntegratedOtherValue(questionId, isRadio = false) {
            const textInput = document.getElementById(questionId + '-other-text');
            const value = textInput?.value?.trim() || '';
            
            integratedOtherValues[questionId] = value;
            
            if (isRadio) {
                // radio: 기타값으로 설정
                integratedAnswers[questionId] = value ? 'other:' + value : 'other';
            } else {
                // chips: 기존 배열에 기타값 추가/갱신
                if (!integratedAnswers[questionId]) {
                    integratedAnswers[questionId] = [];
                }
                // 기존 other: 값 제거
                integratedAnswers[questionId] = integratedAnswers[questionId].filter(v => !v.startsWith('other:') && v !== 'other');
                if (value) {
                    integratedAnswers[questionId].push('other:' + value);
                }
            }
            
            updateIntegratedUniversalAnswers();
            validateStep1();
        }
        
        // 통합 질문 답변을 universalAnswers와 miniModuleResult에 반영
        function updateIntegratedUniversalAnswers() {
            // universalAnswers에 반영
            for (const [key, value] of Object.entries(integratedAnswers)) {
                universalAnswers[key] = value;
            }
            
            // miniModuleResult 계산 (LLM 앵커용)
            const interest_top = (integratedAnswers.univ_interest || [])
                .slice(0, 2)
                .map(v => TOKEN_MAPPING[v] || v);
            const value_top = (Array.isArray(integratedAnswers.univ_priority) 
                ? integratedAnswers.univ_priority 
                : [integratedAnswers.univ_priority])
                .filter(Boolean)
                .slice(0, 2)
                .map(v => TOKEN_MAPPING[v] || v);
            const strength_top = (integratedAnswers.univ_strength || [])
                .slice(0, 2)
                .map(v => TOKEN_MAPPING[v] || v);
            
            // Step 1의 제약조건에서 constraint_flags 추출
            const constraint_flags = [];
            if (careerState.constraints) {
                for (const [type, data] of Object.entries(careerState.constraints)) {
                    if (data.has_constraint) {
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
                    interest: integratedAnswers.univ_interest || [],
                    value: Array.isArray(integratedAnswers.univ_priority) 
                        ? integratedAnswers.univ_priority 
                        : [integratedAnswers.univ_priority].filter(Boolean),
                    strength: integratedAnswers.univ_strength || [],
                    constraint: constraint_flags,
                }
            };
            
        }
        
        // Step 1 → Step 2 (심층 질문) 직접 이동
        async function goToStep2Direct() {
            // Phase 3: 편집 모드 캐스케이드 리셋
            if (window.__editMode && detectStep1Changes()) {
                cascadeResetFromStep1();
            }
            // 통합 질문 결과 계산
            updateIntegratedUniversalAnswers();
            
            // 저장
            saveDraftToServer();
            
            // Step 2 (심층 질문)로 이동
            goToStep(2);
            
            // V3 모드: 기초 서술형 질문 → 라운드 1,2,3
            if (window.V3_MODE !== false) {
                renderNarrativeStep();
            } else {
                // V2 폴백: 기본 선택형 질문
                await generateFollowupQuestions();
            }
        }
        
        // 심층 질문 생성 함수
        async function generateFollowupQuestions() {
            showLoading('질문 구성 중...', '맞춤 심층 질문을 준비하고 있어요');
            
            try {
                currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: '${c.req.path.includes('/major') ? 'major' : 'job'}',
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        career_state: careerState,
                        mini_module_result: window.miniModuleResult || null,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                hideLoading();
                
                
                if (data.result?.followup_questions?.length > 0) {
                    renderFollowupQuestions(data.result.followup_questions);
                } else {
                    // 질문이 없으면 기본 질문 표시
                    renderDefaultFollowupQuestions();
                }
            } catch (error) {
                hideLoading();
                // 에러 시 기본 질문 표시
                renderDefaultFollowupQuestions();
            }
        }
        
        // 기본 심층 질문 (API 실패 시 폴백)
        function renderDefaultFollowupQuestions() {
            const defaultQuestions = [
                {
                    id: 'default_work_preference',
                    question: '하루 업무 중 가장 보람을 느끼는 순간은 언제인가요?',
                    fact_key: 'preference.work_satisfaction',
                    options: [
                        { value: 'problem_solved', label: '어려운 문제를 해결했을 때' },
                        { value: 'helped_someone', label: '누군가에게 도움이 됐을 때' },
                        { value: 'learned_new', label: '새로운 것을 배웠을 때' },
                        { value: 'completed_task', label: '일을 깔끔하게 마무리했을 때' },
                        { value: 'recognized', label: '성과를 인정받았을 때' },
                    ]
                },
                {
                    id: 'default_challenge',
                    question: '가장 힘들게 느껴지는 업무 상황은?',
                    fact_key: 'aversion.work_challenge',
                    options: [
                        { value: 'unclear_direction', label: '방향이 불명확할 때' },
                        { value: 'too_many_people', label: '많은 사람과 조율해야 할 때' },
                        { value: 'repetitive', label: '반복적인 일이 계속될 때' },
                        { value: 'tight_deadline', label: '촉박한 마감에 쫓길 때' },
                        { value: 'no_feedback', label: '피드백이 없을 때' },
                    ]
                },
                {
                    id: 'default_growth',
                    question: '앞으로 어떤 방향으로 성장하고 싶으세요?',
                    fact_key: 'goal.growth_direction',
                    options: [
                        { value: 'specialist', label: '한 분야의 전문가가 되고 싶다' },
                        { value: 'generalist', label: '다양한 경험을 쌓고 싶다' },
                        { value: 'leader', label: '팀을 이끄는 리더가 되고 싶다' },
                        { value: 'entrepreneur', label: '나만의 사업을 하고 싶다' },
                        { value: 'balance', label: '일과 삶의 균형을 찾고 싶다' },
                    ]
                }
            ];
            
            renderFollowupQuestions(defaultQuestions);
        }
        
        // ============================================
        // [DEPRECATED] 레거시 미니모듈 함수들
        // 3단계 구조에서는 통합 질문으로 대체됨
        // Draft 복원 및 major 페이지 호환을 위해 유지
        // ============================================
        const MINI_MODULE_DATA = {};  // 빈 객체로 대체
        const MINI_MODULE_ORDER = [];  // 빈 배열로 대체
        let currentMiniModuleIndex = 0;
        let miniModuleSelections = { interest: [], value: [], strength: [], constraint: [] };
        
        function renderMiniModule() {
            // DEPRECATED: 3단계 구조에서는 renderIntegratedQuestions() 사용
            const moduleKey = MINI_MODULE_ORDER[currentMiniModuleIndex];
            const module = MINI_MODULE_DATA[moduleKey];
            const container = document.getElementById('mini-module-container');
            if (!container) return;
            
            // 프로그레스 바 업데이트
            MINI_MODULE_ORDER.forEach((key, idx) => {
                const bar = document.getElementById(\`mm-progress-\${idx + 1}\`);
                if (bar) {
                    if (idx < currentMiniModuleIndex) {
                        bar.className = 'w-16 h-1 rounded-full bg-emerald-500';
                    } else if (idx === currentMiniModuleIndex) {
                        bar.className = 'w-16 h-1 rounded-full bg-amber-500';
                    } else {
                        bar.className = 'w-16 h-1 rounded-full bg-wiki-border/50';
                    }
                }
            });
            
            // 버튼 텍스트 업데이트
            const btnText = document.getElementById('mm-btn-text');
            if (btnText) {
                if (currentMiniModuleIndex === MINI_MODULE_ORDER.length - 1) {
                    btnText.textContent = '완료';
                } else {
                    btnText.textContent = '다음 영역';
                }
            }
            
            const colorMap = {
                amber: { bg: 'rgba(245, 158, 11, 0.1)', border: 'rgba(245, 158, 11, 0.3)', text: 'rgb(252, 211, 77)' },
                emerald: { bg: 'rgba(16, 185, 129, 0.1)', border: 'rgba(16, 185, 129, 0.3)', text: 'rgb(110, 231, 183)' },
                blue: { bg: 'rgba(59, 130, 246, 0.1)', border: 'rgba(59, 130, 246, 0.3)', text: 'rgb(147, 197, 253)' },
                red: { bg: 'rgba(239, 68, 68, 0.1)', border: 'rgba(239, 68, 68, 0.3)', text: 'rgb(252, 165, 165)' },
            };
            const colors = colorMap[module.color] || colorMap.amber;
            
            // 제약 모듈은 선택 제한 없음, 나머지는 2개
            const isConstraint = moduleKey === 'constraint';
            const selectionLimit = isConstraint ? 6 : 2;
            const selectionHint = isConstraint ? '해당하는 것을 모두 선택해주세요 (없으면 건너뛰기 가능)' : '가장 끌리는 것 2개를 선택해주세요';
            
            container.innerHTML = \`
                <div class="text-center mb-6">
                    <div class="inline-flex items-center justify-center w-16 h-16 rounded-full mb-3" style="background: \${colors.bg}; border: 2px solid \${colors.border};">
                        <span class="text-3xl">\${module.emoji}</span>
                    </div>
                    <h3 class="text-lg font-bold text-white">\${module.title}</h3>
                    <p class="text-sm" style="color: \${colors.text};">\${module.subtitle}</p>
                    <p class="text-xs text-wiki-muted mt-1">\${selectionHint}</p>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                    \${module.questions.map(q => \`
                        <button type="button" onclick="selectMiniModuleItem('\${moduleKey}', '\${q.token}', this, \${selectionLimit})"
                                class="mm-chip p-4 rounded-xl border-2 transition-all duration-200 text-left group"
                                style="background-color: rgba(26,26,46,0.7); border-color: rgba(42,42,62,0.5);"
                                data-token="\${q.token}">
                            <div class="flex items-center gap-3">
                                <span class="text-2xl group-hover:scale-110 transition-transform">\${q.emoji}</span>
                                <span class="text-white text-sm">\${q.text}</span>
                            </div>
                        </button>
                    \`).join('')}
                </div>
                
                <div class="text-center mt-4">
                    <span id="mm-selection-count" class="text-sm text-wiki-muted">
                        선택: 0\${isConstraint ? '' : '/2'}
                    </span>
                </div>
            \`;
            
            // 이전 선택 복원
            const currentSelections = miniModuleSelections[moduleKey];
            if (currentSelections.length > 0) {
                currentSelections.forEach(token => {
                    const chip = container.querySelector(\`[data-token="\${token}"]\`);
                    if (chip) {
                        chip.style.backgroundColor = colors.bg;
                        chip.style.borderColor = colors.border;
                        chip.classList.add('mm-selected');
                    }
                });
                updateMiniModuleCount(moduleKey);
            }
            
            // 버튼 상태 업데이트
            updateMiniModuleNextButton();
        }
        
        function selectMiniModuleItem(moduleKey, token, btn, limit) {
            const module = MINI_MODULE_DATA[moduleKey];
            const colorMap = {
                amber: { bg: 'rgba(245, 158, 11, 0.15)', border: 'rgba(245, 158, 11, 0.5)' },
                emerald: { bg: 'rgba(16, 185, 129, 0.15)', border: 'rgba(16, 185, 129, 0.5)' },
                blue: { bg: 'rgba(59, 130, 246, 0.15)', border: 'rgba(59, 130, 246, 0.5)' },
                red: { bg: 'rgba(239, 68, 68, 0.15)', border: 'rgba(239, 68, 68, 0.5)' },
            };
            const colors = colorMap[module.color] || colorMap.amber;
            
            const selections = miniModuleSelections[moduleKey];
            const isSelected = selections.includes(token);
            
            if (isSelected) {
                // 선택 해제
                const idx = selections.indexOf(token);
                selections.splice(idx, 1);
                btn.style.backgroundColor = 'rgba(26,26,46,0.7)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.classList.remove('mm-selected');
            } else {
                // 선택 추가 (제한 확인)
                if (selections.length >= limit) {
                    // 제한 초과 시 가장 오래된 선택 제거
                    const oldToken = selections.shift();
                    const oldBtn = document.querySelector(\`[data-token="\${oldToken}"]\`);
                    if (oldBtn) {
                        oldBtn.style.backgroundColor = 'rgba(26,26,46,0.7)';
                        oldBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                        oldBtn.classList.remove('mm-selected');
                    }
                }
                selections.push(token);
                btn.style.backgroundColor = colors.bg;
                btn.style.borderColor = colors.border;
                btn.classList.add('mm-selected');
            }
            
            updateMiniModuleCount(moduleKey);
            updateMiniModuleNextButton();
        }
        
        function updateMiniModuleCount(moduleKey) {
            const countEl = document.getElementById('mm-selection-count');
            if (!countEl) return;
            
            const isConstraint = moduleKey === 'constraint';
            const count = miniModuleSelections[moduleKey].length;
            
            if (isConstraint) {
                countEl.textContent = \`선택: \${count}\`;
            } else {
                countEl.textContent = \`선택: \${count}/2\`;
            }
        }
        
        function updateMiniModuleNextButton() {
            const btn = document.getElementById('mm-next-btn');
            if (!btn) return;
            
            const moduleKey = MINI_MODULE_ORDER[currentMiniModuleIndex];
            const isConstraint = moduleKey === 'constraint';
            const count = miniModuleSelections[moduleKey].length;
            
            // 제약 모듈은 0개도 허용, 나머지는 2개 필수
            const isValid = isConstraint ? true : count === 2;
            btn.disabled = !isValid;
        }
        
        // 미니모듈에서 "이전" 버튼 클릭 시 동작
        function goBackMiniModuleOrStep1() {
            if (currentMiniModuleIndex > 0) {
                // 이전 미니모듈로 이동
                currentMiniModuleIndex--;
                renderMiniModule();
            } else {
                // 첫 미니모듈이면 Step 1(상태 단계)로 이동
                goToStep(1);
            }
        }
        
        function nextMiniModule() {
            currentMiniModuleIndex++;
            
            if (currentMiniModuleIndex >= MINI_MODULE_ORDER.length) {
                // 미니모듈 완료 → 결과 계산 후 Step 2로
                finishMiniModule();
            } else {
                // 다음 모듈 렌더링
                renderMiniModule();
            }
        }
        
        function finishMiniModule() {
            // 미니모듈 결과 계산
            const result = calculateMiniModuleResultFromSelections();
            window.miniModuleResult = result;
            
            
            // Step 2로 전환
            goToStep2WithLoading();
        }
        
        function calculateMiniModuleResultFromSelections() {
            const getTopN = (selections, n) => {
                // 선택된 순서대로 상위 N개 반환
                return selections.slice(0, n);
            };
            
            const interest_top = getTopN(miniModuleSelections.interest, 2);
            const value_top = getTopN(miniModuleSelections.value, 2);
            const strength_top = getTopN(miniModuleSelections.strength, 2);
            const constraint_flags = [...miniModuleSelections.constraint];
            
            // 내부 충돌 체크
            const conflictPairs = [
                ['autonomy', 'stability', 'autonomy_vs_stability'],
                ['growth', 'income', 'growth_vs_income'],
                ['meaning', 'income', 'meaning_vs_income'],
            ];
            
            const internal_conflict_flags = [];
            for (const [val1, val2, conflictName] of conflictPairs) {
                if (value_top.includes(val1) && value_top.includes(val2)) {
                    internal_conflict_flags.push(conflictName);
                }
            }
            
            return {
                interest_top,
                value_top,
                strength_top,
                constraint_flags,
                internal_conflict_flags: internal_conflict_flags.length > 0 ? internal_conflict_flags : undefined,
                raw_selections: { ...miniModuleSelections },
            };
        }
        
        function summarizeMiniModuleResultLocal(result) {
            const tokenToKorean = {
                problem_solving: '문제해결', creating: '창작', helping_teaching: '도움/가르침',
                data_numbers: '데이터', organizing: '조직/관리', influencing: '영향력',
                autonomy: '자율', growth: '성장', stability: '안정', income: '수입', meaning: '의미', recognition: '인정',
                analytical: '분석력', creative: '창의력', communication: '소통력',
                structured_execution: '실행력', persistence: '끈기', fast_learning: '학습력',
                time_constraint: '시간', income_constraint: '수입', location_constraint: '위치',
                physical_constraint: '체력', qualification_constraint: '자격', uncertainty_constraint: '불확실성',
            };
            
            const format = (arr) => arr.map(t => tokenToKorean[t] || t).join(', ') || '없음';
            
            return \`흥미: \${format(result.interest_top)} | 가치: \${format(result.value_top)} | 강점: \${format(result.strength_top)} | 제약: \${format(result.constraint_flags)}\`;
        }
        
        function goBackToMiniModule() {
            // Step 2에서 미니모듈로 돌아가기
            currentMiniModuleIndex = MINI_MODULE_ORDER.length - 1; // 마지막 모듈부터 시작
            renderMiniModule();
            
            document.querySelectorAll('.step-content').forEach(s => s.classList.add('hidden'));
            document.getElementById('step1-5')?.classList.remove('hidden');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
        
        // Step 1 → Step 2 전환 (로딩 포함)
        function goToStep2WithLoading() {
            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();
            
            showLoading('질문 구성 중...', '상황에 맞는 질문을 준비하고 있어요');
            setTimeout(() => {
            renderUniversalQuestions();
            goToStep(2);
                hideLoading();
            }, 600);
        }
        
        // ============================================
        // Step 3: 전이 신호 UI 렌더링 (고급 UI)
        // ============================================
        function renderTransitionSignalForm() {
            const container = document.getElementById('transition-signal-form');
            if (!container) return;
            
            // Step3 제목 복원 (V3 라운드에서 돌아온 경우)
            const step3Title = document.querySelector('#step3 h2');
            if (step3Title) {
                step3Title.innerHTML = '<i class="fas fa-compass text-emerald-400 mr-2"></i>앞으로의 방향 (1~2분)';
            }
            
            // 버튼 텍스트 복원
            const nextBtn = document.getElementById('step3-next-btn');
            if (nextBtn) {
                nextBtn.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>다음';
                nextBtn.onclick = submitTransitionAndContinue;
            }
            
            // 이전 버튼: Step 2로 돌아가기
            const prevBtn = document.getElementById('step3-prev-btn');
            if (prevBtn) {
                prevBtn.onclick = () => goToStep(2);
            }

            container.innerHTML = TRANSITION_SIGNAL_QUESTIONS.map(q => {
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
            
            // 저장된 값 복원
            restoreTransitionSignalAnswers();
        }
        
        // 전이 신호 답변 복원
        function restoreTransitionSignalAnswers() {
            if (!transitionSignalAnswers || Object.keys(transitionSignalAnswers).length === 0) return;
            
            for (const [questionId, values] of Object.entries(transitionSignalAnswers)) {
                const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
                if (!container) continue;
                
                if (Array.isArray(values)) {
                    // 칩 선택 복원
                    for (const val of values) {
                        const btn = container.querySelector(\`[data-value="\${val}"]\`);
                        if (btn) {
                            // 선택 상태로 스타일 적용
                            btn.style.backgroundColor = 'rgba(16,185,129,0.2)';
                            btn.style.borderColor = '#10b981';
                            btn.style.color = '#34d399';
                        }
                    }
                    // 순서 업데이트
                    updateChipOrder(questionId);
                } else if (typeof values === 'string') {
                    // 라디오 버튼 복원 (selectTransitionRadio와 동일한 스타일)
                    const btn = container.querySelector(\`[data-value="\${values}"]\`);
                    if (btn) {
                        btn.style.backgroundColor = 'rgba(16,185,129,0.2)';
                        btn.style.borderColor = '#10b981';
                        const radioCircle = btn.querySelector('.radio-circle');
                        const radioDot = btn.querySelector('.radio-dot');
                        if (radioCircle) radioCircle.style.borderColor = '#10b981';
                        if (radioDot) radioDot.classList.remove('hidden');
                    }
                }
            }
        }
        
        // 전이 신호 답변 수집
        function collectTransitionSignalAnswers() {
            // transitionSignalAnswers는 selectTransitionChip 등에서 이미 업데이트됨
            // 슬라이더 값 수집
            document.querySelectorAll('.trans-slider').forEach(slider => {
                const questionId = slider.closest('[data-question-id]')?.dataset.questionId;
                if (questionId) {
                    transitionSignalAnswers[questionId] = slider.value;
                }
            });
        }
        
        // 전이 신호 선택 핸들러들 (고급 UI)
        function selectTransitionChip(questionId, value, btnEl, maxSelections) {
            if (!transitionSignalAnswers[questionId]) {
                transitionSignalAnswers[questionId] = [];
            }
            
            const arr = transitionSignalAnswers[questionId];
            const idx = arr.indexOf(value);
            
            if (idx > -1) {
                // 이미 선택됨 → 제거
                arr.splice(idx, 1);
                btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                btnEl.style.color = 'rgb(148,163,184)';
                btnEl.querySelector('.chip-rank')?.classList.add('hidden');
                btnEl.querySelector('.chip-rank')?.classList.remove('flex');
            } else if (arr.length < maxSelections) {
                // 새로 선택
                arr.push(value);
                btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                btnEl.style.borderColor = '#10b981';
                btnEl.style.color = '#34d399';
            }
            
            // 선택 순서 표시 및 순위 배지 업데이트
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
                const q = TRANSITION_SIGNAL_QUESTIONS.find(q => q.question_id === questionId);
                const labels = arr.map((v, i) => {
                    const opt = q?.options.find(o => o.value === v);
                    // 해당 버튼에 순위 배지 표시
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
            
            // 같은 질문의 다른 버튼들 선택 해제
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
            if (!transitionSignalAnswers[questionId]) {
                transitionSignalAnswers[questionId] = [];
            }
            
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
        
        // Step 2 → Step 3 전환 (전이 신호)
        async function submitUniversalAndGoToTransition() {
            collectUniversalAnswers();
            
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
        
        // Step 3 → 서술형 질문 단계 전환 (V3)
        async function submitTransitionAndContinue() {
            // 전이 신호 답변 수집 (임시 저장용)
            collectTransitionSignalAnswers();
            
            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();
            
            // V3 모드: 서술형 심층 질문 단계로 진행
            const isMinor = MINOR_STAGES.includes(selectedStage);

            if (!isMinor && window.V3_MODE !== false) {
                showLoading('준비 중...', '심층 질문을 구성하고 있어요');
                setTimeout(() => {
                    renderNarrativeStep();
                    hideLoading();
                }, 400);
                return;
            }
            
            // 기존 V2 로직
            showLoading('분석 중...', '맞춤 심층 질문을 구성하고 있어요');
            
            try {
                currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        career_state: careerState,
                        transition_signal: transitionSignalAnswers,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                hideLoading();
                
                if (data.result?.followup_questions?.length > 0) {
                    renderFollowupQuestions(data.result.followup_questions);
                    goToStep(2); // 심층 질문 (3단계 구조)
                } else {
                    // Follow-up 질문이 없으면 바로 결과로
                    currentRequestId = data.request_id;
                    displayResults(data);
                    goToStep(3); // 결과 (3단계 구조)
                }
            } catch (error) {
                hideLoading();
                alert('오류가 발생했습니다: ' + error.message);
            }
        }
        
        // ============================================
        // V3: 3라운드 심층 질문 시스템
        // ============================================
        window.V3_MODE = true; // V3 모드 활성화 플래그
        window.currentRound = 1;
        window.roundAnswers = [];
        window.narrativeFacts = null;
        
        // V3: 서술형 답변 저장 (P0-1: 에러 표시 강화)
        async function saveNarrativeFacts(facts) {
            try {
                currentSessionId = currentSessionId || 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);

                // P0-1: session_id 유효성 검사
                if (!currentSessionId || currentSessionId.trim() === '') {
                    showErrorToast('세션 ID가 유효하지 않습니다. 페이지를 새로고침해주세요.');
                    return false;
                }


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

                // P0-1: 응답 상태 확인
                if (!response.ok) {
                    const errorText = await response.text();
                    // 테이블 없음 등의 D1 에러는 무시하고 계속 진행 (테스트 환경)
                    if (errorText.includes('error code: 1031') || errorText.includes('no such table')) {
                        return true; // 테스트를 위해 계속 진행
                    }
                    showErrorToast('서술형 답변 저장 실패: ' + errorText.substring(0, 100));
                    return false;
                }

                const data = await response.json();

                // P0-1: 상세 에러 표시
                if (!data.success) {
                    showErrorToast('서술형 답변 저장 실패: ' + (data.detail || data.error || 'Unknown error'));
                    return false;
                }

                return true;

            } catch (error) {
                // JSON 파싱 에러 등은 무시하고 계속 진행 (테스트 환경)
                if (error.message && error.message.includes('JSON')) {
                    return true;
                }
                showErrorToast('서술형 답변 저장 중 오류 발생: ' + (error.message || 'Network error'));
                return false;
            }
        }
        
        // P0-1: 에러 토스트 표시 함수
        function showErrorToast(message) {
            // 기존 토스트 제거
            const existingToast = document.querySelector('.v3-error-toast');
            if (existingToast) existingToast.remove();
            
            const toast = document.createElement('div');
            toast.className = 'v3-error-toast';
            toast.innerHTML = \`
                <div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); 
                            background: #ef4444; color: white; padding: 12px 20px; border-radius: 8px;
                            box-shadow: 0 4px 12px rgba(0,0,0,0.3); z-index: 10000; max-width: 90vw;
                            font-size: 14px; display: flex; align-items: center; gap: 8px;">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                              d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span>\${message}</span>
                    <button onclick="this.parentElement.parentElement.remove()" 
                            style="margin-left: 8px; background: none; border: none; color: white; cursor: pointer;">✕</button>
                </div>
            \`;
            document.body.appendChild(toast);
            
            // 5초 후 자동 제거
            setTimeout(() => toast.remove(), 5000);
        }
        
        // V3: 라운드 질문 시작
        async function startV3RoundQuestions(roundNumber) {
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
                        // 미니모듈 결과 (LLM 판단 앵커 - 이게 핵심!)
                        mini_module_result: window.miniModuleResult || null,
                    })
                });
                
                hideLoading();
                
                // 먼저 HTTP 상태 체크 (500 에러 등)
                if (!response.ok) {
                    const errorText = await response.text().catch(() => 'Unknown server error');
                    alert('질문 생성 중 서버 오류가 발생했습니다 (HTTP ' + response.status + ')\\n\\n잠시 후 다시 시도해주세요.');
                    return;
                }
                
                const data = await response.json();
                
                // API 에러 처리
                if (data.error) {
                    alert('질문 생성 중 오류가 발생했습니다: ' + (data.error || 'Unknown error') + '\\n\\n페이지를 새로고침하고 다시 시도해주세요.');
                    return;
                }
                
                // LLM 생성 질문 사용
                const questions = data.questions || [];
                
                if (questions.length > 0) {
                    window.currentRound = roundNumber;
                    window.roundQuestions = questions;  // 질문 저장 (복원용)
                    
                    
                    renderV3RoundUI(roundNumber, questions, meta);
                    // Step 2에 라운드 표시 (3단계 구조)
                    document.querySelectorAll('.step-content').forEach(s => s.classList.add('hidden'));
                    document.getElementById('step2')?.classList.remove('hidden');
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                } else {
                    // 질문이 없으면 에러 표시
                    alert('질문을 생성하지 못했습니다. 페이지를 새로고침하고 다시 시도해주세요.');
                }
            } catch (error) {
                hideLoading();
                alert('질문 생성 중 오류가 발생했습니다: ' + (error.message || 'Network error') + '\\n\\n페이지를 새로고침하고 다시 시도해주세요.');
            }
        }
        
        // V3: 라운드 UI 렌더링
        function renderV3RoundUI(roundNumber, questions, meta) {
            // Step 2에서 호출 시 followup-questions-form 사용
            const container = document.getElementById('followup-questions-form') || document.getElementById('transition-signal-form');
            if (!container) return;
            
            const progressWidth = (roundNumber / 3) * 100;
            
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
                                oninput="updateV3Counter(this)"></textarea>
                            <div class="flex justify-between items-center mt-2">
                                <span class="text-xs text-wiki-muted">최소 \${q.minLengthGuidance || 30}자</span>
                                <span id="v3_q_\${q.id}_counter" class="text-xs text-wiki-muted">0자</span>
                            </div>
                        </div>
                    \`).join('')}
                </div>
            \`;
            
            // Step 2 제목 및 서브타이틀 업데이트 (3단계 구조)
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
            
            // Step 인디케이터 업데이트 - 심층 단계(2) 표시
            currentStep = 2;
            window.currentStep = 2;
            document.querySelectorAll('.step-dot').forEach((el) => {
                const circle = el.querySelector('span:first-child');
                const stepNum = parseInt(el.dataset.step, 10);
                if (stepNum <= 2) {
                    circle.classList.remove('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-primary', 'text-white');
                } else {
                    circle.classList.add('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.remove('bg-wiki-primary', 'text-white');
                }
            });
            
            // Step 2 버튼 텍스트 업데이트
            const analyzeBtn = document.getElementById('analyze-btn');
            if (analyzeBtn) {
                if (roundNumber < 3) {
                    analyzeBtn.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>다음 라운드';
                    analyzeBtn.onclick = () => submitV3RoundAndContinue(roundNumber, questions);
                } else {
                    analyzeBtn.innerHTML = '<i class="fas fa-magic mr-2"></i>분석 시작';
                    analyzeBtn.onclick = () => submitV3RoundAndAnalyze(questions);
                }
            }
            
            // 이전 버튼 동작 업데이트 (라운드별 분기)
            const step2PrevBtn = document.getElementById('step2-prev-btn');
            if (step2PrevBtn) {
                step2PrevBtn.onclick = () => {
                    if (roundNumber === 1) {
                        // Round 1 -> 서술형 질문으로
                        showPrevWarningModal(() => {
                            renderNarrativeStep();
                        });
                    } else {
                        // Round 2/3 -> 이전 라운드로 (경고 없이 바로 이동)
                        startV3RoundQuestions(roundNumber - 1);
                    }
                };
            }
        }
        
        // 이전 버튼 경고 모달 표시
        function showPrevWarningModal(onConfirm) {
            // 기존 모달 제거
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
                // 심층 질문 상태 초기화
                window.currentRound = 0;
                window.roundQuestions = null;
                window.roundAnswers = [];
                onConfirm();
            };
        }
        
        // V3: 심층 질문 기초 답변 복원
        function restoreNarrativeAnswers() {
            if (!window.narrativeFacts) {
                return;
            }
            
            const facts = window.narrativeFacts;
            
            // Q0: 스토리 질문
            const q0 = document.getElementById('narrative_q0');
            if (q0 && (facts.storyAnswer || facts.life_story)) {
                q0.value = facts.storyAnswer || facts.life_story || '';
                if (typeof updateNarrativeCounter === 'function') {
                    updateNarrativeCounter(q0, 5000);
                }
            }
            
            // Career background (선택)
            const careerBg = document.getElementById('narrative_career_bg');
            if (careerBg && facts.career_background) {
                careerBg.value = facts.career_background;
            }
            
            // Q1: 동적 질문 1
            const q1 = document.getElementById('narrative_q1');
            if (q1 && (facts.question1Answer || facts.highAliveMoment)) {
                q1.value = facts.question1Answer || facts.highAliveMoment || '';
                if (typeof updateNarrativeCounter === 'function') {
                    updateNarrativeCounter(q1, 10000);
                }
            }
            
            // Q2: 동적 질문 2
            const q2 = document.getElementById('narrative_q2');
            if (q2 && (facts.question2Answer || facts.lostMoment)) {
                q2.value = facts.question2Answer || facts.lostMoment || '';
                if (typeof updateNarrativeCounter === 'function') {
                    updateNarrativeCounter(q2, 10000);
                }
            }
            
        }
        
        // V3: 라운드 답변 복원
        function restoreRoundAnswers() {
            if (!window.roundAnswers || !window.currentRound) return;
            
            // 현재 라운드의 답변 찾기
            const currentRoundAnswers = window.roundAnswers.filter(a => a.roundNumber === window.currentRound);
            
            currentRoundAnswers.forEach(answer => {
                const textarea = document.getElementById('v3_q_' + answer.questionId);
                if (textarea && answer.answer) {
                    textarea.value = answer.answer;
                    // 카운터 업데이트
                    if (typeof updateV3Counter === 'function') {
                        updateV3Counter(textarea);
                    }
                }
            });
            
        }
        
        // V3: 글자수 카운터
        function updateV3Counter(textarea) {
            const counter = document.getElementById(textarea.id + '_counter');
            if (counter) {
                counter.textContent = textarea.value.length + '자';
                counter.style.color = textarea.value.length >= (parseInt(textarea.minLength) || 30) ? 'rgb(74, 222, 128)' : 'rgb(148,163,184)';
            }
        }
        
        // V3: 라운드 답변 제출 후 다음 라운드
        async function submitV3RoundAndContinue(currentRound, questions) {
            const answers = collectV3RoundAnswers(questions);
            if (!validateV3Answers(answers, questions)) return;

            // Phase 3: 편집 모드 - 라운드 변경 시 이후 라운드 초기화
            if (window.__editMode && detectRoundChanges(currentRound)) {
                cascadeResetFromRound(currentRound);
            }
            
            const nextBtn = document.getElementById('step3-next-btn');
            const prevBtn = document.getElementById('step3-prev-btn');
            const originalNextHtml = nextBtn?.innerHTML;
            
            // 저장 구간부터 로딩 표시 (기존에는 없었음)
            showLoading('답변 저장 중...', '다음 라운드를 준비하고 있어요');
            
            try {
                // 버튼 비활성화
                if (nextBtn) {
                    nextBtn.disabled = true;
                    nextBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>저장 중...';
                }
                if (prevBtn) prevBtn.setAttribute('disabled', 'true');
                
                // 답변 저장
                await saveV3RoundAnswers(currentRound, answers, questions);
                
                // 다음 라운드 시작 (startV3RoundQuestions 내부에서 showLoading('질문 구성 중...') → hideLoading() 처리됨)
                await startV3RoundQuestions(currentRound + 1);
            } finally {
                // 버튼 복원
                if (nextBtn) {
                    nextBtn.disabled = false;
                    if (originalNextHtml) nextBtn.innerHTML = originalNextHtml;
                }
                if (prevBtn) prevBtn.removeAttribute('disabled');
                // 안전장치: 오류로 startV3RoundQuestions로 못 갔을 때를 대비
                hideLoading();
            }
        }
        
        // V3: 마지막 라운드 후 분석 시작
        async function submitV3RoundAndAnalyze(questions) {
            const answers = collectV3RoundAnswers(questions);
            if (!validateV3Answers(answers, questions)) return;
            
            const nextBtn = document.getElementById('step3-next-btn');
            const prevBtn = document.getElementById('step3-prev-btn');
            
            // 저장부터 로딩 표시
            showLoading('답변 저장 중...', '마지막 답변을 저장하고 있어요');
            
            // 버튼 비활성화
            if (nextBtn) {
                nextBtn.disabled = true;
                nextBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>저장 중...';
            }
            if (prevBtn) prevBtn.setAttribute('disabled', 'true');
            
            // 마지막 라운드 답변 저장
            await saveV3RoundAnswers(3, answers, questions);
            
            // ============================================
            // Freeze v1.1: Recommendation Mode 통합
            // - 기존 분석 API 호출 (리포트 생성용)
            // - 새 Recommend API 호출 (최신 Vectorize+TAG 기반 추천)
            // ============================================
            showLoading('분석 중...', '전문가급 리포트를 생성하고 있어요');
            
            try {
                // 1. 기존 분석 API (리포트 생성)
                const analyzeResponse = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        career_state: careerState,
                        transition_signal: transitionSignalAnswers,
                        universal_answers: universalAnswers,
                        narrative_facts: window.narrativeFacts,
                        round_answers: window.roundAnswers,
                        engine_version: 'v3',
                        debug: DEBUG_MODE,
                        ...getEditModePayloadExtras(),
                    })
                });
                
                const analyzeData = await analyzeResponse.json();
                
                // ★★★ LLM 모듈 확인용 콘솔 로그 ★★★
                
                // 2. Recommendation Mode API (최신 Vectorize+TAG 추천)
                showLoading('추천 생성 중...', 'AI가 최적의 직업을 찾고 있어요');
                
                try {
                    // SearchProfile 구성
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
                    
                    // Phase 1: 추천만 빠르게 (리포트는 Phase 2에서 비동기 생성)
                    let recommendResponse;
                    for (let attempt = 0; attempt <= 2; attempt++) {
                        recommendResponse = await fetch('/api/ai-analyzer/v3/recommend', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                session_id: currentSessionId,
                                searchProfile: searchProfile,
                                mini_module_result: miniModule,
                                topK: 800,
                                judgeTopN: 20,
                                skipReport: true,
                                debug: DEBUG_MODE,
                            })
                        });
                        if (recommendResponse.ok || recommendResponse.status < 500) break;
                        if (attempt < 2) {
                            await new Promise(r => setTimeout(r, 5000 * (attempt + 1)));
                        }
                    }

                    const recommendData = await recommendResponse.json();

                    // 🔍 DEBUG: API 응답 확인
                    if (recommendData.recommendations?.like_top10?.[0]) {
                    }

                    // 3. 결과 병합: Recommendation Mode 결과를 우선 사용
                    if (recommendData.success && recommendData.recommendations) {

                        // analyzeData.result가 없으면 초기화
                        if (!analyzeData.result) {
                            analyzeData.result = {};
                        }

                        // fit_top3에 Recommendation Mode 결과 병합 (result 안에 저장)
                        if (recommendData.recommendations.top_jobs) {
                            const newTopJobs = recommendData.recommendations.top_jobs.slice(0, 10);
                            analyzeData.result.fit_top3 = newTopJobs.map(job => ({
                                job_id: job.job_id,
                                job_name: job.job_name,
                                job_description: job.job_description || '',
                                slug: job.slug || '',
                                image_url: job.image_url || '',
                                fit_score: job.fit_score,
                                like_score: job.like_score,
                                can_score: job.can_score,
                                feasibility_score: job.feasibility_score || 0,
                                rationale: job.rationale || '',
                                like_reason: job.like_reason || '',
                                can_reason: job.can_reason || '',
                                evidence_quotes: job.evidence_quotes || [],
                                risk_details: [],
                                evidence_links: [],
                            }));
                        }

                        // like_top10에 Recommendation Mode 결과 병합 (result 안에 저장)
                        if (recommendData.recommendations.like_top10) {
                            analyzeData.result.like_top10 = recommendData.recommendations.like_top10.map(job => ({
                                job_id: job.job_id,
                                job_name: job.job_name,
                                job_description: job.job_description || '',
                                slug: job.slug || '',
                                image_url: job.image_url || '',
                                fit_score: job.fit_score,
                                like_score: job.like_score,
                                can_score: job.can_score,
                                feasibility_score: job.feasibility_score || 0,
                                rationale: job.rationale || '',
                                like_reason: job.like_reason || '',
                                can_reason: job.can_reason || '',
                            }));
                        }

                        // can_top10에 Recommendation Mode 결과 병합 (result 안에 저장)
                        if (recommendData.recommendations.can_top10) {
                            analyzeData.result.can_top10 = recommendData.recommendations.can_top10.map(job => ({
                                job_id: job.job_id,
                                job_name: job.job_name,
                                job_description: job.job_description || '',
                                slug: job.slug || '',
                                image_url: job.image_url || '',
                                fit_score: job.fit_score,
                                like_score: job.like_score,
                                can_score: job.can_score,
                                feasibility_score: job.feasibility_score || 0,
                                rationale: job.rationale || '',
                                like_reason: job.like_reason || '',
                                can_reason: job.can_reason || '',
                            }));
                        }

                        // premium_report 병합 (추천 모드의 LLM 리포트가 더 정확함)
                        if (recommendData.premium_report) {
                            analyzeData.result.premium_report = recommendData.premium_report;
                        }

                        // request_id 업데이트 (추천 모드에서 갱신된 ID 사용)
                        if (recommendData.request_id) {
                            analyzeData.request_id = recommendData.request_id;
                        }

                        // 메타데이터 추가
                        analyzeData._recommendation_mode = {
                            enabled: true,
                            total_candidates: recommendData.recommendations.total_candidates,
                            filtered_count: recommendData.recommendations.filtered_count,
                            search_duration_ms: recommendData.recommendations.search_duration_ms,
                        };
                    }
                } catch (recommendError) {
                    // Recommendation Mode 실패해도 기존 결과는 표시
                }
                
                hideLoading();

                // 편집 모드: 분석 완료 → 결과 페이지로 이동
                if (window.__editMode && analyzeData.request_id) {
                    fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(window.__editSessionId), {
                        method: 'DELETE', credentials: 'same-origin'
                    }).catch(() => {});
                    window.location.href = '/user/ai-results/' + analyzeData.request_id;
                    return;
                }

                currentRequestId = analyzeData.request_id;
                displayResults(analyzeData);
                goToStep(3); // 결과 (3단계 구조)

                // Phase 2: 프리미엄 리포트 비동기 생성 (결과 표시 후 백그라운드에서)
                (async () => {
                    // 리포트 로딩 표시
                    const reportBanner = document.createElement('div');
                    reportBanner.id = 'report-loading-banner';
                    reportBanner.className = 'text-center py-3 px-4 rounded-xl mb-4';
                    reportBanner.style.cssText = 'background: rgba(99,102,241,0.15); border: 1px solid rgba(99,102,241,0.3);';
                    reportBanner.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i><span class="text-sm" style="color: rgba(165,180,252,0.9);">심리분석 리포트를 생성하고 있습니다...</span>';
                    const step3El = document.getElementById('step3');
                    if (step3El && step3El.firstChild) {
                        step3El.insertBefore(reportBanner, step3El.firstChild);
                    }

                    try {
                        const reportResponse = await fetch('/api/ai-analyzer/v3/recommend/report', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ session_id: currentSessionId }),
                        });

                        document.getElementById('report-loading-banner')?.remove();

                        if (reportResponse.ok) {
                            const reportData = await reportResponse.json();
                            if (reportData.premium_report) {
                                analyzeData.result.premium_report = reportData.premium_report;
                                // 현재 활성 탭 저장 후 재렌더링
                                const activeTab = document.querySelector('.report-tab.active')?.getAttribute('data-tab');
                                displayResults(analyzeData);
                                if (activeTab) showReportTab(activeTab);
                            }
                        } else {
                        }
                    } catch (reportError) {
                        document.getElementById('report-loading-banner')?.remove();
                    }
                })();

            } catch (error) {
                hideLoading();
                alert('분석 중 오류가 발생했습니다: ' + error.message);
            }
        }
        
        // V3: 라운드 답변 수집
        function collectV3RoundAnswers(questions) {
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
        function validateV3Answers(answers, questions) {
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
        
        // V3: 라운드 답변 저장 (P0-1: 에러 표시 강화)
        async function saveV3RoundAnswers(roundNumber, answers, questions) {
            // 로컬 저장 (항상 수행) - 질문 텍스트도 함께 저장!
            for (const ans of answers) {
                window.roundAnswers.push({
                    questionId: ans.question_id,
                    questionText: ans.question_text,  // 질문 텍스트 추가 (다음 라운드에서 사용)
                    roundNumber: roundNumber,
                    answer: ans.answer,
                    answeredAt: new Date().toISOString(),
                });
            }
            
            // P0-1: session_id 유효성 검사
            if (!currentSessionId || currentSessionId.trim() === '') {
                showErrorToast('세션 ID가 유효하지 않습니다. 페이지를 새로고침해주세요.');
                return false;
            }
            
            
            // 서버 저장
            try {
                const response = await fetch('/api/ai-analyzer/v3/round-answers', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        round_number: roundNumber,
                        answers: answers,
                    })
                });
                
                // 먼저 HTTP 상태 체크 (500 에러 등)
                if (!response.ok) {
                    const errorText = await response.text().catch(() => 'Unknown error');
                    showErrorToast('라운드 ' + roundNumber + ' 답변 저장 실패 (HTTP ' + response.status + ')');
                    // 로컬에는 저장되었으므로 진행은 계속
                    return false;
                }
                
                const data = await response.json();
                
                // P0-1: 상세 에러 표시
                if (!data.success) {
                    showErrorToast('라운드 ' + roundNumber + ' 답변 저장 실패: ' + (data.detail || data.error || 'Unknown error'));
                    // 로컬에는 저장되었으므로 진행은 계속
                    return false;
                }
                
                return true;
                
            } catch (error) {
                showErrorToast('라운드 ' + roundNumber + ' 답변 저장 중 오류 발생: ' + (error.message || 'Network error'));
                // 로컬에는 저장되었으므로 진행은 계속
                return false;
            }
        }
        
        // ============================================
        // Step 2: Universal Questions 렌더링 (서술형은 Step 3.5로 이동)
        // ============================================
        function renderUniversalQuestions() {
            const container = document.getElementById('universal-questions');
            const isMinor = MINOR_STAGES.includes(selectedStage);
            
            // ============================================
            // 중복 옵션 필터링 맵 생성 (미니모듈/Step1 → Step2)
            // ============================================
            const duplicateOptionsMap = {};
            
            // 미니모듈 constraint → univ_life_constraint 중복 매핑
            const constraintToLifeConstraintMap = {
                'income_constraint': 'finance_pressure',     // 경제적 제약
                'physical_constraint': 'health',             // 건강/체력 제약
                'time_constraint': 'caregiving',             // 시간 제약 → 돌봄
            };
            
            // 미니모듈 interest → univ_interest 중복 매핑
            const interestToUnivInterestMap = {
                'creative': 'creative',                      // 창작/아이디어
                'analysis': 'science',                       // 분석/연구 → 과학/연구
                'helping': 'social',                         // 돕기/서비스 → 사회/복지
                'data_handling': 'tech',                     // 데이터 → 기술/IT
            };
            
            // 미니모듈 value → univ_priority 중복 매핑 (이미 전체 질문 제외됨)
            
            // 미니모듈 결과가 있으면 중복 옵션 추출
            if (window.miniModuleResult) {
                const mm = window.miniModuleResult;
                
                // constraint_flags → univ_life_constraint 중복
                if (mm.constraint_flags?.length > 0) {
                    duplicateOptionsMap['univ_life_constraint'] = mm.constraint_flags
                        .map(c => constraintToLifeConstraintMap[c])
                        .filter(Boolean);
                }
                
                // interest_top → univ_interest 중복
                if (mm.interest_top?.length > 0) {
                    duplicateOptionsMap['univ_interest'] = mm.interest_top
                        .map(i => interestToUnivInterestMap[i])
                        .filter(Boolean);
                }
            }
            
            // Step 1에서 제약조건이 선택되었는지 확인하는 헬퍼 함수
            function hasStep1Constraints() {
                if (!careerState.constraints) return false;
                return Object.values(careerState.constraints).some(c => c?.has_constraint === true);
            }
            
            // 미성년 단계에서는 오픈텍스트 질문 숨김 + 미니모듈 중복 질문 제거
            const filteredQuestions = UNIVERSAL_QUESTIONS.filter(q => {
                if (isMinor && q.ui_type === 'text') return false;
                
                // === 미니모듈과 중복되는 질문 제거 ===
                // univ_priority (가치) - 미니모듈 value_top과 중복
                if (q.id === 'univ_priority' && window.miniModuleResult?.value_top?.length > 0) {
                    return false;
                }
                // univ_interest (관심사) - 미니모듈 interest_top과 중복
                if (q.id === 'univ_interest' && window.miniModuleResult?.interest_top?.length > 0) {
                    return false;
                }
                // univ_strength (강점) - 미니모듈 strength_top과 중복
                if (q.id === 'univ_strength' && window.miniModuleResult?.strength_top?.length > 0) {
                    return false;
                }
                // univ_life_constraint (생활 제약) - Step 1 제약 또는 미니모듈 constraint_flags와 중복
                if (q.id === 'univ_life_constraint' && 
                    (window.miniModuleResult?.constraint_flags?.length > 0 || hasStep1Constraints())) {
                    return false;
                }
                
                return true;
            });
            
            // 값 복원: universalAnswers에 저장된 값 복원
            // 중복 옵션 맵을 전역에 저장하여 renderUniversalQuestion에서 사용
            window._duplicateOptionsMap = duplicateOptionsMap;
            
            // 질문을 order 필드에 따라 정렬
            const sortedQuestions = filteredQuestions.sort((a, b) => (a.order || 999) - (b.order || 999));
            container.innerHTML = sortedQuestions.map(q => renderUniversalQuestion(q, isMinor)).join('');
            
            // 저장된 값 복원
            restoreUniversalAnswers();
        }
        
        // 저장된 Universal 답변 복원
        function restoreUniversalAnswers() {
            if (!universalAnswers || Object.keys(universalAnswers).length === 0) return;
            
            for (const [questionId, values] of Object.entries(universalAnswers)) {
                if (Array.isArray(values)) {
                    // 칩/체크박스 선택
                    for (const val of values) {
                        const btn = document.querySelector(\`[data-question-id="\${questionId}"] [data-value="\${val}"]\`);
                        if (btn && !btn.classList.contains('chip-selected')) {
                            btn.click();
                        }
                    }
                } else if (typeof values === 'string') {
                    // 라디오 버튼 선택
                    const radioBtn = document.querySelector(\`[data-question-id="\${questionId}"] [data-value="\${values}"]\`);
                    if (radioBtn && !radioBtn.classList.contains('radio-selected')) {
                        radioBtn.click();
                    }
                    
                    // 텍스트 입력
                    const textarea = document.querySelector(\`[data-question-id="\${questionId}"] textarea, textarea[name="\${questionId}"]\`);
                    if (textarea) textarea.value = values;
                }
            }
        }
        
        // V3: 서술형 심층 질문 단계 렌더링 (Step 3.5 - 전이 신호 다음)
        // 상황 + 경력 + 목표에 따라 동적으로 질문 선택
        function renderNarrativeStep() {
            // Step 2에서 호출 시 followup-questions-form 사용
            const container = document.getElementById('followup-questions-form') || document.getElementById('transition-signal-form');
            if (!container) return;
            
            // 저장된 질문이 있으면 재사용, 없으면 새로 생성
            const questions = window.savedNarrativeQuestions || getNarrativeQuestions();
            const q1 = questions.question1;
            const q2 = questions.question2;
            
            // 현재 사용 중인 질문 저장 (나중에 임시저장 시 사용)
            window.savedNarrativeQuestions = questions;
            
            // 저장된 값 복원 (fact_key 기반)
            const savedQ0 = window.narrativeFacts?.storyAnswer || window.narrativeFacts?.life_story || '';
            const savedQ1 = window.narrativeFacts?.question1Answer || window.narrativeFacts?.highAliveMoment || '';
            const savedQ2 = window.narrativeFacts?.question2Answer || window.narrativeFacts?.lostMoment || '';
            const savedQ3 = window.narrativeFacts?.existentialAnswer || '';
            const savedCareerBg = window.narrativeFacts?.career_background || '';
            
            // 스토리 질문 (공통 - 모든 템플릿에서 첫 번째 질문)
            const storyQuestion = {
                id: 'life_story',
                text: '간략하게 지금까지의 이야기를 들려주세요',
                placeholder: '예: 대학에서 경영학을 전공하고 마케팅 회사에서 3년 일했어요. 숫자보다는 사람들과 소통하는 일이 좋아서 기획 쪽으로 옮겼고, 지금은 새로운 도전을 찾고 있어요...',
                emoji: '📖',
                color: 'from-slate-500 to-blue-500',
                fact_key: 'narrative.life_story'
            };
            
            // 전공/이전 직업 질문 (선택 - 구조화 입력)
            const careerBackgroundQuestion = {
                id: 'career_background',
                text: '전공/최근 직무 정보 (선택)',
                placeholder: '예: 컴퓨터공학 전공, 마케팅 회사 3년 근무, 데이터 분석 업무',
                hint: '전공/학과, 최근 직무/업종, 경력 기간을 간략히 적어주세요. AI가 더 정확한 추천을 드리는 데 도움이 됩니다.',
                emoji: '📋',
                color: 'from-cyan-500 to-blue-500',
                fact_key: 'narrative.career_background',
                required: false
            };
            
            // 색상 파싱 함수
            const parseGradient = (color) => {
                const colors = color.replace('from-', '').replace(' to-', ',').split(',');
                const colorMap = {
                    'yellow-500': '234,179,8', 'orange-500': '249,115,22', 'red-500': '239,68,68',
                    'pink-500': '236,72,153', 'rose-500': '244,63,94', 'rose-600': '225,29,72',
                    'violet-500': '139,92,246', 'purple-500': '168,85,247', 'purple-600': '147,51,234',
                    'indigo-500': '99,102,241', 'indigo-600': '79,70,229', 'blue-500': '59,130,246',
                    'blue-600': '37,99,235', 'cyan-500': '6,182,212', 'cyan-600': '8,145,178',
                    'teal-500': '20,184,166', 'teal-600': '13,148,136', 'emerald-500': '16,185,129',
                    'green-500': '34,197,94', 'amber-500': '245,158,11', 'slate-500': '100,116,139',
                    'slate-600': '71,85,105', 'gray-600': '75,85,99', 'zinc-600': '82,82,91', 'pink-600': '219,39,119',
                };
                return colors.map(c => colorMap[c.trim()] || '139,92,246');
            };
            
            const q0Colors = parseGradient(storyQuestion.color);
            const careerBgColors = parseGradient(careerBackgroundQuestion.color);
            const q1Colors = parseGradient(q1.color);
            const q2Colors = parseGradient(q2.color);
            
            container.innerHTML = \`
                <!-- 격려 문구 -->
                <div class="bg-gradient-to-r from-emerald-500/10 to-teal-500/10 border border-emerald-500/20 rounded-xl p-4 mb-6">
                    <p class="text-emerald-300 text-sm">
                        <i class="fas fa-lightbulb mr-2"></i>
                        자세히 (구체적인 상황, 감정, 이유를 솔직하게) 작성할수록 AI가 당신을 더 잘 이해하고, 더 정확한 추천을 드릴 수 있어요.
                    </p>
                </div>
                
                <!-- 서술형 질문 0 (스토리 - 공통) -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${q0Colors[0]},0.1), rgba(\${q0Colors[1]},0.05)); border: 1px solid rgba(\${q0Colors[0]},0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">\${storyQuestion.emoji}</span>
                        \${storyQuestion.text}
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">학력, 경력, 현재 상황 등 배경을 간략히 적어주세요. AI가 맥락을 이해하는 데 도움이 돼요.</p>
                    <textarea 
                        id="narrative_q0"
                        name="narrative_q0" 
                        data-fact-key="\${storyQuestion.fact_key}"
                        data-question-id="\${storyQuestion.id}"
                        rows="4" 
                        minlength="30"
                        maxlength="5000"
                        placeholder="\${storyQuestion.placeholder}"
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[100px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(\${q0Colors[0]},0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(\${q0Colors[0]},0.6)';"
                        onblur="this.style.borderColor='rgba(\${q0Colors[0]},0.3)'; validateNarrativeLength(this, 30);"
                        oninput="updateNarrativeCounter(this, 5000);">\${savedQ0}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q0_hint" class="text-xs text-wiki-muted">최소 30자 / 현재 \${savedQ0.length}자</span>
                        <span id="narrative_q0_counter" class="text-xs text-wiki-muted">\${savedQ0.length}자</span>
                    </div>
                </div>
                
                <!-- 전공/이전 직업 정보 (이력서 업로드 시 자동 입력 or 숨김) -->
                \${window.resumeUploaded && window.resumeCareerBackground ? \`
                    <!-- 이력서에서 추출된 정보 표시 (읽기 전용) -->
                    <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(16,185,129,0.1), rgba(16,185,129,0.05)); border: 1px solid rgba(16,185,129,0.3);">
                        <label class="block text-lg font-semibold mb-2 text-white">
                            <span class="mr-2">📋</span>
                            이력서에서 추출된 배경 정보
                            <span class="text-xs text-emerald-400 ml-2">✓ 자동 입력됨</span>
                        </label>
                        <div class="px-4 py-3 rounded-xl" style="background-color: rgba(15,15,35,0.7); border: 1px solid rgba(16,185,129,0.2);">
                            <p class="text-white">\${window.resumeCareerBackground}</p>
                        </div>
                        <input type="hidden" id="narrative_career_bg" name="narrative_career_bg" 
                               data-fact-key="\${careerBackgroundQuestion.fact_key}"
                               value="\${window.resumeCareerBackground}" />
                    </div>
                \` : \`
                    <!-- 수동 입력 필드 (이력서 미업로드 시) -->
                    <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${careerBgColors[0]},0.1), rgba(\${careerBgColors[1]},0.05)); border: 1px solid rgba(\${careerBgColors[0]},0.2);">
                        <label class="block text-lg font-semibold mb-2 text-white">
                            <span class="mr-2">\${careerBackgroundQuestion.emoji}</span>
                            \${careerBackgroundQuestion.text}
                            <span class="text-xs text-wiki-muted ml-2">(선택사항)</span>
                        </label>
                        <p class="text-sm text-wiki-muted mb-4">\${careerBackgroundQuestion.hint}</p>
                        <input 
                            type="text"
                            id="narrative_career_bg"
                            name="narrative_career_bg" 
                            data-fact-key="\${careerBackgroundQuestion.fact_key}"
                            data-question-id="\${careerBackgroundQuestion.id}"
                            maxlength="500"
                            placeholder="\${careerBackgroundQuestion.placeholder}"
                            value="\${savedCareerBg}"
                            class="w-full px-4 py-3 rounded-xl border transition-all"
                            style="background-color: rgba(15,15,35,1); border-color: rgba(\${careerBgColors[0]},0.3); color: #fff;"
                            onfocus="this.style.borderColor='rgba(\${careerBgColors[0]},0.6)';"
                            onblur="this.style.borderColor='rgba(\${careerBgColors[0]},0.3)';"
                        />
                        <div class="flex justify-between items-center mt-2">
                            <span class="text-xs text-wiki-muted/60">전공, 직무, 업종, 경력 기간 등 정확한 추천에 도움이 됩니다</span>
                        </div>
                    </div>
                \`}
                
                <!-- 서술형 질문 1 (동적) -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${q1Colors[0]},0.1), rgba(\${q1Colors[1]},0.05)); border: 1px solid rgba(\${q1Colors[0]},0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">\${q1.emoji}</span>
                        \${q1.text}
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">구체적인 상황, 그때의 감정, 왜 그렇게 느꼈는지 자유롭게 적어주세요</p>
                    <textarea 
                        id="narrative_q1"
                        name="narrative_q1" 
                        data-fact-key="\${q1.fact_key}"
                        data-question-id="\${q1.id}"
                        rows="5" 
                        minlength="50"
                        maxlength="10000"
                        placeholder="\${q1.placeholder}"
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[120px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(\${q1Colors[0]},0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(\${q1Colors[0]},0.6)';"
                        onblur="this.style.borderColor='rgba(\${q1Colors[0]},0.3)'; validateNarrativeLength(this, 50);"
                        oninput="updateNarrativeCounter(this, 10000);">\${savedQ1}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q1_hint" class="text-xs text-wiki-muted">최소 50자 / 현재 \${savedQ1.length}자</span>
                        <span id="narrative_q1_counter" class="text-xs text-wiki-muted">\${savedQ1.length}자</span>
                    </div>
                </div>
                
                <!-- 서술형 질문 2 (동적) -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(\${q2Colors[0]},0.1), rgba(\${q2Colors[1]},0.05)); border: 1px solid rgba(\${q2Colors[0]},0.2);">
                    <label class="block text-lg font-semibold mb-2 text-white">
                        <span class="mr-2">\${q2.emoji}</span>
                        \${q2.text}
                        <span class="text-red-400 ml-1">*</span>
                    </label>
                    <p class="text-sm text-wiki-muted mb-4">구체적인 상황, 그때의 감정, 왜 그렇게 느꼈는지 자유롭게 적어주세요</p>
                    <textarea 
                        id="narrative_q2"
                        name="narrative_q2" 
                        data-fact-key="\${q2.fact_key}"
                        data-question-id="\${q2.id}"
                        rows="5" 
                        minlength="50"
                        maxlength="10000"
                        placeholder="\${q2.placeholder}"
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[120px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(\${q2Colors[0]},0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(\${q2Colors[0]},0.6)';"
                        onblur="this.style.borderColor='rgba(\${q2Colors[0]},0.3)'; validateNarrativeLength(this, 50);"
                        oninput="updateNarrativeCounter(this, 10000);">\${savedQ2}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q2_hint" class="text-xs text-wiki-muted">최소 50자 / 현재 \${savedQ2.length}자</span>
                        <span id="narrative_q2_counter" class="text-xs text-wiki-muted">\${savedQ2.length}자</span>
                    </div>
                </div>
                
                <!-- 서술형 질문 3: 실존적 가치 질문 -->
                <div class="question-block p-5 rounded-2xl mb-5" style="background: linear-gradient(135deg, rgba(168,85,247,0.1), rgba(236,72,153,0.05)); border: 1px solid rgba(168,85,247,0.2);">
                    <label class="block text-lg font-semibold mb-3 text-white">
                        <span class="mr-2">\u{1F30C}</span>
                        마지막 7일
                    </label>
                    <div class="text-sm text-slate-300 mb-4 leading-relaxed space-y-2">
                        <p>오늘 밤 9시, 모든 방송과 휴대폰에 긴급 뉴스가 뜹니다.</p>
                        <p>과학적으로 확인된 사실이며, 정확히 7일 뒤 지구는 사라집니다. 생존 가능성은 없습니다.</p>
                        <p>사람들은 각자의 방식으로 남은 시간을 보내기 시작합니다.</p>
                        <p class="text-white font-medium pt-1">이 소식을 듣는 순간, 당신이 가장 먼저 떠올릴 행동은 무엇일 것 같나요?</p>
                        <p class="text-white font-medium">어디로 가고 싶고, 누구를 만나고 싶고, 무엇을 하고 싶을 것 같나요?</p>
                        <p class="text-white font-medium">그리고 왜 그것이 가장 먼저 떠올랐을까요?</p>
                    </div>
                    <textarea
                        id="narrative_q3"
                        name="narrative_q3"
                        data-fact-key="narrative.existential_answer"
                        rows="5"
                        minlength="30"
                        maxlength="5000"
                        placeholder="가장 먼저 떠오르는 행동, 가고 싶은 곳, 만나고 싶은 사람, 그리고 그 이유를 자유롭게 적어주세요..."
                        class="w-full px-4 py-3 rounded-xl border transition-all resize-y min-h-[100px]"
                        style="background-color: rgba(15,15,35,1); border-color: rgba(168,85,247,0.3); color: #fff;"
                        onfocus="this.style.borderColor='rgba(168,85,247,0.6)';"
                        onblur="this.style.borderColor='rgba(168,85,247,0.3)'; validateNarrativeLength(this, 30);"
                        oninput="updateNarrativeCounter(this, 5000);">\${savedQ3}</textarea>
                    <div class="flex justify-between items-center mt-2">
                        <span id="narrative_q3_hint" class="text-xs text-wiki-muted">최소 30자 / 현재 \${savedQ3.length}자</span>
                        <span id="narrative_q3_counter" class="text-xs text-wiki-muted">\${savedQ3.length}자</span>
                    </div>
                </div>

                <!-- 추가 격려 문구 -->
                <div class="text-center text-xs text-wiki-muted/60 mt-6">
                    <i class="fas fa-shield-alt mr-1"></i>
                    입력하신 내용은 추천에만 사용되며, 외부에 공개되지 않습니다.
                </div>
            \`;
            
            // Step 2 제목 및 서브타이틀 업데이트 (3단계 구조)
            const step2Title = document.querySelector('#step2 h2');
            if (step2Title) {
                step2Title.innerHTML = '<i class="fas fa-comments text-wiki-primary mr-2"></i>심층 질문 기초';
            }
            const step2Subtitle = document.getElementById('step2-subtitle');
            if (step2Subtitle) {
                step2Subtitle.textContent = '당신의 이야기를 자유롭게 들려주세요';
            }
            
            // Step 인디케이터 업데이트 - 심층 단계 (Step 2) 표시
            currentStep = 2;
            window.currentStep = 2;
            document.querySelectorAll('.step-dot').forEach((el) => {
                const circle = el.querySelector('span:first-child');
                const stepNum = parseInt(el.dataset.step, 10);
                if (stepNum <= 2) {
                    circle.classList.remove('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.add('bg-wiki-primary', 'text-white');
                } else {
                    circle.classList.add('bg-wiki-border', 'text-wiki-muted');
                    circle.classList.remove('bg-wiki-primary', 'text-white');
                }
            });
            
            
            // Step 2 버튼 업데이트
            const analyzeBtn = document.getElementById('analyze-btn');
            if (analyzeBtn) {
                analyzeBtn.innerHTML = '<i class="fas fa-arrow-right mr-2"></i>다음';
                analyzeBtn.onclick = submitNarrativeAndContinueV3;
            }
            
            // 이전 버튼: 프로필로 돌아가기
            const step2PrevBtn = document.getElementById('step2-prev-btn');
            if (step2PrevBtn) {
                step2PrevBtn.onclick = () => {
                    // 서술형 답변 임시 저장
                    collectNarrativeAnswers();
                    // 프로필로 돌아가기
                    goToStep(1);
                    goToProfileStep2();  // 프로필 2/2로 이동
                };
            }
            
            // 저장된 값이 있으면 카운터/힌트 업데이트
            setTimeout(() => {
                const q0 = document.getElementById('narrative_q0');
                const q1 = document.getElementById('narrative_q1');
                const q2 = document.getElementById('narrative_q2');
                if (q0 && q0.value) {
                    updateNarrativeCounter(q0, 5000);
                    validateNarrativeLength(q0, 30);
                }
                if (q1 && q1.value) {
                    updateNarrativeCounter(q1, 10000);
                    validateNarrativeLength(q1, 50);
                }
                if (q2 && q2.value) {
                    updateNarrativeCounter(q2, 10000);
                    validateNarrativeLength(q2, 50);
                }
                const q3 = document.getElementById('narrative_q3');
                if (q3 && q3.value) {
                    updateNarrativeCounter(q3, 5000);
                    validateNarrativeLength(q3, 30);
                }
            }, 100);
        }
        
        // 서술형 글자수 카운터 업데이트 (상한선 근접 시에만 표시)
        function updateNarrativeCounter(textarea, maxLength) {
            const counter = document.getElementById(textarea.id + '_counter');
            const hint = document.getElementById(textarea.id + '_hint');
            const current = textarea.value.length;
            const minLength = parseInt(textarea.minLength) || 30;
            
            if (counter) {
                // 항상 글자수 표시
                counter.textContent = current.toLocaleString() + '자';
                counter.classList.remove('hidden');
                
                // 색상 (최소 충족 여부에 따라)
                if (current >= maxLength * 0.9) {
                    counter.style.color = current >= maxLength ? 'rgb(239, 68, 68)' : 'rgb(251, 146, 60)';
                } else if (current >= minLength) {
                    counter.style.color = 'rgb(74, 222, 128)';  // 최소 충족: 초록색
                } else {
                    counter.style.color = 'rgb(148, 163, 184)';  // 미충족: 회색
                }
            }
            
            // 힌트 텍스트 업데이트 (최소 글자수 표시)
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
        
        // 서술형 최소 길이 검증 (압박 제거, 권장 메시지로 변경)
        function validateNarrativeLength(textarea, minLength) {
            const hint = document.getElementById(textarea.id + '_hint');
            const current = textarea.value.length;
            if (hint) {
                // 항상 부드러운 톤으로 안내
                hint.textContent = '💡 자세히 적을수록 추천 정확도가 높아집니다';
                hint.style.color = 'rgb(148,163,184)';
            }
        }
        
        // 서술형 답변 제출 후 V3 라운드로 진행
        async function submitNarrativeAndContinueV3() {
            // 서술형 답변 검증
            if (!validateNarrativeRequired()) {
                return;
            }

            // 서술형 답변 수집 및 저장
            const narrativeFacts = collectNarrativeAnswers();

            // Phase 3: 편집 모드 - 서술형 변경 시 라운드 데이터 초기화
            if (window.__editMode && detectNarrativeChanges()) {
                cascadeResetFromNarrative();
            }
            if (narrativeFacts) {
                await saveNarrativeFacts(narrativeFacts);
            }
            
            // 서버에 자동 저장 (백그라운드)
            saveDraftToServer();
            
            // 3라운드 심층 질문 시작
            await startV3RoundQuestions(1);
        }
        
        // 서술형 답변 수집 (동적 질문 지원)
        function collectNarrativeAnswers() {
            const q0 = document.getElementById('narrative_q0');
            const q1 = document.getElementById('narrative_q1');
            const q2 = document.getElementById('narrative_q2');
            const q3 = document.getElementById('narrative_q3');
            const careerBg = document.getElementById('narrative_career_bg');

            // 레거시 지원 (이전 버전 호환)
            const legacyHighAlive = document.getElementById('narrative_high_alive');
            const legacyLost = document.getElementById('narrative_lost');

            if (q1 && q2) {
                // 새로운 동적 질문 형식
                window.narrativeFacts = {
                    // 스토리 질문 (공통)
                    storyAnswer: q0?.value?.trim() || '',
                    life_story: q0?.value?.trim() || '',
                    // 전공/이전 직업 (선택)
                    career_background: careerBg?.value?.trim() || '',
                    // 레거시 호환성 유지
                    highAliveMoment: q1.value.trim(),
                    lostMoment: q2.value.trim(),
                    // 실존적 가치 질문 (7일 뒤 지구 멸망)
                    existentialAnswer: q3?.value?.trim() || '',
                    // 새로운 구조
                    question1Answer: q1.value.trim(),
                    question2Answer: q2.value.trim(),
                    question1FactKey: q1.dataset.factKey,
                    question2FactKey: q2.dataset.factKey,
                    question1Id: q1.dataset.questionId,
                    question2Id: q2.dataset.questionId,
                };
            } else if (legacyHighAlive && legacyLost) {
                // 레거시 형식
                window.narrativeFacts = {
                    highAliveMoment: legacyHighAlive.value.trim(),
                    lostMoment: legacyLost.value.trim()
                };
            }
            return window.narrativeFacts || null;
        }

        // 서술형 필수 검증 (동적 질문 지원)
        function validateNarrativeRequired() {
            const isMinor = MINOR_STAGES.includes(selectedStage);
            if (isMinor) return true; // 미성년은 서술형 없음

            // 스토리 질문 (공통)
            const q0 = document.getElementById('narrative_q0');
            
            // 새로운 동적 질문 형식
            const q1 = document.getElementById('narrative_q1');
            const q2 = document.getElementById('narrative_q2');
            
            // 레거시 지원
            const legacyHighAlive = document.getElementById('narrative_high_alive');
            const legacyLost = document.getElementById('narrative_lost');
            
            const textarea1 = q1 || legacyHighAlive;
            const textarea2 = q2 || legacyLost;

            if (!textarea1 || !textarea2) return true; // 요소 없으면 패스

            // 스토리 질문 검증 (최소 30자)
            if (q0 && q0.value.trim().length < 30) {
                q0.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q0.focus();
                alert('지금까지의 이야기를 30자 이상 작성해주세요.');
                return false;
            }

            const q1Valid = textarea1.value.trim().length >= 50;
            const q2Valid = textarea2.value.trim().length >= 50;

            if (!q1Valid) {
                textarea1.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                textarea1.focus();
                alert('첫 번째 질문에 50자 이상 작성해주세요.');
                return false;
            }

            if (!q2Valid) {
                textarea2.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                textarea2.focus();
                alert('두 번째 질문에 50자 이상 작성해주세요.');
                return false;
            }

            // 실존적 질문 검증 (최소 30자)
            const q3El = document.getElementById('narrative_q3');
            if (q3El && q3El.value.trim().length > 0 && q3El.value.trim().length < 30) {
                q3El.style.borderColor = 'rgba(239, 68, 68, 0.5)';
                q3El.focus();
                alert('실존적 질문에 30자 이상 작성해주세요.');
                return false;
            }

            return true;
        }
        
        function renderUniversalQuestion(q, isMinor) {
            let optionsHtml = '';
            const requiredMark = q.required ? '<span class="text-red-400 ml-1">*</span>' : '';
            const qId = q.question_id || q.id;  // question_id 또는 id 사용
            
            // 특별한 상황 질문인 경우 추가 설명 필드 포함
            const isLifeConstraint = qId === 'univ_life_constraint';
            
            if (q.ui_type === 'language_chips') {
                // 언어 선택 UI (수준 선택 + 기타 언어 입력 지원)
                const levels = q.levels || [
                    { value: 'basic', label: '일상회화' },
                    { value: 'business', label: '업무가능' },
                    { value: 'native', label: '원어민급' },
                ];
                optionsHtml = \`
                    <div class="language-selector" data-question-id="\${qId}" data-max-selections="\${q.max_selections || 5}">
                        <div class="flex flex-wrap gap-2 mb-3">
                            \${(q.options || []).map(opt => \`
                                <button type="button" onclick="toggleLanguageChip('\${qId}', '\${opt.value}', this, \${opt.hasInput || false})"
                                        class="lang-chip group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                        style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                        data-value="\${opt.value}" data-has-level="\${opt.hasLevel || false}" data-has-input="\${opt.hasInput || false}">
                                    <span class="flex items-center gap-2">
                                        \${opt.emoji ? \`<span class="text-lg">\${opt.emoji}</span>\` : ''}
                                        <span>\${opt.label}</span>
                                    </span>
                                    <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden chip-check">✓</div>
                                </button>
                            \`).join('')}
                        </div>
                        
                        <!-- 언어 수준 선택 패널 (언어 선택 시 표시) -->
                        <div id="lang-level-panel-\${qId}" class="hidden mt-3 p-4 rounded-xl" style="background-color: rgba(15,15,35,0.8); border: 1px solid rgba(42,42,62,0.5);">
                            <p class="text-sm mb-3" style="color: rgb(148,163,184);">
                                <span id="lang-level-label-\${qId}">영어</span> 수준을 선택해주세요:
                            </p>
                            <div class="flex flex-wrap gap-2">
                                \${levels.map(lvl => \`
                                    <button type="button" onclick="selectLanguageLevel('\${qId}', '\${lvl.value}', this)"
                                            class="level-option px-4 py-2 rounded-lg border transition-all duration-200"
                                            style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                            data-level="\${lvl.value}">
                                        \${lvl.label}
                                    </button>
                                \`).join('')}
                            </div>
                        </div>
                        
                        <!-- 기타 언어 입력 패널 -->
                        <div id="lang-other-panel-\${qId}" class="hidden mt-3 p-4 rounded-xl" style="background-color: rgba(15,15,35,0.8); border: 1px solid rgba(42,42,62,0.5);">
                            <p class="text-sm mb-3" style="color: rgb(148,163,184);">어떤 언어인가요?</p>
                            <div class="flex gap-2 flex-wrap">
                                <select id="lang-other-select-\${qId}" onchange="selectOtherLanguage('\${qId}', this.value)"
                                        class="px-4 py-2 rounded-lg border flex-shrink-0"
                                        style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);">
                                    <option value="">선택...</option>
                                    <option value="vietnamese">베트남어</option>
                                    <option value="thai">태국어</option>
                                    <option value="indonesian">인도네시아어</option>
                                    <option value="russian">러시아어</option>
                                    <option value="portuguese">포르투갈어</option>
                                    <option value="arabic">아랍어</option>
                                    <option value="hindi">힌디어</option>
                                    <option value="italian">이탈리아어</option>
                                    <option value="dutch">네덜란드어</option>
                                    <option value="custom">직접 입력...</option>
                                </select>
                                <input type="text" id="lang-other-input-\${qId}" 
                                       placeholder="언어명 입력" 
                                       class="hidden px-4 py-2 rounded-lg border flex-1 min-w-[150px]"
                                       style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: #fff;"
                                       onchange="setCustomLanguage('\${qId}', this.value)">
                            </div>
                            <div class="mt-3">
                                <p class="text-sm mb-2" style="color: rgb(148,163,184);">수준:</p>
                                <div class="flex flex-wrap gap-2">
                                    \${levels.map(lvl => \`
                                        <button type="button" onclick="selectOtherLanguageLevel('\${qId}', '\${lvl.value}', this)"
                                                class="other-level-option px-4 py-2 rounded-lg border transition-all duration-200"
                                                style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                                data-level="\${lvl.value}">
                                            \${lvl.label}
                                        </button>
                                    \`).join('')}
                                </div>
                            </div>
                        </div>
                        
                        <!-- 선택된 언어 표시 -->
                        <div id="lang-selected-\${qId}" class="mt-3 flex flex-wrap gap-2"></div>
                    </div>
                    \${q.max_selections ? \`<p class="text-xs mt-2" style="color: rgb(100,116,139)">최대 \${q.max_selections}개 선택 가능</p>\` : ''}
                \`;
            } else if (q.ui_type === 'chips' || q.ui_type === 'checkbox') {
                // 중복 옵션 필터링 (미니모듈에서 이미 선택된 항목)
                const duplicateOptions = window._duplicateOptionsMap?.[qId] || [];
                
                optionsHtml = \`
                    <div class="flex flex-wrap gap-2" data-question-id="\${qId}" data-max-selections="\${q.max_selections || 99}">
                        \${(q.options || []).map(opt => {
                            const isDuplicate = duplicateOptions.includes(opt.value);
                            if (isDuplicate) {
                                // 중복 옵션: 비활성화 상태로 표시 + "이미 선택됨" 표시
                                return \`
                                    <button type="button" disabled
                                            class="chip-option chip-duplicate group relative px-4 py-2.5 rounded-xl border transition-all duration-200 cursor-not-allowed"
                                            style="background-color: rgba(99,102,241,0.1); border-color: rgba(99,102,241,0.3); color: rgb(165,180,252); opacity: 0.7;"
                                            data-value="\${opt.value}" title="나를 알아가기 단계에서 이미 선택됨">
                                        <span class="flex items-center gap-2">
                                            \${opt.emoji ? \`<span class="text-lg">\${opt.emoji}</span>\` : ''}
                                            <span>\${opt.label}</span>
                                            <span class="text-xs ml-1" style="color: rgb(129,140,248);">✓ 선택됨</span>
                                        </span>
                                    </button>
                                \`;
                            }
                            return \`
                                <button type="button" onclick="toggleChipOption('\${qId}', '\${opt.value}', this, false)"
                                        class="chip-option group relative px-4 py-2.5 rounded-xl border transition-all duration-200"
                                        style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5); color: rgb(148,163,184);"
                                        data-value="\${opt.value}">
                                    <span class="flex items-center gap-2">
                                        \${opt.emoji ? \`<span class="text-lg">\${opt.emoji}</span>\` : ''}
                                        <span>\${opt.label}</span>
                                    </span>
                                    <div class="absolute -top-1 -right-1 w-5 h-5 rounded-full bg-emerald-500 text-white items-center justify-center text-xs font-bold hidden chip-check">✓</div>
                                </button>
                            \`;
                        }).join('')}
                        \${q.allow_unknown ? \`
                            <button type="button" onclick="toggleChipOption('\${qId}', '_unknown', this, true)"
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
                    \${isLifeConstraint ? \`
                        <div id="life-constraint-detail" class="mt-4 hidden">
                            <label class="text-sm font-medium mb-2 block" style="color: rgb(148,163,184)">
                                <i class="fas fa-info-circle mr-1"></i>선택한 상황에 대해 더 자세히 알려주세요 (선택)
                            </label>
                            <textarea id="life_constraint_detail" 
                                      name="life_constraint_detail" 
                                      rows="3"
                                      placeholder="예: 장애의 종류, 돌봄 대상과 시간, 경제적 상황 등 구체적으로 적어주시면 더 정확한 추천이 가능해요"
                                      class="w-full px-4 py-3 rounded-xl border transition-all resize-none"
                                      style="background-color: rgba(15,15,35,1); border-color: rgba(42,42,62,0.5); color: #fff;"
                                      onfocus="this.style.borderColor='rgba(67,97,238,0.5)';"
                                      onblur="this.style.borderColor='rgba(42,42,62,0.5)'; updateLifeConstraintDetail(this.value);"></textarea>
                            <p class="text-xs mt-1" style="color: rgba(148,163,184,0.6)">입력한 내용은 추천 정확도를 높이는 데에만 사용됩니다</p>
                        </div>
                    \` : ''}
                \`;
            } else if (q.ui_type === 'radio') {
                optionsHtml = \`
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-3" data-question-id="\${q.id}">
                        \${(q.options || []).map(opt => \`
                            <button type="button" onclick="selectRadioOption('\${q.id}', '\${opt.value}', this, false)"
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
                            <button type="button" onclick="selectRadioOption('\${q.id}', '_unknown', this, true)"
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
                \`;
            } else if (q.ui_type === 'text') {
                const privacyWarning = isMinor ? \`
                    <p class="text-xs text-yellow-400 mt-2">⚠️ 민감한 개인정보(주소/학교 이름/연락처/실명 등)는 작성하지 마세요.</p>
                \` : '';
                optionsHtml = \`
                    <textarea name="\${q.id}" rows="3" placeholder="\${q.placeholder || ''}"
                              class="w-full px-4 py-3 rounded-xl border transition-all resize-none"
                              style="background-color: rgba(15,15,35,1); border-color: rgba(42,42,62,0.5); color: #fff;"
                              onfocus="this.style.borderColor='rgba(67,97,238,0.5)';"
                              onblur="this.style.borderColor='rgba(42,42,62,0.5)';"></textarea>
                    \${privacyWarning}
                \`;
            }
            
            // help_text 표시
            const helpTextHtml = q.help_text ? \`<p class="text-xs mt-3 px-2 py-1.5 rounded-lg" style="color: rgb(147,197,253); background-color: rgba(59,130,246,0.1);">\${q.help_text}</p>\` : '';
            
            return \`
                <div class="question-block p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);">
                    <label class="block text-lg font-semibold mb-4 text-white">\${q.text}\${requiredMark}</label>
                    \${optionsHtml}
                    \${helpTextHtml}
                </div>
            \`;
        }
        
        // 칩 옵션 토글 (복수 선택)
        function toggleChipOption(questionId, value, btnEl, isUnknown) {
            const container = btnEl.parentElement;
            const maxSelections = parseInt(container.dataset.maxSelections) || 99;
            const isSelected = btnEl.classList.contains('selected');
            
            if (isUnknown) {
                // "모르겠어요" 류 선택 시: 다른 모든 선택 해제
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
                    
                    // 다른 옵션들 비활성화 표시
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.add('disabled-by-unknown');
                        btn.style.opacity = '0.3';
                        btn.style.pointerEvents = 'none';
                    });
                } else {
                    // 다른 옵션들 다시 활성화
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.remove('disabled-by-unknown');
                        btn.style.opacity = '1';
                        btn.style.pointerEvents = 'auto';
                    });
                }
            } else {
                // 일반 옵션 선택 시
                // 먼저 "모르겠어요" 해제
                const unknownBtn = container.querySelector('.chip-unknown');
                if (unknownBtn && unknownBtn.classList.contains('selected')) {
                    unknownBtn.classList.remove('selected');
                    unknownBtn.style.backgroundColor = 'rgba(15,15,35,0.5)';
                    unknownBtn.style.borderColor = 'rgba(100,100,120,0.5)';
                    unknownBtn.style.borderStyle = 'dashed';
                    unknownBtn.style.color = 'rgb(120,120,140)';
                    unknownBtn.querySelector('.chip-check')?.classList.add('hidden');
                    unknownBtn.querySelector('.chip-check')?.classList.remove('flex');
                    // 다른 옵션들 다시 활성화
                    container.querySelectorAll('.chip-option:not(.chip-unknown)').forEach(btn => {
                        btn.classList.remove('disabled-by-unknown');
                        btn.style.opacity = '1';
                        btn.style.pointerEvents = 'auto';
                    });
                }
                
                if (isSelected) {
                    // 선택 해제
                    btnEl.classList.remove('selected');
                    btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                    btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                    btnEl.style.color = 'rgb(148,163,184)';
                    btnEl.querySelector('.chip-check')?.classList.add('hidden');
                    btnEl.querySelector('.chip-check')?.classList.remove('flex');
                } else {
                    // 최대 선택 수 체크
                    const selectedCount = container.querySelectorAll('.chip-option.selected:not(.chip-unknown)').length;
                    if (selectedCount >= maxSelections) {
                        // 가장 먼저 선택된 것 해제
                        const firstSelected = container.querySelector('.chip-option.selected:not(.chip-unknown)');
                        if (firstSelected) {
                            firstSelected.classList.remove('selected');
                            firstSelected.style.backgroundColor = 'rgba(26,26,46,0.9)';
                            firstSelected.style.borderColor = 'rgba(42,42,62,0.5)';
                            firstSelected.style.color = 'rgb(148,163,184)';
                            firstSelected.querySelector('.chip-check')?.classList.add('hidden');
                            firstSelected.querySelector('.chip-check')?.classList.remove('flex');
                        }
                    }
                    
                    // 새 선택
                    btnEl.classList.add('selected');
                    btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                    btnEl.style.borderColor = '#10b981';
                    btnEl.style.color = '#34d399';
                    btnEl.querySelector('.chip-check')?.classList.remove('hidden');
                    btnEl.querySelector('.chip-check')?.classList.add('flex');
                }
            }
            
            // 특별한 상황 (univ_life_constraint) 추가 설명 필드 표시/숨김
            if (questionId === 'univ_life_constraint') {
                const detailContainer = document.getElementById('life-constraint-detail');
                if (detailContainer) {
                    const selectedCount = container.querySelectorAll('.chip-option.selected:not(.chip-unknown)').length;
                    if (selectedCount > 0) {
                        detailContainer.classList.remove('hidden');
                    } else {
                        detailContainer.classList.add('hidden');
                    }
                }
            }
        }
        
        // 특별한 상황 추가 설명 업데이트
        function updateLifeConstraintDetail(value) {
            universalAnswers['life_constraint_detail'] = value;
        }
        
        // ============================================
        // 언어 선택 관련 함수들
        // ============================================
        // 선택된 언어 데이터 저장
        window.selectedLanguages = {};
        window.currentLangSelection = {};  // 현재 선택 중인 언어 정보
        
        // 언어 칩 토글
        function toggleLanguageChip(questionId, langValue, btnEl, hasInput) {
            const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
            const maxSelections = parseInt(container?.dataset?.maxSelections || '5');
            const isSelected = btnEl.classList.contains('selected');
            const hasLevel = btnEl.dataset.hasLevel === 'true';
            
            // 수준 패널 숨기기 (다른 언어 선택 시)
            const levelPanel = document.getElementById(\`lang-level-panel-\${questionId}\`);
            const otherPanel = document.getElementById(\`lang-other-panel-\${questionId}\`);
            
            if (isSelected) {
                // 선택 해제
                btnEl.classList.remove('selected');
                btnEl.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btnEl.style.borderColor = 'rgba(42,42,62,0.5)';
                btnEl.style.color = 'rgb(148,163,184)';
                btnEl.querySelector('.chip-check')?.classList.add('hidden');
                btnEl.querySelector('.chip-check')?.classList.remove('flex');
                
                // 저장된 언어 데이터에서 제거
                if (window.selectedLanguages[questionId]) {
                    delete window.selectedLanguages[questionId][langValue];
                }
                
                // 패널 숨기기
                if (levelPanel) levelPanel.classList.add('hidden');
                if (otherPanel) otherPanel.classList.add('hidden');
                
                updateLanguageDisplay(questionId);
            } else {
                // 최대 선택 수 체크
                const currentCount = Object.keys(window.selectedLanguages[questionId] || {}).length;
                if (currentCount >= maxSelections) {
                    alert(\`최대 \${maxSelections}개까지 선택 가능합니다.\`);
                    return;
                }
                
                // 현재 선택 중인 언어 정보 저장
                window.currentLangSelection[questionId] = { 
                    lang: langValue, 
                    btnEl: btnEl,
                    hasLevel: hasLevel,
                    hasInput: hasInput
                };
                
                if (hasInput) {
                    // 기타 언어: 입력 패널 표시
                    if (levelPanel) levelPanel.classList.add('hidden');
                    if (otherPanel) {
                        otherPanel.classList.remove('hidden');
                        // 초기화
                        const select = document.getElementById(\`lang-other-select-\${questionId}\`);
                        const input = document.getElementById(\`lang-other-input-\${questionId}\`);
                        if (select) select.value = '';
                        if (input) { input.value = ''; input.classList.add('hidden'); }
                    }
                } else if (hasLevel) {
                    // 수준 선택 패널 표시
                    if (otherPanel) otherPanel.classList.add('hidden');
                    if (levelPanel) {
                        levelPanel.classList.remove('hidden');
                        const label = document.getElementById(\`lang-level-label-\${questionId}\`);
                        if (label) label.textContent = btnEl.querySelector('span span:last-child')?.textContent || langValue;
                        // 수준 버튼 초기화
                        levelPanel.querySelectorAll('.level-option').forEach(opt => {
                            opt.classList.remove('selected');
                            opt.style.backgroundColor = 'rgba(26,26,46,0.9)';
                            opt.style.borderColor = 'rgba(42,42,62,0.5)';
                            opt.style.color = 'rgb(148,163,184)';
                        });
                    }
                } else {
                    // 수준 선택 없는 언어: 바로 선택 완료
                    completeLanguageSelection(questionId, langValue, 'business', btnEl);
                }
            }
        }
        window.toggleLanguageChip = toggleLanguageChip;
        
        // 언어 수준 선택
        function selectLanguageLevel(questionId, levelValue, btnEl) {
            const current = window.currentLangSelection[questionId];
            if (!current) return;
            
            // 수준 버튼 스타일 업데이트
            const panel = document.getElementById(\`lang-level-panel-\${questionId}\`);
            panel?.querySelectorAll('.level-option').forEach(opt => {
                opt.classList.remove('selected');
                opt.style.backgroundColor = 'rgba(26,26,46,0.9)';
                opt.style.borderColor = 'rgba(42,42,62,0.5)';
                opt.style.color = 'rgb(148,163,184)';
            });
            btnEl.classList.add('selected');
            btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
            btnEl.style.borderColor = '#10b981';
            btnEl.style.color = '#34d399';
            
            // 선택 완료
            completeLanguageSelection(questionId, current.lang, levelValue, current.btnEl);
            
            // 패널 숨기기
            if (panel) panel.classList.add('hidden');
        }
        window.selectLanguageLevel = selectLanguageLevel;
        
        // 기타 언어 드롭다운 선택
        function selectOtherLanguage(questionId, value) {
            const input = document.getElementById(\`lang-other-input-\${questionId}\`);
            if (value === 'custom') {
                input?.classList.remove('hidden');
                input?.focus();
            } else {
                input?.classList.add('hidden');
                if (input) input.value = '';
            }
            window.currentLangSelection[questionId].otherLang = value === 'custom' ? '' : value;
        }
        window.selectOtherLanguage = selectOtherLanguage;
        
        // 기타 언어 직접 입력
        function setCustomLanguage(questionId, value) {
            window.currentLangSelection[questionId].otherLang = value;
        }
        window.setCustomLanguage = setCustomLanguage;
        
        // 기타 언어 수준 선택
        function selectOtherLanguageLevel(questionId, levelValue, btnEl) {
            const current = window.currentLangSelection[questionId];
            if (!current || !current.otherLang) {
                alert('먼저 언어를 선택해주세요.');
                return;
            }
            
            // 수준 버튼 스타일 업데이트
            const panel = document.getElementById(\`lang-other-panel-\${questionId}\`);
            panel?.querySelectorAll('.other-level-option').forEach(opt => {
                opt.classList.remove('selected');
                opt.style.backgroundColor = 'rgba(26,26,46,0.9)';
                opt.style.borderColor = 'rgba(42,42,62,0.5)';
                opt.style.color = 'rgb(148,163,184)';
            });
            btnEl.classList.add('selected');
            btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
            btnEl.style.borderColor = '#10b981';
            btnEl.style.color = '#34d399';
            
            // 선택 완료 (기타 언어)
            const langKey = \`other_\${current.otherLang}\`;
            completeLanguageSelection(questionId, langKey, levelValue, current.btnEl);
            
            // 패널 숨기기 및 초기화
            if (panel) panel.classList.add('hidden');
            const select = document.getElementById(\`lang-other-select-\${questionId}\`);
            const input = document.getElementById(\`lang-other-input-\${questionId}\`);
            if (select) select.value = '';
            if (input) { input.value = ''; input.classList.add('hidden'); }
        }
        window.selectOtherLanguageLevel = selectOtherLanguageLevel;
        
        // 언어 선택 완료 처리
        function completeLanguageSelection(questionId, langValue, levelValue, btnEl) {
            // 저장 구조 초기화
            if (!window.selectedLanguages[questionId]) {
                window.selectedLanguages[questionId] = {};
            }
            
            // 언어+수준 저장
            window.selectedLanguages[questionId][langValue] = levelValue;
            
            // 칩 스타일 업데이트
            btnEl.classList.add('selected');
            btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
            btnEl.style.borderColor = '#10b981';
            btnEl.style.color = '#34d399';
            btnEl.querySelector('.chip-check')?.classList.remove('hidden');
            btnEl.querySelector('.chip-check')?.classList.add('flex');
            
            // 표시 업데이트
            updateLanguageDisplay(questionId);
            
            // 현재 선택 정보 초기화
            delete window.currentLangSelection[questionId];
        }
        
        // 선택된 언어 표시 업데이트
        function updateLanguageDisplay(questionId) {
            const displayContainer = document.getElementById(\`lang-selected-\${questionId}\`);
            if (!displayContainer) return;
            
            const langs = window.selectedLanguages[questionId] || {};
            const levelLabels = { basic: '일상회화', business: '업무가능', native: '원어민급' };
            const langLabels = {
                english: '영어', chinese: '중국어', japanese: '일본어',
                spanish: '스페인어', german: '독일어', french: '프랑스어',
                vietnamese: '베트남어', thai: '태국어', indonesian: '인도네시아어',
                russian: '러시아어', portuguese: '포르투갈어', arabic: '아랍어',
                hindi: '힌디어', italian: '이탈리아어', dutch: '네덜란드어'
            };
            
            displayContainer.innerHTML = Object.entries(langs).map(([lang, level]) => {
                const isOther = lang.startsWith('other_');
                const langName = isOther 
                    ? (langLabels[lang.replace('other_', '')] || lang.replace('other_', ''))
                    : (langLabels[lang] || lang);
                const levelName = levelLabels[level] || level;
                
                return \`
                    <span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm"
                          style="background-color: rgba(16,185,129,0.15); border: 1px solid rgba(16,185,129,0.3); color: #34d399;">
                        \${langName} (\${levelName})
                        <button type="button" onclick="removeSelectedLanguage('\${questionId}', '\${lang}')" 
                                class="hover:text-red-400 transition-colors">&times;</button>
                    </span>
                \`;
            }).join('');
            
            // universalAnswers 업데이트
            const values = Object.entries(langs).map(([lang, level]) => \`\${lang}_\${level}\`);
            if (values.length > 0) {
                universalAnswers[questionId] = values;
            } else {
                delete universalAnswers[questionId];
            }
        }
        
        // 선택된 언어 제거
        function removeSelectedLanguage(questionId, langValue) {
            if (window.selectedLanguages[questionId]) {
                delete window.selectedLanguages[questionId][langValue];
            }
            
            // 칩 버튼 스타일 초기화
            const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
            const btn = container?.querySelector(\`[data-value="\${langValue}"]\`);
            if (btn) {
                btn.classList.remove('selected');
                btn.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.style.color = 'rgb(148,163,184)';
                btn.querySelector('.chip-check')?.classList.add('hidden');
                btn.querySelector('.chip-check')?.classList.remove('flex');
            }
            
            // other 버튼의 경우 특별 처리
            if (langValue.startsWith('other_')) {
                const otherBtn = container?.querySelector('[data-value="other"]');
                if (otherBtn) {
                    // 다른 other 언어가 없으면 버튼 스타일 초기화
                    const hasOtherLangs = Object.keys(window.selectedLanguages[questionId] || {}).some(k => k.startsWith('other_'));
                    if (!hasOtherLangs) {
                        otherBtn.classList.remove('selected');
                        otherBtn.style.backgroundColor = 'rgba(26,26,46,0.9)';
                        otherBtn.style.borderColor = 'rgba(42,42,62,0.5)';
                        otherBtn.style.color = 'rgb(148,163,184)';
                        otherBtn.querySelector('.chip-check')?.classList.add('hidden');
                        otherBtn.querySelector('.chip-check')?.classList.remove('flex');
                    }
                }
            }
            
            updateLanguageDisplay(questionId);
        }
        window.removeSelectedLanguage = removeSelectedLanguage;
        
        // ============================================
        
        // 라디오 옵션 선택 (단일 선택)
        function selectRadioOption(questionId, value, btnEl, isUnknown) {
            const container = btnEl.parentElement;
            const isSelected = btnEl.classList.contains('selected');
            
            // 모든 옵션 선택 해제
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
                // 새 선택
                btnEl.classList.add('selected');
                
                if (isUnknown) {
                    btnEl.style.backgroundColor = 'rgba(100,116,139,0.3)';
                    btnEl.style.borderColor = '#64748b';
                    btnEl.style.borderStyle = 'solid';
                    btnEl.querySelector('.radio-circle').style.borderColor = '#64748b';
                    btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
                    
                    // 다른 옵션들 비활성화 표시
                    container.querySelectorAll('.radio-option:not(.radio-unknown)').forEach(btn => {
                        btn.classList.add('disabled-by-unknown');
                        btn.style.opacity = '0.3';
                        btn.style.pointerEvents = 'none';
                    });
                } else {
                    btnEl.style.backgroundColor = 'rgba(16,185,129,0.2)';
                    btnEl.style.borderColor = '#10b981';
                    btnEl.querySelector('.radio-circle').style.borderColor = '#10b981';
                    btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
                }
            }
        }
        
        // ============================================
        // Universal 답변 수집
        // ============================================
        function collectUniversalAnswers() {
            universalAnswers = {};
            UNIVERSAL_QUESTIONS.forEach(q => {
                if (q.ui_type === 'language_chips') {
                    // 언어 선택 UI: window.selectedLanguages에서 가져옴
                    const langs = window.selectedLanguages?.[q.id] || {};
                    const values = Object.entries(langs).map(([lang, level]) => \`\${lang}_\${level}\`);
                    if (values.length > 0) universalAnswers[q.id] = values;
                } else if (q.ui_type === 'chips' || q.ui_type === 'checkbox') {
                    const container = document.querySelector(\`[data-question-id="\${q.id}"]\`);
                    if (container) {
                        const selected = container.querySelectorAll('.chip-option.selected:not(.chip-unknown)');
                        const values = Array.from(selected).map(btn => btn.dataset.value);
                    if (values.length > 0) universalAnswers[q.id] = values;
                    }
                } else if (q.ui_type === 'radio') {
                    const container = document.querySelector(\`[data-question-id="\${q.id}"]\`);
                    if (container) {
                        const selected = container.querySelector('.radio-option.selected:not(.radio-unknown)');
                        if (selected) universalAnswers[q.id] = selected.dataset.value;
                    }
                } else if (q.ui_type === 'text') {
                    const textarea = document.querySelector(\`textarea[name="\${q.id}"]\`);
                    if (textarea && textarea.value.trim()) universalAnswers[q.id] = textarea.value.trim();
                }
            });
            return universalAnswers;
        }
        
        // ============================================
        // Step 2 → Step 3 or Step 4
        // ============================================
        async function submitUniversalAndContinue() {
            collectUniversalAnswers();
            showLoading('답변 분석 중...', '심화 질문을 구성하고 있어요');
            
            // API 호출하여 follow-up 질문 받기
            try {
                currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                hideLoading();
                
                if (data.result?.followup_questions?.length > 0) {
                    renderFollowupQuestions(data.result.followup_questions);
                    goToStep(3);
                } else {
                    // Follow-up 질문이 없으면 바로 결과로
                    currentRequestId = data.request_id;
                    displayResults(data);
                    goToStep(3); // 결과 (3단계 구조)
                }
            } catch (error) {
                hideLoading();
                alert('오류가 발생했습니다: ' + error.message);
            }
        }
        
        async function submitUniversalAndAnalyze() {
            collectUniversalAnswers();
            const btn = document.getElementById('analyze-btn-quick');
            if (btn) {
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>분석 중...';
            }
            showLoading('AI가 분석 중...', '맞춤 추천을 구성하고 있어요');
            
            try {
                currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                
                if (!response.ok) throw new Error(data.error || 'API 오류');
                
                currentRequestId = data.request_id;
                displayResults(data);
                goToStep(3); // 결과 (3단계 구조)
            } catch (error) {
                alert('분석 중 오류가 발생했습니다: ' + error.message);
            } finally {
                hideLoading();
                if (btn) {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-magic mr-2"></i>바로 결과 보기';
                }
            }
        }
        
        // ============================================
        // Step 2: Follow-up Questions 렌더링 (고급 UI) - 3단계 구조
        // ============================================
        function renderFollowupQuestions(questions) {
            const container = document.getElementById('followup-questions-form');
            container.innerHTML = questions.slice(0, 5).map((q, idx) => \`
                <div class="followup-question p-5 rounded-2xl mb-5" style="background-color: rgba(26,26,46,0.5); border: 1px solid rgba(42,42,62,0.3);" data-question-id="followup_\${q.id}">
                    <div class="flex items-start gap-4 mb-4">
                        <span class="flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold" style="background: linear-gradient(135deg, #a855f7, #6366f1); color: white;">\${idx + 1}</span>
                        <h4 class="font-semibold text-white text-lg leading-relaxed">\${q.question}</h4>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-3 ml-12">
                        \${(q.options || []).map(opt => \`
                            <button type="button" onclick="selectFollowupOption('followup_\${q.id}', '\${opt.value}', '\${q.fact_key}', this)"
                                    class="followup-option group relative p-4 rounded-xl border text-left transition-all duration-200"
                                    style="background-color: rgba(26,26,46,0.9); border-color: rgba(42,42,62,0.5);"
                                    data-value="\${opt.value}" data-fact-key="\${q.fact_key}">
                                <div class="flex items-center gap-3">
                                    <div class="w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 radio-circle"
                                         style="border-color: rgba(100,100,120,0.5);">
                                        <div class="w-2.5 h-2.5 rounded-full hidden radio-dot" style="background: linear-gradient(135deg, #a855f7, #6366f1);"></div>
                                    </div>
                                    <span style="color: rgb(148,163,184)">\${opt.label}</span>
                                </div>
                            </button>
                        \`).join('')}
                    </div>
                </div>
            \`).join('');
        }
        
        function selectFollowupOption(questionId, value, factKey, btnEl) {
            const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
            const isSelected = btnEl.classList.contains('selected');
            
            // 같은 질문의 다른 버튼들 선택 해제
            container.querySelectorAll('.followup-option').forEach(btn => {
                btn.classList.remove('selected');
                btn.style.backgroundColor = 'rgba(26,26,46,0.9)';
                btn.style.borderColor = 'rgba(42,42,62,0.5)';
                btn.querySelector('.radio-circle').style.borderColor = 'rgba(100,100,120,0.5)';
                btn.querySelector('.radio-dot')?.classList.add('hidden');
            });
            
            if (!isSelected) {
                btnEl.classList.add('selected');
                btnEl.style.backgroundColor = 'rgba(168,85,247,0.2)';
                btnEl.style.borderColor = '#a855f7';
                btnEl.querySelector('.radio-circle').style.borderColor = '#a855f7';
                btnEl.querySelector('.radio-dot')?.classList.remove('hidden');
            }
        }
        
        async function submitFollowupsAndAnalyze() {
            const btn = document.getElementById('analyze-btn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>분석 중...';
            showLoading('AI가 분석 중...', '맞춤 추천을 구성하고 있어요');
            
            // Followup 답변 수집 및 제출 (새 UI 방식)
            try {
                const selectedOptions = document.querySelectorAll('#followup-questions-form .followup-option.selected');
                for (const btn of selectedOptions) {
                    const factKey = btn.dataset.factKey;
                    const answer = btn.dataset.value;
                    const container = btn.closest('[data-question-id]');
                    const questionId = container.dataset.questionId.replace('followup_', '');
                    
                    await fetch('/api/ai-analyzer/followup', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            session_id: currentSessionId,
                            question_id: questionId,
                            fact_key: factKey,
                            answer: answer,
                        })
                    });
                }
                
                // 재분석
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                if (!response.ok) throw new Error(data.error || 'API 오류');
                
                currentRequestId = data.request_id;
                displayResults(data);
                goToStep(3); // 결과 (3단계 구조)
            } catch (error) {
                alert('분석 중 오류가 발생했습니다: ' + error.message);
            } finally {
                hideLoading();
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-magic mr-2"></i>AI 추천 시작하기';
            }
        }
        
        // ============================================
        // Step 4: 결과 표시 (V3: 프리미엄 리포트 지원)
        // ============================================
        function displayResults(data) {
            // 결과가 없는 경우 처리
            if (!data || !data.result) {
                showErrorToast('분석 결과를 불러올 수 없습니다: ' + (data?.error || '데이터가 없습니다'));
                return;
            }
            
            const result = data.result;

            // mini_module_result 복원 (DB에서 로드 시 window에 없을 수 있음)
            if (result.mini_module_result && !window.miniModuleResult) {
                window.miniModuleResult = result.mini_module_result;
            }

            // V3: 프리미엄 리포트가 있으면 새 UI로 표시
            if (result.premium_report || (result.engine_version && result.engine_version.startsWith('v3'))) {
                displayPremiumReportV3(result);
                return;
            }
            
            // V2 기존 로직
            const top3 = result.fit_top3 || [];
            
            // User Insight 표시
            displayUserInsight(result.user_insight);
            
            // Confidence UI 표시
            displayConfidenceUI(result);
            
            // TOP3 표시 (썸네일 + 링크 포함, 점수는 토글)
            const top3Html = top3.map((job, idx) => \`
                <div class="bg-wiki-bg p-4 rounded-xl border border-wiki-border group">
                    <a href="/job/\${job.slug || job.job_id}" target="_blank" rel="noopener noreferrer" class="block hover:opacity-90 transition">
                        \${job.image_url ? \`
                            <div class="mb-3 overflow-hidden rounded-lg">
                                <img src="\${job.image_url}" alt="\${job.job_name}" class="w-full h-32 object-cover group-hover:scale-105 transition-transform" />
                            </div>
                        \` : ''}
                        <div class="flex items-center gap-2 mb-2">
                            <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : '🥉'}</span>
                            <span class="text-lg font-bold group-hover:text-wiki-primary transition">\${job.job_name}</span>
                        </div>
                        <div class="text-xs text-wiki-primary opacity-0 group-hover:opacity-100 transition">자세히 보기 →</div>
                    </a>
                    <button onclick="toggleJobScores(this)" class="flex items-center gap-1.5 text-xs text-wiki-muted hover:text-wiki-primary transition mt-2">
                        <i class="fas fa-info-circle"></i>
                        <span>상세 점수 보기</span>
                        <i class="fas fa-chevron-down text-[10px] transition-transform score-toggle-icon"></i>
                    </button>
                    <div class="score-details hidden mt-2 pt-2 border-t border-wiki-border/30">
                        <div class="p-3 rounded-lg" style="background-color: rgba(26,26,46,0.5);">
                            \${getScoreExplanation(job.like_score, job.can_score, job.fit_score, job.risk_penalty || 0, job.feasibility_score || 0)}
                        </div>
                    </div>
                </div>
            \`).join('');
            document.getElementById('top3-results').innerHTML = top3Html || '<p class="text-wiki-muted col-span-3 text-center">추천 결과가 없습니다.</p>';
            
            // 디버그 패널 (debug=true)
            if (DEBUG_MODE) {
                updateDebugPanel(result, data);
            }
            
            // 추가 Follow-up 질문 (있으면)
            if (result.followup_questions?.length > 0) {
                displayResultFollowup(result.followup_questions[0]);
            }
            
            previousTop3 = top3.map(j => j.job_name);
        }
        
        // ============================================
        // V3: 프리미엄 리포트 UI
        // ============================================
        
        // 영어 용어 → 한국어 변환 맵
        const STAGE_LABELS = {
            job_explore: '탐색 단계',
            job_student: '학생 단계',
            job_prepare: '취업 준비',
            job_early: '초기 커리어 (0~3년)',
            job_mid: '경력자 (3년+)',
            job_transition: '전환/복귀',
            job_second: '세컨드 커리어',
        };
        
        const VALUE_LABELS = {
            recognition: '인정받고 영향력 발휘',
            stability: '안정성',
            income: '높은 수입',
            growth: '성장',
            autonomy: '자율성',
            meaning: '의미/사회 기여',
            wlb: '워라밸',
            balance: '일과 삶의 균형',
            expertise: '전문성',
            creativity: '창의성',
        };

        // 워크스타일 변환 맵 (백엔드 TOKEN_TO_KOREAN과 동기화)
        const WORKSTYLE_LABELS = {
            solo: '혼자 집중',
            solo_deep: '혼자 깊이 집중',
            team: '팀 협업',
            team_harmony: '팀 조화',
            mixed: '상황에 따라',
            structured: '체계적 환경',
            flexible: '자유로운 환경',
        };

        // 관심 영역 변환 맵
        const INTEREST_LABELS = {
            problem_solving: '문제 해결',
            data_numbers: '데이터/숫자',
            tech: '기술/IT',
            creative: '창작/예술',
            people: '사람/소통',
            helping: '돌봄/봉사',
            business: '비즈니스/경영',
            nature: '자연/환경',
            physical: '신체 활동',
            research: '연구/탐구',
            teaching: '교육/가르침',
            analysis: '분석',
            design: '디자인',
            writing: '글쓰기',
            hands_on: '손으로 만들기',
        };

        // 강점 변환 맵 (백엔드 TOKEN_TO_KOREAN과 동기화)
        const STRENGTH_LABELS = {
            // 백엔드 기본 토큰
            analytical: '분석력',
            creative: '창의력',  // 백엔드는 creative (creativity 아님)
            communication: '소통력',
            structured_execution: '실행력',  // ★ 누락됐던 토큰!
            persistence: '끈기',  // 백엔드는 persistence (perseverance 아님)
            fast_learning: '학습력',
            // 추가 토큰
            leadership: '리더십',
            detail_oriented: '꼼꼼함',
            patience: '인내심',
            empathy: '공감 능력',
            organization: '체계적 정리',
            adaptability: '적응력',
            perseverance: '끈기',  // 호환용 유지
            creativity: '창의성',  // 호환용 유지
            strategic: '전략적 사고',
            teamwork: '팀워크',
            independence: '독립적 업무',
        };

        // 에너지 소진 요인 변환 맵 (백엔드 TOKEN_TO_KOREAN과 동기화)
        const DRAIN_LABELS = {
            // 백엔드 기본 토큰
            people_drain: '대인관계 스트레스',
            cognitive_drain: '인지 피로',
            time_pressure_drain: '시간 압박 스트레스',
            responsibility_drain: '책임 스트레스',
            repetition_drain: '반복 피로',
            unpredictability_drain: '불확실성 스트레스',
            routine_drain: '반복 업무 피로',
            bureaucracy_drain: '관료주의 스트레스',
            // 호환용
            pressure_drain: '마감 압박',
            conflict_drain: '갈등 상황',
            isolation_drain: '고립된 환경',
            physical_drain: '신체적 피로',
            uncertainty_drain: '불확실성',
        };

        // 희생 가능 요소 변환 맵 (백엔드 TOKEN_TO_KOREAN과 동기화)
        const SACRIFICE_LABELS = {
            // 백엔드 기본 토큰
            low_initial_income: '낮은 초봉 감수',
            willing_to_study: '재학습 감수',
            field_change_ok: '분야 전환 감수',
            ignore_social_pressure: '주변 시선 감수',
            no_sacrifice: '포기 불가',
            unstable_hours: '불규칙한 시간 감수',
            long_hours_ok: '긴 근무시간 감수',
            // 호환용
            long_hours: '긴 근무시간',
            relocation: '거주지 이동',
            unstable_early: '초기 불안정 감수',
        };

        // 제약조건 변환 맵 (미니모듈 및 백엔드 constraint 토큰)
        const CONSTRAINT_LABELS = {
            // 미니모듈 기본 제약 토큰
            time_constraint: '시간 제약',
            income_constraint: '수입 조건',
            location_constraint: '위치 제약',
            physical_constraint: '체력 제약',
            qualification_constraint: '자격 제약',
            uncertainty_constraint: '불확실성 회피',
            health_constraint: '건강 제약',
            // 백엔드 confirmed_constraint 토큰
            work_hours_strict: '불규칙한 근무시간',
            no_travel: '출장 불가',
            no_overtime: '야근 불가',
            remote_only: '재택만 가능',
            remote_preferred: '재택 선호',
            prefer_remote: '재택 선호',
            shift_work_no: '교대근무 불가',
            degree_impossible: '학위 취득 어려움',
            license_impossible: '자격 취득 어려움',
            travel_impossible: '출장 불가',
            prefer_low_overtime: '야근 최소화',
            // 기타 제약
            no_shift: '교대근무 불가',
            no_weekend: '주말 근무 불가',
            no_physical: '육체노동 불가',
            no_outdoor: '야외근무 불가',
            no_repetitive: '반복 업무 회피',
            no_social_stress: '대인 스트레스 회피',
            no_relocation: '이사/출장 불가',
        };

        // 영어 용어를 한국어로 변환하는 헬퍼 함수
        // 템플릿 리터럴에 안전하게 삽입하기 위한 이스케이프 함수
        function escapeTemplateString(str) {
            if (!str) return str;
            // $와 백틱을 HTML 엔티티로 치환하여 템플릿 리터럴 파싱 에러 방지
            const backtick = String.fromCharCode(96);
            return String(str).replace(/\\$/g, '&#36;').replace(new RegExp(backtick, 'g'), '&#96;');
        }

        function translateToKorean(text) {
            if (!text) return text;
            let result = String(text);

            // 모든 레이블 맵 합치기
            const ALL_LABELS = {
                ...STAGE_LABELS,
                ...VALUE_LABELS,
                ...WORKSTYLE_LABELS,
                ...INTEREST_LABELS,
                ...STRENGTH_LABELS,
                ...DRAIN_LABELS,
                ...SACRIFICE_LABELS,
                ...CONSTRAINT_LABELS,
            };

            // 정확히 일치하는 경우 먼저 처리
            if (ALL_LABELS[result]) {
                return ALL_LABELS[result];
            }

            // 부분 문자열 치환 (언더스코어 포함 키를 먼저 처리)
            const sortedEntries = Object.entries(ALL_LABELS)
                .sort((a, b) => b[0].length - a[0].length);

            for (const [eng, kor] of sortedEntries) {
                result = result.replace(new RegExp(eng.replace(/_/g, '[_\\\\s]?'), 'gi'), kor);
            }

            // 템플릿 리터럴 안전성을 위해 이스케이프
            return escapeTemplateString(result);
        }
        
        function displayPremiumReportV3(result) {
            // 결과 단계: step indicator와 페이지 타이틀 숨김 (깔끔한 리포트 뷰)
            const stepIndicator = document.getElementById('step-indicator');
            if (stepIndicator) stepIndicator.style.display = 'none';
            const pageTitle = document.querySelector('h1.text-3xl');
            if (pageTitle) pageTitle.style.display = 'none';
            // 계정 안내 배너도 숨김
            const accountBanner = document.getElementById('account-warning-banner');
            if (accountBanner) accountBanner.style.display = 'none';

            const report = result.premium_report || {};
            
            // PremiumReport 타입 데이터 매핑 (백엔드 실제 필드에 맞춤)
            // 백엔드 실제 필드: executiveSummary, workStyleNarrative, innerConflictAnalysis 등
            const summary = {
                headline: report.executiveSummary || report.summary_one_page?.headline || '',
                top_takeaways: report.lifeVersionStatement?.expanded || report.summary_one_page?.top_takeaways || [],
                recommended_next_step: report.expertGuidance?.doNow?.[0] || report.summary_one_page?.recommended_next_step || '',
            };
            
            // 심리 분석 데이터 매핑 (미니모듈 결과 + 백엔드 분석 결과 활용)
            const mm = window.miniModuleResult || {};

            // workStyleNarrative 텍스트 정리 함수
            function cleanWorkStyleNarrative(text) {
                if (!text) return null;
                let cleaned = text;
                // 1. 괄호 안의 Top2/선호/강점 정보 제거 (흥미 Top2: ...), (가치 Top2: ...), (환경 선호: ...), (강점 Top2: ...) 등
                cleaned = cleaned.replace(/\\([^)]*(?:Top2|선호|강점)[^)]*\\)/g, '');
                // 2. 두 번째 이후의 "당신은" 제거 (첫 번째만 유지)
                const parts = cleaned.split('당신은');
                if (parts.length > 2) {
                    // 첫 번째 "당신은"만 유지하고 나머지는 연결
                    cleaned = parts[0] + '당신은' + parts.slice(1).join('');
                }
                // 3. 연속된 공백 정리
                cleaned = cleaned.replace(/\\s+/g, ' ').trim();
                return cleaned;
            }

            const personal = {
                personality_summary: cleanWorkStyleNarrative(report.workStyleNarrative) ||
                    (report.lifeVersionStatement?.oneLiner) ||
                    (mm.interest_top?.length ? generatePersonalitySummary(mm) : null),
                work_style_insights: [
                    report.workStyleMap?.socialStyle ? \`\${translateToKorean(report.workStyleMap.socialStyle)} 업무 스타일을 선호합니다\` : null,
                    report.workStyleMap?.decisionStyle ? \`의사결정 시 \${translateToKorean(report.workStyleMap.decisionStyle)} 접근을 취합니다\` : null,
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
            
            const hypotheses = report.key_hypotheses || {};
            const topRecs = report.recommendations_top || {};
            const holdRecs = report.recommendations_hold || {};
            const planB = report.plan_b_paths || {};
            const nextQ = report.next_questions || {};

            // ============================================
            // V3 심리 분석 추가 데이터 매핑
            // ============================================

            // 내면 갈등 분석
            const innerConflict = {
                analysis: report.innerConflictAnalysis || '',
                patterns: report.conflictPatterns || [],
            };

            // 성장 곡선
            const growthCurve = {
                type: report.growthCurveType || '',
                description: report.growthCurveDescription || '',
            };

            // 스트레스 프로필
            const stressProfile = {
                profile: report.stressProfile || '',
                triggers: report.stressTriggers || [],
                failurePattern: report.failurePattern || '',
            };

            // 프로필 해석 (LLM 생성)
            const profileInterpretation = report.profileInterpretation || null;

            // 전환 타이밍 (30/60/90일 계획)
            const transitionTiming = report.transitionTiming || {
                day30: { goal: '', actions: [], milestone: '' },
                day60: { goal: '', actions: [], milestone: '' },
                day90: { goal: '', actions: [], milestone: '' },
            };

            // 인생 버전 선언문
            const lifeVersion = {
                oneLiner: report.lifeVersionStatement?.oneLiner || '',
                expanded: report.lifeVersionStatement?.expanded || [],
            };

            // 전문가 가이던스
            const expertGuidance = report.expertGuidance || {
                doNow: [],
                stopDoing: [],
                learnNext: [],
                avoidPaths: [],
            };

            // 작업 스타일 맵 (5축)
            const workStyleMap = report.workStyleMap || {
                analytical_vs_creative: 0,
                solo_vs_team: 0,
                structured_vs_flexible: 0,
                depth_vs_breadth: 0,
                guided_vs_autonomous: 0,
            };

            // 메타인지 분석 결과
            const metaCognition = report.metaCognition || null;

            // 한국어 받침 판별 (조사 선택용)
            function hasBatchim(word) {
                if (!word || word.length === 0) return false;
                const last = word.charCodeAt(word.length - 1);
                if (last >= 0xAC00 && last <= 0xD7A3) return (last - 0xAC00) % 28 !== 0;
                if (last >= 0x30 && last <= 0x39) return [0, 1, 3, 6, 7, 8].includes(last - 0x30);
                return false;
            }

            // 성격 요약 생성 헬퍼 (미니모듈 기반)
            function generatePersonalitySummary(mm) {
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
            
            // 직업 추천 데이터 - result.fit_top3 우선 사용 (직업 이름, 썸네일 포함)
            const fitTop3 = result.fit_top3 || [];
            const jobRecs = report.jobRecommendations || {};
            
            // overallTop5: fit_top3 우선, 부족하면 jobRecommendations에서 보충
            const overallTop5 = fitTop3.length > 0 ? fitTop3.slice(0, 5) : (jobRecs.overallTop5 || topRecs.recommendations || []);
            
            // fitTop10: can_top10 또는 fit_top3 확장 (반드시 10개로 제한)
            const fitTop10 = (result.can_top10 || fitTop3 || []).slice(0, 10);
            
            // likeTop10: like_top10 또는 desireTop10 (반드시 10개로 제한)
            const likeTop10 = (result.like_top10 || jobRecs.desireTop10 || []).slice(0, 10);
            
            // 결과 컨테이너 초기화 (3단계 구조: step3 = 결과)
            const container = document.getElementById('step3');
            if (!container) return;

            // 커리어 비전 섹션 HTML 사전 계산 (중첩 템플릿 리터럴 문제 방지)
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
                        // 마지막 파트에 문장 종결이 없으면 추가
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
                const summaryText = parts.length > 0 ? '당신은 ' + parts.join(', ') + ' 사람입니다.' : '당신의 커리어 프로필을 분석했습니다.';
                careerVisionHtml = '<div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);"><p class="text-lg leading-relaxed text-white">💫 ' + summaryText + '</p></div>';
            }

            // 탭 UI 생성
            container.innerHTML = \`
                <!-- 리포트 헤더 -->
                <div class="text-center mb-6">
                    <h2 class="text-2xl md:text-3xl font-bold mb-2 flex items-center justify-center gap-2">
                        <span class="text-2xl">✨</span>
                        당신만의 커리어 분석 리포트
                    </h2>
                    <p class="text-wiki-muted text-sm">AI가 분석한 당신의 커리어 방향성</p>
                    <div class="flex justify-center items-center gap-2 mt-3">
                        <button onclick="shareReport()" id="share-report-btn" class="inline-flex items-center gap-2 px-5 py-2 rounded-full text-sm font-medium transition" style="background: linear-gradient(135deg, #6366f1, #a855f7); color: white; border: none; cursor: pointer;">
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
                    <button onclick="showReportTab('summary')" class="report-tab active px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="summary">요약</button>
                    <button onclick="showReportTab('psychology')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="psychology">메타인지</button>
                    <button onclick="showReportTab('recommendations')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="recommendations">추천 직업</button>
                    <button onclick="showReportTab('details')" class="report-tab px-6 py-3 rounded-xl text-base font-semibold transition" data-tab="details" title="분석 상세">
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
                        <p class="text-center text-wiki-muted text-sm mt-2">당신의 커리어 분석 핵심을 한눈에 확인하세요.</p>
                        <div class="mt-6 h-px bg-gradient-to-r from-transparent via-amber-500/50 to-transparent"></div>
                    </div>

                    <!-- ✨ 커리어 비전 (요약 탭 첫 섹션) -->
                    <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                        <span>✨</span> 커리어 비전
                    </h4>
                    \${careerVisionHtml}

                    <!-- 📊 메타인지 요약 (요약 탭) -->
                    \${metaCognition ? \`
                        <div class="mt-8 mb-8">
                            <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                                <span>📊</span> 메타인지
                                <button onclick="showReportTab('psychology')" class="ml-auto px-3 py-1.5 rounded-lg text-[13px] font-medium text-wiki-primary bg-wiki-primary/10 hover:bg-wiki-primary/20 transition-all flex items-center gap-1.5">
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
                                                <span class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-2 rounded-lg text-xs text-white whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-50" style="background: rgba(30,30,40,0.95); border: 1px solid rgba(255,255,255,0.1);">이 항목들은 에너지가 소모되거나 스트레스를 유발할 수 있는 요인입니다.<br/>커리어 선택 시 이 요인들을 고려하면 번아웃을 예방할 수 있습니다.</span>
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

                    <!-- 🆕 나의 커리어 프로필 (프로필 해석) -->
                    \${profileInterpretation ? \`
                        <div class="mt-8 mb-8">
                            <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                                <span>🧬</span> 나의 커리어 프로필
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

                    <!-- 업무 스타일 힌트 (핵심 인사이트에서 이동) -->
                    \${workStyleMap && (workStyleMap.analytical_vs_creative !== undefined || workStyleMap.solo_vs_team !== undefined) ? \`
                        <div class="mt-6 flex flex-wrap gap-2 justify-center">
                            \${[
                                workStyleMap.analytical_vs_creative < 0 ? '🔍 분석적 접근' : workStyleMap.analytical_vs_creative > 0 ? '💡 창의적 접근' : null,
                                workStyleMap.solo_vs_team < 0 ? '🧘 집중 작업 선호' : workStyleMap.solo_vs_team > 0 ? '🤝 협업 선호' : null,
                                workStyleMap.structured_vs_flexible < 0 ? '📋 체계적 스타일' : workStyleMap.structured_vs_flexible > 0 ? '🌊 유연한 스타일' : null,
                                workStyleMap.guided_vs_autonomous > 0 ? '🚀 자율 지향' : null,
                            ].filter(Boolean).map(hint => \`
                                <span class="px-3 py-1.5 rounded-full text-[13px] font-medium" style="background: rgba(99,102,241,0.1); color: rgb(165,180,252); border: 1px solid rgba(99,102,241,0.2);">\${hint}</span>
                            \`).join('')}
                        </div>
                    \` : ''}

                    <!-- C: 프로필 → 추천 브릿지 문장 -->
                    \${profileInterpretation && overallTop5.length > 0 ? \`
                        <div class="mt-4 mb-2 p-4 rounded-xl text-center" style="background: linear-gradient(135deg, rgba(251,191,36,0.1), rgba(245,158,11,0.05)); border: 1px solid rgba(251,191,36,0.2);">
                            <p class="text-base md:text-lg" style="color: rgb(253,224,71);">
                                <span class="font-medium">🎯 이런 당신에게 맞는 직업</span>
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
                                        parts.push('<span class="text-red-400">"' + translateToKorean(pi.constraints[0].label) + '"</span> 없이 성장할 수 있는 직업을 찾았습니다.');
                                    } else if (parts.length > 0) {
                                        parts.push('에게 맞는 직업을 찾았습니다.');
                                    }
                                    return parts.length > 0 ? parts.join(' ') : '당신의 프로필을 바탕으로 직업을 추천합니다.';
                                })()}
                            </p>
                        </div>
                    \` : ''}

                    <!-- TOP 3 직업 카드 (요약 탭) -->
                    \${overallTop5.length > 0 ? \`
                        <div class="mt-6 pt-4 border-t border-wiki-border/30">
                            <h4 class="text-xl font-bold mb-4 text-wiki-text flex items-center gap-2">
                                <span>🏆</span> 추천 직업 Top 3
                                <button onclick="showReportTab('recommendations')" class="ml-auto px-3 py-1.5 rounded-lg text-[13px] font-medium text-wiki-primary bg-wiki-primary/10 hover:bg-wiki-primary/20 transition-all flex items-center gap-1.5">
                                    <span>더보기</span>
                                    <i class="fas fa-chevron-right text-[10px]"></i>
                                </button>
                            </h4>
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                                \${overallTop5.slice(0, 3).map((job, idx) => {
                                    const jobName = job.job_name || job.job_id || '직업';
                                    const jobSlug = job.slug || encodeURIComponent(jobName);
                                    const rationale = job.rationale || job.one_line_why || '';
                                    const imageUrl = job.image_url || '';
                                    const description = (job.job_description || job.description || job.summary || '').replace(/\\n\\n/g, ' ').replace(/\\n/g, ' ').trim();
                                    // fallback 1: rationale에서 첫 문장 추출 (자동 생성 아닌 경우)
                                    // fallback 2: rationale 전체 (자동 생성 포함)
                                    // fallback 3: 직업명 기반 기본 설명
                                    const displayDescription = description
                                        || (rationale && !rationale.includes('자동 생성') ? rationale.split('.')[0] + '.' : '')
                                        || (rationale ? rationale.replace('자동 생성된 결과입니다. LLM 분석이 진행되지 않았습니다.', '').trim() : '')
                                        || \`\${jobName} 직업에 대해 더 알아보세요.\`;
                                    const fitScore = job.scores?.fit || job.fit_score || '-';
                                    const likeScore = job.scores?.like || job.like_score || '-';

                                    // rationale 파싱: 좋아할 이유, 잘할 이유 추출
                                    const extractLikeReason = (r) => {
                                        if (!r || r.includes('자동 생성된 결과')) return null;
                                        const match = r.match(/\\[좋아할 이유\\]\\s*(.+?)(?=\\[|$)/s)
                                            || r.match(/\\[1\\]\\s*(.+?)(?=\\[2\\]|$)/s);
                                        return match ? match[1].trim() : null;
                                    };
                                    const extractCanReason = (r) => {
                                        if (!r || r.includes('자동 생성된 결과')) return null;
                                        const match = r.match(/\\[잘할 이유\\]\\s*(.+?)(?=\\[|$)/s)
                                            || r.match(/\\[2\\]\\s*(.+?)(?=\\[3\\]|\\[리스크\\]|$)/s);
                                        return match ? match[1].trim() : null;
                                    };

                                    const likeReason = job.like_reason || extractLikeReason(rationale);
                                    const canReason = job.can_reason || extractCanReason(rationale);
                                    const hasReasons = likeReason || canReason;

                                    return \`
                                        <a href="/job/\${jobSlug}" target="_blank" rel="noopener noreferrer" class="block p-4 rounded-xl transition-all hover:scale-[1.02] group"
                                           style="background: linear-gradient(135deg, rgba(\${idx === 0 ? '245,158,11' : idx === 1 ? '100,116,139' : '180,83,9'},0.15), rgba(\${idx === 0 ? '251,191,36' : idx === 1 ? '148,163,184' : '217,119,6'},0.05)); border: 1px solid rgba(\${idx === 0 ? '245,158,11' : idx === 1 ? '100,116,139' : '180,83,9'},0.3);">
                                            <!-- 썸네일 (없으면 placeholder) -->
                                            <div class="mb-3 overflow-hidden rounded-lg" style="aspect-ratio: 16/10;">
                                                \${imageUrl ? \`
                                                    <img src="\${imageUrl}" alt="\${jobName}"
                                                         class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                                    <div class="hidden w-full h-full items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.2), rgba(168,85,247,0.1));">
                                                        <i class="fas fa-briefcase text-3xl text-wiki-muted"></i>
                                                    </div>
                                                \` : \`
                                                    <div class="w-full h-full flex items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.2), rgba(168,85,247,0.1));">
                                                        <i class="fas fa-briefcase text-3xl text-wiki-muted"></i>
                                                    </div>
                                                \`}
                                            </div>
                                            <div class="flex items-center gap-3 mb-3">
                                                <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : '🥉'}</span>
                                                <span class="font-bold text-lg text-white flex-1 line-clamp-1">\${jobName}</span>
                                                <span class="text-base font-bold" style="color: rgb(\${idx === 0 ? '251,191,36' : idx === 1 ? '148,163,184' : '217,119,6'});">Fit \${fitScore}</span>
                                            </div>
                                            \${displayDescription ? \`<p class="text-base text-wiki-muted line-clamp-3 mb-3">\${displayDescription}</p>\` : ''}
                                            <!-- 잘할 이유 + 좋아할 이유 -->
                                            \${hasReasons ? \`
                                                <div class="space-y-1.5 mt-3 p-3 rounded-lg" style="background: rgba(0,0,0,0.2);">
                                                    \${likeReason ? \`<p class="text-[13px] leading-relaxed text-purple-300/90"><span class="text-purple-400 font-medium">💜 Like:</span> \${likeReason}</p>\` : ''}
                                                    \${canReason ? \`<p class="text-[13px] leading-relaxed text-blue-300/90"><span class="text-blue-400 font-medium">💪 Can:</span> \${canReason}</p>\` : ''}
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

                <!-- 탭 컨텐츠: 메타인지 -->
                <div id="tab-psychology" class="report-tab-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">
                    <div class="mb-8 pb-6">
                        <h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">
                            <span class="text-3xl">📊</span>
                            <span class="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">메타인지</span>
                        </h2>
                        <p class="text-center text-wiki-muted text-sm mt-2">자기 자신에 대한 깊은 이해와 내면 탐구.</p>
                        <div class="mt-6 h-px bg-gradient-to-r from-transparent via-purple-500/50 to-transparent"></div>
                    </div>

                    <!-- ============================================ -->
                    <!-- 핵심 요약 (💫 당신은...) - 가장 먼저 표시 -->
                    <!-- ============================================ -->
                    \${personal.personality_summary || metaCognition?.innerExploration?.identityInsight ? \`
                        <div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.3);">
                            <h4 class="text-xl font-bold mb-3" style="color: rgb(165,180,252);">💫 핵심 요약</h4>
                            <p class="text-base md:text-lg leading-relaxed text-white mb-4">
                                \${(() => {
                                    // LLM identityInsight 우선, 없으면 personality_summary fallback
                                    const rawText = metaCognition?.innerExploration?.identityInsight || personal.personality_summary || '';
                                    // 키워드 볼드 + 색상 처리
                                    let styled = rawText
                                        .replace(/'([^']+)'/g, '<strong class="text-wiki-secondary font-bold">$1</strong>');
                                    // 프로필 키워드에 색상 적용
                                    if (profileInterpretation) {
                                        const pi = profileInterpretation;
                                        (pi.interests || []).forEach(i => {
                                            const label = translateToKorean(i.label);
                                            styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-green-400">' + label + '</strong>');
                                        });
                                        (pi.strengths || []).forEach(s => {
                                            const label = translateToKorean(s.label);
                                            styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-blue-400">' + label + '</strong>');
                                        });
                                        (pi.values || []).forEach(v => {
                                            const label = translateToKorean(v.label);
                                            styled = styled.replace(new RegExp(label, 'g'), '<strong class="text-purple-400">' + label + '</strong>');
                                        });
                                    }
                                    return styled;
                                })()}
                            </p>
                            \${metaCognition?.innerExploration?.innerConflicts ? \`
                                <div class="p-4 rounded-xl mb-4" style="background-color: rgba(236,72,153,0.08); border-left: 3px solid rgba(236,72,153,0.5);">
                                    <div class="text-[15px] font-medium text-pink-300 mb-2">🎭 알아두면 좋은 내적 갈등</div>
                                    <p class="text-[15px] text-wiki-muted leading-relaxed">\${translateToKorean(metaCognition.innerExploration.innerConflicts)}</p>
                                </div>
                            \` : ''}
                            \${metaCognition?.innerExploration?.valueAnalysis ? \`
                                <details class="group">
                                    <summary class="cursor-pointer text-[15px] text-violet-400 font-medium hover:text-violet-300 flex items-center gap-2">
                                        <span>📖</span>
                                        <span class="group-open:hidden">▶ 추가 설명</span>
                                        <span class="hidden group-open:inline">▼ 추가 설명</span>
                                    </summary>
                                    <div class="mt-3 p-4 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(139,92,246,0.05);">
                                        \${translateToKorean(metaCognition.innerExploration.valueAnalysis)}
                                    </div>
                                </details>
                            \` : ''}
                        </div>
                    \` : \`
                        <div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.1)); border: 1px solid rgba(99,102,241,0.2);">
                            <h4 class="text-xl font-bold mb-3" style="color: rgb(165,180,252);">💫 핵심 요약</h4>
                            <p class="text-base md:text-lg leading-relaxed text-wiki-muted">심층 분석을 위해 더 많은 정보가 필요합니다. 심층 질문에 자세히 답변해주시면 더 정확한 분석이 가능합니다.</p>
                        </div>
                    \`}

                    <!-- ============================================ -->
                    <!-- 메타인지 5개 섹션 (LLM/Rule 기반) - 핵심 요약 아래에 배치 -->
                    <!-- ============================================ -->

                    \${metaCognition ? \`
                        <!-- 강점 + 선호도 (2열 그리드) -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                            <!-- 1️⃣ 나의 무기고 (강점 + 약점) - 핵심만 표시 -->
                            <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(59,130,246,0.08), rgba(99,102,241,0.05)); border: 1px solid rgba(59,130,246,0.15);">
                                <h4 class="text-lg font-bold mb-4 text-blue-400 flex items-center gap-2">
                                    <span>💪</span> 나의 강점
                                </h4>

                            \${metaCognition.myArsenal?.strengths?.length > 0 ? \`
                                <!-- 클릭 가능한 강점 태그 -->
                                <div class="flex flex-wrap gap-2 mb-4">
                                    \${metaCognition.myArsenal.strengths.map((s, i) => {
                                        const icons = { '분석력': '🔍', '창작/예술': '🎨', '소통력': '💬', '체계적 실행력': '📋', '끈기': '💪', '빠른 학습': '⚡', '리더십': '👑', '공감 능력': '🤝', '꼼꼼함': '🔬', '적응력': '🌊' };
                                        const icon = icons[translateToKorean(s.trait)] || '✨';
                                        return \`<button onclick="document.getElementById('strength-detail-\${i}').classList.toggle('hidden'); this.classList.toggle('ring-2')" class="px-4 py-2 rounded-full text-[15px] font-semibold cursor-pointer transition-all hover:scale-105" style="background-color: rgba(34,197,94,0.15); color: rgb(134,239,172);">
                                            \${icon} \${translateToKorean(s.trait)}
                                        </button>\`;
                                    }).join('')}
                                </div>
                                <!-- 태그 클릭 시 표시되는 상세 설명 -->
                                \${metaCognition.myArsenal.strengths.map((s, i) => \`
                                    <div id="strength-detail-\${i}" class="hidden mb-3 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed animate-fadeIn" style="background-color: rgba(34,197,94,0.05); border-left: 2px solid rgba(34,197,94,0.3);">
                                        <span class="font-medium text-green-300">\${translateToKorean(s.trait)}:</span>
                                        <span class="ml-1">\${s.meaning}</span>
                                    </div>
                                \`).join('')}

                                <!-- 상담사 노트 -->
                                \${metaCognition.myArsenal.counselorNote ? \`
                                    <div class="mt-3 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);">
                                        <div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div>
                                        <p class="text-[15px] text-wiki-text leading-relaxed italic">\${translateToKorean(metaCognition.myArsenal.counselorNote)}</p>
                                    </div>
                                \` : ''}
                            \` : '<p class="text-[15px] text-wiki-muted">강점 분석을 위해 더 많은 정보가 필요합니다.</p>'}

                            \${metaCognition.myArsenal?.weaknesses?.length > 0 ? \`
                                <div class="mt-5 pt-4 border-t border-wiki-border/20">
                                    <div class="text-[15px] font-medium text-orange-400 mb-3 flex items-center gap-2">
                                        <span>⚠️</span> 개선 가능 영역
                                    </div>
                                    <div class="flex flex-wrap gap-2 mb-3">
                                        \${metaCognition.myArsenal.weaknesses.map(w => \`
                                            <span class="px-3 py-1.5 rounded-full text-[15px]" style="background-color: rgba(251,146,60,0.1); color: rgb(253,186,116);">
                                                \${translateToKorean(w.trait)}
                                            </span>
                                        \`).join('')}
                                    </div>
                                    <!-- 개선 영역 상세 - 더보기 -->
                                    <details class="group">
                                        <summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1">
                                            <span class="group-open:hidden">▶ 극복 방향 보기</span>
                                            <span class="hidden group-open:inline">▼ 접기</span>
                                        </summary>
                                        <div class="mt-3 space-y-2 pl-2 border-l-2 border-orange-500/20">
                                            \${metaCognition.myArsenal.weaknesses.map(w => \`
                                                <div class="text-[15px]">
                                                    <span class="font-medium text-orange-300">\${translateToKorean(w.trait)}:</span>
                                                    <span class="text-wiki-muted ml-1">\${w.meaning}</span>
                                                </div>
                                            \`).join('')}
                                        </div>
                                    </details>
                                </div>
                            \` : ''}
                            </div>

                            <!-- 2️⃣ 선호도 지도 - 핵심만 표시 -->
                            <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(168,85,247,0.08), rgba(236,72,153,0.05)); border: 1px solid rgba(168,85,247,0.15);">
                                <h4 class="text-lg font-bold mb-4 text-purple-400 flex items-center gap-2">
                                    <span>🎯</span> 선호도 요약
                                </h4>

                            <div class="space-y-4">
                                <!-- 좋아하는 것 -->
                                \${metaCognition.preferenceMap?.likes?.length > 0 ? \`
                                    <div>
                                        <div class="text-[15px] font-medium text-green-400 mb-2">💚 좋아하는 것</div>
                                        <div class="flex flex-wrap gap-1.5 mb-2">
                                            \${metaCognition.preferenceMap.likes.map((l, i) => {
                                                const icons = { '기술/IT': '💻', '문제해결': '🧩', '창작/예술': '🎨', '데이터/숫자': '📊', '사람 돕기': '🤲', '조직/관리': '📋', '영향력': '📢', '연구/탐구': '🔬', '리딩': '👑', '빌딩': '🏗️' };
                                                const icon = icons[translateToKorean(l.item)] || '💚';
                                                return \`<button onclick="document.getElementById('like-detail-\${i}').classList.toggle('hidden'); this.classList.toggle('ring-2')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(34,197,94,0.12); color: rgb(134,239,172);">\${icon} \${translateToKorean(l.item)}</button>\`;
                                            }).join('')}
                                        </div>
                                        \${metaCognition.preferenceMap.likes.map((l, i) => \`
                                            <div id="like-detail-\${i}" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(34,197,94,0.05); border-left: 2px solid rgba(34,197,94,0.3);">
                                                <span class="font-medium text-green-300">\${translateToKorean(l.item)}:</span>
                                                <span class="ml-1">\${translateToKorean(l.why)}</span>
                                            </div>
                                        \`).join('')}
                                    </div>
                                \` : ''}

                                <!-- 피하고 싶은 것 -->
                                \${metaCognition.preferenceMap?.dislikes?.length > 0 ? \`
                                    <div>
                                        <div class="text-[15px] font-medium text-red-400 mb-2">🚫 피하고 싶은 것</div>
                                        <div class="flex flex-wrap gap-1.5 mb-2">
                                            \${metaCognition.preferenceMap.dislikes.map((d, i) => {
                                                const icons = { '불규칙한 근무시간': '⏰', '재택 선호': '🏠', '야근 없음': '🌙', '출장 없음': '✈️', '교대근무 없음': '🔄', '시간 제약': '⏳', '수입 제약': '💰', '체력 제약': '🏋️', '불확실성 제약': '❓' };
                                                const icon = icons[translateToKorean(d.item)] || '🚫';
                                                return \`<button onclick="document.getElementById('dislike-detail-\${i}').classList.toggle('hidden'); this.classList.toggle('ring-2')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(239,68,68,0.12); color: rgb(252,165,165);">\${icon} \${translateToKorean(d.item)}</button>\`;
                                            }).join('')}
                                        </div>
                                        \${metaCognition.preferenceMap.dislikes.map((d, i) => \`
                                            <div id="dislike-detail-\${i}" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(239,68,68,0.05); border-left: 2px solid rgba(239,68,68,0.3);">
                                                <span class="font-medium text-red-300">\${translateToKorean(d.item)}:</span>
                                                <span class="ml-1">\${translateToKorean(d.why)}</span>
                                            </div>
                                        \`).join('')}
                                    </div>
                                \` : ''}

                                <!-- 잘 맞는 것 -->
                                \${metaCognition.preferenceMap?.fits?.length > 0 ? \`
                                    <div>
                                        <div class="text-[15px] font-medium text-blue-400 mb-2">💙 잘 맞는 것</div>
                                        <div class="flex flex-wrap gap-1.5 mb-2">
                                            \${metaCognition.preferenceMap.fits.map((f, i) => \`
                                                <button onclick="document.getElementById('fit-detail-\${i}').classList.toggle('hidden'); this.classList.toggle('ring-2')" class="px-2.5 py-1 rounded-lg text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(59,130,246,0.12); color: rgb(147,197,253);">💙 \${translateToKorean(f.item)}</button>
                                            \`).join('')}
                                        </div>
                                        \${metaCognition.preferenceMap.fits.map((f, i) => \`
                                            <div id="fit-detail-\${i}" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(59,130,246,0.05); border-left: 2px solid rgba(59,130,246,0.3);">
                                                <span class="font-medium text-blue-300">\${translateToKorean(f.item)}:</span>
                                                <span class="ml-1">\${translateToKorean(f.why)}</span>
                                            </div>
                                        \`).join('')}
                                    </div>
                                \` : ''}
                            </div>

                            <!-- 상담사 노트 -->
                            \${metaCognition.preferenceMap?.counselorNote ? \`
                                <div class="mt-4 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);">
                                    <div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div>
                                    <p class="text-[15px] text-wiki-text leading-relaxed italic">\${translateToKorean(metaCognition.preferenceMap.counselorNote)}</p>
                                </div>
                            \` : ''}
                            </div>
                        </div>

                        <!-- 스트레스 + 성장 (2열 그리드, 하나만 있으면 전체 너비) -->
                        <div class="grid grid-cols-1 \${metaCognition.stressRecovery?.stressFactors?.length > 0 && metaCognition.growthPotential ? 'md:grid-cols-2' : ''} gap-6 mb-6">
                            <!-- 4️⃣ 스트레스 & 회복 - 핵심만 -->
                            \${metaCognition.stressRecovery?.stressFactors?.length > 0 ? \`
                                <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(239,68,68,0.08), rgba(251,146,60,0.05)); border: 1px solid rgba(239,68,68,0.15);">
                                    <h4 class="text-lg font-bold mb-4 text-red-400 flex items-center gap-2">
                                        <span>⚡</span> 스트레스 요인
                                    </h4>

                                <!-- 클릭 가능한 스트레스 요인 태그 -->
                                <div class="flex flex-wrap gap-2 mb-4">
                                    \${metaCognition.stressRecovery.stressFactors.map((s, i) => {
                                        const icons = { '반복 업무 피로': '🔄', '관료주의 스트레스': '📑', '사람 상대 피로': '👥', '인지 과부하': '🧠', '시간 압박': '⏰', '책임감 부담': '⚖️', '예측 불가': '🌪️', '갈등 상황': '💢', '멀티태스킹': '🔀', '불확실성': '❓' };
                                        const icon = icons[translateToKorean(s.factor)] || '⚡';
                                        return \`<button onclick="document.getElementById('stress-detail-\${i}').classList.toggle('hidden'); this.classList.toggle('ring-2')" class="px-3 py-1.5 rounded-full text-[15px] font-medium cursor-pointer transition-all hover:scale-105" style="background-color: rgba(239,68,68,0.12); color: rgb(252,165,165);">
                                            \${icon} \${translateToKorean(s.factor)}
                                        </button>\`;
                                    }).join('')}
                                </div>
                                <!-- 태그 클릭 시 표시되는 상세 설명 -->
                                \${metaCognition.stressRecovery.stressFactors.map((s, i) => \`
                                    <div id="stress-detail-\${i}" class="hidden mb-2 p-3 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(239,68,68,0.05); border-left: 2px solid rgba(239,68,68,0.3);">
                                        <span class="font-medium text-red-300">\${translateToKorean(s.factor)}:</span>
                                        <span class="ml-1">\${translateToKorean(s.why)}</span>
                                    </div>
                                \`).join('')}

                                <!-- 상담사 노트 -->
                                \${metaCognition.stressRecovery.counselorNote ? \`
                                    <div class="mt-3 p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);">
                                        <div class="text-[15px] font-medium mb-1" style="color: rgb(251,191,36);">💡 상담사 노트</div>
                                        <p class="text-[15px] text-wiki-text leading-relaxed italic">\${translateToKorean(metaCognition.stressRecovery.counselorNote)}</p>
                                    </div>
                                \` : ''}

                                <!-- 회복 방법 (있으면) -->
                                \${metaCognition.stressRecovery?.recoveryMethods?.length > 0 ? \`
                                    <div class="mt-4 pt-4 border-t border-wiki-border/20">
                                        <div class="text-[15px] font-medium text-emerald-400 mb-2 flex items-center gap-2">
                                            <span>🌿</span> 회복 방법
                                        </div>
                                        <div class="flex flex-wrap gap-2 mb-3">
                                            \${metaCognition.stressRecovery.recoveryMethods.map(r => \`
                                                <span class="px-3 py-1.5 rounded-full text-[15px] font-medium" style="background-color: rgba(16,185,129,0.12); color: rgb(110,231,183);">
                                                    \${translateToKorean(r.factor)}
                                                </span>
                                            \`).join('')}
                                        </div>
                                        <!-- 회복 방법 상세 - 더보기 -->
                                        <details class="group">
                                            <summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1">
                                                <span class="group-open:hidden">▶ 왜 회복되는지 이해하기</span>
                                                <span class="hidden group-open:inline">▼ 접기</span>
                                            </summary>
                                            <div class="mt-3 space-y-2 text-[15px]">
                                                \${metaCognition.stressRecovery.recoveryMethods.map(r => \`
                                                    <div class="p-3 rounded-lg" style="background-color: rgba(16,185,129,0.05);">
                                                        <span class="font-medium text-emerald-300">\${translateToKorean(r.factor)}:</span>
                                                        <span class="text-wiki-muted ml-1">\${translateToKorean(r.why)}</span>
                                                    </div>
                                                \`).join('')}
                                            </div>
                                        </details>
                                    </div>
                                \` : ''}
                                </div>
                            \` : ''}

                            <!-- 5️⃣ 성장 가능성 -->
                            \${metaCognition.growthPotential ? \`
                                <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(16,185,129,0.08), rgba(52,211,153,0.05)); border: 1px solid rgba(16,185,129,0.15);">
                                    <h4 class="text-lg font-bold mb-4 text-emerald-400 flex items-center gap-2">
                                        <span>🌱</span> 성장 가능성
                                    </h4>

                                <!-- 핵심: 활용할 강점 태그 (아이콘 개별 적용) -->
                                \${metaCognition.growthPotential.leveragePoints?.length > 0 ? \`
                                    <div class="flex flex-wrap gap-2 mb-4">
                                        \${metaCognition.growthPotential.leveragePoints.map(p => {
                                            const icons = { '분석력': '🔍', '창작/예술': '🎨', '소통력': '💬', '체계적 실행력': '📋', '끈기': '💪', '빠른 학습': '⚡', '리더십': '👑', '공감 능력': '🤝', '꼼꼼함': '🔬', '적응력': '🌊' };
                                            const icon = icons[translateToKorean(p)] || '✨';
                                            return \`<span class="px-3 py-1.5 rounded-full text-[15px] font-medium" style="background-color: rgba(16,185,129,0.12); color: rgb(110,231,183);">
                                                \${icon} \${translateToKorean(p)}
                                            </span>\`;
                                        }).join('')}
                                    </div>
                                \` : ''}

                                <!-- 상담사 노트 (핵심 메시지) -->
                                \${metaCognition.growthPotential.counselorNote ? \`
                                    <div class="p-4 rounded-xl mb-4" style="background: linear-gradient(135deg, rgba(251,191,36,0.08), rgba(245,158,11,0.05)); border-left: 3px solid rgba(251,191,36,0.5);">
                                        <div class="text-[15px] font-medium mb-2" style="color: rgb(251,191,36);">💡 상담사 노트</div>
                                        <p class="text-[15px] text-wiki-text leading-relaxed italic">\${translateToKorean(metaCognition.growthPotential.counselorNote)}</p>
                                    </div>
                                \` : ''}

                                <!-- 성장 방향 - 더보기 -->
                                \${metaCognition.growthPotential.direction ? \`
                                    <details class="group">
                                        <summary class="cursor-pointer text-[15px] text-wiki-muted hover:text-wiki-primary flex items-center gap-1">
                                            <span class="group-open:hidden">▶ 성장 방향 상세 보기</span>
                                            <span class="hidden group-open:inline">▼ 접기</span>
                                        </summary>
                                        <div class="mt-3 p-4 rounded-lg text-[15px] text-wiki-muted leading-relaxed" style="background-color: rgba(16,185,129,0.05);">
                                            🎯 \${translateToKorean(metaCognition.growthPotential.direction)}
                                        </div>
                                    </details>
                                \` : ''}
                                </div>
                            \` : ''}
                        </div>

                        <hr class="border-wiki-border/20 my-8" />
                    \` : ''}

                    <!-- ============================================ -->
                    <!-- ============================================ -->
                    <!-- 추가 분석 섹션들 (핵심 요약 아래 보충 정보) -->
                    <!-- ============================================ -->

                    <!-- 작업 스타일 인사이트 -->
                    \${personal.work_style_insights?.length > 0 ? \`
                        <div class="mb-8">
                            <h4 class="text-xl font-bold mb-4 flex items-center gap-2">
                                <span>🎨</span> 작업 스타일
                            </h4>
                            <div class="grid gap-3">
                                \${personal.work_style_insights.map(ws => {
                                    // 마침표 일관성 보장
                                    let text = translateToKorean(ws).trim();
                                    if (!text.endsWith('.') && !text.endsWith('다.') && !text.endsWith('요.') && !text.endsWith('니다.')) {
                                        if (text.endsWith('다') || text.endsWith('요') || text.endsWith('니다')) {
                                            text += '.';
                                        } else {
                                            text += '.';
                                        }
                                    }
                                    // 키워드 볼드+색상 처리
                                    text = text
                                        .replace(/(성장|도전|학습|몰입|성취감|자율|창의성|분석|문제|해결|독립|협업|리더십|꼼꼼|유연|안정|전문성|체계)/g, '<strong class="text-indigo-400">$1</strong>');
                                    return \`<div class="p-4 rounded-xl bg-wiki-bg/50 flex items-start gap-4" style="border: 1px solid rgba(99,102,241,0.1);">
                                        <span class="text-wiki-primary text-lg mt-0.5">✓</span>
                                        <span class="text-[15px] leading-relaxed text-wiki-text">\${text}</span>
                                    </div>\`;
                                }).join('')}
                            </div>
                        </div>
                    \` : ''}

                    <!-- 가치 우선순위 (가로 배치) -->
                    \${personal.value_priorities?.length > 0 ? \`
                        <div class="mb-8">
                            <h4 class="text-xl font-bold mb-4 flex items-center gap-2">
                                <span>⭐</span> 가치 우선순위
                            </h4>
                            <div class="grid grid-cols-\${Math.min(personal.value_priorities.length, 3)} gap-3">
                                \${personal.value_priorities.slice(0, 5).map((v, i) => {
                                    const colors = ['rgba(168,85,247,0.2)', 'rgba(99,102,241,0.2)', 'rgba(59,130,246,0.2)', 'rgba(6,182,212,0.2)', 'rgba(16,185,129,0.2)'];
                                    const textColors = ['rgb(216,180,254)', 'rgb(165,180,252)', 'rgb(147,197,253)', 'rgb(103,232,249)', 'rgb(110,231,183)'];
                                    let text = translateToKorean(v).trim();
                                    // 짧은 값 레이블은 마침표 제거, 문장(10자+)만 마침표 유지
                                    if (text.length < 10) text = text.replace(/\\.$/, '');
                                    else if (!text.endsWith('.')) text += '.';
                                    return \`<div class="p-3 md:p-4 rounded-xl flex items-center gap-2 justify-center" style="background-color: \${colors[i % colors.length]}; border: 1px solid \${colors[i % colors.length].replace('0.2', '0.3')};">
                                        <span class="text-sm font-bold" style="color: \${textColors[i % textColors.length]};">#\${i + 1}</span>
                                        <span class="text-[15px] font-semibold text-wiki-text">\${text}</span>
                                    </div>\`;
                                }).join('')}
                            </div>
                        </div>
                    \` : ''}

                    <!-- 잠재적 도전 -->
                    \${personal.potential_challenges?.length > 0 ? \`
                        <div class="mb-8 p-5 rounded-xl" style="background-color: rgba(251,146,60,0.1); border: 1px solid rgba(251,146,60,0.2);">
                            <h4 class="text-xl font-bold mb-4 text-orange-400 flex items-center gap-2">
                                <span>⚠️</span> 주의할 점
                            </h4>
                            <ul class="space-y-3">
                                \${personal.potential_challenges.map(c => \`
                                    <li class="flex items-center gap-3">
                                        <span class="text-orange-400">•</span>
                                        <span class="text-[15px] leading-relaxed text-wiki-text">\${c}</span>
                                    </li>
                                \`).join('')}
                            </ul>
                        </div>
                    \` : ''}

                    <!-- 블라인드 스팟 -->
                    \${personal.blind_spots_to_check?.length > 0 ? \`
                        <div class="mb-8 p-5 rounded-xl" style="background-color: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.2);">
                            <h4 class="text-xl font-bold mb-4 text-red-400 flex items-center gap-2">
                                <span>🔍</span> 점검할 블라인드 스팟
                            </h4>
                            <ul class="space-y-3">
                                \${personal.blind_spots_to_check.map(b => \`
                                    <li class="flex items-center gap-3">
                                        <span class="text-red-400">•</span>
                                        <span class="text-[15px] leading-relaxed text-wiki-text">\${b}</span>
                                    </li>
                                \`).join('')}
                            </ul>
                        </div>
                    \` : ''}
                    
                    <!-- 미니모듈 결과 기반 기본 분석 (데이터가 없을 때) -->
                    \${!personal.work_style_insights?.length && window.miniModuleResult ? \`
                        <div class="mb-8">
                            <h4 class="text-xl font-bold mb-4 flex items-center gap-2">
                                <span>📊</span> 선택 기반 분석
                            </h4>
                            <p class="text-sm text-wiki-muted mb-4">미니모듈에서 선택한 내용을 기반으로 한 기초 분석입니다.</p>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div class="p-4 rounded-xl" style="background-color: rgba(99,102,241,0.08); border: 1px solid rgba(99,102,241,0.15);">
                                    <div class="text-sm font-semibold text-indigo-400 mb-2">흥미 영역</div>
                                    <div class="text-base text-wiki-text">\${(window.miniModuleResult.interest_top || []).map(t => translateToKorean(t)).join(', ') || '미선택'}</div>
                                </div>
                                <div class="p-4 rounded-xl" style="background-color: rgba(168,85,247,0.08); border: 1px solid rgba(168,85,247,0.15);">
                                    <div class="text-sm font-semibold text-purple-400 mb-2">중요 가치</div>
                                    <div class="text-base text-wiki-text">\${(window.miniModuleResult.value_top || []).map(t => translateToKorean(t)).join(', ') || '미선택'}</div>
                                </div>
                                <div class="p-4 rounded-xl" style="background-color: rgba(16,185,129,0.08); border: 1px solid rgba(16,185,129,0.15);">
                                    <div class="text-sm font-semibold text-emerald-400 mb-2">강점</div>
                                    <div class="text-base text-wiki-text">\${(window.miniModuleResult.strength_top || []).map(t => translateToKorean(t)).join(', ') || '미선택'}</div>
                                </div>
                                <div class="p-4 rounded-xl" style="background-color: rgba(251,146,60,0.08); border: 1px solid rgba(251,146,60,0.15);">
                                    <div class="text-sm font-semibold text-orange-400 mb-2">제약 조건</div>
                                    <div class="text-base text-wiki-text">\${(window.miniModuleResult.constraint_flags || []).map(t => translateToKorean(t)).join(', ') || '없음'}</div>
                                </div>
                            </div>
                        </div>
                    \` : ''}

                    <!-- ============================================ -->
                    <!-- V3 추가 심리 분석 섹션들 -->
                    <!-- ============================================ -->

                    <!-- 작업 스타일 5축 시각화 (개선된 버전) -->
                    \${workStyleMap && (workStyleMap.analytical_vs_creative !== 0 || workStyleMap.solo_vs_team !== 0) ? \`
                        <div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(6,182,212,0.1), rgba(59,130,246,0.1)); border: 1px solid rgba(6,182,212,0.2);">
                            <h4 class="text-xl font-bold mb-2 text-cyan-400 flex items-center gap-2">
                                <span>📊</span> 작업 스타일 5축 분석
                            </h4>
                            <p class="text-sm text-wiki-muted mb-5">각 축의 중앙은 균형 상태이며, 좌우로 치우칠수록 해당 성향이 강합니다.</p>
                            <div class="space-y-5">
                                \${[
                                    { left: '분석형', right: '창의형', value: workStyleMap.analytical_vs_creative, color: 'cyan', leftDesc: '데이터와 논리 기반 접근을 선호합니다', rightDesc: '새로운 아이디어와 창의적 접근을 선호합니다', balanceDesc: '분석과 창의성을 균형 있게 활용합니다' },
                                    { left: '혼자 집중', right: '팀 협업', value: workStyleMap.solo_vs_team, color: 'blue', leftDesc: '독립적으로 깊이 파고드는 작업에서 에너지를 얻습니다', rightDesc: '팀원들과 함께 논의하고 협력할 때 시너지를 냅니다', balanceDesc: '상황에 따라 독립 작업과 협업을 유연하게 전환합니다' },
                                    { left: '체계적', right: '유연함', value: workStyleMap.structured_vs_flexible, color: 'violet', leftDesc: '명확한 계획과 프로세스 안에서 안정감을 느낍니다', rightDesc: '상황에 맞게 즉흥적으로 대응하는 것을 선호합니다', balanceDesc: '체계와 유연함을 상황에 맞게 조합합니다' },
                                    { left: '전문가형', right: '제너럴리스트', value: workStyleMap.depth_vs_breadth, color: 'amber', leftDesc: '한 분야를 깊이 파고들어 전문성을 키우는 것을 선호합니다', rightDesc: '다양한 분야를 넓게 경험하며 연결하는 것을 즐깁니다', balanceDesc: '깊이와 넓이를 균형 있게 추구합니다' },
                                    { left: '가이드 선호', right: '자율 선호', value: workStyleMap.guided_vs_autonomous, color: 'emerald', leftDesc: '명확한 방향과 멘토링이 있을 때 성장이 빠릅니다', rightDesc: '스스로 판단하고 실행할 수 있는 자율성을 중요시합니다', balanceDesc: '적절한 가이드와 자율성의 균형을 추구합니다' },
                                ].map(axis => \`
                                    <div>
                                        <div class="flex items-center gap-4">
                                            <span class="text-sm w-24 text-right \${axis.value < 0 ? 'text-' + axis.color + '-400 font-semibold' : 'text-wiki-muted'}">\${axis.left}</span>
                                            <div class="flex-1 h-3 bg-wiki-border/20 rounded-full relative overflow-hidden">
                                                <div class="absolute top-0 left-1/2 w-px h-full bg-wiki-muted/40 z-10"></div>
                                                \${axis.value === 0
                                                    ? '<div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-3 h-3 bg-gray-400 rounded-full border-2 border-wiki-bg z-20"></div>'
                                                    : \`<div class="absolute top-0 h-full bg-\${axis.color}-400/80 rounded-full transition-all"
                                                         style="\${axis.value >= 0
                                                            ? 'left: 50%; width: ' + Math.max(axis.value / 2, 3) + '%;'
                                                            : 'right: 50%; width: ' + Math.max(Math.abs(axis.value) / 2, 3) + '%;'}"></div>\`}
                                            </div>
                                            <span class="text-sm w-24 \${axis.value > 0 ? 'text-' + axis.color + '-400 font-semibold' : 'text-wiki-muted'}">\${axis.right}</span>
                                        </div>
                                        <p class="text-xs text-wiki-muted mt-1 text-center">\${Math.abs(axis.value) >= 15 ? (axis.value < 0 ? axis.leftDesc : axis.rightDesc) : axis.balanceDesc}</p>
                                    </div>
                                \`).join('')}
                            </div>
                        </div>
                    \` : ''}

                    <!-- 내면 갈등 + 성장 곡선 (둘 다 있으면 2열, 하나만 있으면 1열) -->
                    \${(innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts) || growthCurve.type ? \`
                        <div class="grid grid-cols-1 \${(innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts) && growthCurve.type ? 'md:grid-cols-2' : ''} gap-6 mb-8">
                            <!-- 내면 갈등 분석 -->
                            \${innerConflict.analysis && !metaCognition?.innerExploration?.innerConflicts ? \`
                                <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(168,85,247,0.1), rgba(236,72,153,0.1)); border: 1px solid rgba(168,85,247,0.2);">
                                    <h4 class="text-xl font-bold mb-4 text-purple-400 flex items-center gap-2">
                                        <span>💭</span> 내면 갈등 분석
                                    </h4>
                                    \${innerConflict.patterns?.length > 0 ? \`
                                        <p class="text-lg font-bold mb-3" style="color: rgb(216,180,254);">\${innerConflict.patterns[0]}</p>
                                    \` : ''}
                                    <p class="text-[15px] leading-relaxed text-wiki-text mb-4">\${innerConflict.analysis}</p>
                                    \${innerConflict.patterns?.length > 1 ? \`
                                        <div class="mt-4 pt-4 border-t border-purple-400/20">
                                            <span class="text-sm text-purple-300 font-semibold">기타 갈등 패턴:</span>
                                            <ul class="mt-3 space-y-2">
                                                \${innerConflict.patterns.slice(1).map(p => \`
                                                    <li class="flex items-center gap-3">
                                                        <span class="text-purple-400">•</span>
                                                        <span class="text-[15px] leading-relaxed text-wiki-muted">\${p}</span>
                                                    </li>
                                                \`).join('')}
                                            </ul>
                                        </div>
                                    \` : ''}
                                </div>
                            \` : ''}

                            <!-- 성장 곡선 -->
                            \${growthCurve.type ? \`
                                <div class="p-5 md:p-6 rounded-2xl h-full" style="background: linear-gradient(135deg, rgba(16,185,129,0.1), rgba(52,211,153,0.1)); border: 1px solid rgba(16,185,129,0.2);">
                                    <h4 class="text-xl font-bold mb-4 text-emerald-400 flex items-center gap-2">
                                        <span>📈</span> 성장 곡선 유형
                                    </h4>
                                    <p class="text-lg font-bold mb-3" style="color: rgb(52,211,153);">\${translateToKorean(growthCurve.type)}</p>
                                    \${growthCurve.description ? \`
                                        <p class="text-[15px] leading-relaxed text-wiki-text">\${growthCurve.description}</p>
                                    \` : ''}
                                </div>
                            \` : ''}
                        </div>
                    \` : ''}

                    <!-- 전환 타이밍 (30/60/90일 계획) -->
                    \${transitionTiming.day30?.goal || transitionTiming.day60?.goal || transitionTiming.day90?.goal ? \`
                        <div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(59,130,246,0.1), rgba(99,102,241,0.1)); border: 1px solid rgba(59,130,246,0.2);">
                            <h4 class="text-xl font-bold mb-2 text-blue-400 flex items-center gap-2">
                                <span>📅</span> 30/60/90일 전환 계획
                            </h4>
                            <p class="text-sm text-wiki-muted mb-5">단계별 목표와 실행 계획을 통해 체계적으로 전환을 준비하세요.</p>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                \${transitionTiming.day30?.goal ? \`
                                    <div class="p-4 rounded-xl" style="background-color: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.15);">
                                        <div class="text-sm font-bold text-blue-300 mb-3 flex items-center gap-2">
                                            <span class="w-8 h-8 rounded-full bg-blue-500/20 flex items-center justify-center text-blue-400 font-bold">30</span>
                                            첫 30일
                                        </div>
                                        <div class="text-base font-semibold text-white mb-3">\${transitionTiming.day30.goal}</div>
                                        \${transitionTiming.day30.actions?.length > 0 ? \`
                                            <ul class="text-sm text-wiki-muted space-y-2 mb-3">
                                                \${transitionTiming.day30.actions.slice(0,2).map(a => \`<li class="flex items-center gap-2"><span class="text-blue-400">•</span> \${a}</li>\`).join('')}
                                            </ul>
                                        \` : ''}
                                        \${transitionTiming.day30.milestone ? \`<div class="text-sm text-blue-400 font-medium">✓ \${transitionTiming.day30.milestone}</div>\` : ''}
                                    </div>
                                \` : ''}
                                \${transitionTiming.day60?.goal ? \`
                                    <div class="p-4 rounded-xl" style="background-color: rgba(99,102,241,0.1); border: 1px solid rgba(99,102,241,0.15);">
                                        <div class="text-sm font-bold text-indigo-300 mb-3 flex items-center gap-2">
                                            <span class="w-8 h-8 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold">60</span>
                                            60일차
                                        </div>
                                        <div class="text-base font-semibold text-white mb-3">\${transitionTiming.day60.goal}</div>
                                        \${transitionTiming.day60.actions?.length > 0 ? \`
                                            <ul class="text-sm text-wiki-muted space-y-2 mb-3">
                                                \${transitionTiming.day60.actions.slice(0,2).map(a => \`<li class="flex items-center gap-2"><span class="text-indigo-400">•</span> \${a}</li>\`).join('')}
                                            </ul>
                                        \` : ''}
                                        \${transitionTiming.day60.milestone ? \`<div class="text-sm text-indigo-400 font-medium">✓ \${transitionTiming.day60.milestone}</div>\` : ''}
                                    </div>
                                \` : ''}
                                \${transitionTiming.day90?.goal ? \`
                                    <div class="p-4 rounded-xl" style="background-color: rgba(139,92,246,0.1); border: 1px solid rgba(139,92,246,0.15);">
                                        <div class="text-sm font-bold text-violet-300 mb-3 flex items-center gap-2">
                                            <span class="w-8 h-8 rounded-full bg-violet-500/20 flex items-center justify-center text-violet-400 font-bold">90</span>
                                            90일차
                                        </div>
                                        <div class="text-base font-semibold text-white mb-3">\${transitionTiming.day90.goal}</div>
                                        \${transitionTiming.day90.actions?.length > 0 ? \`
                                            <ul class="text-sm text-wiki-muted space-y-2 mb-3">
                                                \${transitionTiming.day90.actions.slice(0,2).map(a => \`<li class="flex items-center gap-2"><span class="text-violet-400">•</span> \${a}</li>\`).join('')}
                                            </ul>
                                        \` : ''}
                                        \${transitionTiming.day90.milestone ? \`<div class="text-sm text-violet-400 font-medium">✓ \${transitionTiming.day90.milestone}</div>\` : ''}
                                    </div>
                                \` : ''}
                            </div>
                        </div>
                    \` : ''}

                    <!-- 전문가 가이던스 -->
                    \${expertGuidance.doNow?.length > 0 || expertGuidance.stopDoing?.length > 0 || expertGuidance.learnNext?.length > 0 ? \`
                        <div class="mb-8 p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(34,197,94,0.1), rgba(16,185,129,0.1)); border: 1px solid rgba(34,197,94,0.2);">
                            <h4 class="text-xl font-bold mb-2 text-green-400 flex items-center gap-2">
                                <span>🧭</span> 전문가 가이던스
                            </h4>
                            <p class="text-[15px] text-wiki-muted mb-5">지금 당장 실천할 수 있는 구체적인 조언입니다.</p>
                            \${(() => {
                                // 활성 섹션 수 계산하여 그리드 동적 조정
                                const activeSections = [
                                    expertGuidance.doNow?.length > 0 ? 'doNow' : null,
                                    expertGuidance.stopDoing?.length > 0 ? 'stopDoing' : null,
                                    expertGuidance.learnNext?.length > 0 ? 'learnNext' : null,
                                    expertGuidance.avoidPaths?.length > 0 ? 'avoidPaths' : null
                                ].filter(Boolean);
                                const count = activeSections.length;
                                const lastSection = activeSections[count - 1];
                                const isOdd = count % 2 === 1;
                                const gridClass = count <= 1 ? 'grid grid-cols-1 gap-4' : 'grid grid-cols-1 md:grid-cols-2 gap-4';

                                // 홀수개일 때 마지막 섹션만 col-span-2
                                const doNowSpan = isOdd && lastSection === 'doNow' ? 'md:col-span-2' : '';
                                const stopSpan = isOdd && lastSection === 'stopDoing' ? 'md:col-span-2' : '';
                                const learnSpan = isOdd && lastSection === 'learnNext' ? 'md:col-span-2' : '';
                                const avoidSpan = isOdd && lastSection === 'avoidPaths' ? 'md:col-span-2' : '';

                                return '<div class="' + gridClass + '">'
                                + (expertGuidance.doNow?.length > 0 ? '<div class="p-5 rounded-xl ' + doNowSpan + '" style="background-color: rgba(34,197,94,0.1); border: 1px solid rgba(34,197,94,0.15);"><div class="text-base font-bold text-green-400 mb-3 flex items-center gap-2"><span class="text-xl">✅</span> 지금 시작할 것</div><ul class="space-y-2">' + expertGuidance.doNow.slice(0,3).map(d => '<li class="flex items-center gap-3"><span class="text-green-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(d) + '</span></li>').join('') + '</ul></div>' : '')
                                + (expertGuidance.stopDoing?.length > 0 ? '<div class="p-5 rounded-xl ' + stopSpan + '" style="background-color: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.15);"><div class="text-base font-bold text-red-400 mb-3 flex items-center gap-2"><span class="text-xl">🚫</span> 그만해야 할 것</div><ul class="space-y-2">' + expertGuidance.stopDoing.slice(0,3).map(s => '<li class="flex items-center gap-3"><span class="text-red-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(s) + '</span></li>').join('') + '</ul></div>' : '')
                                + (expertGuidance.learnNext?.length > 0 ? '<div class="p-5 rounded-xl ' + learnSpan + '" style="background-color: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.15);"><div class="text-base font-bold text-blue-400 mb-3 flex items-center gap-2"><span class="text-xl">📚</span> 학습할 것</div><ul class="space-y-2">' + expertGuidance.learnNext.slice(0,3).map(l => '<li class="flex items-center gap-3"><span class="text-blue-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(l) + '</span></li>').join('') + '</ul></div>' : '')
                                + (expertGuidance.avoidPaths?.length > 0 ? '<div class="p-5 rounded-xl ' + avoidSpan + '" style="background-color: rgba(251,146,60,0.1); border: 1px solid rgba(251,146,60,0.15);"><div class="text-base font-bold text-orange-400 mb-3 flex items-center gap-2"><span class="text-xl">⚠️</span> 피해야 할 경로</div><ul class="space-y-2">' + expertGuidance.avoidPaths.slice(0,3).map(a => '<li class="flex items-center gap-3"><span class="text-orange-400">•</span><span class="text-[15px] text-wiki-text">' + translateToKorean(a) + '</span></li>').join('') + '</ul></div>' : '')
                                + '</div>';
                            })()}
                        </div>
                    \` : ''}

                    <!-- 스트레스 프로필 상세 -->
                    \${stressProfile.profile ? \`
                        <div class="p-5 md:p-6 rounded-2xl" style="background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(251,146,60,0.1)); border: 1px solid rgba(239,68,68,0.2);">
                            <h4 class="text-xl font-bold mb-4 text-red-400 flex items-center gap-2">
                                <span>😰</span> 스트레스 프로필
                            </h4>
                            <p class="text-[15px] leading-relaxed text-wiki-text mb-4">\${stressProfile.profile}</p>
                            \${stressProfile.triggers?.length > 0 ? \`
                                <div class="mt-4 pt-4 border-t border-red-400/20">
                                    <span class="text-sm text-red-300 font-semibold">주요 트리거:</span>
                                    <div class="mt-3 flex flex-wrap gap-2">
                                        \${stressProfile.triggers.map(t => \`
                                            <span class="px-3 py-1.5 rounded-lg text-sm font-medium" style="background-color: rgba(239,68,68,0.15); color: rgb(252,165,165);">\${t}</span>
                                        \`).join('')}
                                    </div>
                                </div>
                            \` : ''}
                        </div>
                    \` : ''}

                </div>
                
                <!-- 탭 컨텐츠: 추천 직업 -->
                <div id="tab-recommendations" class="report-tab-content hidden glass-card p-6 rounded-2xl mb-6">
                    <div class="mb-8 pb-6">
                        <h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">
                            <span class="text-3xl">💼</span>
                            <span class="bg-gradient-to-r from-emerald-400 to-teal-400 bg-clip-text text-transparent">추천 직업</span>
                        </h2>
                        <p class="text-center text-wiki-muted text-sm mt-2">당신에게 맞는 직업을 AI가 분석했습니다.</p>
                        <div class="mt-6 h-px bg-gradient-to-r from-transparent via-emerald-500/50 to-transparent"></div>
                    </div>

                    <!-- 📌 프로필 기반 추천 요약 (A: 추천 탭 상단) -->
                    \${profileInterpretation ? \`
                        <div class="mb-6 p-5 rounded-2xl" style="background: linear-gradient(135deg, rgba(99,102,241,0.1), rgba(168,85,247,0.08)); border: 1px solid rgba(99,102,241,0.2);">
                            <h4 class="text-lg font-bold mb-3 flex items-center gap-2" style="color: rgb(165,180,252);">
                                <span>📌</span> 당신의 프로필 기반 추천
                            </h4>
                            <div class="grid grid-cols-2 md:grid-cols-4 gap-3 mb-4">
                                \${profileInterpretation.interests?.length > 0 ? \`
                                    <div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(34,197,94,0.1);">
                                        <span class="text-green-400">💚</span>
                                        <div>
                                            <div class="text-base font-semibold text-green-400">흥미</div>
                                            <div class="text-[15px] text-white">\${profileInterpretation.interests.slice(0,2).map(i => i.label).join(', ')}</div>
                                        </div>
                                    </div>
                                \` : ''}
                                \${profileInterpretation.strengths?.length > 0 ? \`
                                    <div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(59,130,246,0.1);">
                                        <span class="text-blue-400">💪</span>
                                        <div>
                                            <div class="text-base font-semibold text-blue-400">강점</div>
                                            <div class="text-[15px] text-white">\${profileInterpretation.strengths.slice(0,2).map(s => s.label).join(', ')}</div>
                                        </div>
                                    </div>
                                \` : ''}
                                \${profileInterpretation.values?.length > 0 ? \`
                                    <div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(168,85,247,0.1);">
                                        <span class="text-purple-400">⭐</span>
                                        <div>
                                            <div class="text-base font-semibold text-purple-400">가치</div>
                                            <div class="text-[15px] text-white">\${profileInterpretation.values.slice(0,2).map(v => v.label).join(', ')}</div>
                                        </div>
                                    </div>
                                \` : ''}
                                \${profileInterpretation.constraints?.length > 0 ? \`
                                    <div class="flex items-center gap-2 p-2 rounded-lg" style="background: rgba(239,68,68,0.1);">
                                        <span class="text-red-400">🚫</span>
                                        <div>
                                            <div class="text-base font-semibold text-red-400">제약</div>
                                            <div class="text-[15px] text-white">\${profileInterpretation.constraints.slice(0,2).map(c => c.label).join(', ')}</div>
                                        </div>
                                    </div>
                                \` : ''}
                            </div>
                            <p class="text-[15px] text-wiki-muted">
                                이 조건들을 종합하여 <span class="text-wiki-primary font-medium">\${overallTop5.length || fitTop10.length}개</span>의 직업을 추천합니다.
                            </p>
                        </div>
                    \` : ''}

                    <!-- 3세트 탭 -->
                    <div class="flex gap-3 mb-6">
                        <button onclick="showJobSet('overall')" class="job-set-tab active flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="overall">
                            <span class="flex items-center justify-center gap-2">
                                <span class="text-lg">🏆</span>
                                <span>종합 추천</span>
                            </span>
                        </button>
                        <button onclick="showJobSet('fit')" class="job-set-tab flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="fit">
                            <span class="flex items-center justify-center gap-2">
                                <span class="text-lg">💪</span>
                                <span>잘 할 것 같은 직업</span>
                            </span>
                        </button>
                        <button onclick="showJobSet('desire')" class="job-set-tab flex-1 px-5 py-3.5 rounded-xl text-[15px] font-medium" data-set="desire">
                            <span class="flex items-center justify-center gap-2">
                                <span class="text-lg">💖</span>
                                <span>좋아할만한 직업</span>
                            </span>
                        </button>
                    </div>
                    
                    <!-- 직업 카드들 -->
                    <div id="job-cards-container">
                        \${renderJobCardsV3((overallTop5.length > 0 ? overallTop5 : fitTop10).slice(0, 5), 'overall', profileInterpretation)}
                    </div>
                </div>
                
                <!-- 탭 컨텐츠: 분석 상세 (점수/신뢰도 정보) -->
                <div id="tab-details" class="report-tab-content hidden glass-card p-6 md:p-8 rounded-2xl mb-6">
                    <div class="mb-8 pb-6">
                        <h2 class="text-2xl md:text-3xl font-bold text-center flex items-center justify-center gap-3">
                            <span class="text-3xl">📊</span>
                            <span class="bg-gradient-to-r from-blue-400 to-indigo-400 bg-clip-text text-transparent">분석 상세 정보</span>
                        </h2>
                        <p class="text-center text-wiki-muted text-sm mt-2">AI 추천의 근거와 기술적 분석을 확인하세요.</p>
                        <p class="text-center text-wiki-muted text-xs mt-1">엔진 버전: \${result.engine_version || 'unknown'}</p>
                        <div class="mt-6 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
                    </div>
                    <p class="text-base text-wiki-muted mb-6">이 섹션은 AI 추천의 근거, 사용된 알고리즘, 그리고 점수 산출 과정을 상세히 보여줍니다.</p>

                    <!-- 분석 파이프라인 설명 -->
                    <div class="mb-8 p-5 rounded-xl" style="background: linear-gradient(135deg, rgba(34,197,94,0.1), rgba(16,185,129,0.05)); border: 1px solid rgba(34,197,94,0.2);">
                        <h4 class="text-xl font-bold mb-4 text-emerald-400">🔬 분석 파이프라인</h4>
                        <div class="space-y-4 text-base">
                            <div class="flex items-start gap-3">
                                <span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">1</span>
                                <div>
                                    <p class="font-medium text-white">벡터 검색 (Vectorize)</p>
                                    <p class="text-wiki-muted text-[15px]">당신의 답변을 임베딩으로 변환하여 7,000개 직업 DB에서 의미적으로 유사한 후보를 검색합니다.</p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">2</span>
                                <div>
                                    <p class="font-medium text-white">TAG 필터링 (Hard Constraints)</p>
                                    <p class="text-wiki-muted text-[15px]">워라밸, 원격근무, 자격요건 등 절대 조건에 맞지 않는 직업을 제외합니다.</p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">3</span>
                                <div>
                                    <p class="font-medium text-white">LLM Judge (GPT-4o-mini)</p>
                                    <p class="text-wiki-muted text-[15px]">남은 후보 60개에 대해 AI가 Like/Can/Fit 점수를 계산하고, 추천 이유를 생성합니다.</p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3">
                                <span class="flex-shrink-0 w-7 h-7 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center text-sm font-bold">4</span>
                                <div>
                                    <p class="font-medium text-white">LLM Reporter (심리분석)</p>
                                    <p class="text-wiki-muted text-[15px]">당신의 미니모듈 결과를 바탕으로 업무 스타일과 커리어 방향을 분석합니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 입력 데이터 요약 -->
                    <div class="mb-8">
                        <h4 class="text-xl font-bold mb-4">📝 분석에 사용된 입력 데이터</h4>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                            <div class="p-4 rounded-xl bg-wiki-bg/50 text-center">
                                <div class="text-3xl font-bold text-wiki-primary">\${report._factsCount || 0}</div>
                                <div class="text-base text-wiki-muted mt-1">수집된 팩트</div>
                            </div>
                            <div class="p-4 rounded-xl bg-wiki-bg/50 text-center">
                                <div class="text-3xl font-bold text-emerald-400">\${report._answeredQuestions || 0}</div>
                                <div class="text-base text-wiki-muted mt-1">답변한 질문</div>
                            </div>
                            <div class="p-4 rounded-xl bg-wiki-bg/50 text-center">
                                <div class="text-3xl font-bold text-purple-400">\${(report._totalJobCount || report._candidatesScored || 0).toLocaleString()}</div>
                                <div class="text-base text-wiki-muted mt-1">분석 대상 직업</div>
                            </div>
                            <div class="p-4 rounded-xl bg-wiki-bg/50 text-center">
                                <div class="text-3xl font-bold text-amber-400">6</div>
                                <div class="text-base text-wiki-muted mt-1">LLM 호출 횟수</div>
                            </div>
                        </div>
                    </div>

                    <!-- AI 추천 시스템 작동 원리 -->
                    <div class="mb-8 p-5 rounded-xl" style="background-color: rgba(99,102,241,0.1); border: 1px solid rgba(99,102,241,0.2);">
                        <h4 class="text-xl font-bold mb-4" style="color: rgb(165,180,252);">🎯 AI 추천은 이렇게 만들어집니다</h4>
                        <p class="text-[15px] text-wiki-muted mb-5">이 리포트는 단순 키워드 매칭이 아닌, 3단계 AI 시스템을 거쳐 생성됩니다.</p>

                        <!-- RAG: 벡터 검색 -->
                        <div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                            <div class="flex items-center gap-2 mb-2">
                                <span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(34,197,94,0.2); color: rgb(34,197,94);">STEP 1</span>
                                <span class="font-bold text-white text-base">RAG — 의미 기반 후보 검색</span>
                            </div>
                            <p class="text-[14px] text-wiki-muted leading-relaxed mb-2">당신의 답변 전체를 AI 임베딩(숫자 벡터)으로 변환한 뒤, 7,000개 직업 DB에서 <span class="text-emerald-400">의미적으로 가장 가까운 직업들</span>을 찾습니다.</p>
                            <p class="text-[13px] text-wiki-muted/70">"데이터 분석을 좋아한다"고 답하면, 직업명에 '분석'이 없더라도 데이터 관련 업무를 하는 직업이 후보에 포함됩니다. 단순 키워드 검색과의 차이입니다.</p>
                        </div>

                        <!-- TAG: 절대 조건 필터 -->
                        <div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                            <div class="flex items-center gap-2 mb-2">
                                <span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(251,191,36,0.2); color: rgb(251,191,36);">STEP 2</span>
                                <span class="font-bold text-white text-base">TAG — 절대 조건 필터링</span>
                            </div>
                            <p class="text-[14px] text-wiki-muted leading-relaxed mb-2">후보 직업들의 속성 태그를 당신의 <span class="text-amber-400">제약 조건</span>과 대조합니다.</p>
                            <p class="text-[13px] text-wiki-muted/70">"절대 안 돼" 수준의 제약은 해당 직업을 후보에서 완전히 제거합니다. "가능하면 피하고 싶다" 수준이면 제거 대신 Risk 감점이 적용되어 순위가 내려갑니다. 예: "야근 절대 불가" → 야간 근무 직업 제외, "출장 가능하면 싫다" → 출장 직업은 남되 감점.</p>
                        </div>

                        <!-- CAG: LLM 평가 -->
                        <div class="mb-5 p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                            <div class="flex items-center gap-2 mb-2">
                                <span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(99,102,241,0.2); color: rgb(129,140,248);">STEP 3</span>
                                <span class="font-bold text-white text-base">CAG — AI가 직접 평가</span>
                            </div>
                            <p class="text-[14px] text-wiki-muted leading-relaxed mb-2">남은 후보 직업 각각에 대해, GPT-4o-mini가 당신의 프로필 전체를 읽고 <span class="text-indigo-400">Like(좋아할 가능성)</span>와 <span class="text-blue-400">Can(잘할 가능성)</span> 점수를 매깁니다.</p>
                            <p class="text-[13px] text-wiki-muted/70">AI는 단순히 숫자만 매기는 것이 아니라, "왜 이 직업을 좋아할지", "왜 잘할 수 있는지"에 대한 구체적인 이유도 함께 생성합니다. 각 직업 카드에 표시되는 Like/Can 이유가 바로 이 단계에서 만들어집니다.</p>
                        </div>

                        <!-- 최종 점수 -->
                        <div class="p-4 rounded-xl" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                            <div class="flex items-center gap-2 mb-2">
                                <span class="text-xs font-bold px-2 py-0.5 rounded" style="background: rgba(168,85,247,0.2); color: rgb(192,132,252);">최종</span>
                                <span class="font-bold text-white text-base">종합 점수 계산 (Fit)</span>
                            </div>
                            <p class="text-[14px] text-wiki-muted leading-relaxed mb-3">AI가 매긴 점수를 아래 공식으로 조합하여 최종 순위를 결정합니다.</p>
                            <div class="p-3 rounded-lg text-center" style="background: rgba(99,102,241,0.15); border: 1px solid rgba(99,102,241,0.3);">
                                <p class="text-base font-bold text-white" style="font-family: monospace;">Fit = Like + Can + Background − Risk</p>
                            </div>
                            <div class="mt-3 space-y-1 text-[13px] text-wiki-muted/80">
                                <p><span class="text-purple-400 font-medium">Like</span> — 좋아할 직업을 중요하게 반영합니다. 흥미와 가치관이 맞아야 오래 갈 수 있기 때문입니다.</p>
                                <p><span class="text-blue-400 font-medium">Can</span> — 잘할 수 있는 직업도 함께 반영합니다. 강점과 역량이 맞아야 성과를 낼 수 있습니다.</p>
                                <p><span class="text-amber-400 font-medium">Background</span> — 경력, 학력, 경험이 직업과 얼마나 관련 있는지 평가합니다.</p>
                                <p><span class="text-red-400 font-medium">Risk</span> — 당신이 "절대 싫다"고 한 조건과 충돌하면 감점됩니다.</p>
                            </div>
                        </div>
                    </div>

                    <!-- 점수 계산 방식 설명 -->
                    <div class="mb-8 rounded-xl overflow-hidden" style="border: 1px solid rgba(255,255,255,0.08);">
                        <div class="px-5 py-3" style="background: rgba(255,255,255,0.04); border-bottom: 1px solid rgba(255,255,255,0.08);">
                            <h4 class="text-base font-bold text-wiki-text">💡 점수 계산 방식</h4>
                        </div>
                        <div class="divide-y" style="--tw-divide-opacity: 0.06; --tw-divide-color: rgba(255,255,255,var(--tw-divide-opacity));">
                            <div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(52,211,153);">
                                <span class="text-emerald-400 font-bold text-sm w-10 shrink-0 text-center">Fit</span>
                                <span class="text-white text-sm font-medium w-20 shrink-0">종합 적합도</span>
                                <span class="text-wiki-muted text-[13px]">Like + Can + Background 종합, Risk 차감</span>
                            </div>
                            <div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(168,85,247);">
                                <span class="text-purple-400 font-bold text-sm w-10 shrink-0 text-center">Like</span>
                                <span class="text-white text-sm font-medium w-20 shrink-0">좋아할 가능성</span>
                                <span class="text-wiki-muted text-[13px]">관심 분야, 가치관, 우선순위와 직업 특성의 일치도</span>
                            </div>
                            <div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(96,165,250);">
                                <span class="text-blue-400 font-bold text-sm w-10 shrink-0 text-center">Can</span>
                                <span class="text-white text-sm font-medium w-20 shrink-0">잘할 가능성</span>
                                <span class="text-wiki-muted text-[13px]">강점, 업무 스타일, 경험과 직업 요구사항의 적합도</span>
                            </div>
                            <div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(251,191,36);">
                                <span class="text-amber-400 font-bold text-sm w-10 shrink-0 text-center">Bg</span>
                                <span class="text-white text-sm font-medium w-20 shrink-0">배경 적합도</span>
                                <span class="text-wiki-muted text-[13px]">경력, 전공, 자격증, 해외경험 등 배경의 도움 정도</span>
                            </div>
                            <div class="flex items-center gap-4 px-5 py-3" style="border-left: 3px solid rgb(248,113,113);">
                                <span class="text-red-400 font-bold text-sm w-10 shrink-0 text-center">Risk</span>
                                <span class="text-white text-sm font-medium w-20 shrink-0">위험 요소</span>
                                <span class="text-wiki-muted text-[13px]">피하고 싶은 조건과 직업 환경 충돌 시 페널티</span>
                            </div>
                        </div>
                    </div>

                    <!-- 데이터 소스 -->
                    <div class="p-5 rounded-xl" style="background: linear-gradient(135deg, rgba(139,92,246,0.1), rgba(99,102,241,0.05)); border: 1px solid rgba(139,92,246,0.2);">
                        <h4 class="text-xl font-bold mb-4 text-purple-400">📚 데이터 소스</h4>
                        <div class="grid md:grid-cols-2 gap-4 text-base">
                            <div>
                                <p class="font-medium text-white mb-1">직업 정보</p>
                                <p class="text-wiki-muted text-[15px]">커리어넷 + 고용24 + 워크넷 데이터 통합 (약 7,000개 직업)</p>
                            </div>
                            <div>
                                <p class="font-medium text-white mb-1">직업 속성 태깅</p>
                                <p class="text-wiki-muted text-[15px]">job_attributes 테이블: 워라밸, 성장성, 자격요건 등 15개 속성</p>
                            </div>
                            <div>
                                <p class="font-medium text-white mb-1">임베딩 모델</p>
                                <p class="text-wiki-muted text-[15px]">OpenAI text-embedding-3-small (1536차원)</p>
                            </div>
                            <div>
                                <p class="font-medium text-white mb-1">판단 모델</p>
                                <p class="text-wiki-muted text-[15px]">GPT-4o-mini (Like/Can/Fit 점수 및 추천 이유 생성)</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 하단: 입력 수정 + 내용 추가 버튼 -->
                <div class="flex flex-col sm:flex-row gap-3 justify-center mt-8">
                    <button onclick="showEditWarningModal()"
                        class="inline-flex items-center justify-center gap-2 px-5 py-3 rounded-xl text-sm font-medium transition hover:opacity-80"
                        style="background: rgba(251, 191, 36, 0.15); color: #fbbf24; border: 1px solid rgba(251, 191, 36, 0.3);">
                        <i class="fas fa-edit"></i> 입력한 내용 수정
                    </button>
                    <button onclick="showAddContextModal()"
                        class="inline-flex items-center justify-center gap-2 px-5 py-3 rounded-xl text-sm font-medium transition hover:opacity-80"
                        style="background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3);">
                        <i class="fas fa-plus"></i> 새로운 내용 추가
                    </button>
                </div>

                <!-- 입력 수정 경고 모달 -->
                <div id="edit-warning-modal" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center hidden">
                    <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-lg mx-4 shadow-2xl w-full max-h-[90vh] overflow-y-auto">
                        <div class="mb-5">
                            <div class="w-12 h-12 mx-auto mb-4 bg-amber-500/20 rounded-full flex items-center justify-center">
                                <i class="fas fa-exclamation-triangle text-xl text-amber-400"></i>
                            </div>
                            <h3 class="text-lg font-bold text-white text-center mb-2">입력 내용 수정 안내</h3>
                            <p class="text-sm text-wiki-muted text-center">기존에 입력했던 내용을 수정할 수 있습니다.<br>단, 수정 범위에 따라 이후 단계의 답변이 초기화될 수 있습니다.</p>
                        </div>
                        <div class="space-y-4 mb-6">
                            <div class="p-3 rounded-lg" style="background: rgba(251, 191, 36, 0.08); border: 1px solid rgba(251, 191, 36, 0.2);">
                                <p class="text-sm font-medium text-amber-300 mb-1">Step 1 (프로필 기본정보) 수정 시</p>
                                <p class="text-xs text-wiki-muted">Step 2(심층 질문)의 질문이 새로 생성되며, 기존 심층 질문 답변이 모두 초기화됩니다.</p>
                            </div>
                            <div class="p-3 rounded-lg" style="background: rgba(251, 191, 36, 0.08); border: 1px solid rgba(251, 191, 36, 0.2);">
                                <p class="text-sm font-medium text-amber-300 mb-1">Step 2 (심층 질문) 답변 수정 시</p>
                                <p class="text-xs text-wiki-muted">수정한 라운드 이후의 질문들이 새로 생성되며, 해당 라운드 이후 답변이 초기화됩니다.</p>
                            </div>
                        </div>
                        <div class="flex gap-3">
                            <button onclick="hideEditWarningModal()" class="flex-1 px-4 py-2.5 bg-wiki-bg border border-wiki-border text-white rounded-xl hover:bg-wiki-card transition text-sm font-medium">
                                취소
                            </button>
                            <button onclick="navigateToEditMode()" class="flex-1 px-4 py-2.5 bg-gradient-to-r from-amber-500 to-orange-500 text-white rounded-xl hover:opacity-90 transition text-sm font-medium">
                                수정 시작하기
                            </button>
                        </div>
                    </div>
                </div>

                <!-- 내용 추가 모달 -->
                <div id="add-context-modal" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center hidden">
                    <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-md mx-4 shadow-2xl w-full">
                        <div class="mb-5">
                            <h3 class="text-lg font-bold text-white mb-2">
                                <i class="fas fa-plus text-emerald-400 mr-2"></i>추가 정보 입력
                            </h3>
                            <p class="text-sm text-wiki-muted">현재 분석에 반영하고 싶은 추가 정보를 자유롭게 작성해주세요.</p>
                        </div>
                        <textarea id="additional-context-text"
                                  class="w-full h-32 p-3 rounded-xl text-sm text-white placeholder-wiki-muted resize-none focus:outline-none focus:ring-2 focus:ring-emerald-500/50"
                                  style="background: rgba(15, 15, 35, 0.6); border: 1px solid rgba(148, 163, 184, 0.2);"
                                  placeholder="예: 최근 데이터 분석 부트캠프를 수료했습니다. 재택근무가 가능한 직업을 선호합니다."
                                  minlength="30"></textarea>
                        <p id="context-char-count" class="text-xs mt-1 text-wiki-muted">0 / 최소 30자</p>
                        <div class="flex gap-3 mt-4">
                            <button onclick="hideAddContextModal()" class="flex-1 px-4 py-2.5 bg-wiki-bg border border-wiki-border text-white rounded-xl hover:bg-wiki-card transition text-sm font-medium">
                                취소
                            </button>
                            <button id="submit-context-btn" onclick="submitAdditionalContext()" disabled
                                    class="flex-1 px-4 py-2.5 bg-gradient-to-r from-emerald-500 to-teal-500 text-white rounded-xl hover:opacity-90 transition text-sm font-medium disabled:opacity-50 disabled:cursor-not-allowed">
                                추가 후 재분석
                            </button>
                        </div>
                    </div>
                </div>
            \`;
            
            // 스타일 추가
            addReportStyles();
            
            // 전역 데이터 저장 (탭 전환용 + Evidence 시스템)
            // Evidence 데이터 매핑 (job_id → evidence_links)
            const evidenceMap = {};
            (result.fit_top3 || []).forEach(job => {
                if (job.evidence_links?.length > 0) {
                    evidenceMap[job.job_id] = job.evidence_links;
                }
            });
            
            window.currentReportData = {
                report,
                overallTop5,
                fitTop10,
                likeTop10,
                evidenceMap,  // Evidence 데이터 추가
                profileInterpretation,  // 프로필 해석 데이터
            };
        }
        
        // 탭 전환
        function showReportTab(tabId) {
            document.querySelectorAll('.report-tab-content').forEach(el => el.classList.add('hidden'));
            document.querySelectorAll('.report-tab').forEach(el => el.classList.remove('active'));
            
            document.getElementById('tab-' + tabId)?.classList.remove('hidden');
            document.querySelector('.report-tab[data-tab="' + tabId + '"]')?.classList.add('active');
        }
        
        // ============================================
        // 입력 수정 / 내용 추가 (V3 리포트 하단)
        // ============================================
        function showEditWarningModal() {
            document.getElementById('edit-warning-modal')?.classList.remove('hidden');
        }
        function hideEditWarningModal() {
            document.getElementById('edit-warning-modal')?.classList.add('hidden');
        }
        function navigateToEditMode() {
            if (!currentSessionId) { alert('세션 정보가 없습니다.'); return; }
            const analyzerPath = selectedAnalysisType === 'major' ? '/analyzer/major' : '/analyzer/job';
            const params = new URLSearchParams({
                session_id: currentSessionId,
                edit_mode: 'true',
            });
            if (currentRequestId) params.set('source_request_id', String(currentRequestId));
            window.location.href = analyzerPath + '?' + params.toString();
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
        document.getElementById('additional-context-text')?.addEventListener('input', updateContextCharCount);

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
                const res = await fetch('/api/ai-analyzer/add-context', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ request_id: currentRequestId, additional_text: text })
                });
                const data = await res.json();
                if (data.success && data.redirect_url) {
                    window.location.href = data.redirect_url;
                } else if (data.success && data.new_request_id) {
                    window.location.href = '/user/ai-results/' + data.new_request_id;
                } else {
                    alert('재분석 요청 실패: ' + (data.message || '알 수 없는 오류'));
                    if (btn) { btn.disabled = false; btn.innerHTML = '추가 후 재분석'; }
                }
            } catch (err) {
                alert('재분석 요청 중 오류가 발생했습니다.');
                if (btn) { btn.disabled = false; btn.innerHTML = '추가 후 재분석'; }
            }
        }

        // ============================================
        // 공유 기능
        // ============================================
        let _shareUrl = null;
        let _shareToken = null;

        async function shareReport() {
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

                _shareUrl = json.share_url;
                _shareToken = json.token;

                // 글로벌 공유 모달 열기
                var ogImage = json.share_url + '/og.png';
                if (window.__openShareModal) {
                    window.__openShareModal(json.share_url, 'AI가 분석한 나의 커리어 DNA', ogImage);
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

        // 결과 전체 복사 기능 (데이터 기반 - DOM이 아닌 실제 데이터에서 추출)
        function copyAllReportContent() {
            const data = window.currentReportData;
            if (!data) { alert('리포트 데이터가 없습니다.'); return; }
            const report = data.report || {};
            const pi = data.profileInterpretation;
            const mm = window.miniModuleResult || {};

            let t = '=== AI 커리어 분석 리포트 ===\\n';
            t += '생성일: ' + new Date().toLocaleDateString('ko-KR') + '\\n\\n';

            // ── 1. 요약 ──
            t += '━━━ 📋 요약 ━━━\\n\\n';
            const headline = report.executiveSummary || report.summary_one_page?.headline || '';
            if (headline) t += headline + '\\n\\n';
            const takeaways = report.lifeVersionStatement?.expanded || report.summary_one_page?.top_takeaways || [];
            if (takeaways.length > 0) {
                t += '▸ 핵심 포인트\\n';
                takeaways.forEach(function(item) { t += '  • ' + item + '\\n'; });
                t += '\\n';
            }
            const nextStep = report.expertGuidance?.doNow?.[0] || report.summary_one_page?.recommended_next_step || '';
            if (nextStep) t += '▸ 다음 단계: ' + nextStep + '\\n\\n';

            // 나의 커리어 프로필
            if (pi) {
                t += '▸ 나의 커리어 프로필\\n';
                if (pi.interests?.length) t += '  흥미: ' + pi.interests.map(function(i){return i.label}).join(', ') + '\\n';
                if (pi.strengths?.length) t += '  강점: ' + pi.strengths.map(function(s){return s.label}).join(', ') + '\\n';
                if (pi.values?.length) t += '  가치: ' + pi.values.map(function(v){return v.label}).join(', ') + '\\n';
                if (pi.constraints?.length) t += '  제약: ' + pi.constraints.map(function(c){return c.label}).join(', ') + '\\n';
                t += '\\n';
            }

            // 요약 Top 3 직업
            const summaryJobs = (data.overallTop5 || data.fitTop10 || []).slice(0, 3);
            if (summaryJobs.length > 0) {
                t += '▸ 추천 직업 Top 3\\n';
                summaryJobs.forEach(function(job, i) {
                    const name = job.job_name || job.job_id || '';
                    const fit = job.scores?.fit || job.fit_score || '-';
                    const like = job.scores?.like || job.like_score || '-';
                    const can = job.scores?.can || job.can_score || '-';
                    const bg = job.feasibility_score || job.feasibilityScore || 0;
                    var scoreStr = '(Fit:' + fit + ' Like:' + like + ' Can:' + can;
                    if (bg > 0) scoreStr += ' Bg:' + bg;
                    scoreStr += ')';
                    t += '  ' + (i+1) + '. ' + name + ' ' + scoreStr + '\\n';
                    if (job.like_reason) t += '     Like: ' + job.like_reason + '\\n';
                    if (job.can_reason) t += '     Can: ' + job.can_reason + '\\n';
                });
                t += '\\n';
            }

            // ── 2. 메타인지 ──
            t += '━━━ 🧠 메타인지 ━━━\\n\\n';
            const personality = report.workStyleNarrative || report.lifeVersionStatement?.oneLiner || '';
            if (personality) t += '▸ 성격 요약\\n  ' + personality + '\\n\\n';

            const workInsights = [
                report.workStyleMap?.socialStyle ? translateToKorean(report.workStyleMap.socialStyle) + ' 업무 스타일' : null,
                report.workStyleMap?.decisionStyle ? translateToKorean(report.workStyleMap.decisionStyle) + ' 의사결정' : null,
                report.growthCurveDescription || null,
            ].filter(Boolean);
            if (workInsights.length > 0) {
                t += '▸ 업무 스타일\\n';
                workInsights.forEach(function(w) { t += '  • ' + w + '\\n'; });
                t += '\\n';
            }

            const valuePriorities = mm.value_top?.map(function(v){return translateToKorean(v)}) || report.personal_analysis?.value_priorities || [];
            if (valuePriorities.length > 0) t += '▸ 가치 우선순위: ' + valuePriorities.join(', ') + '\\n\\n';

            if (report.innerConflictAnalysis) t += '▸ 내면 갈등 분석\\n  ' + report.innerConflictAnalysis + '\\n\\n';
            if (report.conflictPatterns?.length) {
                t += '▸ 갈등 패턴\\n';
                report.conflictPatterns.forEach(function(p) { t += '  • ' + p + '\\n'; });
                t += '\\n';
            }

            if (report.stressProfile) t += '▸ 스트레스 프로필: ' + report.stressProfile + '\\n';
            if (report.stressTriggers?.length) {
                t += '▸ 스트레스 요인\\n';
                report.stressTriggers.forEach(function(s) { t += '  • ' + s + '\\n'; });
                t += '\\n';
            }
            if (report.failurePattern) t += '▸ 실패 패턴: ' + report.failurePattern + '\\n\\n';

            // 메타인지 (metaCognition)
            const mc = report.metaCognition;
            if (mc) {
                if (mc.strengths?.length) {
                    t += '▸ 메타인지 강점\\n';
                    mc.strengths.forEach(function(s) { t += '  • ' + (s.label || s) + (s.detail ? ': ' + s.detail : '') + '\\n'; });
                    t += '\\n';
                }
                if (mc.values?.length) {
                    t += '▸ 메타인지 가치\\n';
                    mc.values.forEach(function(v) { t += '  • ' + (v.label || v) + (v.detail ? ': ' + v.detail : '') + '\\n'; });
                    t += '\\n';
                }
                if (mc.stressPoints?.length) {
                    t += '▸ 스트레스 포인트\\n';
                    mc.stressPoints.forEach(function(s) { t += '  • ' + (s.label || s) + (s.detail ? ': ' + s.detail : '') + '\\n'; });
                    t += '\\n';
                }
            }

            // 5축 워크스타일 맵
            const wsm = report.workStyleMap;
            if (wsm && (wsm.analytical_vs_creative !== undefined)) {
                t += '▸ 5축 워크스타일\\n';
                t += '  분석↔창의: ' + (wsm.analytical_vs_creative || 0) + '\\n';
                t += '  독립↔협업: ' + (wsm.solo_vs_team || 0) + '\\n';
                t += '  체계↔유연: ' + (wsm.structured_vs_flexible || 0) + '\\n';
                t += '  깊이↔넓이: ' + (wsm.depth_vs_breadth || 0) + '\\n';
                t += '  가이드↔자율: ' + (wsm.guided_vs_autonomous || 0) + '\\n\\n';
            }

            // ── 3. 추천 직업 (3세트 전부) ──
            t += '━━━ 💼 추천 직업 ━━━\\n\\n';

            function formatJobList(jobs, label) {
                if (!jobs || jobs.length === 0) return '';
                let s = '▸ ' + label + '\\n';
                jobs.forEach(function(job, i) {
                    const name = job.job_name || job.job_id || '';
                    const fit = job.scores?.fit || job.fit_score || '-';
                    const like = job.scores?.like || job.like_score || '-';
                    const can = job.scores?.can || job.can_score || '-';
                    const bg = job.feasibility_score || job.feasibilityScore || 0;
                    const desc = (job.job_description || job.description || job.summary || '').replace(/\\n/g, ' ').trim();
                    var scoreStr = '(Fit:' + fit + ' Like:' + like + ' Can:' + can;
                    if (bg > 0) scoreStr += ' Bg:' + bg;
                    scoreStr += ')';
                    s += '  ' + (i+1) + '. ' + name + ' ' + scoreStr + '\\n';
                    if (desc) s += '     ' + desc.substring(0, 100) + (desc.length > 100 ? '...' : '') + '\\n';
                    if (job.like_reason) s += '     💜 Like: ' + job.like_reason + '\\n';
                    if (job.can_reason) s += '     💪 Can: ' + job.can_reason + '\\n';
                    if (job.dislike_warnings?.length) s += '     ⚠️ 주의: ' + job.dislike_warnings.join(', ') + '\\n';
                });
                return s + '\\n';
            }

            const overallJobs = (data.overallTop5 || data.fitTop10 || []).slice(0, 5);
            const fitJobs = (data.fitTop10 || []).slice(0, 10);
            const likeJobs = (data.likeTop10 || data.fitTop10 || []).slice(0, 10);

            t += formatJobList(overallJobs, '🏆 종합 추천 Top 5');
            t += formatJobList(fitJobs, '💪 잘 할 것 같은 직업 Top 10');
            t += formatJobList(likeJobs, '💖 좋아할만한 직업 Top 10');

            // ── 4. 전문가 가이던스 ──
            const eg = report.expertGuidance;
            if (eg && (eg.doNow?.length || eg.stopDoing?.length || eg.learnNext?.length || eg.avoidPaths?.length)) {
                t += '━━━ 🎯 전문가 가이던스 ━━━\\n\\n';
                if (eg.doNow?.length) { t += '▸ 지금 당장\\n'; eg.doNow.forEach(function(a){ t += '  • ' + a + '\\n'; }); t += '\\n'; }
                if (eg.stopDoing?.length) { t += '▸ 멈출 것\\n'; eg.stopDoing.forEach(function(a){ t += '  • ' + a + '\\n'; }); t += '\\n'; }
                if (eg.learnNext?.length) { t += '▸ 배울 것\\n'; eg.learnNext.forEach(function(a){ t += '  • ' + a + '\\n'; }); t += '\\n'; }
                if (eg.avoidPaths?.length) { t += '▸ 피할 것\\n'; eg.avoidPaths.forEach(function(a){ t += '  • ' + a + '\\n'; }); t += '\\n'; }
            }

            // 30/60/90일 전환 계획
            const tt = report.transitionTiming;
            if (tt && (tt.day30?.goal || tt.day60?.goal || tt.day90?.goal)) {
                t += '━━━ 📅 전환 계획 ━━━\\n\\n';
                ['day30','day60','day90'].forEach(function(key) {
                    const d = tt[key];
                    if (!d?.goal) return;
                    const label = key === 'day30' ? '30일' : key === 'day60' ? '60일' : '90일';
                    t += '▸ ' + label + ': ' + d.goal + '\\n';
                    if (d.actions?.length) d.actions.forEach(function(a){ t += '  • ' + a + '\\n'; });
                    if (d.milestone) t += '  ✓ 마일스톤: ' + d.milestone + '\\n';
                    t += '\\n';
                });
            }

            // 인생 버전 선언문
            if (report.lifeVersionStatement?.oneLiner) {
                t += '━━━ ✨ 인생 버전 선언문 ━━━\\n\\n';
                t += report.lifeVersionStatement.oneLiner + '\\n\\n';
            }

            // ── 5. 분석 상세 (DOM에서 추출 - 점수/기술 정보) ──
            const detailEl = document.getElementById('tab-details');
            if (detailEl) {
                t += '━━━ 📊 분석 상세 ━━━\\n\\n';
                const wasHidden = detailEl.classList.contains('hidden');
                detailEl.classList.remove('hidden');
                t += detailEl.innerText.trim() + '\\n';
                if (wasHidden) detailEl.classList.add('hidden');
            }

            navigator.clipboard.writeText(t).then(function() {
                alert('리포트 전체 내용이 클립보드에 복사되었습니다!');
            }).catch(function(err) {
                const textarea = document.createElement('textarea');
                textarea.value = t;
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand('copy');
                document.body.removeChild(textarea);
                alert('리포트 전체 내용이 클립보드에 복사되었습니다!');
            });
        }
        
        // 분석 초기화 기능 (테스트용)
        function resetAnalyzer() {
            if (!confirm('정말 처음부터 다시 시작하시겠습니까?\\n현재까지의 모든 답변이 초기화됩니다.')) {
                return;
            }
            
            // 로컬 스토리지의 draft 데이터 삭제
            localStorage.removeItem('analyzer_draft');
            localStorage.removeItem('analyzer_draft_timestamp');
            
            // 서버의 draft도 삭제 시도 (옵션)
            fetch('/api/ai-analyzer/draft', {
                method: 'DELETE',
                credentials: 'same-origin'
            }).catch(() => {});
            
            // 모든 상태 초기화
            window.currentStep = 1;
            window.currentRound = null;
            window.savedAnswers = {};
            window.collectedCareerState = {};
            window.universalAnswers = {};
            window.narrativeAnswers = {};
            window.roundAnswers = [];
            window.stepScrollPositions = {};
            
            // UI 초기화
            goToStep(1);
            
            // 페이지 새로고침
            window.location.reload();
        }
        
        // 직업 세트 전환
        function showJobSet(setId) {
            const data = window.currentReportData;
            if (!data) return;

            let jobList = [];

            if (setId === 'overall') jobList = (data.overallTop5 || data.fitTop10 || []).slice(0, 5);  // 종합 추천: 5개
            else if (setId === 'fit') jobList = (data.fitTop10 || []).slice(0, 10);  // 잘 할 것 같은 직업: 10개
            else if (setId === 'desire') jobList = (data.likeTop10 || data.fitTop10 || []).slice(0, 10);  // 좋아할만한 직업: 10개

            // setId와 profileInterpretation을 전달하여 탭별로 다른 이유 및 매칭 태그 표시
            document.getElementById('job-cards-container').innerHTML = renderJobCardsV3(jobList, setId, data.profileInterpretation);

            document.querySelectorAll('.job-set-tab').forEach(el => el.classList.remove('active'));
            document.querySelector('.job-set-tab[data-set="' + setId + '"]')?.classList.add('active');
        }
        
        // V3 직업 카드 렌더링 (PremiumReport 데이터 구조용) - 컴팩트 디자인
        // setId: 'overall' | 'fit' | 'desire'
        // profileInterp: ProfileInterpretation 데이터 (매칭 태그용)
        function renderJobCardsV3(jobs, setId = 'overall', profileInterp = null) {
            if (!jobs || jobs.length === 0) {
                return '<p class="text-wiki-muted text-center py-8">추천 결과가 없습니다.</p>';
            }

            // rationale 파싱 헬퍼 함수
            const extractLikeReason = (r) => {
                if (!r || r.includes('자동 생성된 결과')) return null;
                const match = r.match(/\\[좋아할 이유\\]\\s*(.+?)(?=\\[|$)/s)
                    || r.match(/\\[1\\]\\s*(.+?)(?=\\[2\\]|$)/s);
                return match ? match[1].trim() : null;
            };
            const extractCanReason = (r) => {
                if (!r || r.includes('자동 생성된 결과')) return null;
                const match = r.match(/\\[잘할 이유\\]\\s*(.+?)(?=\\[|$)/s)
                    || r.match(/\\[2\\]\\s*(.+?)(?=\\[3\\]|\\[리스크\\]|$)/s);
                return match ? match[1].trim() : null;
            };

            return jobs.map((job, idx) => {
                const jobName = job.job_name || job.job_id || '직업';
                const jobSlug = job.slug || job.job_id || '';
                // 이미지 URL 인코딩 (한글 파일명 처리)
                let imageUrl = job.image_url || '';
                if (imageUrl && imageUrl.includes('/uploads/')) {
                    const parts = imageUrl.split('/');
                    const filename = parts.pop();
                    imageUrl = parts.join('/') + '/' + encodeURIComponent(filename);
                }
                const rationale = job.rationale || job.one_line_why || '';
                const description = (job.job_description || job.description || job.summary || '').replace(/\\n\\n/g, ' ').replace(/\\n/g, ' ').trim();
                // fallback 1: rationale에서 첫 문장 추출 (자동 생성 아닌 경우)
                // fallback 2: 직업명 기반 기본 설명
                const displayDescription = description
                    || (rationale && !rationale.includes('자동 생성') ? rationale.split('.')[0] + '.' : '')
                    || \`\${jobName} 직업에 대해 더 알아보세요.\`;
                const dislikeWarnings = job.dislike_warnings || [];
                const fitScore = job.scores?.fit || job.fit_score || '-';
                const likeScore = job.scores?.like || job.like_score || '-';
                const canScore = job.scores?.can || job.can_score || '-';

                // 탭별 주점수 및 이유 결정
                let mainScore, mainScoreLabel, mainScoreColor;
                let likeReasonText = job.like_reason || extractLikeReason(rationale) || '';
                let canReasonText = job.can_reason || extractCanReason(rationale) || '';

                // 자동 생성 결과 필터링
                const isAutoGenerated = rationale.includes('자동 생성된 결과') || rationale.includes('LLM 분석이 진행되지');
                if (likeReasonText.includes('자동 생성된 결과')) likeReasonText = '';
                if (canReasonText.includes('자동 생성된 결과')) canReasonText = '';

                // LLM 분석 없이 자동 생성된 경우, 점수 기반 기본 이유 생성
                if (!likeReasonText && !isAutoGenerated && rationale && !rationale.includes('[')) {
                    likeReasonText = rationale;  // 일반 rationale을 like 이유로 사용
                }
                if (!likeReasonText && likeScore !== '-') {
                    const score = parseInt(likeScore) || 0;
                    if (score >= 70) likeReasonText = '당신의 관심사와 가치관에 잘 맞는 직업입니다.';
                    else if (score >= 50) likeReasonText = '흥미로운 업무 환경을 제공할 수 있습니다.';
                }
                if (!canReasonText && canScore !== '-') {
                    const score = parseInt(canScore) || 0;
                    if (score >= 70) canReasonText = '당신의 강점을 잘 발휘할 수 있는 분야입니다.';
                    else if (score >= 50) canReasonText = '성장 가능성이 있는 분야입니다.';
                }

                if (setId === 'desire') {
                    mainScore = likeScore;
                    mainScoreLabel = 'Like';
                    mainScoreColor = 'text-purple-400';
                } else if (setId === 'fit') {
                    mainScore = canScore;
                    mainScoreLabel = 'Can';
                    mainScoreColor = 'text-blue-400';
                } else {
                    mainScore = fitScore;
                    mainScoreLabel = 'Fit';
                    mainScoreColor = 'text-emerald-400';
                }

                // 이유 HTML 생성 (카드 내부에 표시)
                let reasonOuterHtml = '';
                if (setId === 'overall') {
                    if (likeReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-purple-400 font-medium shrink-0 text-[13px] w-12">💜 Like</span><p class="text-[14px] text-purple-300/90 leading-relaxed">' + likeReasonText + '</p></div>';
                    if (canReasonText) reasonOuterHtml += '<div class="flex gap-3 items-start"><span class="text-blue-400 font-medium shrink-0 text-[13px] w-12">💪 Can</span><p class="text-[14px] text-blue-300/90 leading-relaxed">' + canReasonText + '</p></div>';
                } else if (setId === 'desire') {
                    if (likeReasonText) reasonOuterHtml = '<div class="flex gap-3 items-start"><span class="text-purple-400 font-medium shrink-0 text-[13px] w-12">💜 Like</span><p class="text-[14px] text-purple-300/90 leading-relaxed">' + likeReasonText + '</p></div>';
                } else {
                    if (canReasonText) reasonOuterHtml = '<div class="flex gap-3 items-start"><span class="text-blue-400 font-medium shrink-0 text-[13px] w-12">💪 Can</span><p class="text-[14px] text-blue-300/90 leading-relaxed">' + canReasonText + '</p></div>';
                }

                const rankBadge = idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : \`\${idx + 1}\`;
                const rankColor = idx < 3 ? 'rgba(99,102,241,0.8)' : 'rgba(100,116,139,0.4)';

                // B: 프로필 매칭 포인트 생성
                const matchingTags = [];
                const likeNum = parseInt(likeScore) || 0;
                const canNum = parseInt(canScore) || 0;
                const riskPenalty = job.riskPenalty || job.risk_penalty || 0;
                const bgScore = job.feasibility_score || job.feasibilityScore || 0;

                // profileInterpretation에서 토큰 가져오기
                const pi = profileInterp || {};
                const interestLabels = (pi.interests || []).slice(0, 2).map(i => i.label);
                const strengthLabels = (pi.strengths || []).slice(0, 2).map(s => s.label);
                const constraintLabels = (pi.constraints || []).slice(0, 1).map(c => c.label);

                // Like 점수 기반 흥미/가치 매칭
                if (likeNum >= 65 && interestLabels.length > 0) {
                    matchingTags.push({ icon: '💚', label: interestLabels[0] + ' 흥미', color: 'green' });
                }
                // Can 점수 기반 강점 매칭
                if (canNum >= 65 && strengthLabels.length > 0) {
                    matchingTags.push({ icon: '💪', label: strengthLabels[0] + ' 강점', color: 'blue' });
                }
                // 제약 충족 (Risk 페널티 없음)
                if (riskPenalty <= 5 && constraintLabels.length > 0) {
                    matchingTags.push({ icon: '✅', label: '제약 충족', color: 'emerald' });
                }

                const matchingTagsHtml = matchingTags.length > 0 ? \`
                    <div class="flex flex-wrap gap-1.5 mt-2">
                        \${matchingTags.map(tag => \`
                            <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs"
                                  style="background: rgba(\${tag.color === 'green' ? '34,197,94' : tag.color === 'blue' ? '59,130,246' : '16,185,129'},0.15); color: rgb(\${tag.color === 'green' ? '134,239,172' : tag.color === 'blue' ? '147,197,253' : '110,231,183'});">
                                <span>\${tag.icon}</span>
                                <span>\${tag.label}</span>
                            </span>
                        \`).join('')}
                    </div>
                \` : '';

                // 점수 바 너비 계산 (0-100)
                const fitNum = parseInt(fitScore) || 0;
                const likeNum2 = parseInt(likeScore) || 0;
                const canNum2 = parseInt(canScore) || 0;

                return \`
                <div class="rounded-2xl overflow-hidden group transition-all mb-4" style="background: linear-gradient(135deg, rgba(30,30,50,0.9), rgba(25,25,45,0.95)); border: 1px solid rgba(99,102,241,\${idx < 3 ? '0.25' : '0.12'});">
                    <!-- 상단: 썸네일 + 직업 정보 -->
                    <div class="flex items-stretch">
                        <!-- 썸네일 (카드 높이 꽉 채움) -->
                        \${imageUrl && imageUrl.trim() ? \`
                            <div class="flex-shrink-0 w-28 sm:w-32 relative overflow-hidden">
                                <img src="\${imageUrl}" alt="\${jobName}"
                                     class="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                                     onerror="this.onerror=null; this.parentElement.innerHTML='<div class=\\'w-full h-full flex items-center justify-center\\' style=\\'background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(139,92,246,0.1));\\' ><i class=\\'fas fa-briefcase text-2xl text-wiki-muted\\'></i></div>';" />
                                <div class="absolute top-2 left-2 w-7 h-7 flex items-center justify-center rounded-full" style="background: rgba(0,0,0,0.6); backdrop-filter: blur(4px);">
                                    <span class="\${idx < 3 ? 'text-sm' : 'text-xs font-bold text-wiki-muted'}">\${rankBadge}</span>
                                </div>
                            </div>
                        \` : \`
                            <div class="flex-shrink-0 w-28 sm:w-32 relative flex items-center justify-center" style="background: linear-gradient(135deg, rgba(99,102,241,0.15), rgba(139,92,246,0.1));">
                                <i class="fas fa-briefcase text-2xl text-wiki-muted"></i>
                                <div class="absolute top-2 left-2 w-7 h-7 flex items-center justify-center rounded-full" style="background: rgba(0,0,0,0.6);">
                                    <span class="\${idx < 3 ? 'text-sm' : 'text-xs font-bold text-wiki-muted'}">\${rankBadge}</span>
                                </div>
                            </div>
                        \`}

                        <!-- 직업 정보 + 점수 -->
                        <div class="flex-1 min-w-0 p-4 flex flex-col justify-between">
                            <div>
                                <!-- 직업명 + 메인 점수 -->
                                <div class="flex items-start justify-between gap-3 mb-1.5">
                                    <a href="/job/\${jobSlug}" target="_blank" rel="noopener noreferrer" class="group-hover:text-wiki-primary transition">
                                        <h4 class="font-bold text-lg text-white leading-tight">\${jobName}</h4>
                                    </a>
                                    <div class="flex-shrink-0 text-right">
                                        <span class="text-xl font-bold \${mainScoreColor}">\${mainScore}</span>
                                        <span class="text-xs text-wiki-muted ml-0.5">\${mainScoreLabel}</span>
                                    </div>
                                </div>

                                <!-- 직업 설명 -->
                                \${displayDescription ? \`<p class="text-[14px] text-wiki-muted line-clamp-2 leading-relaxed mb-2">\${displayDescription}</p>\` : ''}

                                <!-- 매칭 태그 -->
                                \${matchingTagsHtml}
                                \${dislikeWarnings.length > 0 ? \`
                                    <p class="text-[13px] text-orange-400/80 line-clamp-1 mt-1.5">⚠️ \${dislikeWarnings[0]?.label || ''}</p>
                                \` : ''}
                            </div>

                            <!-- 점수 바 -->
                            <div class="flex items-center gap-3 mt-3 pt-2.5" style="border-top: 1px solid rgba(255,255,255,0.06);">
                                <div class="flex-1">
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-[11px] text-emerald-400/80 font-medium">Fit</span>
                                        <span class="text-[11px] text-emerald-400 font-semibold">\${fitScore}</span>
                                    </div>
                                    <div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);">
                                        <div class="h-full rounded-full transition-all" style="width: \${Math.min(fitNum, 100)}%; background: rgb(52,211,153);"></div>
                                    </div>
                                </div>
                                <div class="flex-1">
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-[11px] text-purple-400/80 font-medium">Like</span>
                                        <span class="text-[11px] text-purple-400 font-semibold">\${likeScore}</span>
                                    </div>
                                    <div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);">
                                        <div class="h-full rounded-full transition-all" style="width: \${Math.min(likeNum2, 100)}%; background: rgb(168,85,247);"></div>
                                    </div>
                                </div>
                                <div class="flex-1">
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-[11px] text-blue-400/80 font-medium">Can</span>
                                        <span class="text-[11px] text-blue-400 font-semibold">\${canScore}</span>
                                    </div>
                                    <div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);">
                                        <div class="h-full rounded-full transition-all" style="width: \${Math.min(canNum2, 100)}%; background: rgb(96,165,250);"></div>
                                    </div>
                                </div>
                                \${parseInt(bgScore) > 0 ? \`<div class="flex-1">
                                    <div class="flex items-center justify-between mb-1">
                                        <span class="text-[11px] text-amber-400/80 font-medium">Bg</span>
                                        <span class="text-[11px] text-amber-400 font-semibold">\${bgScore}</span>
                                    </div>
                                    <div class="h-1 rounded-full" style="background: rgba(255,255,255,0.06);">
                                        <div class="h-full rounded-full transition-all" style="width: \${Math.min(parseInt(bgScore) || 0, 100)}%; background: rgb(251,191,36);"></div>
                                    </div>
                                </div>\` : ''}
                            </div>
                        </div>
                    </div>

                    <!-- 하단: 추천 이유 (Like/Can) -->
                    \${reasonOuterHtml ? \`
                    <div class="px-4 pb-4 pt-0">
                        <div class="p-3 rounded-xl space-y-2" style="background: rgba(99,102,241,0.06); border: 1px solid rgba(99,102,241,0.1);">
                            \${reasonOuterHtml}
                        </div>
                    </div>
                    \` : ''}

                    <!-- 하단 액션 바 -->
                    <div class="flex items-center justify-between px-4 pb-3 \${reasonOuterHtml ? '' : 'pt-0'}">
                        <button onclick="event.stopPropagation(); toggleJobScoresCompact(this)" class="text-[13px] text-wiki-muted hover:text-wiki-primary transition flex items-center gap-1.5" title="상세 점수">
                            <i class="fas fa-chart-bar"></i>
                            <span>상세 점수</span>
                        </button>
                        \${jobSlug ? \`<a href="/job/\${jobSlug}" target="_blank" rel="noopener noreferrer" class="text-[13px] text-wiki-primary hover:text-indigo-300 font-medium transition flex items-center gap-1">
                            <span>상세 보기</span>
                            <i class="fas fa-arrow-right text-[11px]"></i>
                        </a>\` : ''}
                    </div>

                    <!-- 점수 상세 (기본 숨김) -->
                    <div class="score-details-compact hidden px-4 pb-3">
                        <div class="p-3 rounded-lg" style="background-color: rgba(26,26,46,0.5);">
                            \${getScoreExplanation(likeScore, canScore, fitScore, riskPenalty, bgScore)}
                        </div>
                    </div>
                </div>
                \`;
            }).join('');
        }
        
        // 컴팩트 점수 토글
        function toggleJobScoresCompact(btn) {
            const card = btn.closest('.rounded-2xl');
            if (!card) return;
            const details = card.querySelector('.score-details-compact');
            if (details) {
                details.classList.toggle('hidden');
            }
        }
        window.toggleJobScoresCompact = toggleJobScoresCompact;
        
        // (기존 큰 카드용 함수 유지 - 호환성)
        function renderJobCardsV3Large(jobs) {
            if (!jobs || jobs.length === 0) {
                return '<p class="text-wiki-muted text-center py-8">추천 결과가 없습니다.</p>';
            }
            
            return jobs.map((job, idx) => {
                const jobName = job.job_name || job.job_id || '직업';
                const jobSlug = job.slug || job.job_id || '';
                const imageUrl = job.image_url || '';
                const rationale = job.rationale || job.one_line_why || '';
                const description = (job.job_description || job.description || job.summary || '').replace(/\\n\\n/g, ' ').replace(/\\n/g, ' ').trim();
                const growthPath = job.growth_path || job.first30DaysPlan || [];
                const risks = job.risks || [];
                const dislikeWarnings = job.dislike_warnings || [];
                const fitScore = job.scores?.fit || job.fit_score || '-';
                const likeScore = job.scores?.like || job.like_score || '-';
                const canScore = job.scores?.can || job.can_score || '-';
                const riskPenalty = job.riskPenalty || job.risk_penalty || job.scores?.risk_penalty || 0;
                const bgScore = job.feasibility_score || job.feasibilityScore || 0;

                return \`
                <div class="glass-card p-5 rounded-xl group" style="border-left: 4px solid \${idx < 3 ? 'rgba(99,102,241,0.8)' : 'rgba(100,100,120,0.3)'};">
                    <a href="/job/\${jobSlug}" target="_blank" rel="noopener noreferrer" class="block hover:opacity-90 transition">
                        \${imageUrl ? \`
                            <div class="mb-4 overflow-hidden rounded-lg" style="aspect-ratio: 16/9;">
                                <img src="\${imageUrl}" alt="\${jobName}" class="w-full h-full object-cover group-hover:scale-105 transition-transform" />
                            </div>
                        \` : ''}
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex items-center gap-3">
                                <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : '📌'}</span>
                                <div>
                                    <h4 class="font-bold text-lg group-hover:text-wiki-primary transition">\${jobName}</h4>
                                    <span class="text-xs text-wiki-primary">자세히 보기 →</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    \${dislikeWarnings.length > 0 ? \`
                        <div class="p-2 rounded-lg mb-3" style="background-color: rgba(251,146,60,0.15); border: 1px solid rgba(251,146,60,0.3);">
                            <div class="text-xs space-y-1">
                                \${dislikeWarnings.map(w => \`<div class="\${w.severity === 'high' ? 'text-orange-400 font-medium' : 'text-amber-400/80'}">\${w.label}</div>\`).join('')}
                            </div>
                        </div>
                    \` : ''}
                    \${rationale ? \`
                        <div class="mb-3 p-3 rounded-lg" style="background-color: rgba(16,185,129,0.05); border: 1px solid rgba(16,185,129,0.15);">
                            <div class="text-xs font-medium text-emerald-400 mb-1">💡 추천 이유</div>
                            <p class="text-sm text-white/90">\${rationale}</p>
                        </div>
                    \` : ''}
                    \${description ? \`<p class="text-sm text-wiki-muted/80 mb-3 line-clamp-2">\${description}</p>\` : ''}
                    \${growthPath.length > 0 ? \`
                        <div class="p-3 rounded-lg mb-3" style="background-color: rgba(99,102,241,0.1);">
                            <div class="text-xs font-medium text-indigo-400 mb-2">🚀 성장 경로</div>
                            <ol class="text-xs text-wiki-muted space-y-1 list-decimal list-inside">
                                \${growthPath.slice(0, 3).map(p => \`<li>\${p}</li>\`).join('')}
                            </ol>
                        </div>
                    \` : ''}
                    \${risks.length > 0 ? \`
                        <div class="p-2 rounded-lg mb-3" style="background-color: rgba(239,68,68,0.1);">
                            <div class="text-xs text-red-400">\${risks.slice(0, 2).map(r => '⚠️ ' + r).join(' · ')}</div>
                        </div>
                    \` : ''}
                    <div class="flex items-center gap-3 mt-2 flex-wrap">
                        <button onclick="toggleJobScores(this)" class="flex items-center gap-1.5 text-xs text-wiki-muted hover:text-wiki-primary transition">
                            <i class="fas fa-info-circle"></i>
                            <span>상세 점수</span>
                            <i class="fas fa-chevron-down text-[10px] transition-transform score-toggle-icon"></i>
                        </button>
                        <button onclick="showJobEvidence('\${job.job_id || job.slug}', '\${jobName}')" class="flex items-center gap-1.5 text-xs text-wiki-muted hover:text-emerald-400 transition evidence-trigger">
                            <i class="fas fa-search"></i>
                            <span>근거 보기</span>
                        </button>
                    </div>
                    <div class="score-details hidden mt-3 pt-3 border-t border-wiki-border/30">
                        <div class="p-3 rounded-lg" style="background-color: rgba(26,26,46,0.5);">
                            \${getScoreExplanation(likeScore, canScore, fitScore, riskPenalty, bgScore)}
                        </div>
                    </div>
                </div>
                \`;
            }).join('');
        }

        // 직업 카드 렌더링
        function renderJobCards(jobs, setId) {
            if (!jobs || jobs.length === 0) {
                return '<p class="text-wiki-muted text-center py-8">추천 결과가 없습니다.</p>';
            }
            
            return jobs.map((job, idx) => \`
                <div class="glass-card p-5 rounded-xl group" style="border-left: 4px solid \${idx < 3 ? 'rgba(99,102,241,0.8)' : 'rgba(100,100,120,0.3)'};">
                    <!-- 클릭 가능한 상단 영역 -->
                    <a href="/job/\${job.slug || job.job_id}" target="_blank" rel="noopener noreferrer" class="block hover:opacity-90 transition">
                        <!-- 썸네일 이미지 -->
                        \${job.image_url ? \`
                            <div class="mb-4 overflow-hidden rounded-lg">
                                <img src="\${job.image_url}" alt="\${job.job_name}" class="w-full h-40 object-cover group-hover:scale-105 transition-transform" />
                            </div>
                        \` : ''}
                        
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex items-center gap-3">
                                <span class="text-2xl">\${idx === 0 ? '🥇' : idx === 1 ? '🥈' : idx === 2 ? '🥉' : '📌'}</span>
                                <div>
                                    <h4 class="font-bold text-lg group-hover:text-wiki-primary transition">\${job.job_name}</h4>
                                    <span class="text-xs text-wiki-primary">자세히 보기 →</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    
                    <!-- 추천 이유 -->
                    \${job.rationale ? \`
                        <p class="text-sm text-wiki-muted mb-3">\${job.rationale}</p>
                    \` : ''}
                    
                    <!-- 30일 플랜 -->
                    \${job.first30DaysPlan?.length > 0 ? \`
                        <div class="p-3 rounded-lg mb-3" style="background-color: rgba(99,102,241,0.1);">
                            <div class="text-xs font-medium text-indigo-400 mb-2">🚀 30일 실행 플랜</div>
                            <ol class="text-xs text-wiki-muted space-y-1 list-decimal list-inside">
                                \${job.first30DaysPlan.map(p => \`<li>\${p}</li>\`).join('')}
                            </ol>
                        </div>
                    \` : ''}
                    
                    <!-- 상세 점수 토글 버튼 -->
                    <button onclick="toggleJobScores(this)" class="flex items-center gap-1.5 text-xs text-wiki-muted hover:text-wiki-primary transition mt-2">
                        <i class="fas fa-info-circle"></i>
                        <span>상세 점수 보기</span>
                        <i class="fas fa-chevron-down text-[10px] transition-transform score-toggle-icon"></i>
                    </button>
                    
                    <!-- 점수 상세 (기본 숨김) -->
                    <div class="score-details hidden mt-3 pt-3 border-t border-wiki-border/30">
                        <!-- 점수 산출 과정 -->
                        <div class="p-3 rounded-lg mb-3" style="background-color: rgba(26,26,46,0.5);">
                            \${getScoreExplanation(job.desireScore || job.like_score, job.feasibilityScore || job.can_score, job.fitScore || job.fit_score, job.riskPenalty || job.risk_penalty || 0, job.feasibilityScore || job.feasibility_score || 0)}
                        </div>
                        
                        <!-- 리스크 플래그 -->
                        \${job.riskFlags?.length > 0 ? \`
                            <div class="flex flex-wrap gap-1 mb-3">
                                \${job.riskFlags.map(f => \`<span class="px-2 py-0.5 bg-red-500/20 text-red-300 rounded text-xs">⚠️ \${f}</span>\`).join('')}
                            </div>
                        \` : ''}
                        
                        <!-- 근거 인용 -->
                        \${job.evidenceQuotes?.length > 0 ? \`
                            <div class="p-3 rounded-lg" style="background-color: rgba(251,191,36,0.1); border: 1px solid rgba(251,191,36,0.2);">
                                <div class="text-xs font-medium text-amber-400 mb-2">📝 근거 인용</div>
                                <ul class="text-xs text-wiki-muted space-y-1">
                                    \${job.evidenceQuotes.slice(0, 3).map(eq => \`<li>"<em>\${eq.text}</em>"</li>\`).join('')}
                                </ul>
                            </div>
                        \` : ''}
                    </div>
                </div>
            \`).join('');
        }
        
        // 점수 산출 과정 설명 생성
        function getScoreExplanation(likeVal, canVal, fitVal, riskVal, bgVal) {
            const like = parseInt(likeVal) || 0;
            const can = parseInt(canVal) || 0;
            const fit = parseInt(fitVal) || 0;
            const risk = parseFloat(riskVal) || 0;
            const bg = parseInt(bgVal) || 0;
            let html = '<div class="space-y-2.5 text-[13px]">';
            html += '<div class="flex items-center justify-between"><span class="text-purple-400">💜 흥미(Like)</span><span class="text-purple-300 font-medium">' + like + '점</span></div>';
            html += '<div class="flex items-center justify-between"><span class="text-blue-400">💪 역량(Can)</span><span class="text-blue-300 font-medium">' + can + '점</span></div>';
            if (bg > 0) {
                html += '<div class="flex items-center justify-between"><span class="text-amber-400">🎓 배경(Background)</span><span class="text-amber-300 font-medium">' + bg + '점</span></div>';
            }
            if (risk > 0) {
                html += '<div class="flex items-center justify-between"><span class="text-red-400">⚠️ 리스크 감점</span><span class="text-red-300 font-medium">−' + risk + '</span></div>';
            }
            html += '<div class="border-t border-wiki-border/30 pt-2 mt-1 flex items-center justify-between"><span class="text-emerald-400 font-medium">= 적합도(Fit)</span><span class="text-emerald-400 font-bold text-base">' + fit + '점</span></div>';
            html += '</div>';
            return html;
        }

        // 점수 상세 토글
        function toggleJobScores(btn) {
            const card = btn.closest('.glass-card');
            const details = card.querySelector('.score-details');
            const icon = btn.querySelector('.score-toggle-icon');
            const label = btn.querySelector('span');
            
            if (details.classList.contains('hidden')) {
                details.classList.remove('hidden');
                icon.style.transform = 'rotate(180deg)';
                label.textContent = '숨기기';
            } else {
                details.classList.add('hidden');
                icon.style.transform = 'rotate(0deg)';
                label.textContent = '상세 점수';
            }
        }
        window.toggleJobScores = toggleJobScores;
        
        // ============================================
        // Evidence 모달 시스템
        // ============================================
        function showJobEvidence(jobId, jobName) {
            const data = window.currentReportData;
            if (!data || !data.evidenceMap) {
                showErrorToast('근거 데이터를 불러올 수 없습니다.');
                return;
            }
            
            const evidenceLinks = data.evidenceMap[jobId] || [];
            
            // 모달 생성
            const modal = document.createElement('div');
            modal.id = 'evidence-modal';
            modal.className = 'fixed inset-0 z-50 flex items-center justify-center p-4';
            modal.style.cssText = 'background-color: rgba(0,0,0,0.7); backdrop-filter: blur(4px);';
            modal.onclick = (e) => { if (e.target === modal) closeEvidenceModal(); };
            
            // 매칭 타입별 보더 색상
            const borderColors = {
                positive: 'rgba(16,185,129,0.6)',
                neutral: 'rgba(148,163,184,0.4)',
                negative: 'rgba(239,68,68,0.5)',
            };
            
            // 출처 라벨 매핑
            const sourceLabels = {
                'step1': '1단계: 기본정보',
                'step2': '2단계: 선호도',
                'step3': '3단계: 방향설정',
                'narrative': '서술형 질문',
                'round1': '심층질문 Round 1',
                'round2': '심층질문 Round 2',
                'round3': '심층질문 Round 3',
                'mini_module': '나를 알아가기',
            };
            
            modal.innerHTML = \`
                <div class="relative max-w-2xl w-full max-h-[85vh] overflow-y-auto rounded-2xl p-6" 
                     style="background: linear-gradient(135deg, rgba(26,26,46,0.98), rgba(15,15,35,0.98)); border: 1px solid rgba(99,102,241,0.3);">
                    <!-- 닫기 버튼 -->
                    <button onclick="closeEvidenceModal()" class="absolute top-4 right-4 w-8 h-8 rounded-full flex items-center justify-center transition hover:bg-white/10" style="color: rgb(148,163,184);">
                        <i class="fas fa-times"></i>
                    </button>
                    
                    <!-- 헤더 -->
                    <div class="mb-6">
                        <h3 class="text-xl font-bold text-white flex items-center gap-2">
                            <i class="fas fa-quote-left text-emerald-400"></i>
                            <span>\${jobName} 추천 근거</span>
                        </h3>
                        <p class="text-sm text-wiki-muted mt-1">아래 내용을 바탕으로 이 직업이 추천되었습니다</p>
                    </div>
                    
                    <!-- Evidence 목록 (인용 스타일) -->
                    \${evidenceLinks.length > 0 ? \`
                        <div class="space-y-3">
                            \${evidenceLinks.map((ev, idx) => {
                                const borderColor = borderColors[ev.match_type] || borderColors.neutral;
                                const sourceKey = ev.user_fact?.source?.split('.')[0] || 'unknown';
                                const sourceLabel = sourceLabels[sourceKey] || ev.user_fact?.source || '사용자 입력';
                                
                                return \`
                                    <div class="pl-4 py-2" style="border-left: 3px solid \${borderColor};">
                                        <!-- 인용문 (사용자 답변) -->
                                        <p class="text-sm text-white/90 italic mb-1">
                                            "\${ev.user_fact?.label || ev.user_fact?.value || '(데이터 없음)'}"
                                        </p>
                                        
                                        <!-- 출처 -->
                                        <div class="flex items-center gap-2 text-xs text-wiki-muted">
                                            <i class="fas fa-bookmark"></i>
                                            <span>출처: \${sourceLabel}</span>
                                        </div>
                                        
                                        <!-- 매칭 설명 (있으면) -->
                                        \${ev.explanation ? \`
                                            <div class="mt-2 p-2 rounded-lg" style="background-color: rgba(99,102,241,0.08);">
                                                <p class="text-xs text-indigo-300/80">
                                                    <i class="fas fa-link mr-1"></i>
                                                    \${ev.explanation}
                                                </p>
                                            </div>
                                        \` : ''}
                                        
                                        <!-- 직업 특성 매칭 -->
                                        \${ev.job_attribute?.label ? \`
                                            <div class="mt-1 text-xs text-wiki-muted/70">
                                                → 직업 특성: \${ev.job_attribute.label}
                                            </div>
                                        \` : ''}
                                    </div>
                                \`;
                            }).join('')}
                        </div>
                    \` : \`
                        <div class="text-center py-12">
                            <i class="fas fa-quote-left text-4xl text-wiki-muted/30 mb-4"></i>
                            <p class="text-wiki-muted">아직 구체적인 근거 데이터가 없습니다.</p>
                            <p class="text-sm text-wiki-muted/60 mt-2">심층 질문에 더 자세히 답변하시면 근거가 추가됩니다.</p>
                        </div>
                    \`}
                    
                    <!-- 닫기 버튼 -->
                    <div class="mt-6 pt-4 border-t border-wiki-border/30 text-center">
                        <button onclick="closeEvidenceModal()" class="px-6 py-2 rounded-lg text-sm font-medium transition" 
                                style="background: rgba(99,102,241,0.2); color: rgb(165,180,252); border: 1px solid rgba(99,102,241,0.3);">
                            닫기
                        </button>
                    </div>
                </div>
            \`;
            
            document.body.appendChild(modal);
            document.body.style.overflow = 'hidden';
        }
        window.showJobEvidence = showJobEvidence;
        
        function closeEvidenceModal() {
            const modal = document.getElementById('evidence-modal');
            if (modal) {
                modal.remove();
                document.body.style.overflow = '';
            }
        }
        window.closeEvidenceModal = closeEvidenceModal;
        
        // Work Style 바 렌더링
        function renderWorkStyleBar(leftLabel, rightLabel, value) {
            const normalizedValue = ((value || 0) + 100) / 2; // -100~100 → 0~100
            return \`
                <div class="flex items-center gap-2 text-xs">
                    <span class="w-16 text-right text-wiki-muted">\${leftLabel}</span>
                    <div class="flex-1 h-2 bg-wiki-border rounded-full overflow-hidden">
                        <div class="h-full bg-gradient-to-r from-wiki-primary to-wiki-secondary transition-all" style="width: \${normalizedValue}%"></div>
                    </div>
                    <span class="w-16 text-wiki-muted">\${rightLabel}</span>
                </div>
            \`;
        }
        
        // 전환 일정 렌더링
        function renderTransitionDay(day, data) {
            if (!data) return '';
            const colors = { 30: 'emerald', 60: 'blue', 90: 'purple' };
            const color = colors[day] || 'gray';
            
            return \`
                <div class="p-4 rounded-xl" style="background: linear-gradient(135deg, rgba(var(--\${color}-rgb, 16,185,129), 0.1), transparent); border: 1px solid rgba(var(--\${color}-rgb, 16,185,129), 0.2);">
                    <div class="flex items-center gap-3 mb-3">
                        <div class="w-10 h-10 rounded-full bg-\${color}-500/20 flex items-center justify-center text-\${color}-400 font-bold">\${day}</div>
                        <div>
                            <div class="font-bold">Day \${day}</div>
                            <div class="text-sm text-wiki-muted">\${data.goal}</div>
                        </div>
                    </div>
                    <ul class="text-sm space-y-1 mb-3">
                        \${(data.actions || []).map(a => \`<li>• \${a}</li>\`).join('')}
                    </ul>
                    <div class="text-xs text-wiki-muted">📍 마일스톤: \${data.milestone}</div>
                </div>
            \`;
        }
        
        // 리포트 스타일 추가
        function addReportStyles() {
            if (document.getElementById('report-v3-styles')) return;
            
            const style = document.createElement('style');
            style.id = 'report-v3-styles';
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
                .job-set-tab {
                    background: linear-gradient(135deg, rgba(26,26,46,0.7), rgba(42,42,62,0.5));
                    color: rgb(148,163,184);
                    border: 1px solid rgba(148,163,184,0.15);
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                }
                .job-set-tab:hover {
                    background: linear-gradient(135deg, rgba(42,42,62,0.8), rgba(62,62,82,0.6));
                    color: rgb(200,210,220);
                    border-color: rgba(148,163,184,0.3);
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                }
                .job-set-tab.active {
                    background: linear-gradient(135deg, rgba(99,102,241,0.4), rgba(168,85,247,0.25));
                    color: white;
                    border: 1px solid rgba(99,102,241,0.5);
                    box-shadow: 0 4px 16px rgba(99,102,241,0.25);
                }
            \`;
            document.head.appendChild(style);
        }
        
        function displayConfidenceUI(result) {
            const card = document.getElementById('confidence-card');
            if (!card) return;
            
            // confidence_score 계산 (서버에서 안 왔으면 클라이언트에서 추정)
            let confidenceScore = result.confidence_score;
            if (confidenceScore === undefined) {
                // 클라이언트에서 간단히 추정: 응답한 질문 수 기반
                const answeredCount = Object.keys(universalAnswers).length + 
                                     Object.keys(transitionSignalAnswers).length + 
                                     Object.keys(followupAnswers).length;
                confidenceScore = Math.min(0.4 + (answeredCount * 0.06), 0.95);
            }
            
            const percentage = Math.round(confidenceScore * 100);
            
            // 게이지바 업데이트
            document.getElementById('confidence-score-text').textContent = percentage + '%';
            document.getElementById('confidence-bar').style.width = percentage + '%';
            
            // 설명 텍스트
            let description = '';
            if (percentage >= 80) {
                description = '충분한 정보를 바탕으로 신뢰도 높은 추천이에요.';
            } else if (percentage >= 60) {
                description = '기본적인 추천은 가능하지만, 더 많은 정보가 있으면 정확도가 올라가요.';
            } else {
                description = '제한된 정보로 추천했어요. 추가 질문에 답변하시면 더 정확해져요.';
            }
            document.getElementById('confidence-description').textContent = description;
            
            // 결정 변수 표시
            const keyDecisions = result.key_decision_variables || generateKeyDecisions();
            const decisionsHtml = keyDecisions.map(kd => \`
                <div class="flex items-start gap-3 p-2 bg-wiki-bg/50 rounded-lg">
                    <span class="text-amber-400">•</span>
                    <div class="flex-1">
                        <span class="text-sm">\${kd.label || kd.fact_key || kd}</span>
                        \${kd.impact ? \`<span class="text-xs text-wiki-muted ml-2">(영향도: \${kd.impact})</span>\` : ''}
                    </div>
                </div>
            \`).join('');
            document.getElementById('key-decisions').innerHTML = decisionsHtml || '<p class="text-wiki-muted text-sm">결정 변수 정보가 없습니다.</p>';
            
            card.classList.remove('hidden');
        }
        
        function generateKeyDecisions() {
            // 클라이언트에서 응답 기반으로 결정 변수 생성
            const decisions = [];
            
            // 5축 상태에서
            if (careerState.role_identity) {
                const opt = ROLE_IDENTITY_OPTIONS.find(o => o.value === careerState.role_identity);
                decisions.push({ label: '현재 상태: ' + (opt?.label || careerState.role_identity), fact_key: 'state.role_identity' });
            }
            if (careerState.transition_status && careerState.transition_status !== 'none') {
                const opt = TRANSITION_STATUS_OPTIONS.find(o => o.value === careerState.transition_status);
                decisions.push({ label: '전환 상태: ' + (opt?.label || careerState.transition_status), fact_key: 'state.transition_status' });
            }
            
            // Universal 답변에서
            if (universalAnswers.univ_interest?.length > 0) {
                decisions.push({ label: '관심 분야: ' + universalAnswers.univ_interest.slice(0, 3).join(', '), fact_key: 'profile.interest' });
            }
            if (universalAnswers.univ_priority) {
                decisions.push({ label: '우선순위: ' + universalAnswers.univ_priority, fact_key: 'priority.top1' });
            }
            
            // 전이 신호에서
            if (transitionSignalAnswers.trans_desired_type?.length > 0) {
                decisions.push({ label: '원하는 변화: ' + transitionSignalAnswers.trans_desired_type.slice(0, 2).join(', '), fact_key: 'transition.desired_type' });
            }
            if (transitionSignalAnswers.trans_motivation) {
                decisions.push({ label: '변화 동기: ' + transitionSignalAnswers.trans_motivation, fact_key: 'transition.motivation_primary' });
            }
            
            return decisions.slice(0, 5);
        }
        
        function displayUserInsight(insight) {
            const card = document.getElementById('user-insight-card');
            if (!insight || !insight.summary) {
                card.classList.add('hidden');
                return;
            }
            
            card.classList.remove('hidden');
            document.getElementById('insight-summary').textContent = insight.summary;
            
            const traitsHtml = (insight.key_traits || []).map(t => \`
                <div class="flex items-start gap-3 p-3 bg-purple-500/10 rounded-lg">
                    <span class="text-xl">💡</span>
                    <div>
                        <div class="font-semibold text-purple-300">\${t.trait}</div>
                        <div class="text-sm text-wiki-muted">\${t.evidence}</div>
                        <div class="text-xs text-green-400 mt-1">→ \${t.score_impact}</div>
                    </div>
                </div>
            \`).join('');
            document.getElementById('insight-traits').innerHTML = traitsHtml;
            
            if (insight.applied_facts?.length > 0) {
                document.getElementById('insight-applied-facts').classList.remove('hidden');
                document.getElementById('insight-facts-list').textContent = 
                    insight.applied_facts.map(f => f.effect_summary).join(', ');
            }
        }
        
        function updateDebugPanel(result, data) {
            const debugInfo = result.debug_info;
            
            // 1. Candidate Source
            const sourceEl = document.getElementById('debug-candidate-source');
            if (sourceEl) {
                if (debugInfo) {
                    const sourceLabel = {
                        'tagged': '🏷️ tagged (DB)',
                        'sample_fallback': '⚠️ sample_fallback',
                        'vector': '🔍 vector',
                        'random': '🎲 random'
                    }[debugInfo.candidate_source] || debugInfo.candidate_source;
                    sourceEl.innerHTML = \`
                        <span class="text-yellow-400">\${sourceLabel}</span> | 
                        Stage: <span class="text-blue-400">\${selectedStage || '-'}</span> | 
                        Tagged: <span class="text-green-400">\${debugInfo.tagged_count}</span> / 
                        Total: <span class="text-white">\${debugInfo.total_in_db}</span>
                    \`;
                } else {
                    sourceEl.textContent = \`Stage: \${selectedStage || '-'}, Candidates: \${result.total_candidates || 0}\`;
                }
            }
            
            // 2. 점수 분해 (TOP3)
            const scoreEl = document.getElementById('debug-score-breakdown');
            if (scoreEl) {
                if (debugInfo?.score_breakdown) {
                    scoreEl.innerHTML = debugInfo.score_breakdown.map((s, i) => \`
                        <div class="mb-2 pb-2 \${i < 2 ? 'border-b border-slate-700' : ''}">
                            <div class="flex justify-between">
                                <span class="text-yellow-300">\${i+1}. \${s.job_name}</span>
                                <span class="text-green-400">Fit: \${s.final_fit}</span>
                            </div>
                            <div class="text-slate-400 text-xs">
                                Base: L\${s.base_like}/C\${s.base_can}/R\${s.base_risk} → 
                                Final: L\${s.final_like}/C\${s.final_can}/R\${s.final_risk}
                            </div>
                            \${s.like_boosts.length > 0 ? \`<div class="text-green-300 text-xs">Like ↑: \${s.like_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                            \${s.can_boosts.length > 0 ? \`<div class="text-blue-300 text-xs">Can ↑: \${s.can_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                            \${s.risk_boosts.length > 0 ? \`<div class="text-red-300 text-xs">Risk ↑: \${s.risk_boosts.map(b => b.rule).join(', ')}</div>\` : ''}
                        </div>
                    \`).join('');
                } else {
                    const top1 = result.fit_top3?.[0];
                    if (top1) {
                        scoreEl.innerHTML = \`Like: \${top1.like_score}, Can: \${top1.can_score}, Fit: \${top1.fit_score}\`;
                    }
                }
            }
            
            // 3. Follow-up 근거
            const followupEl = document.getElementById('debug-followup-rationale');
            if (followupEl) {
                if (debugInfo?.followup_rationale) {
                    const fr = debugInfo.followup_rationale;
                    followupEl.innerHTML = \`
                        <span class="text-purple-400">Split Attr:</span> \${fr.split_attribute} | 
                        <span class="text-yellow-400">Gain:</span> \${fr.split_gain.toFixed(2)} | 
                        <span class="text-slate-400">\${fr.reason}</span>
                    \`;
                } else if (result.followup_questions?.[0]) {
                    const fq = result.followup_questions[0];
                    followupEl.innerHTML = \`질문: "\${fq.question.slice(0, 40)}..." → \${fq.fact_key}\`;
                } else {
                    followupEl.textContent = '추가 질문 없음';
                }
            }
            
            // 4. Rank Change
            const rankEl = document.getElementById('debug-rank-change');
            if (rankEl) {
                if (debugInfo?.rank_changes) {
                    const rc = debugInfo.rank_changes;
                    rankEl.innerHTML = \`
                        <div class="text-slate-400">Before: \${rc.before.join(' → ')}</div>
                        <div class="text-green-400">After: \${rc.after.join(' → ')}</div>
                        <div class="text-yellow-400">Changes: \${rc.changes.join(', ') || '없음'}</div>
                    \`;
                } else if (previousTop3.length > 0) {
                    const currentTop3 = (result.fit_top3 || []).map(j => j.job_name);
                    rankEl.innerHTML = \`
                        <div class="text-slate-400">Before: \${previousTop3.join(' → ')}</div>
                        <div class="text-green-400">After: \${currentTop3.join(' → ')}</div>
                    \`;
                } else {
                    rankEl.textContent = '첫 분석 (비교 대상 없음)';
                }
            }
            
            // 5. Applied Facts & Rules
            const factsEl = document.getElementById('debug-applied-facts');
            if (factsEl) {
                if (debugInfo?.applied_facts) {
                    factsEl.innerHTML = debugInfo.applied_facts.map(f => \`
                        <div class="py-1 border-b border-slate-700/50">
                            <span class="text-blue-300">\${f.fact_key}</span>: 
                            <span class="text-white">\${f.value}</span>
                            <span class="text-slate-500">(\${f.effect})</span>
                        </div>
                    \`).join('');
                } else {
                    factsEl.innerHTML = \`Facts: \${result.input_summary?.facts_applied || 0}개, Rules: \${(result.input_summary?.applied_rules || []).join(', ') || '없음'}\`;
                }
            }
            
            // 6. 버전 정보
            const versionsEl = document.getElementById('debug-versions');
            if (versionsEl) {
                const v = debugInfo?.versions || result.versions || {};
                versionsEl.innerHTML = \`
                    <span class="text-slate-400">recipe:</span> \${v.recipe || '-'} | 
                    <span class="text-slate-400">tagger:</span> \${v.tagger || '-'} | 
                    <span class="text-slate-400">scoring:</span> \${v.scoring || '-'} | 
                    <span class="text-slate-400">embedding:</span> \${v.embedding || 'none'}
                \`;
            }
            
            // Phase4 상태
            const phase4El = document.getElementById('debug-phase4-status');
            if (phase4El) {
                const diversityApplied = debugInfo?.diversity_guard_triggered || result.diversity_guard_active;
                const biasCapApplied = debugInfo?.research_bias_cap_applied || false;
                phase4El.innerHTML = \`
                    <span class="\${diversityApplied ? 'text-green-400' : 'text-slate-500'}">
                        Diversity Guard: \${diversityApplied ? '✓ 적용됨' : '✗ 미적용'}
                    </span> | 
                    <span class="\${biasCapApplied ? 'text-yellow-400' : 'text-slate-500'}">
                        Research Bias Cap: \${biasCapApplied ? '✓ 적용됨' : '✗ 미적용'}
                    </span>
                    \${result.diversity_changes?.length > 0 ? \`<div class="text-xs text-yellow-300 mt-1">변경: \${result.diversity_changes.join(', ')}</div>\` : ''}
                \`;
            }
        }
        
        function displayResultFollowup(question) {
            const section = document.getElementById('result-followup-section');
            section.classList.remove('hidden');
            document.getElementById('result-followup-question').textContent = question.question;
            
            document.getElementById('result-followup-options').innerHTML = (question.options || []).map(opt => \`
                <button onclick="submitResultFollowup('\${question.id}', '\${question.fact_key}', '\${opt.value}')"
                        class="px-4 py-2 bg-wiki-primary hover:bg-blue-600 text-white rounded-lg transition">
                    \${opt.label}
                </button>
            \`).join('');
        }
        
        async function submitResultFollowup(qId, factKey, answer) {
            try {
                await fetch('/api/ai-analyzer/followup', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        question_id: qId,
                        fact_key: factKey,
                        answer: answer,
                    })
                });
                
                const response = await fetch('/api/ai-analyzer/analyze', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        session_id: currentSessionId,
                        analysis_type: selectedAnalysisType,
                        stage: selectedStage,
                        universal_answers: universalAnswers,
                        debug: DEBUG_MODE,
                    })
                });
                
                const data = await response.json();
                displayResults(data);
            } catch (error) {
            }
        }
        
        function toggleDebugPanel() {
            const panel = document.getElementById('debug-panel-content');
            if (panel) panel.classList.toggle('hidden');
        }
        
        function resetAnalysis() {
            universalAnswers = {};
            followupAnswers = {};
            currentSessionId = null;
            currentRequestId = null;
            previousTop3 = [];
            selectedStage = null;
            goToStep(0);
        }
        
        // 자동 저장 기능
        // 변경사항 추적 플래그
        window.analyzerUnsavedChanges = false;
        
        // 세션 자동 연장 (30분마다 활동 감지 시)
        let lastActivityTime = Date.now();
        let sessionExtendInterval = null;
        
        function trackActivity() {
            lastActivityTime = Date.now();
        }
        
        async function extendSessionIfNeeded() {
            // 5분 이내에 활동이 있었으면 세션 연장
            if (Date.now() - lastActivityTime < 5 * 60 * 1000) {
                try {
                    await fetch('/auth/refresh', { 
                        method: 'POST', 
                        credentials: 'same-origin' 
                    });
                } catch (e) {
                }
            }
        }
        
        // 활동 감지 이벤트 (클릭, 키입력, 스크롤)
        ['click', 'keydown', 'scroll', 'touchstart'].forEach(event => {
            document.addEventListener(event, trackActivity, { passive: true });
        });
        
        // 30분마다 세션 연장 체크
        sessionExtendInterval = setInterval(extendSessionIfNeeded, 30 * 60 * 1000);
        
        function autoSaveDraft() {
            const draft = {
                currentStep: window.currentStep,
                currentRound: window.currentRound,
                collectedCareerState: window.collectedCareerState || {},
                universalAnswers: window.universalAnswers || {},
                narrativeAnswers: window.narrativeAnswers || {},
                roundAnswers: window.roundAnswers || {},
                selectedStage: selectedStage,
                timestamp: Date.now()
            };
            try {
                localStorage.setItem('analyzer_draft', JSON.stringify(draft));
                localStorage.setItem('analyzer_draft_timestamp', Date.now().toString());
                window.analyzerUnsavedChanges = true; // 로컬에만 저장된 상태
            } catch (e) {
            }
        }
        
        // 서버에 자동 저장 (백그라운드, UI 업데이트 없음)
        async function saveDraftToServer() {
            try {
                // 로컬 스토리지 먼저 저장
                autoSaveDraft();
                
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
                    const currentQuestions = typeof getNarrativeQuestions === 'function' ? getNarrativeQuestions() : null;
                    window.narrativeFacts = {
                        storyAnswer: narrativeQ0?.value || '',
                        life_story: narrativeQ0?.value || '',
                        question1Answer: narrativeQ1?.value || '',
                        question2Answer: narrativeQ2?.value || '',
                        highAliveMoment: narrativeQ1?.value || '',
                        lostMoment: narrativeQ2?.value || '',
                        career_background: narrativeCareerBg?.value || window.resumeCareerBackground || '',  // 전공/직무 정보 추가
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
                
                // career_background 현재 값 수집 (이력서 또는 수동 입력)
                const careerBgInput = document.getElementById('narrative_career_bg');
                const currentCareerBackground = careerBgInput?.value || window.resumeCareerBackground || '';
                
                const draftData = {
                    session_id: currentSessionId,
                    analysis_type: '${c.req.path.includes('/major') ? 'major' : 'job'}',
                    current_step: window.currentStep || currentStep || 1,
                    profile_sub_step: profileSubStep || 1,  // 프로필 서브스텝 (1: 5축, 2: 나를 알아가기)
                    current_round: window.currentRound || 0,  // 심층 질문 라운드
                    career_state: careerState || {},
                    step1_answers: { 
                        stage: selectedStage,
                        careerState: careerState || {},
                        profileSubStep: profileSubStep || 1,  // 복원용
                        currentRound: window.currentRound || 0,  // 심층 질문 라운드 복원용
                        resumeUploaded: window.resumeUploaded || false,  // 이력서 업로드 여부
                        resumeCareerBackground: window.resumeCareerBackground || ''  // 이력서에서 추출한 배경
                    },
                    mini_module_result: window.miniModuleResult || null,
                    mini_module_selections: miniModuleSelections || null,
                    step2_answers: currentUniversalAnswers,
                    step3_answers: currentTransitionAnswers,
                    step4_answers: step4Data,
                    career_background: currentCareerBackground  // 전공/직무 정보 (최상위에도 저장)
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
        
        // 수동 임시저장 함수 (버튼 클릭)
        async function saveDraftNow() {
            const saveBtn = event?.target?.closest('button');
            const originalHtml = saveBtn ? saveBtn.innerHTML : '';
            
            // 버튼 상태 변경
            if (saveBtn) {
                saveBtn.disabled = true;
                saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>저장 중...';
            }
            
            try {
                // 로컬 스토리지 저장
                autoSaveDraft();
                
                // 세션 ID 확보 (없으면 생성)
                if (!currentSessionId) {
                    currentSessionId = 'session-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                }
                
                // 최신 답변 수집
                const currentUniversalAnswers = typeof collectUniversalAnswers === 'function' 
                    ? collectUniversalAnswers() 
                    : (universalAnswers || {});
                const currentTransitionAnswers = transitionSignalAnswers || {};
                
                // 서술형 심층 질문 현재 값 수집 (textarea에서 직접)
                const narrativeQ0 = document.getElementById('narrative_q0');
                const narrativeQ1 = document.getElementById('narrative_q1');
                const narrativeQ2 = document.getElementById('narrative_q2');
                const narrativeCareerBg = document.getElementById('narrative_career_bg');
                if (narrativeQ0 || narrativeQ1 || narrativeQ2) {
                    const currentQuestions = typeof getNarrativeQuestions === 'function' ? getNarrativeQuestions() : null;
                    window.narrativeFacts = {
                        // 스토리 질문 (공통)
                        storyAnswer: narrativeQ0?.value || '',
                        life_story: narrativeQ0?.value || '',
                        // 동적 질문 1, 2
                        question1Answer: narrativeQ1?.value || '',
                        question2Answer: narrativeQ2?.value || '',
                        highAliveMoment: narrativeQ1?.value || '',
                        lostMoment: narrativeQ2?.value || '',
                        // 전공/직무 정보 추가
                        career_background: narrativeCareerBg?.value || window.resumeCareerBackground || '',
                    };
                    // 질문 자체도 저장 (복원 시 동일한 질문 사용)
                    if (currentQuestions) {
                        window.savedNarrativeQuestions = currentQuestions;
                    }
                }
                
                // 서버에도 저장 (API 호출)
                // step4_answers에 모든 심층 질문 관련 데이터 통합 (DB 스키마 변경 없이)
                const step4Data = {
                    round_answers: window.roundAnswers || [],
                    narrative_facts: window.narrativeFacts || null,
                    narrative_questions: window.savedNarrativeQuestions || null,
                    round_questions: window.roundQuestions || null,
                    current_round: window.currentRound || 0
                };
                
                // career_background 현재 값 수집 (이력서 또는 수동 입력)
                const careerBgInput = document.getElementById('narrative_career_bg');
                const currentCareerBackground = careerBgInput?.value || window.resumeCareerBackground || '';
                
                const draftData = {
                    session_id: currentSessionId,
                    analysis_type: '${c.req.path.includes('/major') ? 'major' : 'job'}',
                    current_step: window.currentStep || currentStep || 1,
                    profile_sub_step: profileSubStep || 1,  // 프로필 서브스텝
                    current_round: window.currentRound || 0,  // 심층 질문 라운드
                    career_state: careerState || {},  // 로컬 careerState 사용
                    step1_answers: { 
                        stage: selectedStage,
                        careerState: careerState || {},  // 5축 좌표도 저장
                        profileSubStep: profileSubStep || 1,  // 복원용
                        currentRound: window.currentRound || 0,  // 심층 질문 라운드 복원용
                        resumeUploaded: window.resumeUploaded || false,  // 이력서 업로드 여부
                        resumeCareerBackground: window.resumeCareerBackground || ''  // 이력서에서 추출한 배경
                    },
                    mini_module_result: window.miniModuleResult || null,  // 미니모듈 결과
                    step2_answers: currentUniversalAnswers,
                    step3_answers: currentTransitionAnswers,
                    step4_answers: step4Data,  // 통합 데이터
                    career_background: currentCareerBackground  // 전공/직무 정보 (최상위에도 저장)
                };
                
                
                const response = await fetch('/api/ai-analyzer/draft/save', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'same-origin',
                    body: JSON.stringify(draftData)
                });
                
                const responseData = await response.json().catch(() => ({}));
                
                if (response.ok) {
                    window.analyzerUnsavedChanges = false; // 서버에 저장됨
                    
                    // 성공 피드백 - 저장됨 상태 유지 (내용 변경 전까지)
                    if (saveBtn) {
                        saveBtn.innerHTML = '<i class="fas fa-check mr-2 text-emerald-400"></i>저장됨';
                        saveBtn.disabled = false;
                        saveBtn.dataset.saved = 'true';
                    }
                } else {
                    throw new Error('Server save failed: ' + (responseData.error || response.status));
                }
            } catch (error) {
                // 로컬에는 저장되었으므로 경고만 표시
                if (saveBtn) {
                    saveBtn.innerHTML = '<i class="fas fa-exclamation-triangle mr-2 text-amber-400"></i>오프라인 저장됨';
                    saveBtn.disabled = false;
                    saveBtn.dataset.saved = 'true'; // 오프라인 저장도 저장됨 상태로
                }
            }
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
        
        // 자동 복원 기능 (모달 사용)
        let pendingDraft = null;
        let pendingServerDraft = null;
        
        async function autoRestoreDraft() {
            try {
                // 1. 서버에서 진행중인 draft 확인 (캐시 방지!)
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
                
                if (serverResponse.ok && serverData.found && serverData.draft && serverData.draft.analysis_type !== 'major') {
                    const serverDraft = serverData.draft;
                    pendingServerDraft = serverDraft;

                    // 서버에 저장된 데이터가 있으면 모달 표시
                    const stepNames = ['', '상태 선택', '기본 정보', '앞으로의 방향', '심층 질문', '결과'];
                    const savedDate = new Date(serverDraft.updated_at);
                    const dateStr = savedDate.toLocaleDateString('ko-KR') + ' ' + 
                                   savedDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    
                    document.getElementById('continue-modal-info').innerHTML = 
                        '<strong class="text-white">' + stepNames[serverDraft.current_step] + '</strong>까지 진행됨<br>' +
                        '<span class="text-xs">마지막 작업: ' + dateStr + '</span>';
                    
                    document.getElementById('continue-modal').classList.remove('hidden');
                    return 'modal';
                }
                
                // 서버에 draft가 없으면 로컬 스토리지도 정리 (서버가 source of truth)
                // 이전에 유저 메뉴에서 삭제했거나, 다른 기기에서 삭제한 경우
                if (serverResponse.ok && !serverData.found) {
                    localStorage.removeItem('analyzer_draft');
                    localStorage.removeItem('analyzer_draft_timestamp');
                    return false;
                }
                
                // 2. 로컬 스토리지에서 확인 (서버 오류 시 폴백)
                const draftStr = localStorage.getItem('analyzer_draft');
                const timestamp = localStorage.getItem('analyzer_draft_timestamp');
                
                if (!draftStr) return false;
                
                // 24시간 이내의 드래프트만 복원
                const savedTime = parseInt(timestamp, 10);
                if (Date.now() - savedTime > 24 * 60 * 60 * 1000) {
                    localStorage.removeItem('analyzer_draft');
                    localStorage.removeItem('analyzer_draft_timestamp');
                    return false;
                }
                
                const draft = JSON.parse(draftStr);
                pendingDraft = draft;
                
                
                // 로컬에 저장된 데이터가 있으면 모달 표시 (step 1이어도)
                if (draft.currentStep >= 1) {
                    const stepNames = ['', '상태 선택', '기본 정보', '앞으로의 방향', '심층 질문', '결과'];
                    const savedDate = new Date(savedTime);
                    const dateStr = savedDate.toLocaleDateString('ko-KR') + ' ' + 
                                   savedDate.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    
                    document.getElementById('continue-modal-info').innerHTML = 
                        '<strong class="text-white">' + stepNames[draft.currentStep] + '</strong>까지 진행됨<br>' +
                        '<span class="text-xs">마지막 작업: ' + dateStr + '</span>';
                    
                    document.getElementById('continue-modal').classList.remove('hidden');
                    return 'modal'; // 모달 표시 중
                }
                
                return false;
            } catch (e) {
                return false;
            }
        }
        
        // 이어서 하기
        function continueFromDraft() {
            // 서버 draft 우선
            if (pendingServerDraft) {
                const draft = pendingServerDraft;
                currentSessionId = draft.session_id;
                
                // 5축 좌표 복원
                const savedCareerState = draft.step1_answers?.careerState || draft.career_state;
                if (savedCareerState && Object.keys(savedCareerState).length > 0) {
                    Object.assign(careerState, savedCareerState);
                }
                
                // 답변들 복원
                if (draft.step2_answers) {
                    window.universalAnswers = draft.step2_answers;
                    universalAnswers = draft.step2_answers;
                }
                if (draft.step3_answers) {
                    window.narrativeAnswers = draft.step3_answers;
                    transitionSignalAnswers = draft.step3_answers;
                }
                // step4_answers 통합 구조에서 개별 필드 추출
                if (draft.step4_answers && typeof draft.step4_answers === 'object') {
                    const step4Data = draft.step4_answers;
                    window.roundAnswers = Array.isArray(step4Data.round_answers) ? step4Data.round_answers : [];
                    if (step4Data.narrative_facts) window.narrativeFacts = step4Data.narrative_facts;
                    if (step4Data.narrative_questions) window.savedNarrativeQuestions = step4Data.narrative_questions;
                    if (step4Data.round_questions) window.roundQuestions = step4Data.round_questions;
                    if (step4Data.current_round > 0) window.currentRound = step4Data.current_round;
                }
                if (draft.step1_answers?.stage) {
                    selectedStage = draft.step1_answers.stage;
                }

                document.getElementById('continue-modal').classList.add('hidden');

                // mini_module_result 복원
                if (draft.mini_module_result) {
                    window.miniModuleResult = draft.mini_module_result;
                }
                
                // UI 복원 후 해당 step으로 이동
                setTimeout(() => {
                    updateStep1Selection();
                    if (draft.current_step >= 2) {
                        renderUniversalQuestions();
                        setTimeout(() => updateStep2Selection(), 100);
                    }
                    if (draft.current_step >= 3) {
                        renderTransitionSignalForm();
                    }
                    // Step 4 (심층 질문) 복원 추가!
                    if (draft.current_step >= 4) {
                        // 심층 질문 UI 렌더링
                        const currentRound = draft.current_round || 1;
                        
                        // 라운드 질문 가져오기 시작
                        setTimeout(() => {
                            if (typeof startV3RoundQuestions === 'function') {
                                startV3RoundQuestions(currentRound);
                            }
                        }, 300);
                    }
                }, 200);
                
                goToStep(draft.current_step, true);
                pendingServerDraft = null;
                return;
            }
            
            // 로컬 draft
            if (!pendingDraft) return;
            
            // 상태 복원
            if (pendingDraft.collectedCareerState) {
                Object.assign(careerState, pendingDraft.collectedCareerState);
                window.collectedCareerState = pendingDraft.collectedCareerState;
            }
            if (pendingDraft.universalAnswers) {
                window.universalAnswers = pendingDraft.universalAnswers;
                universalAnswers = pendingDraft.universalAnswers;
            }
            if (pendingDraft.narrativeAnswers) {
                window.narrativeAnswers = pendingDraft.narrativeAnswers;
                transitionSignalAnswers = pendingDraft.narrativeAnswers;
            }
            if (pendingDraft.roundAnswers) {
                window.roundAnswers = pendingDraft.roundAnswers;
            }
            if (pendingDraft.selectedStage) {
                selectedStage = pendingDraft.selectedStage;
            }
            if (pendingDraft.currentRound) {
                window.currentRound = pendingDraft.currentRound;
            }
            
            document.getElementById('continue-modal').classList.add('hidden');
            
            // mini_module_result 복원 (로컬)
            if (pendingDraft.miniModuleResult) {
                window.miniModuleResult = pendingDraft.miniModuleResult;
            }
            
            // UI 복원
            setTimeout(() => {
                updateStep1Selection();
                if (pendingDraft.currentStep >= 2) {
                    renderUniversalQuestions();
                    setTimeout(() => updateStep2Selection(), 100);
                }
                if (pendingDraft.currentStep >= 3) {
                    renderTransitionSignalForm();
                }
                // Step 4 (심층 질문) 복원 추가!
                if (pendingDraft.currentStep >= 4) {
                    const currentRound = pendingDraft.currentRound || 1;
                    
                    setTimeout(() => {
                        if (typeof startV3RoundQuestions === 'function') {
                            startV3RoundQuestions(currentRound);
                        }
                    }, 300);
                }
            }, 200);
            
            goToStep(pendingDraft.currentStep, true);
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
        
        // 새로 시작 확인
        async function confirmRestart() {
            
            // 1. 로컬 스토리지 삭제
            localStorage.removeItem('analyzer_draft');
            localStorage.removeItem('analyzer_draft_timestamp');
            
            // 2. 서버의 모든 job 타입 draft 삭제 (다른 세션 포함)
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
            currentSessionId = '';  // 세션 ID 초기화 (새 세션 시작)
            window.collectedCareerState = {};
            window.universalAnswers = {};
            window.narrativeAnswers = {};
            window.roundAnswers = [];
            window.miniModuleResult = null;  // 미니모듈 결과도 초기화
            miniModuleSelections = { interest: [], value: [], strength: [], constraint: [] };
            selectedStage = '';
            window.currentRound = null;
            
            // 5. Step 1부터 시작
            goToStep(1);
        }
        
        // goToStep 래핑하여 자동 저장 추가
        const originalGoToStep = goToStep;
        goToStep = function(step, skipRender = false) {
            originalGoToStep(step, skipRender);
            // 자동 저장
            if (step < 3) {
                // 진행 중 단계: 자동 저장
                setTimeout(autoSaveDraft, 100);
            } else if (step === 3) {
                // 결과 도달 시 서버에 완료 상태 저장 후 localStorage 정리
                saveDraftAsCompleted().then(() => {
                    localStorage.removeItem('analyzer_draft');
                    localStorage.removeItem('analyzer_draft_timestamp');
                    window.analyzerUnsavedChanges = false;
                }).catch(err => {
                    localStorage.removeItem('analyzer_draft');
                    localStorage.removeItem('analyzer_draft_timestamp');
                });
            }
        };
        
        // 결과 도달 시 서버에 완료 상태 저장
        async function saveDraftAsCompleted() {
            if (!currentSessionId) return;
            
            try {
                const draftData = {
                    session_id: currentSessionId,
                    analysis_type: '${c.req.path.includes('/major') ? 'major' : 'job'}',
                    current_step: 3,  // 완료 상태
                    career_state: careerState || {},
                    step1_answers: { 
                        stage: selectedStage,
                        careerState: careerState || {},
                        profileSubStep: profileSubStep || 2,  // 프로필 완료
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
                }
            } catch (error) {
            }
        }
        
        // beforeunload 핸들러 (저장 확인)
        window.addEventListener('beforeunload', (e) => {
            if (window.analyzerUnsavedChanges) {
                e.preventDefault();
                e.returnValue = '저장하지 않은 변경사항이 있습니다. 페이지를 떠나시겠습니까?';
                return e.returnValue;
            }
        });
        
        // 서버에서 draft 불러오기
        async function loadDraftFromServer(sessionId) {
            try {
                const url = sessionId 
                    ? '/api/ai-analyzer/draft/load?session_id=' + encodeURIComponent(sessionId)
                    : '/api/ai-analyzer/draft/load';
                    
                const response = await fetch(url, { credentials: 'same-origin' });
                if (!response.ok) {
                    return null;
                }
                
                const data = await response.json();
                if (!data.found || !data.draft) {
                    return null;
                }
                
                return data.draft;
            } catch (error) {
                return null;
            }
        }
        
        // 서버 draft를 UI에 적용
        function applyServerDraft(draft) {
            if (!draft) return false;
            
            // 세션 ID 설정
            currentSessionId = draft.session_id;
            
            // Step 1: stage와 careerState 복원
            if (draft.step1_answers?.stage) {
                selectedStage = draft.step1_answers.stage;
            }
            
            // 프로필 서브스텝 복원 (1: 5축, 2: 나를 알아가기)
            if (draft.profile_sub_step || draft.step1_answers?.profileSubStep) {
                profileSubStep = draft.profile_sub_step || draft.step1_answers?.profileSubStep || 1;
            }
            
            // 5축 좌표 복원 (step1_answers.careerState 또는 draft.career_state)
            const savedCareerState = draft.step1_answers?.careerState || draft.career_state;
            if (savedCareerState && Object.keys(savedCareerState).length > 0) {
                // 로컬 careerState 변수 업데이트
                Object.assign(careerState, savedCareerState);
                window.collectedCareerState = savedCareerState;
            }
            
            // 이력서 업로드 정보 복원
            if (draft.step1_answers?.resumeUploaded) {
                window.resumeUploaded = true;
                window.resumeCareerBackground = draft.step1_answers.resumeCareerBackground || '';
            }
            
            // career_background 복원 (최상위 필드 또는 narrative_facts에서)
            if (draft.career_background) {
                window.savedCareerBackground = draft.career_background;
            }
            
            // Step 2: universal answers
            if (draft.step2_answers && Object.keys(draft.step2_answers).length > 0) {
                window.universalAnswers = draft.step2_answers;
                universalAnswers = draft.step2_answers;
            }
            
            // Step 3: narrative/transition answers
            if (draft.step3_answers && Object.keys(draft.step3_answers).length > 0) {
                window.narrativeAnswers = draft.step3_answers;
                transitionSignalAnswers = draft.step3_answers;
            }
            
            // Step 4: 심층 질문 데이터 복원 (통합 구조)
            if (draft.step4_answers && typeof draft.step4_answers === 'object') {
                const step4Data = draft.step4_answers;
                
                // round_answers 복원
                if (step4Data.round_answers) {
                    window.roundAnswers = step4Data.round_answers;
                }
                
                // narrative_facts 복원 (심층 질문 기초 답변)
                if (step4Data.narrative_facts) {
                    window.narrativeFacts = step4Data.narrative_facts;
                    // career_background도 narrative_facts에 포함되어 있으면 복원
                    if (step4Data.narrative_facts.career_background && !window.resumeCareerBackground) {
                        window.savedCareerBackground = step4Data.narrative_facts.career_background;
                    }
                }
                
                // narrative_questions 복원 (동적 질문 재사용)
                if (step4Data.narrative_questions) {
                    window.savedNarrativeQuestions = step4Data.narrative_questions;
                }
                
                // round_questions 복원
                if (step4Data.round_questions) {
                    window.roundQuestions = step4Data.round_questions;
                }
                
                // current_round 복원
                if (step4Data.current_round && step4Data.current_round > 0) {
                    window.currentRound = step4Data.current_round;
                }
            }
            
            // 이전 버전 호환성 (별도 필드로 저장된 경우)
            if (draft.narrative_facts && !window.narrativeFacts) {
                window.narrativeFacts = draft.narrative_facts;
            }
            if (draft.narrative_questions && !window.savedNarrativeQuestions) {
                window.savedNarrativeQuestions = draft.narrative_questions;
            }
            if (draft.round_questions && !window.roundQuestions) {
                window.roundQuestions = draft.round_questions;
            }
            if (draft.current_round && draft.current_round > 0 && !window.currentRound) {
                window.currentRound = draft.current_round;
            }
            
            // ============================================
            // 미니모듈 결과 복원
            // ============================================
            if (draft.mini_module_result) {
                window.miniModuleResult = draft.mini_module_result;
            }
            
            // ============================================
            // AggregatedProfile + Memory 복원 (요약 배너용!)
            // ============================================
            if (draft.aggregated_profile) {
                window.aggregatedProfile = draft.aggregated_profile;
            }
            if (draft.memory) {
                // aggregatedProfile이 없으면 생성
                if (!window.aggregatedProfile) {
                    window.aggregatedProfile = { memory: draft.memory };
                } else {
                    window.aggregatedProfile.memory = draft.memory;
                }
            }
            
            return draft.current_step || 1;
        }
        
        // Step 1 UI 업데이트 (5축 좌표 선택 상태 복원)
        function updateStep1Selection() {
            // 축 1: 역할 정체성 복원
            if (careerState.role_identity) {
                document.querySelectorAll('.role-card, [data-value]').forEach(card => {
                    if (card.closest('#role-options') && card.dataset.value === careerState.role_identity) {
                        card.classList.add('selected');
                        card.style.borderColor = '#4361ee';
                        card.style.backgroundColor = 'rgba(67,97,238,0.2)';
                    }
                });
            }
            
            // 축 2: 경력 기간 복원
            if (careerState.career_stage_years) {
                document.querySelectorAll('.career-stage-btn, [data-value]').forEach(card => {
                    if (card.closest('#career-stage-options') && card.dataset.value === careerState.career_stage_years) {
                        card.classList.add('selected');
                        card.style.borderColor = '#4361ee';
                        card.style.backgroundColor = 'rgba(67,97,238,0.2)';
                    }
                });
            }
            
            // 축 3: 전환 상태 복원 (다중 선택 - 배열)
            if (careerState.transition_status && Array.isArray(careerState.transition_status)) {
                document.querySelectorAll('.goal-chip, [data-value]').forEach(card => {
                    if (card.closest('#transition-status-options') && careerState.transition_status.includes(card.dataset.value)) {
                        card.classList.add('selected');
                        card.style.borderColor = '#10b981';
                        card.style.backgroundColor = 'rgba(16,185,129,0.2)';
                    }
                });
            }
            
            // 축 4: 숙련도 복원
            if (careerState.skill_level !== null && careerState.skill_level !== undefined) {
                document.querySelectorAll('.skill-btn, [data-value]').forEach(card => {
                    if (card.closest('#skill-level-options') && parseInt(card.dataset.value) === careerState.skill_level) {
                        card.classList.add('selected');
                        card.style.borderColor = '#8b5cf6';
                        card.style.backgroundColor = 'rgba(139,92,246,0.2)';
                    }
                });
            }
            
            // 축 5: 제약 조건 복원 (UI 직접 업데이트 - toggleConstraint 호출하면 토글되어 해제됨)
            if (careerState.constraints && Object.keys(careerState.constraints).length > 0) {
                setTimeout(() => {
                    // 저장된 제약 조건을 임시 저장하고 careerState 초기화
                    const savedConstraints = JSON.parse(JSON.stringify(careerState.constraints));
                    careerState.constraints = {};
                    
                    Object.entries(savedConstraints).forEach(([type, constraint]) => {
                        if (constraint && constraint.has_constraint) {
                            const card = document.querySelector(\`.constraint-card[data-type="\${type}"]\`);
                            if (card) {
                                const headerBtn = card.querySelector('.constraint-header');
                                if (headerBtn) {
                                    // toggleConstraint를 호출하면 careerState.constraints에 다시 설정됨
                                    headerBtn.click();
                                    
                                    // 세부 태그 복원 (details 배열이 있는 경우)
                                    if (constraint.details && Array.isArray(constraint.details)) {
                                        setTimeout(() => {
                                            constraint.details.forEach(detailValue => {
                                                const detailTag = card.querySelector(\`.detail-tag[data-value="\${detailValue}"]\`);
                                                if (detailTag && !detailTag.classList.contains('selected')) {
                                                    detailTag.click();
                                                }
                                            });
                                        }, 100);
                                    }
                                }
                            }
                        }
                    });
                }, 150);
            }
            
            // 다음 버튼 활성화 체크
            checkStep1Completion();
        }
        
        // Step 2 UI 업데이트 (Universal answers 복원)
        function updateStep2Selection() {
            if (!universalAnswers || Object.keys(universalAnswers).length === 0) return;
            
            Object.entries(universalAnswers).forEach(([questionId, answer]) => {
                const container = document.querySelector(\`[data-question-id="\${questionId}"]\`);
                if (!container) return;
                
                if (Array.isArray(answer)) {
                    // chips/checkbox: 다중 선택
                    answer.forEach(val => {
                        const chip = container.querySelector(\`.chip-option[data-value="\${val}"]\`);
                        if (chip && !chip.classList.contains('selected')) {
                            chip.classList.add('selected');
                            chip.style.borderColor = '#4361ee';
                            chip.style.backgroundColor = 'rgba(67,97,238,0.15)';
                        }
                    });
                } else {
                    // radio: 단일 선택
                    const radio = container.querySelector(\`.radio-option[data-value="\${answer}"]\`);
                    if (radio && !radio.classList.contains('selected')) {
                        radio.classList.add('selected');
                        radio.style.borderColor = '#4361ee';
                        radio.style.backgroundColor = 'rgba(67,97,238,0.15)';
                    }
                    
                    // text input
                    const textarea = container.querySelector(\`textarea[name="\${questionId}"]\`);
                    if (textarea) {
                        textarea.value = answer;
                    }
                }
            });
        }
        
        // 페이지 로드 시 초기화 - /analyzer/job은 Step 1(상태 선택)부터 시작
        document.addEventListener('DOMContentLoaded', async () => {
            renderStageOptions();  // 스테이지 옵션 렌더링
            
            // URL에서 session_id 확인 (AI 추천 메뉴에서 진행중 클릭 시)
            const urlParams = new URLSearchParams(window.location.search);
            const urlSessionId = urlParams.get('session_id');
            const urlEditMode = urlParams.get('edit_mode') === 'true';
            const urlSourceRequestId = urlParams.get('source_request_id');

            // Phase 3: 편집 모드 진입
            if (urlSessionId && urlEditMode && urlSourceRequestId) {
                const serverDraft = await loadDraftFromServer(urlSessionId);
                if (!serverDraft) {
                    alert('원본 데이터를 불러올 수 없습니다.');
                    window.location.href = '/user/ai-results';
                    return;
                }

                const editSessionId = 'edit-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
                const restoredStep = applyServerDraft(serverDraft);
                currentSessionId = editSessionId;

                window.__editMode = true;
                window.__originalSessionId = urlSessionId;
                window.__editSessionId = editSessionId;
                window.__sourceRequestId = parseInt(urlSourceRequestId, 10);
                window.__editSnapshot = {
                    careerState: JSON.stringify(careerState),
                    universalAnswers: JSON.stringify(universalAnswers),
                    narrativeFacts: JSON.stringify(window.narrativeFacts || {}),
                    roundAnswers: JSON.stringify(window.roundAnswers || []),
                };

                setTimeout(() => {
                    updateStep1Selection();
                    showEditModeBanner();
                    if (restoredStep === 1 && profileSubStep === 2) goToProfileStep2();
                    // step 4에서 복원 시 라운드 질문 UI 표시
                    if (restoredStep >= 4 && typeof startV3RoundQuestions === 'function') {
                        try { startV3RoundQuestions(); } catch(e) { }
                    }
                }, 200);

                goToStep(restoredStep || 1, true);
                return;
            }

            if (urlSessionId) {
                // 서버에서 해당 session의 draft 불러오기
                const serverDraft = await loadDraftFromServer(urlSessionId);
                if (serverDraft) {
                    const restoredStep = applyServerDraft(serverDraft);
                    
                    // DOM 업데이트 후 UI 적용 (setTimeout으로 다음 틱에서 실행)
                    setTimeout(() => {
                        updateStep1Selection();  // 5축 좌표 UI 복원
                        
                        // 프로필 서브스텝에 따라 적절한 화면 표시
                        if (restoredStep === 1) {
                            if (profileSubStep === 2) {
                                // 프로필 2/2 (나를 알아가기)로 이동
                                goToProfileStep2();
                            }
                        }
                        
                        // Step 2 (심층 질문) 복원 - 3단계 구조
                        if (restoredStep === 2) {
                            // 라운드 진행 중이면 라운드 UI 렌더링
                            if (window.currentRound > 0 && window.roundQuestions) {
                                const roundMeta = {
                                    1: { title: '내면의 에너지 탐색', subtitle: '무엇이 당신을 움직이게 하나요?', emoji: '🔥', color: 'from-orange-500 to-red-500' },
                                    2: { title: '경계선 확인', subtitle: '무엇을 피하고 싶으신가요?', emoji: '🛡️', color: 'from-purple-500 to-indigo-500' },
                                    3: { title: '실행 계획 설계', subtitle: '어떻게 시작할 수 있을까요?', emoji: '🚀', color: 'from-emerald-500 to-teal-500' },
                                };
                                renderV3RoundUI(window.currentRound, window.roundQuestions, roundMeta[window.currentRound]);
                                setTimeout(() => restoreRoundAnswers(), 100);
                            } else {
                                // 심층 질문 기초 단계 복원
                                renderNarrativeStep();
                                // 저장된 답변 복원
                                setTimeout(() => restoreNarrativeAnswers(), 150);
                            }
                        }
                    }, 200);  // 조금 더 여유 있게
                    
                    // 심층 질문 단계면 Step 3 컨테이너를 직접 표시 (currentStep은 4 유지)
                    if (restoredStep >= 4) {
                        // Step 3 컨테이너만 표시 (goToStep 사용하지 않음 - currentStep 덮어쓰기 방지)
                        document.querySelectorAll('.step-content').forEach(el => el.classList.add('hidden'));
                        document.getElementById('step3')?.classList.remove('hidden');
                        currentStep = 4;
                        window.currentStep = 4;
                        // 인디케이터 업데이트
                        document.querySelectorAll('.step-dot').forEach((el) => {
                            const circle = el.querySelector('span:first-child');
                            const stepNum = parseInt(el.dataset.step, 10);
                            if (stepNum <= 4) {
                                circle.classList.remove('bg-wiki-border', 'text-wiki-muted');
                                circle.classList.add('bg-wiki-primary', 'text-white');
                            }
                        });
                    } else {
                        goToStep(restoredStep, true);
                    }
                    return;
                }
            }
            
            // request_id가 있으면 결과 직접 로드 (테스트 시나리오 결과 조회용)
            const urlRequestId = urlParams.get('request_id');
            if (urlRequestId) {
                try {
                    showLoading();
                    const response = await fetch('/api/ai-analyzer/result/' + urlRequestId);
                    const data = await response.json();
                    hideLoading();

                    if (response.ok && data) {
                        currentRequestId = parseInt(urlRequestId, 10);
                        displayResults(data);
                        goToStep(3);  // 결과 화면으로 이동
                        return;
                    } else {
                        alert('결과를 불러오는데 실패했습니다: ' + (data.error || 'Unknown error'));
                    }
                } catch (e) {
                    hideLoading();
                    alert('결과를 불러오는데 실패했습니다.');
                }
            }

            // 시나리오 자동 실행 (?scenario=stability_seeker 등)
            const scenarioId = urlParams.get('scenario');
            if (scenarioId) {
                try {
                    showLoading();

                    // 로딩 메시지 표시
                    const loadingEl = document.querySelector('.loading-overlay');
                    if (loadingEl) {
                        loadingEl.innerHTML = \`
                            <div class="text-center">
                                <div class="animate-spin w-12 h-12 border-4 border-wiki-primary border-t-transparent rounded-full mx-auto mb-4"></div>
                                <p class="text-white text-lg font-medium">시나리오 테스트 실행 중...</p>
                                <p class="text-wiki-muted mt-2">\${scenarioId}</p>
                            </div>
                        \`;
                    }

                    // 테스트 시나리오 실행
                    const response = await fetch('/api/ai-analyzer/test/run-scenario', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ scenario_id: scenarioId })
                    });
                    const testData = await response.json();

                    if (!testData.success) {
                        throw new Error(testData.error || '테스트 실패');
                    }


                    // 결과 로드
                    if (testData.request_id) {
                        const resultResponse = await fetch('/api/ai-analyzer/result/' + testData.request_id);
                        const resultData = await resultResponse.json();

                        hideLoading();

                        if (resultResponse.ok && resultData) {
                            currentRequestId = testData.request_id;

                            // 시나리오 테스트 배너 표시
                            setTimeout(() => {
                                const banner = document.createElement('div');
                                banner.className = 'fixed top-4 left-1/2 transform -translate-x-1/2 z-50 bg-purple-600 text-white px-6 py-3 rounded-lg shadow-xl flex items-center gap-3';
                                banner.innerHTML = \`
                                    <i class="fas fa-flask"></i>
                                    <div>
                                        <div class="font-medium">테스트 시나리오: \${testData.scenario?.name || scenarioId}</div>
                                        <div class="text-sm opacity-80">검증 점수: \${testData.verification?.score || 0}/100 (\${testData.verification?.passed ? '통과' : '실패'})</div>
                                    </div>
                                    <button onclick="goToStep(1); this.closest('.fixed').remove();" class="ml-2 px-3 py-1.5 bg-white/20 hover:bg-white/30 rounded text-sm font-medium transition">
                                        테스트 종료
                                    </button>
                                    <button onclick="this.parentElement.remove()" class="hover:bg-white/20 p-1 rounded">
                                        <i class="fas fa-times"></i>
                                    </button>
                                \`;
                                document.body.appendChild(banner);
                            }, 500);

                            displayResults(resultData);
                            goToStep(3);  // 결과 화면으로 이동
                            return;
                        }
                    }

                    hideLoading();
                    alert('시나리오 결과를 불러오는데 실패했습니다.');
                } catch (e) {
                    hideLoading();
                    alert('시나리오 테스트 실패: ' + e.message);
                }
            }

            // 저장된 리포트 뷰 모드 확인 (?view=requestId)
            const viewResultId = new URLSearchParams(window.location.search).get('view');
            if (viewResultId) {
                showLoading('리포트 불러오는 중...', '잠시만 기다려주세요');
                try {
                    const res = await fetch('/api/ai-analyzer/saved-result/' + viewResultId);
                    const data = await res.json();
                    hideLoading();
                    if (data.success && data.result) {
                        currentRequestId = data.request_id;
                        displayResults({ result: data.result, request_id: data.request_id });
                        goToStep(3);
                    } else {
                        showErrorToast('결과를 불러올 수 없습니다.');
                        goToStep(1);
                    }
                } catch (e) {
                    hideLoading();
                    showErrorToast('결과를 불러오는데 실패했습니다.');
                    goToStep(1);
                }
            } else {
            // URL에 session_id가 없으면 서버/로컬에서 복원 시도
            const restoredStep = await autoRestoreDraft();
            if (restoredStep === 'modal') {
                // 모달이 표시되므로 기본 Step으로 대기
                goToStep(1);
            } else if (restoredStep) {
                // 복원된 데이터로 UI 업데이트
                setTimeout(() => {
                    updateStep1Selection();  // 5축 좌표 UI 복원
                }, 200);
                goToStep(restoredStep, true);  // skipRender = true
            } else {
                goToStep(1);           // Step 1부터 시작
            }
            }
            
            // Step 2 버튼 기본 핸들러 설정 (renderNarrativeStep/renderV3RoundUI에서 덮어씀)
            const step2PrevBtn = document.getElementById('step2-prev-btn');
            const analyzeBtn = document.getElementById('analyze-btn');
            if (step2PrevBtn) {
                step2PrevBtn.onclick = () => {
                    goToStep(1);
                    goToProfileStep2();
                };
            }
            if (analyzeBtn) {
                analyzeBtn.onclick = () => {
                    // 기본값: 아무 동작 없음 (renderNarrativeStep에서 설정됨)
                };
            }
            
            // 입력 변경 감지 - 저장 버튼 리셋 (저장 버튼 자체 제외)
            document.addEventListener('click', (e) => {
                const target = e.target;
                if (target.closest('[id$="-save-btn"]') || target.closest('#analyze-btn')) return;
                if (target.closest('.role-card, .career-stage-btn, .goal-chip, .skill-btn, .constraint-option, .trans-chip, .trans-radio, .radio-option, .trans-checkbox')) {
                    resetSaveButtons();
                }
            });
            document.addEventListener('input', (e) => {
                if (e.target.matches('input, textarea, select')) {
                    resetSaveButtons();
                }
            });
        });
    </script>
  `
  
  return c.html(renderLayoutWithContext(c, content, 'AI 직업 추천 - Careerwiki'))
})


export { analyzerJobPage }
