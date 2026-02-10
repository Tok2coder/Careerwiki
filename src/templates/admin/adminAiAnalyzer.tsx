/**
 * AI Analyzer 관제판 (Admin Dashboard)
 * Phase 1B: 운영자용 모니터링/디버깅 UI
 */

import { renderAdminLayout } from './adminLayout'

export interface AiAnalyzerOverviewStats {
  taggedJobsCount: number
  candidatePoolSize: number
  targetPoolSize: number
  recentTaggerRun: {
    run_id: string
    status: string
    processed_jobs: number
    started_at: string
  } | null
  lowConfidenceCount: number
  analysisRequestsLast24h: number
  followupsLast24h: number
  engineVersions: {
    scoring: string
    tagger: string
    recipe: string
  }
  recentSessionStats: {
    avgQuestionsGenerated: number
    avgFactsApplied: number
    totalSessions: number
  }
}

export interface AdminAiAnalyzerProps {
  overview: AiAnalyzerOverviewStats
  taggerRuns: Array<{
    run_id: string
    tagger_version: string
    status: string
    total_jobs: number
    processed_jobs: number
    failed_jobs: number
    qa_passed: number
    qa_failed: number
    started_at: string
    completed_at: string | null
  }>
  lowConfidenceJobs: Array<{
    job_id: string
    job_name: string
    _confidence: number
  }>
  taggerErrors: Array<{
    job_id: string
    error_type: string
    error_message: string
    retry_count: number
    created_at: string
  }>
}

