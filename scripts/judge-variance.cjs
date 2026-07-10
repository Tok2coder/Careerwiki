#!/usr/bin/env node
/**
 * Judge 변동성 측정 하네스 (2026-07-07, Judge 품질 국면)
 * — 동일 프로필을 nocache로 K회 반복 호출해 추천 순위가 얼마나 흔들리는지 정량화.
 *
 * 지표:
 *  - top5_jaccard_avg: 회차 쌍 간 top5 집합 Jaccard 유사도 평균 (1=완전 일관)
 *  - top1_mode_ratio: 최빈 top1 직업이 K회 중 차지한 비율
 *  - rank_std_avg: top10에 한 번이라도 든 직업들의 순위 표준편차 평균 (낮을수록 안정)
 *  - top10_unique: K회 통틀어 top10에 등장한 서로 다른 직업 수 (적을수록 안정)
 *
 * Usage: node scripts/judge-variance.cjs [--k=6] [--persona=analytical]
 * 출력: artifacts/judge-variance/<persona>.json + 콘솔
 */
const fs = require('fs')
const path = require('path')
const BASE = 'https://careerwiki.org/api/ai-analyzer'
const OUT = path.join(__dirname, '..', 'artifacts', 'judge-variance')
const { TEST_SCENARIOS } = require(path.join(__dirname, '..', 'artifacts', 'recsys-baseline', 'test-scenarios.cjs'))
const mmOf = (id) => JSON.parse(JSON.stringify(TEST_SCENARIOS.find((s) => s.id === id).miniModule))

const PERSONAS = {
  analytical: { mm: mmOf('analytical_user'), cs: { role_identity: '대학생', career_stage_years: '0년' } },
  creative: { mm: mmOf('creative_user'), cs: { role_identity: '대학생', career_stage_years: '0년' } },
  stability: { mm: mmOf('stability_seeker'), cs: { role_identity: '직장인', career_stage_years: '3년' } },
}

const post = (b) => fetch(BASE + '/v3/recommend', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(b) })
  .then(async (r) => { const t = await r.text(); try { return JSON.parse(t) } catch { return { __err: t.slice(0, 60), status: r.status } } })

const jaccard = (a, b) => { const A = new Set(a), B = new Set(b); const inter = [...A].filter((x) => B.has(x)).length; return inter / (A.size + B.size - inter) }
const std = (arr) => { if (arr.length < 2) return 0; const m = arr.reduce((x, y) => x + y, 0) / arr.length; return Math.sqrt(arr.reduce((s, x) => s + (x - m) ** 2, 0) / arr.length) }

async function measure(name, cfg, K) {
  const runs = []
  for (let i = 0; i < K; i++) {
    const res = await post({ session_id: `jvar_${name}_${i}`, mini_module_result: cfg.mm, career_state: cfg.cs, skipReport: true, nocache: true })
    if (res.__err) { console.log(`  run${i} 실패: ${res.status}`); continue }
    const top = (res.recommendations?.top_jobs || []).map((j) => j.job_name)
    runs.push(top)
    await new Promise((r) => setTimeout(r, 1500))
  }
  // 지표 계산
  const jac = []
  for (let i = 0; i < runs.length; i++) for (let j = i + 1; j < runs.length; j++) jac.push(jaccard(runs[i].slice(0, 5), runs[j].slice(0, 5)))
  const top1s = runs.map((r) => r[0])
  const modeCount = Math.max(...Object.values(top1s.reduce((m, x) => ((m[x] = (m[x] || 0) + 1), m), {})))
  const allJobs = [...new Set(runs.flat())]
  const rankStds = allJobs.map((job) => {
    const ranks = runs.map((r) => { const idx = r.indexOf(job); return idx === -1 ? 11 : idx + 1 }) // 미등장=11위
    return std(ranks)
  })
  const summary = {
    persona: name, K: runs.length,
    top5_jaccard_avg: +(jac.reduce((a, b) => a + b, 0) / (jac.length || 1)).toFixed(3),
    top1_mode_ratio: +(modeCount / runs.length).toFixed(3),
    top1_values: top1s,
    rank_std_avg: +(rankStds.reduce((a, b) => a + b, 0) / (rankStds.length || 1)).toFixed(2),
    top10_unique: allJobs.length,
    runs,
  }
  console.log(`\n[${name}] K=${runs.length}`)
  console.log(`  top5 Jaccard 평균: ${summary.top5_jaccard_avg} (1=완전일관)`)
  console.log(`  top1 최빈 비율: ${summary.top1_mode_ratio} | top1들: ${[...new Set(top1s)].join(', ')}`)
  console.log(`  순위 표준편차 평균: ${summary.rank_std_avg} | top10 누적 고유직업: ${summary.top10_unique}개`)
  return summary
}

async function main() {
  fs.mkdirSync(OUT, { recursive: true })
  const K = parseInt((process.argv.find((a) => a.startsWith('--k=')) || '--k=6').split('=')[1], 10)
  const only = (process.argv.find((a) => a.startsWith('--persona=')) || '').split('=')[1]
  const targets = only ? { [only]: PERSONAS[only] } : PERSONAS
  const all = []
  for (const [name, cfg] of Object.entries(targets)) all.push(await measure(name, cfg, K))
  fs.writeFileSync(path.join(OUT, 'baseline.json'), JSON.stringify(all, null, 1))
  const avgJac = (all.reduce((s, x) => s + x.top5_jaccard_avg, 0) / all.length).toFixed(3)
  console.log(`\n=== 종합: top5 Jaccard 평균 ${avgJac} (1에 가까울수록 일관적) ===`)
  console.log('저장: artifacts/judge-variance/baseline.json')
}
main().catch((e) => { console.error(e); process.exit(1) })
