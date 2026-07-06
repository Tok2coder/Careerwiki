#!/usr/bin/env node
/**
 * Stale Embedding Backfill Runner (2026-07-06 P0)
 *
 * 배경: /api/job/:id/edit 경로에 재인덱싱 훅이 없어 활성 직업 2,875건(41%)의
 * Vectorize 임베딩이 2026-02-23 상태로 고정된 사고의 backfill.
 *
 * 동작: prod의 /api/ai-analyzer/admin/incremental-upsert(-majors)를 반복 호출.
 * 서버 측 incrementalUpsertToVectorize가 신규/버전불일치/stale을 조건 기반으로
 * 선택하므로 이 스크립트는 체크포인트 불필요 — 중단 후 재실행해도 이어서 처리.
 *
 * Usage:
 *   node scripts/backfill-stale-embeddings.cjs            # 직업 + 전공 전체
 *   node scripts/backfill-stale-embeddings.cjs --dry-run  # 잔여 카운트만 확인
 *   node scripts/backfill-stale-embeddings.cjs --max-calls=5  # 부분 실행
 */

const fs = require('fs')
const path = require('path')

const BASE = 'https://careerwiki.org/api/ai-analyzer'
const PER_CALL = 50           // 호출당 max_jobs (CPU 한도 보수 대응 — merged_profile_json 대량 JSON.parse 억제)
const CALL_GAP_MS = 2000
const MAX_CONSECUTIVE_FAILS = 5

function loadAdminSecret() {
  if (process.env.ADMIN_SECRET) return process.env.ADMIN_SECRET
  try {
    const devVars = fs.readFileSync(path.join(__dirname, '..', '.dev.vars'), 'utf-8')
    const m = devVars.match(/^ADMIN_SECRET\s*=\s*"?([^"\r\n]+)"?/m)
    if (m) return m[1]
  } catch {}
  return 'careerwiki-admin-2026'
}

const SECRET = loadAdminSecret()
const HEADERS = { 'Content-Type': 'application/json', 'X-Admin-Secret': SECRET }

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))
const log = (msg) => console.log(`[BACKFILL] ${new Date().toISOString()} ${msg}`)

async function getStatus() {
  const res = await fetch(`${BASE}/admin/indexing-status`, { headers: HEADERS })
  if (!res.ok) throw new Error(`indexing-status HTTP ${res.status}`)
  return res.json()
}

async function runLoop(endpoint, payloadKey, label, maxCalls) {
  let total = { upserted: 0, errors: 0 }
  let fails = 0
  for (let call = 1; maxCalls === 0 || call <= maxCalls; call++) {
    let json
    try {
      const res = await fetch(`${BASE}${endpoint}`, {
        method: 'POST',
        headers: HEADERS,
        body: JSON.stringify({ [payloadKey]: PER_CALL }),
      })
      if (!res.ok) throw new Error(`HTTP ${res.status}: ${(await res.text()).slice(0, 200)}`)
      json = await res.json()
    } catch (e) {
      fails++
      log(`${label} call#${call} FAIL (${fails}/${MAX_CONSECUTIVE_FAILS}): ${e.message}`)
      if (fails >= MAX_CONSECUTIVE_FAILS) {
        log(`${label} 연속 실패 한도 도달 — 중단 (재실행 시 이어서 처리됨)`)
        break
      }
      await sleep(5000 * fails)
      continue
    }
    fails = 0
    const up = json.upserted || 0
    const er = json.errors || 0
    total.upserted += up
    total.errors += er
    log(`${label} call#${call}: upserted=${up} errors=${er} (누적 ${total.upserted}/${total.errors})`)
    if (up === 0 && er === 0) {
      log(`${label} 잔여 0 — 완료`)
      break
    }
    if (up === 0 && er > 0) {
      log(`${label} 에러만 반복 — 중단 (서버 로그 확인 필요)`)
      break
    }
    await sleep(CALL_GAP_MS)
  }
  return total
}

async function main() {
  const dryRun = process.argv.includes('--dry-run')
  const maxCallsArg = process.argv.find((a) => a.startsWith('--max-calls='))
  const maxCalls = maxCallsArg ? parseInt(maxCallsArg.split('=')[1], 10) : 0

  log(`시작 — dry-run=${dryRun} maxCalls=${maxCalls || '무제한'}`)

  const before = await getStatus().catch((e) => ({ error: e.message }))
  log(`사전 상태: ${JSON.stringify(before)}`)
  if (dryRun) return

  const jobs = await runLoop('/admin/incremental-upsert', 'max_jobs', 'jobs', maxCalls)
  const majors = await runLoop('/admin/incremental-upsert-majors', 'max_items', 'majors', maxCalls)

  const after = await getStatus().catch((e) => ({ error: e.message }))
  log(`사후 상태: ${JSON.stringify(after)}`)
  log(`완료 — jobs upserted=${jobs.upserted} errors=${jobs.errors} / majors upserted=${majors.upserted} errors=${majors.errors}`)
  if (jobs.errors > 0 || majors.errors > 0) process.exitCode = 1
}

main().catch((e) => {
  log(`FATAL: ${e.message}`)
  process.exit(1)
})