export function renderAdminAiAnalyzer(props: AdminAiAnalyzerProps): string {
  const { overview, taggerRuns, lowConfidenceJobs, taggerErrors } = props
  
  const poolProgress = Math.round((overview.candidatePoolSize / overview.targetPoolSize) * 100)
  const poolColor = poolProgress >= 100 ? 'green' : poolProgress >= 50 ? 'yellow' : 'red'
  
  const content = `
    <!-- 개요 카드 -->
    <div class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3 mb-6">
      <!-- 태깅된 Job 수 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-tags text-blue-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.taggedJobsCount}</div>
            <div class="text-xs text-slate-400">태깅된 Job</div>
          </div>
        </div>
      </div>
      
      <!-- Candidate Pool -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-${poolColor}-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-database text-${poolColor}-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.candidatePoolSize}/${overview.targetPoolSize}</div>
            <div class="text-xs text-slate-400">Candidate Pool</div>
          </div>
        </div>
        <div class="mt-2 w-full bg-slate-700 rounded-full h-1.5">
          <div class="bg-${poolColor}-500 h-1.5 rounded-full" style="width: ${Math.min(poolProgress, 100)}%"></div>
        </div>
      </div>
      
      <!-- Tagger 상태 -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 ${overview.recentTaggerRun?.status === 'completed' ? 'bg-green-500/20' : overview.recentTaggerRun?.status === 'running' ? 'bg-yellow-500/20' : 'bg-slate-500/20'} rounded-lg flex items-center justify-center">
            <i class="fas fa-robot ${overview.recentTaggerRun?.status === 'completed' ? 'text-green-400' : overview.recentTaggerRun?.status === 'running' ? 'text-yellow-400' : 'text-slate-400'}"></i>
          </div>
          <div>
            <div class="text-lg font-bold text-white">${overview.recentTaggerRun?.status || 'N/A'}</div>
            <div class="text-xs text-slate-400">최근 Tagger</div>
          </div>
        </div>
      </div>
      
      <!-- Low Confidence -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-orange-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-exclamation-triangle text-orange-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.lowConfidenceCount}</div>
            <div class="text-xs text-slate-400">Low Conf Jobs</div>
          </div>
        </div>
      </div>
      
      <!-- 분석 요청 (24h) -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-chart-line text-purple-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.analysisRequestsLast24h}</div>
            <div class="text-xs text-slate-400">분석 요청 (24h)</div>
          </div>
        </div>
      </div>
      
      <!-- Follow-up (24h) -->
      <div class="stat-card glass-card rounded-xl p-4">
        <div class="flex items-center gap-3">
          <div class="w-10 h-10 bg-cyan-500/20 rounded-lg flex items-center justify-center">
            <i class="fas fa-comments text-cyan-400"></i>
          </div>
          <div>
            <div class="text-2xl font-bold text-white">${overview.followupsLast24h}</div>
            <div class="text-xs text-slate-400">Follow-up (24h)</div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 엔진 버전 + 정합성 지표 -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
      <div class="glass-card rounded-xl p-5">
        <h3 class="text-lg font-semibold text-white mb-4"><i class="fas fa-cog mr-2 text-blue-400"></i>엔진 버전</h3>
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">Scoring</span>
            <span class="text-white font-mono">${overview.engineVersions.scoring}</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">Tagger</span>
            <span class="text-white font-mono">${overview.engineVersions.tagger}</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">Recipe</span>
            <span class="text-white font-mono">${overview.engineVersions.recipe}</span>
          </div>
        </div>
      </div>
      
      <div class="glass-card rounded-xl p-5">
        <h3 class="text-lg font-semibold text-white mb-4"><i class="fas fa-check-double mr-2 text-green-400"></i>정합성 지표 (최근 10세션)</h3>
        <div class="space-y-2">
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">평균 질문 생성 수</span>
            <span class="text-white font-bold">${overview.recentSessionStats.avgQuestionsGenerated.toFixed(1)}개</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">평균 Facts 적용 수</span>
            <span class="text-white font-bold">${overview.recentSessionStats.avgFactsApplied.toFixed(1)}개</span>
          </div>
          <div class="flex justify-between text-sm">
            <span class="text-slate-400">총 세션 수</span>
            <span class="text-white font-bold">${overview.recentSessionStats.totalSessions}개</span>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 탭 네비게이션 -->
    <div class="glass-card rounded-xl overflow-hidden">
      <div class="border-b border-slate-700/50">
        <nav class="flex -mb-px overflow-x-auto" id="adminTabs">
          <button onclick="showTab('tagger')" class="tab-btn active px-6 py-4 text-sm font-medium whitespace-nowrap border-b-2 border-blue-500 text-blue-400" data-tab="tagger">
            <i class="fas fa-robot mr-2"></i>Tagger 관제
          </button>
          <button onclick="showTab('session')" class="tab-btn px-6 py-4 text-sm font-medium whitespace-nowrap border-b-2 border-transparent text-slate-400 hover:text-white" data-tab="session">
            <i class="fas fa-history mr-2"></i>세션 조회
          </button>
          <button onclick="showTab('job')" class="tab-btn px-6 py-4 text-sm font-medium whitespace-nowrap border-b-2 border-transparent text-slate-400 hover:text-white" data-tab="job">
            <i class="fas fa-briefcase mr-2"></i>Job Attributes
          </button>
          <button onclick="showTab('errors')" class="tab-btn px-6 py-4 text-sm font-medium whitespace-nowrap border-b-2 border-transparent text-slate-400 hover:text-white" data-tab="errors">
            <i class="fas fa-bug mr-2"></i>에러 로그
          </button>
          <button onclick="showTab('scenario-test')" class="tab-btn px-6 py-4 text-sm font-medium whitespace-nowrap border-b-2 border-transparent text-slate-400 hover:text-white" data-tab="scenario-test">
            <i class="fas fa-flask mr-2"></i>시나리오 테스트
          </button>
        </nav>
      </div>
      
      <!-- Tagger 관제 탭 -->
      <div id="tab-tagger" class="tab-content p-6">
        <div class="flex flex-wrap gap-3 mb-6">
          <button onclick="runGoldenSet()" class="px-4 py-2 bg-yellow-600 hover:bg-yellow-700 text-white rounded-lg font-medium transition-colors">
            <i class="fas fa-star mr-2"></i>골든셋 실행 (30개)
          </button>
          <button onclick="showBatchForm()" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-medium transition-colors">
            <i class="fas fa-play mr-2"></i>배치 실행
          </button>
          <button onclick="refreshRuns()" class="px-4 py-2 bg-slate-600 hover:bg-slate-700 text-white rounded-lg font-medium transition-colors">
            <i class="fas fa-sync mr-2"></i>새로고침
          </button>
        </div>
        
        <!-- 배치 실행 폼 (숨김) -->
        <div id="batchForm" class="hidden mb-6 p-4 bg-slate-800/50 rounded-lg">
          <h4 class="text-white font-medium mb-3">배치 실행 설정</h4>
          <div class="grid grid-cols-3 gap-4 mb-4">
            <div>
              <label class="text-sm text-slate-400">Limit</label>
              <input type="number" id="batchLimit" value="100" class="w-full mt-1 px-3 py-2 bg-slate-700 rounded-lg text-white">
            </div>
            <div>
              <label class="text-sm text-slate-400">Offset</label>
              <input type="number" id="batchOffset" value="0" class="w-full mt-1 px-3 py-2 bg-slate-700 rounded-lg text-white">
            </div>
            <div>
              <label class="text-sm text-slate-400">Batch Size</label>
              <input type="number" id="batchSize" value="50" class="w-full mt-1 px-3 py-2 bg-slate-700 rounded-lg text-white">
            </div>
          </div>
          <button onclick="runBatch()" class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg">실행</button>
          <button onclick="hideBatchForm()" class="px-4 py-2 bg-slate-600 hover:bg-slate-700 text-white rounded-lg ml-2">취소</button>
        </div>
        
        <!-- Runs 테이블 -->
        <h4 class="text-white font-medium mb-3">Tagger Runs</h4>
        <div class="overflow-x-auto">
          <table class="w-full text-sm">
            <thead>
              <tr class="text-left text-slate-400 border-b border-slate-700">
                <th class="pb-3 pr-4">Run ID</th>
                <th class="pb-3 pr-4">상태</th>
                <th class="pb-3 pr-4">처리/전체</th>
                <th class="pb-3 pr-4">QA 통과</th>
                <th class="pb-3 pr-4">시작</th>
                <th class="pb-3 pr-4">액션</th>
              </tr>
            </thead>
            <tbody id="runsTable">
              ${taggerRuns.map(run => `
                <tr class="border-b border-slate-700/50 hover:bg-slate-800/30">
                  <td class="py-3 pr-4 font-mono text-xs text-white">${run.run_id}</td>
                  <td class="py-3 pr-4">
                    <span class="px-2 py-1 rounded text-xs ${run.status === 'completed' ? 'bg-green-500/20 text-green-400' : run.status === 'running' ? 'bg-yellow-500/20 text-yellow-400' : 'bg-red-500/20 text-red-400'}">${run.status}</span>
                  </td>
                  <td class="py-3 pr-4 text-white">${run.processed_jobs}/${run.total_jobs}</td>
                  <td class="py-3 pr-4 text-white">${run.qa_passed}/${run.processed_jobs - run.failed_jobs}</td>
                  <td class="py-3 pr-4 text-slate-400 text-xs">${new Date(run.started_at).toLocaleString('ko-KR')}</td>
                  <td class="py-3 pr-4">
                    <button onclick="viewQAReport('${run.run_id}')" class="px-2 py-1 bg-slate-600 hover:bg-slate-700 text-white rounded text-xs">QA 리포트</button>
                  </td>
                </tr>
              `).join('')}
            </tbody>
          </table>
        </div>
        
        <!-- QA 리포트 모달 영역 -->
        <div id="qaReportModal" class="hidden mt-6 p-4 bg-slate-800/50 rounded-lg">
          <div class="flex justify-between items-center mb-3">
            <h4 class="text-white font-medium">QA 리포트</h4>
            <button onclick="hideQAReport()" class="text-slate-400 hover:text-white"><i class="fas fa-times"></i></button>
          </div>
          <pre id="qaReportContent" class="text-xs text-slate-300 overflow-x-auto whitespace-pre-wrap"></pre>
        </div>
      </div>
      
      <!-- 세션 조회 탭 -->
      <div id="tab-session" class="tab-content hidden p-6">
        <div class="flex gap-3 mb-6">
          <input type="text" id="sessionIdInput" placeholder="session_id 입력" class="flex-1 px-4 py-2 bg-slate-700 rounded-lg text-white">
          <button onclick="searchSession()" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg">
            <i class="fas fa-search mr-2"></i>조회
          </button>
        </div>
        
        <div id="sessionResult" class="hidden">
          <!-- Events 타임라인 -->
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-stream mr-2 text-purple-400"></i>Events 타임라인</h4>
            <div id="eventsTimeline" class="space-y-2 max-h-64 overflow-y-auto"></div>
          </div>
          
          <!-- Requests -->
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-file-alt mr-2 text-blue-400"></i>분석 요청</h4>
            <div id="requestsList" class="space-y-2"></div>
          </div>
          
          <!-- Facts -->
          <div class="mb-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-lightbulb mr-2 text-yellow-400"></i>수집된 Facts</h4>
            <div id="factsList" class="space-y-2"></div>
          </div>
        </div>
      </div>
      
      <!-- Job Attributes 탭 -->
      <div id="tab-job" class="tab-content hidden p-6">
        <div class="flex gap-3 mb-6">
          <input type="text" id="jobIdInput" placeholder="job_id 입력" class="flex-1 px-4 py-2 bg-slate-700 rounded-lg text-white">
          <button onclick="searchJob()" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg">
            <i class="fas fa-search mr-2"></i>조회
          </button>
        </div>
        
        <div id="jobResult" class="hidden">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- 기본 정보 -->
            <div class="space-y-4">
              <h4 class="text-white font-medium"><i class="fas fa-info-circle mr-2 text-blue-400"></i>기본 정보</h4>
              <div id="jobBasicInfo" class="space-y-2"></div>
            </div>
            
            <!-- Attributes -->
            <div class="space-y-4">
              <h4 class="text-white font-medium"><i class="fas fa-sliders-h mr-2 text-green-400"></i>Attributes</h4>
              <div id="jobAttributes" class="space-y-2"></div>
            </div>
          </div>
          
          <!-- Field Confidence -->
          <div class="mt-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-chart-bar mr-2 text-purple-400"></i>Field Confidence</h4>
            <div id="jobConfidence" class="grid grid-cols-2 sm:grid-cols-4 gap-3"></div>
          </div>
          
          <!-- Evidence (Accordion) -->
          <div class="mt-6">
            <h4 class="text-white font-medium mb-3"><i class="fas fa-file-alt mr-2 text-orange-400"></i>Evidence</h4>
            <div id="jobEvidence" class="space-y-2"></div>
          </div>
        </div>
        
        <!-- Low Confidence Jobs -->
        <div class="mt-8">
          <h4 class="text-white font-medium mb-3"><i class="fas fa-exclamation-triangle mr-2 text-orange-400"></i>Low Confidence Jobs (상위 20개)</h4>
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead>
                <tr class="text-left text-slate-400 border-b border-slate-700">
                  <th class="pb-3 pr-4">Job ID</th>
                  <th class="pb-3 pr-4">이름</th>
                  <th class="pb-3 pr-4">Confidence</th>
                  <th class="pb-3 pr-4">액션</th>
                </tr>
              </thead>
              <tbody>
                ${lowConfidenceJobs.map(job => `
                  <tr class="border-b border-slate-700/50 hover:bg-slate-800/30">
                    <td class="py-3 pr-4 font-mono text-xs text-white">${job.job_id}</td>
                    <td class="py-3 pr-4 text-white">${job.job_name || '-'}</td>
                    <td class="py-3 pr-4">
                      <span class="px-2 py-1 rounded text-xs ${job._confidence < 0.6 ? 'bg-red-500/20 text-red-400' : 'bg-orange-500/20 text-orange-400'}">${(job._confidence * 100).toFixed(0)}%</span>
                    </td>
                    <td class="py-3 pr-4">
                      <button onclick="document.getElementById('jobIdInput').value='${job.job_id}';searchJob()" class="px-2 py-1 bg-slate-600 hover:bg-slate-700 text-white rounded text-xs">상세</button>
                    </td>
                  </tr>
                `).join('')}
              </tbody>
            </table>
          </div>
        </div>
      </div>
      
      <!-- 에러 로그 탭 -->
      <div id="tab-errors" class="tab-content hidden p-6">
        <h4 class="text-white font-medium mb-4"><i class="fas fa-bug mr-2 text-red-400"></i>Tagger 에러 로그</h4>
        <div class="overflow-x-auto">
          <table class="w-full text-sm">
            <thead>
              <tr class="text-left text-slate-400 border-b border-slate-700">
                <th class="pb-3 pr-4">Job ID</th>
                <th class="pb-3 pr-4">타입</th>
                <th class="pb-3 pr-4">메시지</th>
                <th class="pb-3 pr-4">재시도</th>
                <th class="pb-3 pr-4">시간</th>
              </tr>
            </thead>
            <tbody>
              ${taggerErrors.map(err => `
                <tr class="border-b border-slate-700/50 hover:bg-slate-800/30">
                  <td class="py-3 pr-4 font-mono text-xs text-white">${err.job_id}</td>
                  <td class="py-3 pr-4">
                    <span class="px-2 py-1 rounded text-xs bg-red-500/20 text-red-400">${err.error_type}</span>
                  </td>
                  <td class="py-3 pr-4 text-slate-300 text-xs max-w-xs truncate">${err.error_message}</td>
                  <td class="py-3 pr-4 text-white">${err.retry_count}</td>
                  <td class="py-3 pr-4 text-slate-400 text-xs">${new Date(err.created_at).toLocaleString('ko-KR')}</td>
                </tr>
              `).join('')}
            </tbody>
          </table>
        </div>
      </div>

      <!-- 시나리오 테스트 탭 -->
      <div id="tab-scenario-test" class="tab-content hidden p-6">
        <div class="mb-6">
          <h4 class="text-white font-medium mb-2"><i class="fas fa-flask mr-2 text-purple-400"></i>자동화 시나리오 테스트</h4>
          <p class="text-slate-400 text-sm">P0/P1/P2/P3 기능을 자동으로 검증합니다. LLM 질문에도 자동 응답합니다.</p>
        </div>

        <!-- E2E 테스트 모드 선택 -->
        <div class="mb-6 p-4 bg-gradient-to-r from-purple-900/30 to-blue-900/30 rounded-xl border border-purple-500/30">
          <h5 class="text-white font-medium mb-3"><i class="fas fa-vial mr-2 text-purple-400"></i>E2E 테스트 (실제 사용자 흐름 시뮬레이션)</h5>
          <p class="text-slate-400 text-sm mb-4">실제 사용자처럼 프로필 입력 → 심층질문 답변 → LLM 라운드 1,2,3 → 결과 확인까지 전 과정을 자동으로 진행합니다.</p>
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

        <!-- 기존 Quick 테스트 (API 직접 호출) -->
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
          <!-- 요약 카드 -->
          <div id="testSummary" class="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6"></div>

          <!-- 상세 결과 -->
          <div id="testDetails" class="space-y-4"></div>
        </div>

        <!-- 기능 검증 체크리스트 -->
        <div class="mt-8 p-4 bg-slate-800/30 rounded-lg">
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

    <!-- JavaScript -->
    <script>
      const API_BASE = '/api/ai-analyzer';
      const ADMIN_API_BASE = '/admin/api/ai';

      // 시나리오별 예상 결과 데이터
      const SCENARIO_EXPECTED_RESULTS = {
        analytical_user: {
          topJobCategories: ['데이터 분석', '통계', '리서치', 'BI'],
          excludedJobCategories: ['현장직', '서비스직', '육체노동'],
          fitScoreRange: { min: 60, max: 95 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: false,
            canBasedFilter: true,
            balanceCap: true
          }
        },
        stability_seeker: {
          topJobCategories: ['공무원', '행정', '사무직', '공공기관'],
          excludedJobCategories: ['스타트업', '영업', '프리랜서', '야근 많은 직업'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: false,
            canBasedFilter: true,
            balanceCap: true
          }
        },
        internal_conflict: {
          topJobCategories: ['UX/UI', '기획', '컨설팅', '연구'],
          excludedJobCategories: ['영업', '단순 사무', '현장직'],
          fitScoreRange: { min: 50, max: 85 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: true,
            canBasedFilter: true,
            balanceCap: true
          }
        },
        creative_user: {
          topJobCategories: ['디자이너', '아트디렉터', '크리에이티브', '일러스트'],
          excludedJobCategories: ['회계', '법무', '공장', '물류'],
          fitScoreRange: { min: 65, max: 95 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: false,
            canBasedFilter: true,
            balanceCap: true
          }
        },
        low_can_user: {
          topJobCategories: ['신입 가능', '교육 제공', '성장 가능'],
          excludedJobCategories: ['시니어급', '전문가급'],
          fitScoreRange: { min: 40, max: 75 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: false,
            canBasedFilter: true,
            balanceCap: false
          }
        },
        comprehensive_test: {
          topJobCategories: ['개발자', 'PM', '기획자', '컨설턴트'],
          excludedJobCategories: ['현장직', '교대근무', '출장 많은 직업'],
          fitScoreRange: { min: 55, max: 90 },
          featuresApplied: {
            growthCurveMatching: true,
            internalConflictRisk: false,
            canBasedFilter: true,
            balanceCap: true
          }
        }
      };

      // 예상 직업 표시
      function showExpectedJobs() {
        const scenarioId = document.getElementById('e2eScenarioSelect').value;
        const panel = document.getElementById('expectedJobsPanel');

        if (!scenarioId) {
          panel.classList.add('hidden');
          return;
        }

        const expected = SCENARIO_EXPECTED_RESULTS[scenarioId];
        if (!expected) {
          panel.classList.add('hidden');
          return;
        }

        // 상위 직업 카테고리 표시
        document.getElementById('expectedTopJobs').innerHTML = expected.topJobCategories.map(cat =>
          \`<span class="px-3 py-1 bg-green-500/20 text-green-400 rounded-full text-sm">\${cat}</span>\`
        ).join('');

        // 제외 직업 카테고리 표시
        document.getElementById('expectedExcludedJobs').innerHTML = expected.excludedJobCategories.map(cat =>
          \`<span class="px-3 py-1 bg-red-500/20 text-red-400 rounded-full text-sm">\${cat}</span>\`
        ).join('');

        // Fit 점수 범위
        document.getElementById('expectedFitRange').textContent = \`\${expected.fitScoreRange.min} ~ \${expected.fitScoreRange.max}\`;

        // 기능 적용 표시
        const f = expected.featuresApplied;
        document.getElementById('expectedGrowthCurve').innerHTML = f.growthCurveMatching
          ? '<span class="text-green-400">✓ 적용</span>'
          : '<span class="text-slate-500">- 미적용</span>';
        document.getElementById('expectedConflictRisk').innerHTML = f.internalConflictRisk
          ? '<span class="text-yellow-400">✓ 감지</span>'
          : '<span class="text-slate-500">- 해당없음</span>';
        document.getElementById('expectedCanFilter').innerHTML = f.canBasedFilter
          ? '<span class="text-green-400">✓ 적용</span>'
          : '<span class="text-slate-500">- 미적용</span>';

        panel.classList.remove('hidden');
      }

      // E2E 테스트 실행
      async function runE2ETest() {
        const scenarioId = document.getElementById('e2eScenarioSelect').value;
        if (!scenarioId) {
          alert('시나리오를 선택하세요');
          return;
        }

        if (typeof window.runE2EScenario !== 'function') {
          alert('E2E 러너가 로드되지 않았습니다. 페이지를 새로고침해주세요.');
          return;
        }

        try {
          await window.runE2EScenario(scenarioId);
        } catch (e) {
          console.error('E2E Test Error:', e);
          alert('E2E 테스트 오류: ' + e.message);
        }
      }

      // 탭 전환
      function showTab(tabName) {
        document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
        document.querySelectorAll('.tab-btn').forEach(el => {
          el.classList.remove('active', 'border-blue-500', 'text-blue-400');
          el.classList.add('border-transparent', 'text-slate-400');
        });
        document.getElementById('tab-' + tabName).classList.remove('hidden');
        document.querySelector('[data-tab="' + tabName + '"]').classList.add('active', 'border-blue-500', 'text-blue-400');
        document.querySelector('[data-tab="' + tabName + '"]').classList.remove('border-transparent', 'text-slate-400');
      }
      
      // 골든셋 실행
      async function runGoldenSet() {
        if (!confirm('골든셋 30개 태깅을 실행하시겠습니까?')) return;
        try {
          const res = await fetch(API_BASE + '/tagger/run-golden', { method: 'POST' });
          const data = await res.json();
          alert('실행 시작: ' + data.run_id);
          setTimeout(() => location.reload(), 2000);
        } catch (e) {
          alert('오류: ' + e.message);
        }
      }
      
      // 배치 폼
      function showBatchForm() { document.getElementById('batchForm').classList.remove('hidden'); }
      function hideBatchForm() { document.getElementById('batchForm').classList.add('hidden'); }
      
      async function runBatch() {
        const limit = document.getElementById('batchLimit').value;
        const offset = document.getElementById('batchOffset').value;
        try {
          const res = await fetch(API_BASE + '/tagger/run-batch', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ limit: parseInt(limit), offset: parseInt(offset) })
          });
          const data = await res.json();
          alert('배치 실행 시작: ' + data.run_id);
          hideBatchForm();
          setTimeout(() => location.reload(), 2000);
        } catch (e) {
          alert('오류: ' + e.message);
        }
      }
      
      function refreshRuns() { location.reload(); }
      
      // QA 리포트
      async function viewQAReport(runId) {
        try {
          const res = await fetch(API_BASE + '/tagger/qa-report/' + runId + '?format=markdown');
          const text = await res.text();
          document.getElementById('qaReportContent').textContent = text;
          document.getElementById('qaReportModal').classList.remove('hidden');
        } catch (e) {
          alert('오류: ' + e.message);
        }
      }
      function hideQAReport() { document.getElementById('qaReportModal').classList.add('hidden'); }
      
      // 세션 조회
      async function searchSession() {
        const sessionId = document.getElementById('sessionIdInput').value.trim();
        if (!sessionId) { alert('session_id를 입력하세요'); return; }
        try {
          const res = await fetch(API_BASE + '/session/' + sessionId);
          const data = await res.json();
          
          // Events
          const eventsHtml = (data.events || []).map(e => \`
            <div class="flex gap-3 p-2 bg-slate-800/30 rounded">
              <span class="text-xs text-slate-400 w-32 shrink-0">\${new Date(e.created_at).toLocaleString('ko-KR')}</span>
              <span class="px-2 py-0.5 rounded text-xs \${getEventColor(e.event_type)}">\${e.event_type}</span>
            </div>
          \`).join('');
          document.getElementById('eventsTimeline').innerHTML = eventsHtml || '<div class="text-slate-400">이벤트 없음</div>';
          
          // Requests
          const requestsHtml = (data.requests || []).map(r => \`
            <div class="p-3 bg-slate-800/30 rounded">
              <div class="flex justify-between">
                <span class="text-white font-mono text-sm">Request #\${r.id}</span>
                <span class="px-2 py-0.5 rounded text-xs \${r.status === 'completed' ? 'bg-green-500/20 text-green-400' : 'bg-yellow-500/20 text-yellow-400'}">\${r.status}</span>
              </div>
              <div class="text-xs text-slate-400 mt-1">버전: \${r.scoring_version || '-'}</div>
            </div>
          \`).join('');
          document.getElementById('requestsList').innerHTML = requestsHtml || '<div class="text-slate-400">요청 없음</div>';
          
          // Facts
          const factsHtml = (data.facts || []).map(f => \`
            <div class="p-3 bg-slate-800/30 rounded">
              <div class="flex justify-between items-center">
                <span class="text-white text-sm">\${f.fact_key}</span>
                <span class="px-2 py-0.5 rounded text-xs bg-purple-500/20 text-purple-400">L\${f.fact_level}</span>
              </div>
              <div class="text-xs text-slate-300 mt-1 font-mono">\${f.value_json}</div>
            </div>
          \`).join('');
          document.getElementById('factsList').innerHTML = factsHtml || '<div class="text-slate-400">Facts 없음</div>';
          
          document.getElementById('sessionResult').classList.remove('hidden');
        } catch (e) {
          alert('조회 실패: ' + e.message);
        }
      }
      
      function getEventColor(type) {
        const colors = {
          'ANALYSIS_REQUESTED': 'bg-blue-500/20 text-blue-400',
          'ANALYSIS_COMPLETED': 'bg-green-500/20 text-green-400',
          'FOLLOWUP_ANSWERED': 'bg-purple-500/20 text-purple-400',
          'FACT_CONFIRMED': 'bg-yellow-500/20 text-yellow-400',
          'RISK_ACCEPTED': 'bg-orange-500/20 text-orange-400',
        };
        return colors[type] || 'bg-slate-500/20 text-slate-400';
      }
      
      // Job 조회
      async function searchJob() {
        const jobId = document.getElementById('jobIdInput').value.trim();
        if (!jobId) { alert('job_id를 입력하세요'); return; }
        try {
          const res = await fetch(API_BASE + '/tagger/job/' + jobId);
          if (!res.ok) { alert('Job을 찾을 수 없습니다'); return; }
          const data = await res.json();
          
          // 기본 정보
          const basicHtml = \`
            <div class="flex justify-between p-2 bg-slate-800/30 rounded"><span class="text-slate-400">Job ID</span><span class="text-white font-mono text-xs">\${data.job_id}</span></div>
            <div class="flex justify-between p-2 bg-slate-800/30 rounded"><span class="text-slate-400">이름</span><span class="text-white">\${data.job_name || '-'}</span></div>
            <div class="flex justify-between p-2 bg-slate-800/30 rounded"><span class="text-slate-400">Source</span><span class="text-white">\${data.source_system}</span></div>
            <div class="flex justify-between p-2 bg-slate-800/30 rounded"><span class="text-slate-400">Tagger</span><span class="text-white font-mono text-xs">\${data.tagger_version}</span></div>
            <div class="flex justify-between p-2 bg-slate-800/30 rounded"><span class="text-slate-400">Confidence</span><span class="text-white font-bold">\${(data._confidence * 100).toFixed(0)}%</span></div>
          \`;
          document.getElementById('jobBasicInfo').innerHTML = basicHtml;
          
          // Attributes
          const criticalFields = ['wlb', 'degree_required', 'license_required', 'work_hours', 'shift_work', 'remote_possible', 'travel'];
          const attrFields = ['wlb', 'growth', 'stability', 'income', 'teamwork', 'solo_deep', 'analytical', 'creative', 'execution', 'people_facing', 'work_hours', 'shift_work', 'travel', 'remote_possible', 'degree_required', 'license_required'];
          const attrsHtml = attrFields.map(f => {
            const isCritical = criticalFields.includes(f);
            const val = data[f];
            return \`<div class="flex justify-between p-2 \${isCritical ? 'bg-yellow-500/10 border border-yellow-500/30' : 'bg-slate-800/30'} rounded">
              <span class="text-slate-400 \${isCritical ? 'font-medium' : ''}">\${f}</span>
              <span class="text-white \${isCritical ? 'font-bold' : ''}">\${val}</span>
            </div>\`;
          }).join('');
          document.getElementById('jobAttributes').innerHTML = attrsHtml;
          
          // Field Confidence
          let fieldConf = {};
          try { fieldConf = JSON.parse(data._field_confidence_json || '{}'); } catch {}
          const confHtml = Object.entries(fieldConf).map(([k, v]) => {
            const pct = ((v || 0) * 100).toFixed(0);
            const color = v >= 0.9 ? 'green' : v >= 0.75 ? 'yellow' : 'red';
            return \`<div class="p-2 bg-slate-800/30 rounded">
              <div class="text-xs text-slate-400">\${k}</div>
              <div class="flex items-center gap-2 mt-1">
                <div class="flex-1 bg-slate-700 rounded-full h-1.5"><div class="bg-\${color}-500 h-1.5 rounded-full" style="width: \${pct}%"></div></div>
                <span class="text-xs text-white">\${pct}%</span>
              </div>
            </div>\`;
          }).join('');
          document.getElementById('jobConfidence').innerHTML = confHtml || '<div class="text-slate-400">데이터 없음</div>';
          
          // Evidence
          let evidence = {};
          try { evidence = JSON.parse(data.evidence_json || '{}'); } catch {}
          const evidenceHtml = Object.entries(evidence).map(([field, items]) => \`
            <details class="bg-slate-800/30 rounded">
              <summary class="p-3 cursor-pointer text-white hover:bg-slate-700/30">\${field} (\${(items || []).length}개)</summary>
              <div class="p-3 pt-0 space-y-2">
                \${(items || []).map(item => \`
                  <div class="p-2 bg-slate-900/50 rounded text-xs">
                    <span class="text-slate-400">[\${item.source}]</span>
                    <span class="text-slate-300">\${item.snippet || '-'}</span>
                    <span class="text-purple-400 ml-2">w:\${item.weight}</span>
                  </div>
                \`).join('')}
              </div>
            </details>
          \`).join('');
          document.getElementById('jobEvidence').innerHTML = evidenceHtml || '<div class="text-slate-400">Evidence 없음</div>';
          
          document.getElementById('jobResult').classList.remove('hidden');
        } catch (e) {
          alert('조회 실패: ' + e.message);
        }
      }

      // ============================================
      // 시나리오 테스트 함수들
      // ============================================

      async function runSingleScenario() {
        const scenarioId = document.getElementById('scenarioSelect').value;
        if (!scenarioId) {
          alert('시나리오를 선택하세요');
          return;
        }

        showTestProgress('시나리오 실행 중: ' + scenarioId);

        try {
          const res = await fetch(API_BASE + '/test/run-scenario', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ scenario_id: scenarioId })
          });
          const data = await res.json();

          if (!data.success) {
            throw new Error(data.error || '테스트 실패');
          }

          displaySingleResult(data);
        } catch (e) {
          alert('테스트 실패: ' + e.message);
        } finally {
          hideTestProgress();
        }
      }

      async function runAllScenarios() {
        const scenarios = [
          'analytical_user',
          'stability_seeker',
          'internal_conflict',
          'creative_user',
          'low_can_user',
          'comprehensive_test'
        ];

        showTestProgress('전체 테스트 시작...');
        const results = [];

        for (let i = 0; i < scenarios.length; i++) {
          updateTestProgress((i + 1) / scenarios.length * 100, \`테스트 중: \${scenarios[i]} (\${i + 1}/\${scenarios.length})\`);

          try {
            const res = await fetch(API_BASE + '/test/run-scenario', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ scenario_id: scenarios[i] })
            });
            const data = await res.json();
            results.push(data);
          } catch (e) {
            results.push({
              success: false,
              scenario: { id: scenarios[i], name: scenarios[i] },
              verification: { passed: false, score: 0, summary: e.message }
            });
          }
        }

        displayAllResults(results);
        hideTestProgress();
      }

      function showTestProgress(text) {
        document.getElementById('testProgress').classList.remove('hidden');
        document.getElementById('testProgressText').textContent = text;
        document.getElementById('testProgressBar').style.width = '0%';
        document.getElementById('testResults').classList.add('hidden');
      }

      function updateTestProgress(percent, text) {
        document.getElementById('testProgressBar').style.width = percent + '%';
        document.getElementById('testProgressText').textContent = text;
      }

      function hideTestProgress() {
        document.getElementById('testProgress').classList.add('hidden');
      }

      function displaySingleResult(data) {
        const v = data.verification;
        const resultPageUrl = data.result_page_url || '';
        const resultApiUrl = data.result_api_url || '';
        const hasResultPage = !!resultPageUrl;
        const summaryHtml = \`
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold \${v.passed ? 'text-green-400' : 'text-red-400'}">\${v.passed ? '통과' : '실패'}</div>
            <div class="text-xs text-slate-400">결과</div>
          </div>
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-white">\${v.score}/100</div>
            <div class="text-xs text-slate-400">점수</div>
          </div>
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-white">\${data.results.total_scored}</div>
            <div class="text-xs text-slate-400">평가 직업 수</div>
          </div>
          \${hasResultPage ? \`
            <div class="stat-card glass-card rounded-xl p-4 cursor-pointer hover:bg-slate-700/50" onclick="window.open('\${resultPageUrl}', '_blank')">
              <div class="text-2xl font-bold text-blue-400"><i class="fas fa-external-link-alt"></i></div>
              <div class="text-xs text-slate-400">결과 페이지</div>
            </div>
          \` : \`
            <div class="stat-card glass-card rounded-xl p-4 opacity-50">
              <div class="text-2xl font-bold text-slate-500"><i class="fas fa-exclamation-circle"></i></div>
              <div class="text-xs text-slate-400">저장 실패</div>
            </div>
          \`}
        \`;
        document.getElementById('testSummary').innerHTML = summaryHtml;

        const detailsHtml = \`
          <div class="glass-card rounded-xl p-5">
            <h5 class="text-white font-medium mb-4">\${data.scenario.name}</h5>
            <p class="text-slate-400 text-sm mb-4">\${data.scenario.description}</p>

            <!-- 검증 상세 -->
            <div class="space-y-3 mb-4">
              \${Object.entries(v.details).map(([key, detail]) => \`
                <div class="flex justify-between items-center p-2 rounded \${detail.passed ? 'bg-green-500/10' : 'bg-red-500/10'}">
                  <span class="text-sm text-slate-300">\${formatCheckName(key)}</span>
                  <span class="text-sm \${detail.passed ? 'text-green-400' : 'text-red-400'}">\${detail.passed ? '✓' : '✗'} \${detail.message}</span>
                </div>
              \`).join('')}
            </div>

            <!-- 적용된 기능 -->
            <div class="grid grid-cols-4 gap-2 mb-4">
              <div class="text-center p-2 rounded \${data.results.applied_features.growth_curve ? 'bg-green-500/20' : 'bg-slate-700'}">
                <div class="text-xs text-slate-400">성장곡선</div>
                <div class="\${data.results.applied_features.growth_curve ? 'text-green-400' : 'text-slate-500'}">\${data.results.applied_features.growth_curve ? '✓' : '-'}</div>
              </div>
              <div class="text-center p-2 rounded \${data.results.applied_features.conflict_risk ? 'bg-green-500/20' : 'bg-slate-700'}">
                <div class="text-xs text-slate-400">내면갈등</div>
                <div class="\${data.results.applied_features.conflict_risk ? 'text-green-400' : 'text-slate-500'}">\${data.results.applied_features.conflict_risk ? '✓' : '-'}</div>
              </div>
              <div class="text-center p-2 rounded \${data.results.applied_features.can_filter ? 'bg-green-500/20' : 'bg-slate-700'}">
                <div class="text-xs text-slate-400">Can 필터</div>
                <div class="\${data.results.applied_features.can_filter ? 'text-green-400' : 'text-slate-500'}">\${data.results.applied_features.can_filter ? '✓' : '-'}</div>
              </div>
              <div class="text-center p-2 rounded \${data.results.applied_features.balance_cap ? 'bg-green-500/20' : 'bg-slate-700'}">
                <div class="text-xs text-slate-400">밸런스캡</div>
                <div class="\${data.results.applied_features.balance_cap ? 'text-green-400' : 'text-slate-500'}">\${data.results.applied_features.balance_cap ? '✓' : '-'}</div>
              </div>
            </div>

            <!-- Top 5 직업 -->
            <div class="flex justify-between items-center mb-2">
              <h6 class="text-white font-medium">Top 5 추천 직업</h6>
              <div class="flex gap-2">
                \${data.result_page_url ? \`
                  <a href="\${data.result_page_url}" target="_blank" class="px-3 py-1 bg-blue-600 hover:bg-blue-700 text-white rounded text-sm">
                    <i class="fas fa-external-link-alt mr-1"></i>결과 페이지에서 보기
                  </a>
                \` : ''}
                \${data.result_api_url ? \`
                  <a href="\${data.result_api_url}" target="_blank" class="px-3 py-1 bg-slate-600 hover:bg-slate-700 text-white rounded text-sm">
                    <i class="fas fa-code mr-1"></i>API 결과
                  </a>
                \` : ''}
              </div>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead>
                  <tr class="text-left text-slate-400 border-b border-slate-700">
                    <th class="pb-2 pr-4">직업명</th>
                    <th class="pb-2 pr-4">Fit</th>
                    <th class="pb-2 pr-4">Like</th>
                    <th class="pb-2 pr-4">Can</th>
                    <th class="pb-2 pr-4">Risk</th>
                    <th class="pb-2 pr-4">상세</th>
                  </tr>
                </thead>
                <tbody>
                  \${data.results.top_jobs.map((job, i) => \`
                    <tr class="border-b border-slate-700/50">
                      <td class="py-2 pr-4">
                        <div class="flex items-center gap-2">
                          \${job.image_url ? \`<img src="\${job.image_url}" class="w-8 h-8 rounded object-cover" onerror="this.style.display='none'" />\` : ''}
                          <span class="text-white">\${i + 1}. \${job.job_name}</span>
                        </div>
                      </td>
                      <td class="py-2 pr-4 text-blue-400 font-bold">\${job.fit}</td>
                      <td class="py-2 pr-4 text-green-400">\${job.like}</td>
                      <td class="py-2 pr-4 text-yellow-400">\${job.can}</td>
                      <td class="py-2 pr-4 text-red-400">\${job.risk}</td>
                      <td class="py-2 pr-4">
                        <a href="/jobs/\${job.slug || job.job_id}" target="_blank" class="text-blue-400 hover:text-blue-300">
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </td>
                    </tr>
                  \`).join('')}
                </tbody>
              </table>
            </div>
          </div>
        \`;
        document.getElementById('testDetails').innerHTML = detailsHtml;
        document.getElementById('testResults').classList.remove('hidden');
      }

      function displayAllResults(results) {
        const passed = results.filter(r => r.success && r.verification?.passed).length;
        const failed = results.length - passed;
        const avgScore = results.reduce((sum, r) => sum + (r.verification?.score || 0), 0) / results.length;

        const summaryHtml = \`
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-green-400">\${passed}</div>
            <div class="text-xs text-slate-400">통과</div>
          </div>
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-red-400">\${failed}</div>
            <div class="text-xs text-slate-400">실패</div>
          </div>
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-white">\${avgScore.toFixed(1)}</div>
            <div class="text-xs text-slate-400">평균 점수</div>
          </div>
          <div class="stat-card glass-card rounded-xl p-4">
            <div class="text-2xl font-bold text-white">\${results.length}</div>
            <div class="text-xs text-slate-400">총 시나리오</div>
          </div>
        \`;
        document.getElementById('testSummary').innerHTML = summaryHtml;

        const detailsHtml = results.map(r => \`
          <div class="p-4 rounded-lg \${r.success && r.verification?.passed ? 'bg-green-500/10 border border-green-500/30' : 'bg-red-500/10 border border-red-500/30'}">
            <div class="flex justify-between items-center">
              <div>
                <span class="text-white font-medium">\${r.scenario?.name || r.scenario?.id}</span>
                <span class="ml-2 px-2 py-0.5 rounded text-xs \${r.success && r.verification?.passed ? 'bg-green-500/20 text-green-400' : 'bg-red-500/20 text-red-400'}">\${r.success && r.verification?.passed ? '통과' : '실패'}</span>
              </div>
              <span class="text-white font-bold">\${r.verification?.score || 0}/100</span>
            </div>
            <div class="text-sm text-slate-400 mt-1">\${r.verification?.summary || (r.error || '알 수 없는 오류')}</div>
          </div>
        \`).join('');
        document.getElementById('testDetails').innerHTML = detailsHtml;
        document.getElementById('testResults').classList.remove('hidden');
      }

      function formatCheckName(key) {
        const names = {
          topJobsCheck: 'Top 직업 카테고리',
          excludedJobsCheck: '제외 직업 카테고리',
          fitScoreCheck: 'Fit 점수 범위',
          balanceCheck: 'Like-Can 밸런스',
          featuresCheck: '기능 적용 여부',
        };
        return names[key] || key;
      }
    </script>
  `
  
  return renderAdminLayout({
    title: 'AI Analyzer 관제판',
    currentPath: '/admin/ai-analyzer',
    children: content
  })
}








