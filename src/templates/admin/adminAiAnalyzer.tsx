/**
 * AI 추천기 관리 페이지
 * 핵심 통계: 완료된 추천 수, 재분석 횟수, 세션 조회
 */

import { renderAdminLayout } from './adminLayout'

export interface AiAnalyzerOverviewStats {
  totalCompletedAnalyses: number
  totalRequests: number
  reanalysisCount: number
  analysisRequestsLast24h: number
  followupsLast24h: number
  totalSessions: number
  engineVersions: {
    scoring: string
    recipe: string
  }
}

export interface AdminAiAnalyzerProps {
  overview: AiAnalyzerOverviewStats
}

export function renderAdminAiAnalyzer(props: AdminAiAnalyzerProps): string {
  const { overview } = props

  const content = `
    <!-- 핵심 통계 카드 -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3 mb-6">
      <!-- 완료된 추천 수 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-check-circle text-green-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.totalCompletedAnalyses}</div>
            <div class="text-xs text-slate-400">완료된 추천</div>
          </div>
        </div>
      </div>

      <!-- 총 분석 요청 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-chart-bar text-blue-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.totalRequests}</div>
            <div class="text-xs text-slate-400">총 분석 요청</div>
          </div>
        </div>
      </div>

      <!-- 재분석 횟수 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-amber-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-redo text-amber-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.reanalysisCount}</div>
            <div class="text-xs text-slate-400">재분석 횟수</div>
          </div>
        </div>
      </div>

      <!-- 총 세션 수 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-users text-purple-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.totalSessions}</div>
            <div class="text-xs text-slate-400">총 세션</div>
          </div>
        </div>
      </div>

      <!-- 분석 요청 (24h) -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-cyan-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-clock text-cyan-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.analysisRequestsLast24h}</div>
            <div class="text-xs text-slate-400">요청 (24h)</div>
          </div>
        </div>
      </div>

      <!-- Follow-up (24h) -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-emerald-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-comments text-emerald-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.followupsLast24h}</div>
            <div class="text-xs text-slate-400">Follow-up (24h)</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 엔진 버전 -->
    <div class="glass-card rounded-xl p-5 mb-6">
      <h3 class="text-lg font-semibold text-white mb-4"><i class="fas fa-cog mr-2 text-blue-400"></i>엔진 버전</h3>
      <div class="flex flex-wrap gap-6">
        <div class="flex items-center gap-3 text-sm">
          <span class="text-slate-400">Scoring</span>
          <span class="text-white font-mono px-2 py-1 bg-slate-700/50 rounded">${overview.engineVersions.scoring}</span>
        </div>
        <div class="flex items-center gap-3 text-sm">
          <span class="text-slate-400">Recipe</span>
          <span class="text-white font-mono px-2 py-1 bg-slate-700/50 rounded">${overview.engineVersions.recipe}</span>
        </div>
      </div>
    </div>

    <!-- 세션 조회 -->
    <div class="glass-card rounded-xl overflow-hidden">
      <div class="p-5 border-b border-slate-700/50">
        <h3 class="text-lg font-semibold text-white"><i class="fas fa-search mr-2 text-purple-400"></i>세션 조회</h3>
        <p class="text-sm text-slate-400 mt-1">특정 세션의 분석 내역을 확인합니다.</p>
      </div>
      <div class="p-6">
        <div class="flex gap-3 mb-6">
          <input type="text" id="sessionIdInput" placeholder="session_id 입력" class="flex-1 px-4 py-2 bg-slate-700 rounded-lg text-white">
          <button onclick="searchSession()" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg">
            <i class="fas fa-search mr-2"></i>조회
          </button>
        </div>

        <div id="sessionResult" class="hidden">
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-stream mr-2 text-purple-400"></i>Events 타임라인</h4>
            <div id="eventsTimeline" class="space-y-2 max-h-64 overflow-y-auto"></div>
          </div>
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-file-alt mr-2 text-blue-400"></i>분석 요청</h4>
            <div id="requestsList" class="space-y-2"></div>
          </div>
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-lightbulb mr-2 text-yellow-400"></i>수집된 Facts</h4>
            <div id="factsList" class="space-y-2"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- 시나리오 테스트 -->
    <div class="glass-card rounded-xl overflow-hidden mt-6">
      <div class="p-5 border-b border-slate-700/50">
        <h3 class="text-lg font-semibold text-white"><i class="fas fa-flask mr-2 text-purple-400"></i>시나리오 테스트</h3>
        <p class="text-sm text-slate-400 mt-1">P0/P1/P2/P3 기능을 자동으로 검증합니다. LLM 질문에도 자동 응답합니다.</p>
      </div>
      <div class="p-6">

        <!-- 직업/전공 탭 -->
        <div class="flex gap-2 mb-6 border-b border-slate-700/50 pb-3">
          <button id="tabJobTest" onclick="switchTestTab('job')" class="px-5 py-2 rounded-lg font-medium transition-all bg-purple-600 text-white shadow-lg">
            <i class="fas fa-briefcase mr-2"></i>직업 추천 테스트
          </button>
          <button id="tabMajorTest" onclick="switchTestTab('major')" class="px-5 py-2 rounded-lg font-medium transition-all bg-slate-700 text-slate-300 hover:bg-slate-600">
            <i class="fas fa-graduation-cap mr-2"></i>전공 추천 테스트
          </button>
        </div>

        <!-- ========== 직업 추천 테스트 패널 ========== -->
        <div id="jobTestPanel">
          <!-- E2E 테스트 -->
          <div class="mb-6 p-4 bg-gradient-to-r from-purple-900/30 to-blue-900/30 rounded-xl border border-purple-500/30">
            <h5 class="text-white font-medium mb-3"><i class="fas fa-vial mr-2 text-purple-400"></i>직업 추천 E2E 테스트</h5>
            <p class="text-slate-400 text-sm mb-4">실제 사용자처럼 프로필 입력 → 심층질문 답변 → LLM 라운드 1,2,3 → 직업 추천 결과 확인까지 전 과정을 자동으로 진행합니다.</p>
            <div class="flex gap-3 flex-wrap mb-4">
              <select id="e2eScenarioSelect" class="flex-1 min-w-48 px-4 py-2 bg-slate-700 rounded-lg text-white" onchange="showExpectedJobs()">
                <option value="">시나리오 선택...</option>
                <option value="analytical_user">분석형 유저 (Employed)</option>
                <option value="stability_seeker">안정 지향 유저 (Job Seeker)</option>
                <option value="internal_conflict">내면갈등 유저 (Career Changer)</option>
                <option value="creative_user">창의형 유저 (Student)</option>
                <option value="low_can_user">Can 부족 유저 (Job Seeker)</option>
                <option value="comprehensive_test">종합 테스트 (Employed)</option>
              </select>
              <button onclick="runE2ETest()" class="px-6 py-2 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white rounded-lg font-medium transition-all shadow-lg">
                <i class="fas fa-play-circle mr-2"></i>E2E 테스트 실행
              </button>
            </div>

            <!-- 예상 직업 표시 -->
            <div id="expectedJobsPanel" class="hidden mt-4 p-4 bg-slate-800/50 rounded-lg border border-slate-600/50">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <h6 class="text-green-400 font-medium mb-2 flex items-center gap-2">
                    <i class="fas fa-check-circle"></i>
                    <span>예상 상위 직업 카테고리</span>
                  </h6>
                  <div id="expectedTopJobs" class="flex flex-wrap gap-2"></div>
                </div>
                <div>
                  <h6 class="text-red-400 font-medium mb-2 flex items-center gap-2">
                    <i class="fas fa-times-circle"></i>
                    <span>제외되어야 할 직업 카테고리</span>
                  </h6>
                  <div id="expectedExcludedJobs" class="flex flex-wrap gap-2"></div>
                </div>
              </div>
              <div class="mt-3 pt-3 border-t border-slate-600/50">
                <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 text-sm">
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">Fit 점수 범위</div>
                    <div id="expectedFitRange" class="text-white font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">성장곡선 매칭</div>
                    <div id="expectedGrowthCurve" class="font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">내면갈등 리스크</div>
                    <div id="expectedConflictRisk" class="font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">Can 필터</div>
                    <div id="expectedCanFilter" class="font-medium">-</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Quick 테스트 -->
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
            <div class="space-y-4">
              <h5 class="text-white font-medium">Quick 테스트 (백엔드 직접 계산)</h5>
              <p class="text-slate-400 text-xs">LLM 라운드 없이 빠르게 점수만 확인합니다.</p>
              <div class="flex gap-3">
                <select id="scenarioSelect" class="flex-1 px-4 py-2 bg-slate-700 rounded-lg text-white">
                  <option value="">시나리오 선택...</option>
                  <option value="analytical_user">분석형 유저 (Basic)</option>
                  <option value="stability_seeker">안정 지향 유저 (Basic)</option>
                  <option value="internal_conflict">내면갈등 유저 (Conflict)</option>
                  <option value="creative_user">창의형 유저 (Basic)</option>
                  <option value="low_can_user">Can 부족 유저 (Edge Case)</option>
                  <option value="comprehensive_test">종합 테스트 (Comprehensive)</option>
                </select>
                <button onclick="runSingleScenario()" class="px-4 py-2 bg-slate-600 hover:bg-slate-700 text-white rounded-lg font-medium transition-colors">
                  <i class="fas fa-bolt mr-2"></i>Quick
                </button>
              </div>
            </div>
            <div class="space-y-4">
              <h5 class="text-white font-medium">전체 Quick 테스트</h5>
              <p class="text-slate-400 text-xs">6개 시나리오 모두 Quick 테스트합니다.</p>
              <button onclick="runAllScenarios()" class="px-4 py-2 bg-slate-600 hover:bg-slate-700 text-white rounded-lg font-medium transition-colors">
                <i class="fas fa-rocket mr-2"></i>전체 Quick 테스트
              </button>
            </div>
          </div>
        </div>

        <!-- ========== 전공 추천 테스트 패널 ========== -->
        <div id="majorTestPanel" class="hidden">
          <!-- 전공 E2E 테스트 -->
          <div class="mb-6 p-4 bg-gradient-to-r from-emerald-900/30 to-teal-900/30 rounded-xl border border-emerald-500/30">
            <h5 class="text-white font-medium mb-3"><i class="fas fa-graduation-cap mr-2 text-emerald-400"></i>전공 추천 E2E 테스트</h5>
            <p class="text-slate-400 text-sm mb-4">실제 학생처럼 프로필 입력 → 심층질문 답변 → LLM 라운드 1,2,3 → 전공 추천 결과 확인까지 전 과정을 자동으로 진행합니다.</p>
            <div class="flex gap-3 flex-wrap mb-4">
              <select id="majorE2eScenarioSelect" class="flex-1 min-w-48 px-4 py-2 bg-slate-700 rounded-lg text-white" onchange="showExpectedMajors()">
                <option value="">전공 시나리오 선택...</option>
                <option value="major_stem_student">STEM 지향 학생 (정시)</option>
                <option value="major_humanities_student">인문 지향 학생 (수시)</option>
                <option value="major_creative_student">예술형 학생 (미정)</option>
                <option value="major_career_focused">취업 중시 학생 (정시)</option>
                <option value="major_conflict_student">갈등형 학생 (미정)</option>
                <option value="major_math_constrained">수학 제약 학생 (재수)</option>
                <option value="major_child_curious">호기심 많은 어린이</option>
                <option value="major_elementary_explorer">관심사 탐색 초등학생</option>
              </select>
              <button onclick="runMajorE2ETest()" class="px-6 py-2 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-700 hover:to-teal-700 text-white rounded-lg font-medium transition-all shadow-lg">
                <i class="fas fa-play-circle mr-2"></i>전공 E2E 테스트 실행
              </button>
            </div>

            <!-- 예상 전공 표시 -->
            <div id="expectedMajorsPanel" class="hidden mt-4 p-4 bg-slate-800/50 rounded-lg border border-slate-600/50">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <h6 class="text-green-400 font-medium mb-2 flex items-center gap-2">
                    <i class="fas fa-check-circle"></i>
                    <span>예상 상위 전공 키워드</span>
                  </h6>
                  <div id="expectedTopMajors" class="flex flex-wrap gap-2"></div>
                </div>
                <div>
                  <h6 class="text-red-400 font-medium mb-2 flex items-center gap-2">
                    <i class="fas fa-times-circle"></i>
                    <span>제외되어야 할 전공 키워드</span>
                  </h6>
                  <div id="expectedExcludedMajors" class="flex flex-wrap gap-2"></div>
                </div>
              </div>
              <div class="mt-3 pt-3 border-t border-slate-600/50">
                <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 text-sm">
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">Fit 점수 범위</div>
                    <div id="majorExpectedFitRange" class="text-white font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">Tag Filter</div>
                    <div id="majorExpectedTagFilter" class="font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">내면갈등 리스크</div>
                    <div id="majorExpectedConflictRisk" class="font-medium">-</div>
                  </div>
                  <div class="text-center p-2 bg-slate-700/50 rounded">
                    <div class="text-slate-400 text-xs">Diversity Guard</div>
                    <div id="majorExpectedDiversity" class="font-medium">-</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 테스트 진행 상태 -->
        <div id="testProgress" class="hidden mb-6 p-4 bg-slate-800/50 rounded-lg">
          <div class="flex items-center gap-3 mb-3">
            <div class="animate-spin w-5 h-5 border-2 border-purple-500 border-t-transparent rounded-full"></div>
            <span class="text-white" id="testProgressText">테스트 실행 중...</span>
          </div>
          <div class="w-full bg-slate-700 rounded-full h-2">
            <div id="testProgressBar" class="bg-purple-500 h-2 rounded-full transition-all" style="width: 0%"></div>
          </div>
        </div>

        <!-- 테스트 결과 -->
        <div id="testResults" class="hidden">
          <div id="testSummary" class="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6"></div>
          <div id="testDetails" class="space-y-4"></div>
        </div>

        <!-- 기능 검증 체크리스트 -->
        <div class="mt-6 p-4 bg-slate-800/30 rounded-lg">
          <h5 class="text-white font-medium mb-4"><i class="fas fa-check-double mr-2 text-green-400"></i>검증 대상 기능 (P0/P1/P2/P3)</h5>
          <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 text-sm">
            <div class="space-y-2">
              <div class="text-blue-400 font-medium">P0</div>
              <div class="text-slate-400">Can 검증 질문</div>
              <div class="text-slate-400">Can-Like 밸런스 캡</div>
            </div>
            <div class="space-y-2">
              <div class="text-yellow-400 font-medium">P1</div>
              <div class="text-slate-400">Risk 강도 시스템</div>
              <div class="text-slate-400">Hard Exclusion 조건</div>
            </div>
            <div class="space-y-2">
              <div class="text-purple-400 font-medium">P2</div>
              <div class="text-slate-400">수집 진행도 추적</div>
              <div class="text-slate-400">Can 기반 TAG 필터</div>
            </div>
            <div class="space-y-2">
              <div class="text-green-400 font-medium">P3</div>
              <div class="text-slate-400">성장곡선 매칭</div>
              <div class="text-slate-400">내면갈등 Risk 조정</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Scenario Runner Script -->
    <script src="/static/scenario-runner.js"></script>

    <script>
      const API_BASE = '/api/ai-analyzer';

      // 시나리오별 예상 결과 데이터
      var SCENARIO_EXPECTED_RESULTS = {
        analytical_user: {
          topJobCategories: ['데이터 분석', '통계', '리서치', 'BI'],
          excludedJobCategories: ['현장직', '서비스직', '육체노동'],
          fitScoreRange: { min: 60, max: 95 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true }
        },
        stability_seeker: {
          topJobCategories: ['공무원', '행정', '사무직', '공공기관'],
          excludedJobCategories: ['스타트업', '영업', '프리랜서', '야근 많은 직업'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true }
        },
        internal_conflict: {
          topJobCategories: ['UX/UI', '기획', '컨설팅', '연구'],
          excludedJobCategories: ['영업', '단순 사무', '현장직'],
          fitScoreRange: { min: 50, max: 85 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: true, canBasedFilter: true, balanceCap: true }
        },
        creative_user: {
          topJobCategories: ['디자이너', '아트디렉터', '크리에이티브', '일러스트'],
          excludedJobCategories: ['회계', '법무', '공장', '물류'],
          fitScoreRange: { min: 65, max: 95 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true }
        },
        low_can_user: {
          topJobCategories: ['신입 가능', '교육 제공', '성장 가능'],
          excludedJobCategories: ['시니어급', '전문가급'],
          fitScoreRange: { min: 40, max: 75 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: false }
        },
        comprehensive_test: {
          topJobCategories: ['개발자', 'PM', '기획자', '컨설턴트'],
          excludedJobCategories: ['현장직', '교대근무', '출장 많은 직업'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: { growthCurveMatching: true, internalConflictRisk: false, canBasedFilter: true, balanceCap: true }
        }
      };

      // 전공 시나리오별 예상 결과 데이터
      var MAJOR_SCENARIO_EXPECTED_RESULTS = {
        major_stem_student: {
          topMajorKeywords: ['컴퓨터', '소프트웨어', '전자', '수학', '통계', '데이터', '공학', 'IT'],
          excludedMajorKeywords: ['문학', '미술', '철학', '음악', '무용'],
          fitScoreRange: { min: 60, max: 95 },
          featuresApplied: { tagFilterApplied: false, internalConflictRisk: false, diversityGuardApplied: true, archetypeInjected: true }
        },
        major_humanities_student: {
          topMajorKeywords: ['심리', '교육', '사회', '상담', '복지', '아동', '인문'],
          excludedMajorKeywords: ['공학', '물리', '수학', '통계', '화학'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: { tagFilterApplied: true, internalConflictRisk: false, diversityGuardApplied: true, archetypeInjected: true }
        },
        major_creative_student: {
          topMajorKeywords: ['디자인', '미술', '시각', '산업디자인', '영상', '애니메이션', '건축'],
          excludedMajorKeywords: ['수학', '통계', '법학', '회계', '경제'],
          fitScoreRange: { min: 55, max: 95 },
          featuresApplied: { tagFilterApplied: false, internalConflictRisk: false, diversityGuardApplied: true, archetypeInjected: true }
        },
        major_career_focused: {
          topMajorKeywords: ['간호', '컴퓨터', '경영', '전자', '약학', '기계', '회계', '금융'],
          excludedMajorKeywords: ['철학', '사학', '문학', '순수미술', '고고학'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: { tagFilterApplied: true, internalConflictRisk: false, diversityGuardApplied: true, archetypeInjected: true }
        },
        major_conflict_student: {
          topMajorKeywords: ['산업디자인', 'UX', '미디어', '커뮤니케이션', '건축', '광고', '콘텐츠'],
          excludedMajorKeywords: [],
          fitScoreRange: { min: 50, max: 85 },
          featuresApplied: { tagFilterApplied: false, internalConflictRisk: true, diversityGuardApplied: true, archetypeInjected: true }
        },
        major_math_constrained: {
          topMajorKeywords: ['교육', '심리', '사회', '커뮤니케이션', '행정', '법학', '언어', '복지'],
          excludedMajorKeywords: ['수학', '통계', '물리', '컴퓨터공학', '전자', '화학', '경제학'],
          fitScoreRange: { min: 50, max: 85 },
          featuresApplied: { tagFilterApplied: true, internalConflictRisk: false, diversityGuardApplied: true, archetypeInjected: true }
        }
      };

      // 탭 전환 함수
      function switchTestTab(tab) {
        var jobPanel = document.getElementById('jobTestPanel');
        var majorPanel = document.getElementById('majorTestPanel');
        var jobTab = document.getElementById('tabJobTest');
        var majorTab = document.getElementById('tabMajorTest');
        if (tab === 'job') {
          jobPanel.classList.remove('hidden');
          majorPanel.classList.add('hidden');
          jobTab.className = 'px-5 py-2 rounded-lg font-medium transition-all bg-purple-600 text-white shadow-lg';
          majorTab.className = 'px-5 py-2 rounded-lg font-medium transition-all bg-slate-700 text-slate-300 hover:bg-slate-600';
        } else {
          jobPanel.classList.add('hidden');
          majorPanel.classList.remove('hidden');
          jobTab.className = 'px-5 py-2 rounded-lg font-medium transition-all bg-slate-700 text-slate-300 hover:bg-slate-600';
          majorTab.className = 'px-5 py-2 rounded-lg font-medium transition-all bg-emerald-600 text-white shadow-lg';
        }
      }

      // 전공 예상 결과 표시
      function showExpectedMajors() {
        var scenarioId = document.getElementById('majorE2eScenarioSelect').value;
        var panel = document.getElementById('expectedMajorsPanel');
        if (!scenarioId) { panel.classList.add('hidden'); return; }
        var expected = MAJOR_SCENARIO_EXPECTED_RESULTS[scenarioId];
        if (!expected) { panel.classList.add('hidden'); return; }

        document.getElementById('expectedTopMajors').innerHTML = expected.topMajorKeywords.map(function(kw) {
          return '<span class="px-3 py-1 bg-green-500/20 text-green-400 rounded-full text-sm">' + kw + '</span>';
        }).join('');
        document.getElementById('expectedExcludedMajors').innerHTML = expected.excludedMajorKeywords.length > 0
          ? expected.excludedMajorKeywords.map(function(kw) {
              return '<span class="px-3 py-1 bg-red-500/20 text-red-400 rounded-full text-sm">' + kw + '</span>';
            }).join('')
          : '<span class="text-slate-500 text-sm">제한 없음</span>';
        document.getElementById('majorExpectedFitRange').textContent = expected.fitScoreRange.min + ' ~ ' + expected.fitScoreRange.max;
        var f = expected.featuresApplied;
        document.getElementById('majorExpectedTagFilter').innerHTML = f.tagFilterApplied ? '<span class="text-green-400">ON</span>' : '<span class="text-slate-500">OFF</span>';
        document.getElementById('majorExpectedConflictRisk').innerHTML = f.internalConflictRisk ? '<span class="text-yellow-400">감지</span>' : '<span class="text-slate-500">해당없음</span>';
        document.getElementById('majorExpectedDiversity').innerHTML = f.diversityGuardApplied ? '<span class="text-green-400">ON</span>' : '<span class="text-slate-500">OFF</span>';
        panel.classList.remove('hidden');
      }

      // 전공 E2E 테스트 실행
      async function runMajorE2ETest() {
        var scenarioId = document.getElementById('majorE2eScenarioSelect').value;
        if (!scenarioId) { alert('전공 시나리오를 선택하세요'); return; }
        if (typeof window.runMajorE2EScenario !== 'function') {
          alert('E2E 러너가 로드되지 않았습니다. 페이지를 새로고침해주세요.');
          return;
        }
        try {
          await window.runMajorE2EScenario(scenarioId);
        } catch (e) {
          alert('전공 E2E 테스트 오류: ' + e.message);
        }
      }

      function showExpectedJobs() {
        var scenarioId = document.getElementById('e2eScenarioSelect').value;
        var panel = document.getElementById('expectedJobsPanel');
        if (!scenarioId) { panel.classList.add('hidden'); return; }
        var expected = SCENARIO_EXPECTED_RESULTS[scenarioId];
        if (!expected) { panel.classList.add('hidden'); return; }

        document.getElementById('expectedTopJobs').innerHTML = expected.topJobCategories.map(function(cat) {
          return '<span class="px-3 py-1 bg-green-500/20 text-green-400 rounded-full text-sm">' + cat + '</span>';
        }).join('');
        document.getElementById('expectedExcludedJobs').innerHTML = expected.excludedJobCategories.map(function(cat) {
          return '<span class="px-3 py-1 bg-red-500/20 text-red-400 rounded-full text-sm">' + cat + '</span>';
        }).join('');
        document.getElementById('expectedFitRange').textContent = expected.fitScoreRange.min + ' ~ ' + expected.fitScoreRange.max;
        var f = expected.featuresApplied;
        document.getElementById('expectedGrowthCurve').innerHTML = f.growthCurveMatching ? '<span class="text-green-400">✓ 적용</span>' : '<span class="text-slate-500">- 미적용</span>';
        document.getElementById('expectedConflictRisk').innerHTML = f.internalConflictRisk ? '<span class="text-yellow-400">✓ 감지</span>' : '<span class="text-slate-500">- 해당없음</span>';
        document.getElementById('expectedCanFilter').innerHTML = f.canBasedFilter ? '<span class="text-green-400">✓ 적용</span>' : '<span class="text-slate-500">- 미적용</span>';
        panel.classList.remove('hidden');
      }

      async function runE2ETest() {
        var scenarioId = document.getElementById('e2eScenarioSelect').value;
        if (!scenarioId) { alert('시나리오를 선택하세요'); return; }
        if (typeof window.runE2EScenario !== 'function') {
          alert('E2E 러너가 로드되지 않았습니다. 페이지를 새로고침해주세요.');
          return;
        }
        try {
          await window.runE2EScenario(scenarioId);
        } catch (e) {
          alert('E2E 테스트 오류: ' + e.message);
        }
      }

      async function searchSession() {
        const sessionId = document.getElementById('sessionIdInput').value.trim();
        if (!sessionId) { alert('session_id를 입력하세요'); return; }
        try {
          const res = await fetch(API_BASE + '/session/' + sessionId);
          const data = await res.json();

          const eventsHtml = (data.events || []).map(function(e) {
            return '<div class="flex gap-3 p-2 bg-slate-800/30 rounded">' +
              '<span class="text-xs text-slate-400 w-32 shrink-0">' + new Date(e.created_at).toLocaleString('ko-KR') + '</span>' +
              '<span class="px-2 py-0.5 rounded text-xs ' + getEventColor(e.event_type) + '">' + e.event_type + '</span>' +
            '</div>';
          }).join('');
          document.getElementById('eventsTimeline').innerHTML = eventsHtml || '<div class="text-slate-400">이벤트 없음</div>';

          const requestsHtml = (data.requests || []).map(function(r) {
            return '<div class="p-3 bg-slate-800/30 rounded">' +
              '<div class="flex justify-between">' +
                '<span class="text-white font-mono text-sm">Request #' + r.id + '</span>' +
                '<span class="px-2 py-0.5 rounded text-xs ' + (r.status === 'completed' ? 'bg-green-500/20 text-green-400' : 'bg-yellow-500/20 text-yellow-400') + '">' + r.status + '</span>' +
              '</div>' +
              '<div class="text-xs text-slate-400 mt-1">버전: ' + (r.scoring_version || '-') + '</div>' +
            '</div>';
          }).join('');
          document.getElementById('requestsList').innerHTML = requestsHtml || '<div class="text-slate-400">요청 없음</div>';

          const factsHtml = (data.facts || []).map(function(f) {
            return '<div class="p-3 bg-slate-800/30 rounded">' +
              '<div class="flex justify-between items-center">' +
                '<span class="text-white text-sm">' + f.fact_key + '</span>' +
                '<span class="px-2 py-0.5 rounded text-xs bg-purple-500/20 text-purple-400">L' + f.fact_level + '</span>' +
              '</div>' +
              '<div class="text-xs text-slate-300 mt-1 font-mono">' + f.value_json + '</div>' +
            '</div>';
          }).join('');
          document.getElementById('factsList').innerHTML = factsHtml || '<div class="text-slate-400">Facts 없음</div>';

          document.getElementById('sessionResult').classList.remove('hidden');
        } catch (e) {
          alert('조회 실패: ' + e.message);
        }
      }

      function getEventColor(type) {
        var colors = {
          'ANALYSIS_REQUESTED': 'bg-blue-500/20 text-blue-400',
          'ANALYSIS_COMPLETED': 'bg-green-500/20 text-green-400',
          'FOLLOWUP_ANSWERED': 'bg-purple-500/20 text-purple-400',
          'FACT_CONFIRMED': 'bg-yellow-500/20 text-yellow-400',
          'RISK_ACCEPTED': 'bg-orange-500/20 text-orange-400',
        };
        return colors[type] || 'bg-slate-500/20 text-slate-400';
      }
    </script>
  `

  return renderAdminLayout({
    title: 'AI 추천기 관리',
    currentPath: '/admin/ai-analyzer',
    children: content
  })
}
