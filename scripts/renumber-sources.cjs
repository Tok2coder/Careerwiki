#!/usr/bin/env node
/**
 * renumber-sources.cjs
 *
 * _sources 전역 ID를 페이지 표시 순서(SOURCE_FIELD_ORDER)로 재정렬하고 1부터 재발급.
 * editService의 renumberSourceIds 로직과 동일한 순서를 사용.
 *
 * 사용법:
 *   node scripts/renumber-sources.cjs --all                        전체 직업
 *   node scripts/renumber-sources.cjs --slugs "건설견적원,건설기계운전원"  특정 직업
 *   node scripts/renumber-sources.cjs --all --dry-run               변경사항 출력만
 */

const { execSync, spawnSync } = require('child_process')
const fs = require('fs')
const os = require('os')
const path = require('path')

// ── 설정 ────────────────────────────────────────────────────────────────────
const API_BASE = 'https://careerwiki.org/api/job'
const ADMIN_SECRET = 'careerwiki-admin-2026'

// job-editor.ts SOURCE_FIELD_ORDER 및 full-quality-audit.cjs TEXT_FIELDS_ORDER와 동일
const SOURCE_FIELD_ORDER = [
  'summary',
  'overviewWork.main',
  'overviewProspect.main',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'overviewSalary.sal',
  'trivia',
  'overviewAbilities.technKnow',
  'way',
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.certificate',
  'detailReady.training',
  'sidebarCerts',
]

// ── CLI 파싱 ─────────────────────────────────────────────────────────────────
const args = process.argv.slice(2)
const isDryRun = args.includes('--dry-run')
const isAll = args.includes('--all')
const slugsIdx = args.indexOf('--slugs')
const slugFilter = slugsIdx >= 0 ? args[slugsIdx + 1]?.split(',').map(s => s.trim()).filter(Boolean) : null

if (!isAll && !slugFilter) {
  console.error('사용법: node scripts/renumber-sources.cjs --all [--dry-run]')
  console.error('        node scripts/renumber-sources.cjs --slugs "slug1,slug2" [--dry-run]')
  process.exit(1)
}

// ── 핵심 로직 ────────────────────────────────────────────────────────────────

function renumberSourceIds(sources) {
  const entries = []
  for (const [fieldKey, val] of Object.entries(sources)) {
    const arr = Array.isArray(val) ? val : [val]
    const displayOrder = SOURCE_FIELD_ORDER.indexOf(fieldKey)
    arr.forEach(item => {
      if (item && (item.text || item.url)) {
        entries.push({
          fieldKey,
          item,
          displayOrder: displayOrder >= 0 ? displayOrder : 999,
          originalId: item.id ?? 0,
        })
      }
    })
  }
  entries.sort((a, b) => {
    if (a.displayOrder !== b.displayOrder) return a.displayOrder - b.displayOrder
    return a.originalId - b.originalId
  })
  const result = {}
  entries.forEach((entry, idx) => {
    if (!result[entry.fieldKey]) result[entry.fieldKey] = []
    result[entry.fieldKey].push({ ...entry.item, id: idx + 1 })
  })
  return result
}

function sourcesNeedRenumber(sources) {
  const entries = []
  for (const [fieldKey, val] of Object.entries(sources)) {
    const arr = Array.isArray(val) ? val : [val]
    const displayOrder = SOURCE_FIELD_ORDER.indexOf(fieldKey)
    arr.forEach(item => {
      if (item && (item.text || item.url)) {
        entries.push({ displayOrder: displayOrder >= 0 ? displayOrder : 999, id: item.id ?? 0 })
      }
    })
  }
  entries.sort((a, b) => {
    if (a.displayOrder !== b.displayOrder) return a.displayOrder - b.displayOrder
    return a.id - b.id
  })
  // ID가 1부터 연속 오름차순이면 이미 정렬된 상태
  for (let i = 0; i < entries.length; i++) {
    if (entries[i].id !== i + 1) return true
  }
  return false
}

function diffSources(before, after) {
  const lines = []
  const allKeys = new Set([...Object.keys(before), ...Object.keys(after)])
  for (const key of [...allKeys].sort()) {
    const bArr = before[key] || []
    const aArr = after[key] || []
    const changed = JSON.stringify(bArr) !== JSON.stringify(aArr)
    if (changed) {
      lines.push(`  [${key}]`)
      bArr.forEach((s, i) => {
        const newId = aArr[i]?.id ?? '?'
        if (s.id !== newId) lines.push(`    [${i}] id ${s.id} → ${newId}  "${s.text}"`)
      })
    }
  }
  return lines.join('\n')
}

// ── D1 쿼리 ──────────────────────────────────────────────────────────────────

