#!/usr/bin/env node
/**
 * P1 추천 시스템 베이스라인 측정 하네스 (2026-07-06, 차민혁)
 *
 * 측정 항목:
 *  - 품질 프록시: TEST_SCENARIOS(직업 9) / MAJOR_TEST_SCENARIOS(전공 8)의
 *    기대 카테고리 hit@10, 제외 카테고리 위반, fit 점수 범위
 *  - 지연: cold(캐시 미스) / warm(캐시 히트) 분리, p50/p95
 *
 * 사전 준비 (1회):
 *   npx esbuild src/services/ai-analyzer/test-scenarios.ts src/services/ai-analyzer/test-scenarios-major.ts \
 *     --bundle --platform=node --format=cjs --outdir=artifacts/recsys-baseline
 *   (출력 .js → .cjs로 rename; repo가 type:module이라 필수)
 *
 * Usage:
 *   node scripts/recsys-baseline.cjs --phase=jobs    # 직업 시나리오 9건 실행
 *   node scripts/recsys-baseline.cjs --phase=majors  # 전공 시나리오 8건 실행
 *   node scripts/recsys-baseline.cjs --phase=synth   # 합성 프로필 8건 (cold 지연 샘플 보강)
 *   node scripts/recsys-baseline.cjs --phase=warm    # 전 시나리오 재호출 (warm 지연)
 *   node scripts/recsys-baseline.cjs --phase=report  # 집계 리포트 출력
 */

const fs = require('fs')
const path = require('path')

const BASE = 'https://careerwiki.org/api/ai-analyzer'
const OUT_DIR = path.join(__dirname, '..', 'artifacts', 'recsys-baseline')
const TAG = 'p1'
const FETCH_TIMEOUT_MS = 180000

const { TEST_SCENARIOS } = require(path.join(OUT_DIR, 'test-scenarios.cjs'))
const { MAJOR_TEST_SCENARIOS } = require(path.join(OUT_DIR, 'test-scenarios-major.cjs'))

const log = (m) => console.log(`[BASELINE] ${new Date().toISOString()} ${m}`)
const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

