/**
 * CareerWiki AI Analyzer - Calibration Auto Runner
 * Version: v1.0.0
 * 
 * 목적: Phase 4 검증 및 Research Bias 재발 방지를 위한 자동화 캘리브레이션
 * 실행: npx tsx scripts/run-calibration.ts [--base-url=http://localhost:3000]
 * 
 * 검증 항목:
 * 1. TOP3 다양성 (동일 클러스터 2개 이상 금지)
 * 2. 연구직 독점 방지 (연구직 2개 이상 금지)
 * 3. Phase 4 적용 여부 (phase4_applied, diversity_guard_active)
 * 4. Fit 점수 분포
 */

import { PHASE4_TEST_SCENARIOS } from './phase4-test-scenarios'
import * as fs from 'fs'
import * as path from 'path'

// ============================================
// 타입 정의
// ============================================

interface AnalysisResult {
  request_id: number
  result: {
    engine_state: string
    fit_top3: Array<{
      job_id: string
      job_name: string
      fit_score: number
      like_score: number
      can_score: number
    }>
    phase4_applied?: boolean
    diversity_guard_active?: boolean
    diversity_changes?: string[]
    input_summary?: {
      stage?: string
      confirmed_constraints?: string[]
    }
  }
}

interface CalibrationCheck {
  name: string
  passed: boolean
  expected: string
  actual: string
  details?: string
}

interface ScenarioResult {
  scenario_id: string
  scenario_name: string
  passed: boolean
  checks: CalibrationCheck[]
  top3_jobs: string[]
  fit_scores: number[]
  research_count: number
  execution_time_ms: number
  error?: string
}

interface CalibrationReport {
  generated_at: string
  base_url: string
  total_scenarios: number
  passed_scenarios: number
  failed_scenarios: number
  overall_pass: boolean
  scenarios: ScenarioResult[]
  summary: {
    avg_fit_score: number
    research_bias_detected: boolean
    diversity_violations: number
    phase4_application_rate: number
  }
}

// ============================================
// 연구직 판별 (간단 버전)
// ============================================

const RESEARCH_KEYWORDS = [
  '연구', 'research', '분석', 'analyst', '박사', 'phd', 
  '과학자', 'scientist', '데이터', 'data', '실험'
]

function isResearchJob(jobName: string): boolean {
  const lower = jobName.toLowerCase()
  return RESEARCH_KEYWORDS.some(kw => lower.includes(kw))
}

// ============================================
// 클러스터 판별 (간단 버전 - job_name 기반)
// ============================================

function getJobCluster(jobName: string): string {
  const lower = jobName.toLowerCase()
  
  if (RESEARCH_KEYWORDS.some(kw => lower.includes(kw))) {
    return 'research_analytical'
  }
  if (['디자인', 'design', '창작', '예술', 'art', 'ui', 'ux'].some(kw => lower.includes(kw))) {
    return 'creative_design'
  }
  if (['상담', '교육', '서비스', '영업', '마케팅', 'sales', 'marketing'].some(kw => lower.includes(kw))) {
    return 'people_service'
  }
  if (['개발', 'developer', '엔지니어', 'engineer', '프로그래머'].some(kw => lower.includes(kw))) {
    return 'technical_execution'
  }
  if (['관리', '경영', 'manager', '기획'].some(kw => lower.includes(kw))) {
    return 'management'
  }
  return 'other'
}

// ============================================
// 검증 함수
// ============================================

function checkDiversityViolation(top3Jobs: string[]): { violated: boolean; details: string } {
  const clusters = top3Jobs.map(getJobCluster)
  const clusterCounts: Record<string, number> = {}
  
  for (const c of clusters) {
    clusterCounts[c] = (clusterCounts[c] || 0) + 1
  }
  
  const violations: string[] = []
  for (const [cluster, count] of Object.entries(clusterCounts)) {
    if (count >= 2) {
      violations.push(`${cluster}: ${count}개`)
    }
  }
  
  return {
    violated: violations.length > 0,
    details: violations.length > 0 ? violations.join(', ') : 'OK',
  }
}

function checkResearchBias(top3Jobs: string[]): { biased: boolean; count: number } {
  const researchCount = top3Jobs.filter(isResearchJob).length
  return {
    biased: researchCount >= 2,
    count: researchCount,
  }
}

// ============================================
// 시나리오 실행
// ============================================

