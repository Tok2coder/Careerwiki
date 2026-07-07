#!/usr/bin/env node
/**
 * 커리어 현상태(career_state) 적합성 테스트 (2026-07-07, 차민혁)
 * — 각 유저의 현상태(고교생/대학생/경력전환/시니어/무경력)에 맞는 직업이 추천되는지 검증
 *
 * 결정적 플래그:
 *  - 저경력(고교생·무경력): top10 내 시니어/관리자급 직업 수 (0이 이상적)
 *  - 시니어(15년차): top10이 전부 주니어/보조급이면 문제
 * Usage: node scripts/career-state-test.cjs
 * 출력: artifacts/career-state/results.json + 콘솔 표
 */
const fs = require('fs')
const path = require('path')

const BASE = 'https://careerwiki.org/api/ai-analyzer'
const OUT = path.join(__dirname, '..', 'artifacts', 'career-state')
const { TEST_SCENARIOS } = require(path.join(__dirname, '..', 'artifacts', 'recsys-baseline', 'test-scenarios.cjs'))
const mmOf = (id) => JSON.parse(JSON.stringify(TEST_SCENARIOS.find((s) => s.id === id).miniModule))

const SENIOR_KW = ['수석', '책임', '시니어', '총괄', '관장', '원장', '소장', '부장', '팀장', '본부장', '실장', '이사', '임원', '관리자', '아키텍처', '아키텍트', '컨설턴트']
const ENTRY_KW = ['보조', '인턴', '어시스턴트', '사무원', '주니어']

// 페르소나 5종 — 미니모듈은 시나리오 재활용, career_state·background만 현상태별로 조정
const CASES = [
  {
    id: 'HS', desc: '고등학생 (창작 성향, 무경력)',
    mm: { ...mmOf('creative_user'), background_flags: [] },
    career_state: { role_identity: '고등학생', career_stage_years: '0년 (재학 중)' },
    expectBad: SENIOR_KW, expectBadLabel: '시니어/관리자급',
  },
  {
    id: 'UG', desc: '인문대 4학년 취준생 (사회공헌 성향)',
    mm: { ...mmOf('social_impact'), background_flags: [] },
    career_state: { role_identity: '대학생 (인문계열 4학년)', career_stage_years: '0년 (졸업 예정)' },
    expectBad: SENIOR_KW, expectBadLabel: '시니어/관리자급',
  },
  {
    id: 'CC', desc: '마케팅 5년차 경력 전환 희망 (분석 성향)',
    mm: mmOf('analytical_user'),
    career_state: { role_identity: '퍼포먼스 마케터', career_stage_years: '5년' },
    expectBad: null,
  },
  {
    id: 'SR', desc: '백엔드 개발자 15년차 (분석·전문성 성향)',
    mm: mmOf('analytical_user'),
    career_state: { role_identity: '백엔드 개발자', career_stage_years: '15년' },
    expectAllEntry: true, // top10이 전부 entry급이면 문제
  },
  {
    id: 'NB', desc: '20대 후반 무경력 구직자 (종합 성향)',
    mm: { ...mmOf('comprehensive_test'), background_flags: [] },
    career_state: { role_identity: '구직자 (직무 경험 없음)', career_stage_years: '0년' },
    expectBad: SENIOR_KW, expectBadLabel: '시니어/관리자급',
  },
]

const post = (u, b) => fetch(BASE + u, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(b) }).then((r) => r.json())

async function main() {
  fs.mkdirSync(OUT, { recursive: true })
  const results = []
  for (const c of CASES) {
    const sid = `cstate_${c.id}_v1` // 고정 세션 (엔진 버전으로 캐시 분리)
    const res = await post('/v3/recommend', { session_id: sid, mini_module_result: c.mm, career_state: c.career_state, skipReport: true })
    const top = res.recommendations?.top_jobs || []
    const names = top.map((j) => j.job_name)
    const seniorHits = names.filter((n) => SENIOR_KW.some((k) => n.includes(k)))
    const entryHits = names.filter((n) => ENTRY_KW.some((k) => n.includes(k)))
    const row = {
      case: c.id, desc: c.desc, engine: res.engine_version, cache_hit: res.cache_hit === true,
      top10: names,
      senior_in_top10: seniorHits, entry_in_top10: entryHits,
      top1_feasibility: top[0]?.feasibility_score ?? null,
      top1_feas_reason: (top[0]?.feasibility_reason || '').slice(0, 120),
      top3_rationale_snips: top.slice(0, 3).map((j) => (j.rationale || '').slice(0, 100)),
    }
    results.push(row)
    console.log(`\n[${c.id}] ${c.desc}`)
    console.log(`  top10: ${names.join(', ')}`)
    console.log(`  시니어급 포함: ${seniorHits.length}개 [${seniorHits.join(', ')}] | 엔트리급: ${entryHits.length}개`)
    console.log(`  top1 배경적합(feasibility): ${row.top1_feasibility} | 이유: ${row.top1_feas_reason}`)
    await new Promise((r) => setTimeout(r, 2000))
  }
  fs.writeFileSync(path.join(OUT, 'results.json'), JSON.stringify(results, null, 1))
  console.log('\n저장: artifacts/career-state/results.json')
}

main().catch((e) => { console.error(e); process.exit(1) })
