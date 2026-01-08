// CareerWiki AI Analyzer - QA Report Generator
// Version: tagger-v1.0.0 (Phase 1B)
// 태깅 QA 리포트 자동 생성

import {
  TAGGER_VERSION,
  QA_THRESHOLDS,
  type QAReport,
  type FieldConfidence,
} from './job-attributes-types'

// ============================================
// Types
// ============================================

interface D1Database {
  prepare(sql: string): D1PreparedStatement
}

interface D1PreparedStatement {
  bind(...values: unknown[]): D1PreparedStatement
  first<T = unknown>(): Promise<T | null>
  all<T = unknown>(): Promise<D1Results<T>>
}

interface D1Results<T> {
  results: T[]
  success: boolean
}

interface JobAttributeRow {
  job_id: string
  job_name: string
  source_system: string
  _confidence: number
  _field_confidence_json: string
  wlb: number
  degree_required: string
  license_required: string
  remote_possible: string
  work_hours: string
  shift_work: string
  travel: string
}

// ============================================
// QA Report Generator
// ============================================

export async function generateQAReport(
  db: D1Database,
  runId: string,
  taggerVersion: string = TAGGER_VERSION
): Promise<QAReport> {
  const generatedAt = new Date().toISOString()
  
  // 1. 전체 통계 조회
  const totalStats = await db.prepare(`
    SELECT 
      COUNT(*) as total,
      AVG(_confidence) as avg_confidence,
      MIN(_confidence) as min_confidence,
      MAX(_confidence) as max_confidence
    FROM job_attributes
    WHERE tagger_version = ?
  `).bind(taggerVersion).first<{
    total: number
    avg_confidence: number
    min_confidence: number
    max_confidence: number
  }>()
  
  const total = totalStats?.total || 0
  
  // 2. 필드별 통계
  const fieldStats = await calculateFieldStats(db, taggerVersion)
  
  // 3. 소스별 통계
  const sourceStats = await calculateSourceStats(db, taggerVersion)
  
  // 4. Low confidence jobs (상위 100개)
  const lowConfidenceJobs = await getLowConfidenceJobs(db, taggerVersion, 100)
  
  // 5. QA 통과/실패 집계
  const { passed, failed } = await countQAResults(db, taggerVersion)
  
  return {
    run_id: runId,
    tagger_version: taggerVersion,
    generated_at: generatedAt,
    
    total_jobs: total,
    passed_jobs: passed,
    failed_jobs: failed,
    pass_rate: total > 0 ? passed / total : 0,
    
    field_stats: fieldStats,
    source_stats: sourceStats,
    low_confidence_jobs: lowConfidenceJobs,
  }
}

/**
 * 필드별 통계 계산
 */
async function calculateFieldStats(
  db: D1Database,
  taggerVersion: string
): Promise<QAReport['field_stats']> {
  const jobs = await db.prepare(`
    SELECT _field_confidence_json FROM job_attributes WHERE tagger_version = ?
  `).bind(taggerVersion).all<{ _field_confidence_json: string }>()
  
  const fields: (keyof FieldConfidence)[] = [
    'wlb', 'growth', 'stability', 'income', 'remote_possible',
    'work_hours', 'shift_work', 'travel', 'degree_required', 'license_required',
    'teamwork', 'solo_deep', 'analytical', 'creative', 'execution', 'people_facing',
  ]
  
  const stats: QAReport['field_stats'] = {}
  
  for (const field of fields) {
    const values: number[] = []
    
    for (const row of jobs.results || []) {
      try {
        const fc = JSON.parse(row._field_confidence_json) as FieldConfidence
        values.push(fc[field] ?? 0)
      } catch {
        // 파싱 실패 시 무시
      }
    }
    
    if (values.length === 0) {
      stats[field] = {
        avg_confidence: 0,
        min_confidence: 0,
        max_confidence: 0,
        pass_rate: 0,
        fail_count: 0,
      }
      continue
    }
    
    const threshold = getThreshold(field)
    const passCount = values.filter(v => v >= threshold).length
    
    stats[field] = {
      avg_confidence: values.reduce((a, b) => a + b, 0) / values.length,
      min_confidence: Math.min(...values),
      max_confidence: Math.max(...values),
      pass_rate: passCount / values.length,
      fail_count: values.length - passCount,
    }
  }
  
  return stats
}

