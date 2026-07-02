#!/usr/bin/env node
// B6: 전공 M-cycle 명단 생성 — data/cycle/major_list_M0_M25.jsonl
// M0(파일럿 5, 대표 전공 고정) + M1~(가나다순 25/cycle, 5전공×5배치)
// 검증: 총 607, slug 중복 0, M0∩M1~ 교집합 0
const { spawnSync } = require('child_process')
const fs = require('fs')
const path = require('path')

const PILOT_SLUGS = ['컴퓨터공학과', '기계공학과', '사회복지학과', '유아교육학과', '식품영양학과']

function d1(sql) {
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${sql}"`, {
    shell: true, encoding: 'utf8', maxBuffer: 64 * 1024 * 1024,
  })
  const out = (r.stdout || '') + ''
  const i = out.indexOf('[')
  if (i < 0) { console.error(out, r.stderr); throw new Error('no JSON in wrangler output') }
  const parsed = JSON.parse(out.slice(i))
  return parsed[0].results
}

const rows = d1("SELECT id, slug, name FROM majors WHERE is_active=1 ORDER BY name")
if (rows.length !== 607) throw new Error(`expected 607 active majors, got ${rows.length}`)
const slugs = new Set(rows.map(r => r.slug))
if (slugs.size !== rows.length) throw new Error('slug duplicate detected')

const pilot = PILOT_SLUGS.map(s => {
  const m = rows.find(r => r.slug === s)
  if (!m) throw new Error(`pilot slug not found: ${s}`)
  return m
})
const rest = rows.filter(r => !PILOT_SLUGS.includes(r.slug))
if (pilot.length + rest.length !== 607) throw new Error('partition mismatch')

const lines = []
// M0: 파일럿 1배치 5전공
lines.push(JSON.stringify({ cycle: 'M0', batch: 1, jobs: pilot }))
// M1~: 25/cycle = 5배치×5
let cycle = 1
for (let i = 0; i < rest.length; i += 25) {
  const chunk = rest.slice(i, i + 25)
  for (let b = 0; b < Math.ceil(chunk.length / 5); b++) {
    lines.push(JSON.stringify({ cycle: `M${cycle}`, batch: b + 1, jobs: chunk.slice(b * 5, b * 5 + 5) }))
  }
  cycle++
}

const outPath = path.join(__dirname, '..', 'data', 'cycle', 'major_list_M0_M25.jsonl')
fs.writeFileSync(outPath, lines.join('\n') + '\n', 'utf8')

// 재검증 (파일 재읽기 기준)
const back = fs.readFileSync(outPath, 'utf8').trim().split('\n').map(l => JSON.parse(l))
const all = back.flatMap(e => e.jobs)
const backSlugs = new Set(all.map(j => j.slug))
console.log(JSON.stringify({
  lines: back.length,
  totalMajors: all.length,
  distinctSlugs: backSlugs.size,
  cycles: [...new Set(back.map(e => e.cycle))].length,
  lastCycle: back[back.length - 1].cycle,
  lastCycleSize: all.length === backSlugs.size ? back.filter(e => e.cycle === back[back.length - 1].cycle).flatMap(e => e.jobs).length : -1,
  pilotOk: back[0].cycle === 'M0' && back[0].jobs.length === 5,
}))