async function callRecommend(endpoint, sessionId, miniModule) {
  const t0 = Date.now()
  const controller = new AbortController()
  const to = setTimeout(() => controller.abort(), FETCH_TIMEOUT_MS)
  try {
    const res = await fetch(`${BASE}${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ session_id: sessionId, mini_module_result: miniModule }),
      signal: controller.signal,
    })
    const wall_ms = Date.now() - t0
    const json = await res.json().catch(() => ({}))
    return { ok: res.ok, status: res.status, wall_ms, json }
  } catch (e) {
    return { ok: false, status: 0, wall_ms: Date.now() - t0, json: { error: e.message } }
  } finally {
    clearTimeout(to)
  }
}

function trimResponse(json) {
  // 대형 필드 제거하고 평가에 필요한 것만 보존
  const keep = { ...json }
  delete keep.premium_report
  delete keep.search_profile
  if (Array.isArray(keep.like_top10)) keep.like_top10 = keep.like_top10.map((j) => ({ job_name: j.job_name || j.major_name, score: j.like_score }))
  if (Array.isArray(keep.can_top10)) keep.can_top10 = keep.can_top10.map((j) => ({ job_name: j.job_name || j.major_name, score: j.can_score }))
  return keep
}

function saveRun(kind, id, data) {
  fs.writeFileSync(path.join(OUT_DIR, `run-${kind}-${id}.json`), JSON.stringify(data, null, 1))
}

async function runScenarios(kind, scenarios, endpoint, warmMode) {
  for (const sc of scenarios) {
    const sessionId = `baseline_${TAG}_${kind}_${sc.id}`
    const r = await callRecommend(endpoint, sessionId, sc.miniModule)
    const cacheHit = r.json.cache_hit === true
    const topList = r.json.recommendations?.top_jobs || r.json.recommendations?.top_majors || r.json.fit_top3 || []
    log(`${kind}/${sc.id}: HTTP ${r.status} wall=${r.wall_ms}ms server=${r.json.duration_ms || '?'}ms cache_hit=${cacheHit} top1=${topList[0]?.job_name || topList[0]?.major_name || topList[0]?.name || '?'}`)
    const fileId = warmMode ? `${sc.id}-warm` : sc.id
    saveRun(kind, fileId, {
      scenario_id: sc.id,
      scenario_name: sc.name,
      warm_mode: !!warmMode,
      wall_ms: r.wall_ms,
      http_status: r.status,
      cache_hit: cacheHit,
      expected: sc.expectedResults,
      response: r.ok ? trimResponse(r.json) : r.json,
      measured_at: new Date().toISOString(),
    })
    await sleep(1500)
  }
}

function buildSyntheticProfiles(n) {
  const S = TEST_SCENARIOS
  const out = []
  for (let i = 0; i < n; i++) {
    out.push({
      id: `synth_${i}`,
      name: `합성 프로필 ${i}`,
      miniModule: {
        interest_top: S[i % S.length].miniModule.interest_top,
        value_top: S[(i + 3) % S.length].miniModule.value_top,
        strength_top: S[(i + 5) % S.length].miniModule.strength_top,
        constraint_flags: S[(i + 7) % S.length].miniModule.constraint_flags,
        workstyle_top: S[(i + 2) % S.length].miniModule.workstyle_top,
        background_flags: [],
        language_skills: [],
      },
      expectedResults: null,
    })
  }
  return out
}

// ---------- report ----------
const pct = (arr, p) => {
  if (!arr.length) return null
  const s = [...arr].sort((a, b) => a - b)
  return s[Math.min(s.length - 1, Math.ceil((p / 100) * s.length) - 1)]
}

function evalJobQuality(run) {
  const top = run.response?.recommendations?.top_jobs || run.response?.fit_top3 || []
  const exp = run.expected
  if (!exp || !top.length) return null
  const names = top.map((j) => `${j.job_name || ''} ${j.rationale || ''}`)
  const hit = exp.topJobCategories?.some((kw) => names.some((n) => n.includes(kw))) || false
  const nameOnly = top.map((j) => j.job_name || '')
  const violations = (exp.excludedJobCategories || []).filter((kw) => nameOnly.some((n) => n.includes(kw)))
  const topFit = top[0]?.fit_score ?? null
  const fitInRange = topFit !== null && exp.fitScoreRange ? topFit >= exp.fitScoreRange.min && topFit <= exp.fitScoreRange.max : null
  return { hit, violations, topFit, fitInRange, top_names: nameOnly.slice(0, 10) }
}

function report() {
  const files = fs.readdirSync(OUT_DIR).filter((f) => f.startsWith('run-'))
  const runs = files.map((f) => ({ file: f, ...JSON.parse(fs.readFileSync(path.join(OUT_DIR, f), 'utf-8')) }))
  const cold = runs.filter((r) => r.http_status === 200 && !r.cache_hit)
  const warm = runs.filter((r) => r.http_status === 200 && r.cache_hit)
  const coldMs = cold.map((r) => r.wall_ms)
  const warmMs = warm.map((r) => r.wall_ms)

  console.log('\n===== 지연 (클라이언트 체감 wall time) =====')
  console.log(`cold n=${coldMs.length}  p50=${pct(coldMs, 50)}ms  p95=${pct(coldMs, 95)}ms  min=${Math.min(...coldMs)}  max=${Math.max(...coldMs)}`)
  console.log(`warm n=${warmMs.length}  p50=${pct(warmMs, 50)}ms  p95=${pct(warmMs, 95)}ms`)

  console.log('\n===== 품질 (직업 시나리오, 기대 카테고리 프록시) =====')
  const jobRuns = runs.filter((r) => r.file.startsWith('run-job-') && !r.warm_mode && r.expected)
  let hits = 0, viol = 0, fitOk = 0, fitTotal = 0
  for (const r of jobRuns) {
    const q = evalJobQuality(r)
    if (!q) { console.log(`${r.scenario_id}: 평가 불가`); continue }
    if (q.hit) hits++
    viol += q.violations.length
    if (q.fitInRange !== null) { fitTotal++; if (q.fitInRange) fitOk++ }
    console.log(`${r.scenario_id}: hit=${q.hit} topFit=${q.topFit} fitInRange=${q.fitInRange} viol=[${q.violations}] top3=${q.top_names.slice(0, 3).join(', ')}`)
  }
  console.log(`\nhit@10: ${hits}/${jobRuns.length}  제외위반 총: ${viol}건  fit범위적합: ${fitOk}/${fitTotal}`)

  console.log('\n===== 전공 시나리오 top3 =====')
  const majorRuns = runs.filter((r) => r.file.startsWith('run-major-') && !r.warm_mode)
  for (const r of majorRuns) {
    const top = r.response?.recommendations?.top_majors || r.response?.recommendations?.top_jobs || r.response?.fit_top3 || r.response?.majors || []
    console.log(`${r.scenario_id}: ${top.slice(0, 3).map((m) => m.major_name || m.name || m.job_name).join(', ')}`)
  }

  const summary = {
    measured_at: new Date().toISOString(),
    engine_version: runs.find((r) => r.response?.engine_version)?.response?.engine_version || 'unknown',
    latency: { cold_n: coldMs.length, cold_p50: pct(coldMs, 50), cold_p95: pct(coldMs, 95), warm_n: warmMs.length, warm_p50: pct(warmMs, 50), warm_p95: pct(warmMs, 95) },
    quality_job: { scenarios: jobRuns.length, hit_at_10: hits, exclusion_violations: viol, fit_in_range: `${fitOk}/${fitTotal}` },
  }
  fs.writeFileSync(path.join(OUT_DIR, 'baseline-summary.json'), JSON.stringify(summary, null, 2))
  console.log('\nsummary → artifacts/recsys-baseline/baseline-summary.json')
}

async function main() {
  const phase = (process.argv.find((a) => a.startsWith('--phase=')) || '').split('=')[1]
  if (!phase) { console.log('need --phase=jobs|majors|synth|warm|report'); process.exit(1) }
  fs.mkdirSync(OUT_DIR, { recursive: true })

  if (phase === 'jobs') await runScenarios('job', TEST_SCENARIOS, '/v3/recommend', false)
  else if (phase === 'majors') await runScenarios('major', MAJOR_TEST_SCENARIOS, '/v3/recommend-major', false)
  else if (phase === 'synth') await runScenarios('synth', buildSyntheticProfiles(8), '/v3/recommend', false)
  else if (phase === 'warm') {
    await runScenarios('job', TEST_SCENARIOS, '/v3/recommend', true)
    await runScenarios('major', MAJOR_TEST_SCENARIOS, '/v3/recommend-major', true)
  } else if (phase === 'report') report()
  else { console.log(`unknown phase: ${phase}`); process.exit(1) }
}

main().catch((e) => { console.error(e); process.exit(1) })