/**
 * 소스별 통계 계산
 */
async function calculateSourceStats(
  db: D1Database,
  taggerVersion: string
): Promise<QAReport['source_stats']> {
  const results = await db.prepare(`
    SELECT 
      source_system,
      COUNT(*) as count,
      AVG(_confidence) as avg_confidence
    FROM job_attributes
    WHERE tagger_version = ?
    GROUP BY source_system
  `).bind(taggerVersion).all<{
    source_system: string
    count: number
    avg_confidence: number
  }>()
  
  const stats: QAReport['source_stats'] = {}
  
  for (const row of results.results || []) {
    // 소스별 통과율 계산
    const passResult = await db.prepare(`
      SELECT COUNT(*) as passed FROM job_attributes
      WHERE tagger_version = ? AND source_system = ? AND _confidence >= ?
    `).bind(taggerVersion, row.source_system, QA_THRESHOLDS.MIN_CONFIDENCE)
      .first<{ passed: number }>()
    
    stats[row.source_system] = {
      count: row.count,
      avg_confidence: row.avg_confidence,
      pass_rate: row.count > 0 ? (passResult?.passed || 0) / row.count : 0,
    }
  }
  
  return stats
}

/**
 * Low confidence jobs 조회
 */
async function getLowConfidenceJobs(
  db: D1Database,
  taggerVersion: string,
  limit: number
): Promise<QAReport['low_confidence_jobs']> {
  const results = await db.prepare(`
    SELECT job_id, job_name, _confidence, _field_confidence_json
    FROM job_attributes
    WHERE tagger_version = ?
    ORDER BY _confidence ASC
    LIMIT ?
  `).bind(taggerVersion, limit).all<{
    job_id: string
    job_name: string
    _confidence: number
    _field_confidence_json: string
  }>()
  
  return (results.results || []).map(row => {
    let weakFields: string[] = []
    
    try {
      const fc = JSON.parse(row._field_confidence_json) as FieldConfidence
      weakFields = Object.entries(fc)
        .filter(([field, val]) => val < getThreshold(field as keyof FieldConfidence))
        .map(([field]) => field)
    } catch {
      // 파싱 실패 시 빈 배열
    }
    
    return {
      job_id: row.job_id,
      job_name: row.job_name,
      confidence: row._confidence,
      weak_fields: weakFields,
    }
  })
}

/**
 * QA 통과/실패 집계
 */
async function countQAResults(
  db: D1Database,
  taggerVersion: string
): Promise<{ passed: number; failed: number }> {
  // 전체 통과: 모든 주요 필드가 threshold 이상
  // 간단 버전: _confidence >= MIN_CONFIDENCE로 판단
  const passed = await db.prepare(`
    SELECT COUNT(*) as count FROM job_attributes
    WHERE tagger_version = ? AND _confidence >= ?
  `).bind(taggerVersion, QA_THRESHOLDS.MIN_CONFIDENCE)
    .first<{ count: number }>()
  
  const total = await db.prepare(`
    SELECT COUNT(*) as count FROM job_attributes WHERE tagger_version = ?
  `).bind(taggerVersion).first<{ count: number }>()
  
  return {
    passed: passed?.count || 0,
    failed: (total?.count || 0) - (passed?.count || 0),
  }
}

/**
 * 필드별 threshold 조회
 */
