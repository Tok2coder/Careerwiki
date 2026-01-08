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
    </div>
    
    <!-- JavaScript -->
    <script>
      const API_BASE = '/api/ai-analyzer';
      const ADMIN_API_BASE = '/admin/api/ai';
      
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
    </script>
  `
  
  return renderAdminLayout({
    title: 'AI Analyzer 관제판',
    currentPath: '/admin/ai-analyzer',
    children: content
  })
}







