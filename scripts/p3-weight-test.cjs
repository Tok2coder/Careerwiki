#!/usr/bin/env node
/**
 * P3 버튼(미니모듈) vs 서사(심층답변) 가중치 실험 러너 (2026-07-07)
 *
 * 사전: npx wrangler d1 execute careerwiki-kr --remote --file=scripts/skill-cache/_tmp_p3_fixtures.sql
 * Usage: node scripts/p3-weight-test.cjs --phase=control|treatment
 *  - 상충 페르소나(C1~C3): 서사 타깃 직업이 top10 어디까지 올라오는지
 *  - 일관 페르소나(K1)·버튼만(K2): 회귀 감시
 * 출력: artifacts/p3/<phase>.json + 콘솔 표
 */
const fs = require('fs')
const path = require('path')

const BASE = 'https://careerwiki.org/api/ai-analyzer'
const OUT = path.join(__dirname, '..', 'artifacts', 'p3')
const { TEST_SCENARIOS } = require(path.join(__dirname, '..', 'artifacts', 'recsys-baseline', 'test-scenarios.cjs'))

const mmOf = (id) => TEST_SCENARIOS.find((s) => s.id === id).miniModule

// 케이스: session(서사 픽스처와 일치), 버튼, 서사 타깃 키워드(직업명 매칭)
const CASES = [
  { id: 'C1', session: 'p3_c1', mm: mmOf('stability_seeker'), target: ['데이터', '분석', '그로스', 'BI', '마케팅'], desc: '버튼=안정/도움 vs 서사=데이터분석' },
  { id: 'C2', session: 'p3_c2', mm: mmOf('creative_user'), target: ['간호', '요양', '보건', '의료', '돌봄'], desc: '버튼=창작 vs 서사=간호돌봄' },
  { id: 'C3', session: 'p3_c3', mm: mmOf('analytical_user'), target: ['조리', '요리', '주방', '셰프', '쉐프'], desc: '버튼=분석 vs 서사=요리' },
  { id: 'K1', session: 'p3_k1', mm: mmOf('analytical_user'), target: ['데이터', '분석', 'IT', '정보', '통계'], desc: '일관(분석+분석) — 회귀 감시' },
  { id: 'K2', session: 'p3_k2_nonarr', mm: mmOf('analytical_user'), target: ['데이터', '분석', 'IT', '정보', '통계'], desc: '버튼만(서사 없음) — 회귀 감시' },
]

const post = (url, body) => fetch(BASE + url, {
  method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body),
}).then((r) => r.json())

const evalTop = (jobs, target) => {
  const names = jobs.map((j) => j.job_name || '')
  let bestRank = null
  names.forEach((n, i) => {
    if (bestRank === null && target.some((kw) => n.includes(kw))) bestRank = i + 1
  })
  const hitsTop10 = names.filter((n) => target.some((kw) => n.includes(kw))).length
  return { bestRank, hitsTop10, top5: names.slice(0, 5) }
}

async function main() {
  const phase = (process.argv.find((a) => a.startsWith('--phase=')) || '').split('=')[1] || 'control'
  fs.mkdirSync(OUT, { recursive: true })
  const results = []
  for (const c of CASES) {
    // phase를 세션에 붙이지 않음 — 서사 픽스처 session과 일치해야 함. 캐시는 engine_version으로 분리됨.
    const res = await post('/v3/recommend', { session_id: c.session, mini_module_result: c.mm, skipReport: true })
    const jobs = res.recommendations?.top_jobs || []
    const ev = evalTop(jobs, c.target)
    const row = {
      case: c.id, desc: c.desc, engine: res.engine_version, cache_hit: res.cache_hit === true,
      target_best_rank: ev.bestRank, target_hits_top10: ev.hitsTop10, top5: ev.top5,
      top1_rationale_snippet: (jobs[0]?.rationale || '').slice(0, 160),
    }
    results.push(row)
    console.log(`[${c.id}] ${c.desc}`)
    console.log(`  타깃 최고순위: ${ev.bestRank ?? '탈락'} | top10 내 타깃 수: ${ev.hitsTop10} | cache_hit=${row.cache_hit}`)
    console.log(`  top5: ${ev.top5.join(', ')}`)
    await new Promise((r) => setTimeout(r, 2000))
  }
  fs.writeFileSync(path.join(OUT, `${phase}.json`), JSON.stringify(results, null, 2))
  console.log(`\n저장: artifacts/p3/${phase}.json`)
}

main().catch((e) => { console.error(e); process.exit(1) })