async function runScenario(
  scenario: typeof PHASE4_TEST_SCENARIOS[0],
  baseUrl: string
): Promise<ScenarioResult> {
  const startTime = Date.now()
  const checks: CalibrationCheck[] = []
  
  try {
    // 타임스탬프를 포함한 고유 세션 ID 생성
    const sessionId = `calibration-${scenario.id}-${Date.now()}`
    const payload = {
      ...scenario.input,
      session_id: sessionId,
    }
    
    // 분석 요청
    const response = await fetch(`${baseUrl}/api/ai-analyzer/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    })
    
    if (!response.ok) {
      const errorText = await response.text()
      return {
        scenario_id: scenario.id,
        scenario_name: scenario.name,
        passed: false,
        checks: [],
        top3_jobs: [],
        fit_scores: [],
        research_count: 0,
        execution_time_ms: Date.now() - startTime,
        error: `HTTP ${response.status}: ${errorText}`,
      }
    }
    
    const result: AnalysisResult = await response.json()
    
    if (!result.result?.fit_top3) {
      return {
        scenario_id: scenario.id,
        scenario_name: scenario.name,
        passed: false,
        checks: [],
        top3_jobs: [],
        fit_scores: [],
        research_count: 0,
        execution_time_ms: Date.now() - startTime,
        error: 'No fit_top3 in response',
      }
    }
    
    const top3Jobs = result.result.fit_top3.map(j => j.job_name)
    const fitScores = result.result.fit_top3.map(j => j.fit_score)
    
    // 검증 1: Phase 4 적용 여부
    checks.push({
      name: 'Phase 4 Applied',
      passed: result.result.phase4_applied === true,
      expected: 'true',
      actual: String(result.result.phase4_applied),
    })
    
    // 검증 2: Diversity Guard 활성화
    checks.push({
      name: 'Diversity Guard Active',
      passed: result.result.diversity_guard_active === true,
      expected: 'true',
      actual: String(result.result.diversity_guard_active),
    })
    
    // 검증 3: Research Bias 방지
    const researchCheck = checkResearchBias(top3Jobs)
    checks.push({
      name: 'Research Bias Prevention',
      passed: !researchCheck.biased,
      expected: 'research_count < 2',
      actual: `research_count = ${researchCheck.count}`,
      details: researchCheck.biased ? `연구직 독점: ${top3Jobs.filter(isResearchJob).join(', ')}` : 'OK',
    })
    
    // 검증 4: Diversity (동일 클러스터 2개 이상 금지)
    const diversityCheck = checkDiversityViolation(top3Jobs)
    checks.push({
      name: 'Cluster Diversity',
      passed: !diversityCheck.violated,
      expected: 'max_same_cluster < 2',
      actual: diversityCheck.details,
    })
    
    // 검증 5: Fit 점수 유효성 (0 이상)
    const validScores = fitScores.every(s => s >= 0)
    checks.push({
      name: 'Valid Fit Scores',
      passed: validScores,
      expected: 'all scores >= 0',
      actual: `scores: ${fitScores.join(', ')}`,
    })
    
    // 검증 6: TOP3 존재 (3개 직업)
    checks.push({
      name: 'TOP3 Complete',
      passed: top3Jobs.length === 3,
      expected: 'count = 3',
      actual: `count = ${top3Jobs.length}`,
    })
    
    const allPassed = checks.every(c => c.passed)
    
    return {
      scenario_id: scenario.id,
      scenario_name: scenario.name,
      passed: allPassed,
      checks,
      top3_jobs: top3Jobs,
      fit_scores: fitScores,
      research_count: researchCheck.count,
      execution_time_ms: Date.now() - startTime,
    }
    
  } catch (error) {
    return {
      scenario_id: scenario.id,
      scenario_name: scenario.name,
      passed: false,
      checks,
      top3_jobs: [],
      fit_scores: [],
      research_count: 0,
      execution_time_ms: Date.now() - startTime,
      error: error instanceof Error ? error.message : String(error),
    }
  }
}

// ============================================
// 메인 실행
// ============================================

async function runCalibration(baseUrl: string): Promise<CalibrationReport> {
  console.log('='.repeat(70))
  console.log('CareerWiki AI Analyzer - Calibration Auto Runner')
  console.log('='.repeat(70))
  console.log(`Base URL: ${baseUrl}`)
  console.log(`Scenarios: ${PHASE4_TEST_SCENARIOS.length}`)
  console.log(`Started at: ${new Date().toISOString()}`)
  console.log('='.repeat(70))
  
  const results: ScenarioResult[] = []
  let totalFitScore = 0
  let totalScoreCount = 0
  let diversityViolations = 0
  let phase4AppliedCount = 0
  let researchBiasDetected = false
  
  for (const scenario of PHASE4_TEST_SCENARIOS) {
    console.log(`\n🧪 Running: ${scenario.name}`)
    
    const result = await runScenario(scenario, baseUrl)
    results.push(result)
    
    // 통계 집계
    totalFitScore += result.fit_scores.reduce((a, b) => a + b, 0)
    totalScoreCount += result.fit_scores.length
    
    if (result.checks.some(c => c.name === 'Cluster Diversity' && !c.passed)) {
      diversityViolations++
    }
    if (result.checks.some(c => c.name === 'Phase 4 Applied' && c.passed)) {
      phase4AppliedCount++
    }
    if (result.research_count >= 2) {
      researchBiasDetected = true
    }
    
    // 콘솔 출력
    if (result.passed) {
      console.log(`   ✅ PASSED`)
    } else if (result.error) {
      console.log(`   ❌ ERROR: ${result.error}`)
    } else {
      console.log(`   ❌ FAILED`)
      for (const check of result.checks.filter(c => !c.passed)) {
        console.log(`      - ${check.name}: expected ${check.expected}, got ${check.actual}`)
      }
    }
    console.log(`   TOP3: ${result.top3_jobs.join(' | ')}`)
    console.log(`   Fit Scores: ${result.fit_scores.join(', ')}`)
    console.log(`   Research Count: ${result.research_count}`)
  }
  
  const passedCount = results.filter(r => r.passed).length
  const failedCount = results.length - passedCount
  
  const report: CalibrationReport = {
    generated_at: new Date().toISOString(),
    base_url: baseUrl,
    total_scenarios: PHASE4_TEST_SCENARIOS.length,
    passed_scenarios: passedCount,
    failed_scenarios: failedCount,
    overall_pass: failedCount === 0 && !researchBiasDetected,
    scenarios: results,
    summary: {
      avg_fit_score: totalScoreCount > 0 ? Math.round(totalFitScore / totalScoreCount * 10) / 10 : 0,
      research_bias_detected: researchBiasDetected,
      diversity_violations: diversityViolations,
      phase4_application_rate: results.length > 0 ? Math.round(phase4AppliedCount / results.length * 100) : 0,
    },
  }
  
  // 최종 요약
  console.log('\n' + '='.repeat(70))
  console.log('CALIBRATION SUMMARY')
  console.log('='.repeat(70))
  console.log(`Total: ${report.total_scenarios}`)
  console.log(`Passed: ${report.passed_scenarios}`)
  console.log(`Failed: ${report.failed_scenarios}`)
  console.log(`Overall: ${report.overall_pass ? '✅ PASS' : '❌ FAIL'}`)
  console.log(`Avg Fit Score: ${report.summary.avg_fit_score}`)
  console.log(`Research Bias Detected: ${report.summary.research_bias_detected ? '❌ YES' : '✅ NO'}`)
  console.log(`Diversity Violations: ${report.summary.diversity_violations}`)
  console.log(`Phase 4 Application Rate: ${report.summary.phase4_application_rate}%`)
  console.log('='.repeat(70))
  
  return report
}

// ============================================
// 리포트 저장
// ============================================

function saveReport(report: CalibrationReport): string {
  const artifactsDir = path.join(process.cwd(), 'artifacts')
  if (!fs.existsSync(artifactsDir)) {
    fs.mkdirSync(artifactsDir, { recursive: true })
  }
  
  const dateStr = new Date().toISOString().slice(0, 10).replace(/-/g, '')
  const filename = `calibration-report-${dateStr}.json`
  const filepath = path.join(artifactsDir, filename)
  
  fs.writeFileSync(filepath, JSON.stringify(report, null, 2), 'utf-8')
  console.log(`\n📄 Report saved: ${filepath}`)
  
  return filepath
}

// ============================================
// CLI 엔트리
// ============================================

async function main() {
  // 인자 파싱
  const args = process.argv.slice(2)
  let baseUrl = 'http://localhost:3000'
  
  for (const arg of args) {
    if (arg.startsWith('--base-url=')) {
      baseUrl = arg.replace('--base-url=', '')
    }
  }
  
  try {
    const report = await runCalibration(baseUrl)
    saveReport(report)
    
    // 종료 코드: FAIL이면 1 (CI용)
    process.exit(report.overall_pass ? 0 : 1)
    
  } catch (error) {
    console.error('\n❌ Calibration failed:', error)
    process.exit(1)
  }
}

main()



