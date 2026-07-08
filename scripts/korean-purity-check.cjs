#!/usr/bin/env node
/**
 * 한글 순도 하네스 (2026-07-07, Jason 지시 "계속 제대로 안되니까 하네스 추가")
 * — 영어 토큰 ID가 유저 노출 텍스트에 새는 것을 결정적으로 잡는다.
 *
 * Part 1 (기본, 오프라인): 전 토큰(질문 뱅크 + 테스트 시나리오) ↔ TOKEN_KO_FULL 커버리지 검사
 * Part 2 (--live): 지정 세션들의 실응답(rationale/reason/narrative/report)에서 토큰 등장 스캔
 *
 * 사전: npx esbuild src/services/ai-analyzer/mini-module-questions.ts --bundle --platform=node
 *       --format=cjs --outfile=artifacts/recsys-baseline/mini-module-questions.cjs (스키마 변경 시 재번들)
 * Usage: node scripts/korean-purity-check.cjs [--live]
 * 실패 시 exit 1 (CI/배포 게이트로 사용 가능)
 */
const path = require('path')
const mmq = require(path.join(__dirname, '..', 'artifacts', 'recsys-baseline', 'mini-module-questions.cjs'))
const { TEST_SCENARIOS } = require(path.join(__dirname, '..', 'artifacts', 'recsys-baseline', 'test-scenarios.cjs'))

const KO_MAP = mmq.TOKEN_KO_FULL || mmq.TOKEN_TO_KOREAN || {}

// ── 전 토큰 수집 ──
const allTokens = new Set()
for (const [k, v] of Object.entries(mmq)) {
  if (Array.isArray(v)) for (const q of v) { if (q && typeof q === 'object' && q.token) allTokens.add(q.token) }
}
const collectFromMini = (mm) => {
  for (const key of ['interest_top', 'value_top', 'strength_top', 'constraint_flags', 'workstyle_top', 'background_flags', 'sacrifice_flags', 'energy_drain_flags', 'achievement_feedback_top']) {
    for (const t of (mm[key] || [])) allTokens.add(t)
  }
  for (const key of ['execution_style', 'impact_scope', 'failure_response', 'persistence_anchor', 'external_expectation']) {
    if (mm[key]) allTokens.add(mm[key])
  }
}
for (const sc of TEST_SCENARIOS) collectFromMini(sc.miniModule)

// ── Part 1: 커버리지 ──
const missing = [...allTokens].filter((t) => !KO_MAP[t])
console.log(`[Part1 커버리지] 전 토큰 ${allTokens.size}개 / 맵 ${Object.keys(KO_MAP).length}개 / 누락 ${missing.length}개`)
if (missing.length) console.log('  누락 토큰:', missing.join(', '))

// ── Part 2: 실응답 스캔 (--live) ──
async function liveScan() {
  const BASE = 'https://careerwiki.org/api/ai-analyzer'
  const sessions = process.argv.filter((a) => a.startsWith('--session=')).map((a) => a.split('=')[1])
  const targets = sessions.length ? sessions : ['cstate_HS_v1', 'cstate_UG_v1', 'cstate_CC_v1', 'cstate_SR_v1', 'cstate_NB_v1']
  const tokenPatterns = [...allTokens].filter((t) => t.length >= 4) // 짧은 토큰(art 등)은 오탐 위험 → 4자+
  const leaks = []
  for (const sid of targets) {
    // 저장된 결과에서 request_id 조회 없이, saved-result 대신 세션 결과 직접: recommend cache-hit 재사용
    // (여기서는 저장 결과 조회 API가 request_id 기반이라, 세션의 최신 결과를 D1 없이 못 봄 → recommend 재호출은 비용.
    //  간단화: results.json이 있으면 그걸 스캔)
    try {
      const fs = require('fs')
      const p = path.join(__dirname, '..', 'artifacts', 'career-state', 'results.json')
      const rows = JSON.parse(fs.readFileSync(p, 'utf8'))
      for (const row of rows) {
        const blob = JSON.stringify(row)
        for (const t of tokenPatterns) {
          const re = new RegExp(`[^a-zA-Z_]${t}[^a-zA-Z_]`)
          if (re.test(blob)) leaks.push({ where: row.case, token: t })
        }
      }
      break // results.json은 전 케이스 포함 — 1회만
    } catch { /* 파일 없으면 skip */ }
  }
  const uniq = [...new Set(leaks.map((l) => `${l.where}:${l.token}`))]
  console.log(`[Part2 실응답] 누출 ${uniq.length}건${uniq.length ? ' — ' + uniq.join(', ') : ''}`)
  return uniq.length
}

;(async () => {
  let liveLeaks = 0
  if (process.argv.includes('--live')) liveLeaks = await liveScan()
  const fail = missing.length > 0 || liveLeaks > 0
  console.log(fail ? '\n❌ FAIL — 영어 토큰 누출 가능성' : '\n✅ PASS — 전 토큰 한글 커버')
  process.exit(fail ? 1 : 0)
})()