function queryD1(sql) {
  // shell:'bash' 사용 → 한국어 포함 SQL도 UTF-8로 안전하게 전달
  const escaped = sql.replace(/"/g, '\\"')
  const raw = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --command "${escaped}" 2>/dev/null`,
    { encoding: 'utf8', shell: 'bash', maxBuffer: 50 * 1024 * 1024 }
  )
  const jsonMatch = raw.match(/\[\s*\{[\s\S]*\}\s*\]/)
  if (!jsonMatch) return []
  const parsed = JSON.parse(jsonMatch[0])
  return parsed[0]?.results || []
}

// ── 메인 ─────────────────────────────────────────────────────────────────────

async function main() {
  console.log(`\n🔢 renumber-sources — ${isDryRun ? 'DRY RUN' : '실제 저장'}`)
  console.log('─'.repeat(60))

  // 대상 직업 쿼리
  let rows
  if (isAll) {
    rows = queryD1(
      "SELECT id, slug, name, user_contributed_json FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL AND user_contributed_json LIKE '%_sources%'"
    )
  } else {
    const slugList = slugFilter.map(s => `'${s}'`).join(',')
    rows = queryD1(
      `SELECT id, slug, name, user_contributed_json FROM jobs WHERE slug IN (${slugList})`
    )
  }

  if (!rows || rows.length === 0) {
    console.log('대상 직업 없음.')
    return
  }

  console.log(`대상 직업: ${rows.length}개\n`)

  let changed = 0, skipped = 0, failed = 0

  for (const row of rows) {
    const { id, slug, name } = row
    let ucj
    try {
      ucj = typeof row.user_contributed_json === 'string'
        ? JSON.parse(row.user_contributed_json)
        : row.user_contributed_json
    } catch {
      console.log(`  ⚠️  ${name} (${slug}): UCJ 파싱 실패 — 스킵`)
      skipped++
      continue
    }

    const sources = ucj._sources
    if (!sources || typeof sources !== 'object' || Object.keys(sources).length === 0) {
      skipped++
      continue
    }

    if (!sourcesNeedRenumber(sources)) {
      console.log(`  ✅ ${name} — 이미 정렬됨, 스킵`)
      skipped++
      continue
    }

    const renumbered = renumberSourceIds(sources)
    const diff = diffSources(sources, renumbered)

    if (isDryRun) {
      console.log(`  📋 ${name} (${slug}) — 변경 필요:`)
      console.log(diff || '    (변경 없음)')
      changed++
      continue
    }

    // 실제 API 제출: 전체 _sources를 renumbered로 교체
    // editService의 renumberSourceIds가 다시 한번 정렬하지만 결과는 동일
    const payload = JSON.stringify({
      jobName: name,
      jobId: id,
      fields: {},
      sources: renumbered,
      changeSummary: `_sources ID 재발급: SOURCE_FIELD_ORDER 기준 1~N 재정렬`,
    })

    const tmpFileWin = path.join(os.tmpdir(), `renumber_payload_${id}.json`)
    // Convert Windows path to bash-compatible path (C:\foo\bar → /c/foo/bar)
    const tmpFile = tmpFileWin.replace(/\\/g, '/').replace(/^([A-Za-z]):/, (_, d) => `/${d.toLowerCase()}`)
    try {
      fs.writeFileSync(tmpFileWin, payload, 'utf8')
      const result = execSync(
        `curl -s -X POST "${API_BASE}/${id}/edit" -H "Content-Type: application/json" -H "X-Admin-Secret: ${ADMIN_SECRET}" --data-binary @${tmpFile}`,
        { encoding: 'utf8', shell: 'bash', maxBuffer: 1024 * 1024 }
      )
      fs.unlinkSync(tmpFileWin)
      const res = JSON.parse(result)
      if (res.success) {
        console.log(`  ✅ ${name} (${slug}) — revisionId: ${res.revisionId}`)
        console.log(diff)
        changed++
      } else {
        console.log(`  ❌ ${name} (${slug}) — API 실패: ${JSON.stringify(res)}`)
        failed++
      }
    } catch (e) {
      try { fs.unlinkSync(tmpFileWin) } catch {}
      console.log(`  ❌ ${name} (${slug}) — 예외: ${e.message}`)
      failed++
    }
  }

  console.log('\n' + '─'.repeat(60))
  console.log(`완료: 변경 ${changed}개 / 스킵 ${skipped}개 / 실패 ${failed}개`)

  if (!isDryRun && changed > 0) {
    console.log('\n감사 실행 중...\n')
    // 변경된 직업들만 감사 (--all의 경우 전체)
    if (isAll) {
      execSync('node scripts/full-quality-audit.cjs --all', { stdio: 'inherit' })
    } else {
      for (const slug of slugFilter) {
        execSync(`node scripts/full-quality-audit.cjs --slug=${slug}`, { stdio: 'inherit' })
      }
    }
  }
}

main().catch(e => {
  console.error('오류:', e.message)
  process.exit(1)
})