function getThreshold(field: string): number {
  const thresholds: Record<string, number> = {
    wlb: QA_THRESHOLDS.wlb,
    degree_required: QA_THRESHOLDS.degree_required,
    license_required: QA_THRESHOLDS.license_required,
    remote_possible: QA_THRESHOLDS.remote_possible,
    work_hours: QA_THRESHOLDS.work_hours,
    shift_work: QA_THRESHOLDS.shift_work,
    travel: QA_THRESHOLDS.travel,
  }
  
  return thresholds[field] ?? QA_THRESHOLDS.DEFAULT
}

// ============================================
// Report Formatter (Console/Markdown)
// ============================================

export function formatReportMarkdown(report: QAReport): string {
  const lines: string[] = []
  
  lines.push(`# QA Report: ${report.tagger_version}`)
  lines.push(`Generated: ${report.generated_at}`)
  lines.push(`Run ID: ${report.run_id}`)
  lines.push('')
  
  // Summary
  lines.push('## Summary')
  lines.push(`- Total Jobs: ${report.total_jobs}`)
  lines.push(`- Passed: ${report.passed_jobs} (${(report.pass_rate * 100).toFixed(1)}%)`)
  lines.push(`- Failed: ${report.failed_jobs}`)
  lines.push('')
  
  // Field Stats
  lines.push('## Field Statistics')
  lines.push('| Field | Avg Conf | Pass Rate | Failed |')
  lines.push('|-------|----------|-----------|--------|')
  
  for (const [field, stats] of Object.entries(report.field_stats)) {
    lines.push(`| ${field} | ${stats.avg_confidence.toFixed(2)} | ${(stats.pass_rate * 100).toFixed(1)}% | ${stats.fail_count} |`)
  }
  lines.push('')
  
  // Source Stats
  lines.push('## Source Statistics')
  lines.push('| Source | Count | Avg Conf | Pass Rate |')
  lines.push('|--------|-------|----------|-----------|')
  
  for (const [source, stats] of Object.entries(report.source_stats)) {
    lines.push(`| ${source} | ${stats.count} | ${stats.avg_confidence.toFixed(2)} | ${(stats.pass_rate * 100).toFixed(1)}% |`)
  }
  lines.push('')
  
  // Low Confidence Jobs
  lines.push('## Low Confidence Jobs (Top 20)')
  lines.push('| Job ID | Job Name | Confidence | Weak Fields |')
  lines.push('|--------|----------|------------|-------------|')
  
  for (const job of report.low_confidence_jobs.slice(0, 20)) {
    lines.push(`| ${job.job_id} | ${job.job_name} | ${job.confidence.toFixed(2)} | ${job.weak_fields.join(', ')} |`)
  }
  
  return lines.join('\n')
}

export function formatReportConsole(report: QAReport): string {
  const lines: string[] = []
  
  lines.push('╔══════════════════════════════════════════════════════════════╗')
  lines.push(`║  QA REPORT: ${report.tagger_version.padEnd(48)}║`)
  lines.push('╠══════════════════════════════════════════════════════════════╣')
  lines.push(`║  Total: ${String(report.total_jobs).padEnd(10)} Passed: ${String(report.passed_jobs).padEnd(10)} Failed: ${String(report.failed_jobs).padEnd(10)}║`)
  lines.push(`║  Pass Rate: ${(report.pass_rate * 100).toFixed(1)}%`.padEnd(65) + '║')
  lines.push('╠══════════════════════════════════════════════════════════════╣')
  
  // Critical fields
  const criticalFields = ['wlb', 'degree_required', 'license_required', 'work_hours']
  lines.push('║  CRITICAL FIELDS:'.padEnd(65) + '║')
  
  for (const field of criticalFields) {
    const stats = report.field_stats[field]
    if (stats) {
      const status = stats.pass_rate >= 0.85 ? '✓' : '✗'
      lines.push(`║    ${status} ${field.padEnd(20)} ${(stats.pass_rate * 100).toFixed(1)}% (avg: ${stats.avg_confidence.toFixed(2)})`.padEnd(64) + '║')
    }
  }
  
  lines.push('╚══════════════════════════════════════════════════════════════╝')
  
  return lines.join('\n')
}







