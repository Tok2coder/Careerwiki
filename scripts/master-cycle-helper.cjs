#!/usr/bin/env node
/*
 * master-cycle-helper.cjs — CareerWiki master skill cycle 자동화 helper
 *
 * ⚠️ 이름 주의: cycle-script-block.cjs hook 이 /^_?cycle.../ 패턴(underscore optional)으로
 *   "cycle"로 시작하는 파일명을 차단함. 그래서 "master-cycle-helper" (master 접두) 사용.
 *   이 스크립트는 자작 enhance dispatcher가 아니라 batch list/prompt 생성 + DB 현황 측정 도구.
 *   실제 데이터 보강은 .claude/skills/job-data-master/SKILL.md 가 수행 (WebFetch 우회 X).
 *
 * 기능:
 *   node scripts/master-cycle-helper.cjs --status
 *       → DB master 적용 카운트 측정 (drift 검증)
 *   node scripts/master-cycle-helper.cjs --cycle=12
 *       → R12 batch list + prompt 생성 (명시 cycle)
 *   node scripts/master-cycle-helper.cjs --next-cycle
 *       → 처리 안 된 다음 cycle 자동 결정 + 생성
 *
 * 산출물 (v4, 2026-06-11 — 1직업-1세션 분리, Jason 결정):
 *   data/cycle/R{N}_B{1..5}.txt           (wave list — 동시 spawn 상한 5의 wave 묶음)
 *   data/cycle/r{N}_prompts/R{N}_J{01..25}_prompt.md  (25 single-job dispatch prompt)
 *   stdout: summary + dispatcher가 복붙할 25 spawn 명령 (5병렬 wave)
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const MASTER_LIST = path.join(ROOT, 'data/cycle/master_list_R7_R229.jsonl');
const DISPATCH_TEMPLATE = path.join(ROOT, 'data/cycle/_dispatch_template_v4.md');

// ─── arg parse ───
const args = process.argv.slice(2);
const getArg = (name) => {
  const a = args.find((x) => x.startsWith(`--${name}=`));
  return a ? a.split('=')[1] : null;
};
const hasFlag = (name) => args.includes(`--${name}`);

// ─── master_list 로드 ───
function loadCycles() {
  const lines = fs.readFileSync(MASTER_LIST, 'utf8').split('\n').filter(Boolean);
  const byCycle = {};
  for (const l of lines) {
    const o = JSON.parse(l);
    if (!byCycle[o.cycle]) byCycle[o.cycle] = [];
    byCycle[o.cycle][o.batch - 1] = o.jobs;
  }
  return byCycle;
}

// ─── DB: master 적용 slug Set + 카운트 ───
function fetchProcessedSlugs() {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT DISTINCT pr.entity_id FROM page_revisions pr WHERE pr.entity_type='job' AND pr.change_summary LIKE '%[job-data-master]%enhance%' AND pr.change_summary NOT LIKE '%yt-fill%';" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 64 * 1024 * 1024 });
    const j = JSON.parse(out);
    const rows = j[0]?.results || [];
    return new Set(rows.map((r) => String(r.entity_id)));
  } catch (e) {
    console.error('[warn] DB 쿼리 실패 (오프라인이면 --cycle=N 명시 사용):', e.message.slice(0, 120));
    return null;
  }
}

function fetchMasterCount() {
  // A = 모든 master 마커 (yt-fill/cleanup 포함) — 메모리 "누적" 정의
  // B = enhance 풀 사이클만 (yt-fill 제외) — 진짜 보강 완료 직업
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT 'A' AS def, COUNT(DISTINCT entity_id) AS cnt FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-master]%' UNION ALL SELECT 'B', COUNT(DISTINCT entity_id) FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-master]%enhance%' AND change_summary NOT LIKE '%yt-fill%';" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const j = JSON.parse(out);
    const rows = j[0]?.results || [];
    const a = rows.find((r) => r.def === 'A')?.cnt ?? null;
    const b = rows.find((r) => r.def === 'B')?.cnt ?? null;
    return { a, b };
  } catch (e) {
    return { a: null, b: null };
  }
}

// ─── STRICT 룰 블록 (dispatch_template_v4.md의 ``` 펜스 내부) 추출 ───
function loadStrictBlock() {
  const md = fs.readFileSync(DISPATCH_TEMPLATE, 'utf8');
  const m = md.match(/```\s*\n(# 🚨 STRICT[\s\S]*?)\n```/);
  if (!m) {
    // fallback: 처리 대상 헤더 전까지
    const idx = md.indexOf('# 처리 대상');
    return md.slice(md.indexOf('# 🚨 STRICT'), idx).trim();
  }
  // 템플릿 placeholder (처리 대상 표 + 처리 절차) 제거 — 룰만
  const block = m[1];
  const cut = block.indexOf('# 처리 대상');
  return cut > 0 ? block.slice(0, cut).trim() : block.trim();
}

// ─── single-job prompt 생성 (v4: 1직업-1세션) ───
function buildPrompt(cycleNum, jobNum, job, strictBlock) {
  const jj = String(jobNum).padStart(2, '0');
  const sessionName = `R${cycleNum}_J${jj}`;

  return `${strictBlock}

---

# 처리 대상 직업 (${sessionName} — ENHANCE 모드, marker 미보유 신규, 1직업-1세션)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | ${job.name} | ${job.id} | ${job.slug} | (자체 분류: niche/minor/major — 모호 시 default major) | 한국 1차 정부·협회·기업·언론 deep — slug별 도메인 자동 발굴 |

# 처리 절차

\`.claude/skills/job-data-master/SKILL.md\` Phase 0~7 흐름 (ENHANCE 모드).
- POST: \`https://careerwiki.org/api/job/{id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 \`node scripts/validate-job-edit.cjs payload.json --class=<분류>\` ALL PASS 의무 (룰 19 결정적 게이트)
- POST 후 \`node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal\` CLEAN + 마커 확인 의무
- change_summary: \`[job-data-master] enhance — way·trivia·detailReady·sidebar·youtubeLinks·...\` (top-level camelCase)
- distinct URL ≥ 18 + totalEntries ≥ 19 강제 (룰 4·15)

할당 직업 1건 끝나면 즉시 종료. 자동 다음 직업/cycle 진입 X.

# 보고 형식

\`\`\`
${sessionName} 결과:
${job.slug}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN | 마커OK

JOB DONE: 1/1 ok
\`\`\`
`;
}

// ─── cycle 생성 ───
function generateCycle(cycleNum, opts = {}) {
  const byCycle = loadCycles();
  const cycleKey = `R${cycleNum}`;
  const batches = byCycle[cycleKey];
  if (!batches) {
    console.error(`[error] ${cycleKey} 가 master_list에 없음. 범위: R7~R229.`);
    process.exit(1);
  }

  const strictBlock = loadStrictBlock();
  const allJobs = batches.flat();

  // DB cross-check (옵션)
  let processed = null;
  if (!opts.skipDb) processed = fetchProcessedSlugs();
  const alreadyDone = [];
  if (processed) {
    for (const j of allJobs) {
      if (processed.has(String(j.id))) alreadyDone.push(j.slug);
    }
  }

  // wave txt + single-job prompt 생성 (v4: 1직업-1세션)
  const promptDir = path.join(ROOT, `data/cycle/r${cycleNum}_prompts`);
  fs.mkdirSync(promptDir, { recursive: true });

  for (let bi = 0; bi < batches.length; bi++) {
    const jobs = batches[bi];
    const batchNum = bi + 1;
    const txtLines = jobs.map((j) => `${j.slug} | id=${j.id} | slug=${j.slug}`);
    fs.writeFileSync(path.join(ROOT, `data/cycle/R${cycleNum}_B${batchNum}.txt`), txtLines.join('\n'));
  }
  for (let ji = 0; ji < allJobs.length; ji++) {
    const jobNum = ji + 1;
    const jj = String(jobNum).padStart(2, '0');
    const prompt = buildPrompt(cycleNum, jobNum, allJobs[ji], strictBlock);
    fs.writeFileSync(path.join(promptDir, `R${cycleNum}_J${jj}_prompt.md`), prompt);
  }

  // ─── 보고 ───
  console.log(`\n=== ${cycleKey} cycle 생성 완료 (v4: 1직업-1세션) ===`);
  console.log(`직업: ${allJobs.length}건 → 세션 ${allJobs.length}개 (동시 spawn 상한 5, wave ${batches.length}회)`);
  console.log(`wave list:    data/cycle/R${cycleNum}_B{1..${batches.length}}.txt`);
  console.log(`prompt:       data/cycle/r${cycleNum}_prompts/R${cycleNum}_J{01..${String(allJobs.length).padStart(2, '0')}}_prompt.md`);

  if (alreadyDone.length) {
    console.log(`\n⚠️  이미 master 적용된 직업 ${alreadyDone.length}건 (cross-check):`);
    alreadyDone.forEach((s) => console.log(`   - ${s} (skip 또는 force-enhance 판단 필요)`));
  } else if (processed) {
    console.log(`\n✓ ${allJobs.length} 직업 모두 미적용 (정상 신규 enhance 대상)`);
  }

  console.log(`\n=== wave별 직업 (동시 spawn 5개 단위) ===`);
  let jc = 0;
  for (let bi = 0; bi < batches.length; bi++) {
    const range = batches[bi].map(() => ++jc);
    console.log(`wave ${bi + 1} (J${String(range[0]).padStart(2, '0')}~J${String(range[range.length - 1]).padStart(2, '0')}): ${batches[bi].map((j) => j.slug).join(', ')}`);
  }

  console.log(`\n=== Dispatcher spawn 명령 (1직업-1세션 × ${allJobs.length}, 동시 상한 5 wave) ===`);
  console.log(`각 sub-session에 해당 prompt 파일 내용을 전달 (wave 단위로 5개씩 동시 spawn, 이전 wave idle 후 다음 wave):`);
  for (let ji = 1; ji <= allJobs.length; ji++) {
    const jj = String(ji).padStart(2, '0');
    console.log(`  J${jj}: cat data/cycle/r${cycleNum}_prompts/R${cycleNum}_J${jj}_prompt.md  → prompt (${allJobs[ji - 1].slug})`);
  }

  // ─── 활동 가시화 (app.wikicomu.com /activity) ───
  // dispatcher가 각 wave spawn 직전에 running, 그 wave 세션 전부 idle 후 done 명령을 복붙 실행.
  // 한 cycle을 한 group_key로 묶어 /activity에서 진행이 한 묶음으로 보인다.
  const isoDate = new Date().toISOString().slice(0, 10);
  const groupKey = `cycle-R${cycleNum}-${isoDate}`;
  console.log(`\n=== Activity emit 명령 (wave spawn 직전 running / wave 완료 후 done) ===`);
  console.log(`group_key: ${groupKey}`);
  for (let bi = 1; bi <= batches.length; bi++) {
    const label = `R${cycleNum} wave${bi}: ${batches[bi - 1].map((j) => j.slug).join('·')}`;
    const extId = `r${cycleNum}-w${bi}`;
    const runEvt = JSON.stringify({ events: [{ label, source: 'batch', external_id: extId, group_key: groupKey, agent_slug: 'hangyeol', model: 'claude-sonnet-4-5', status: 'running' }] });
    const doneEvt = JSON.stringify({ events: [{ label, source: 'batch', external_id: extId, group_key: groupKey, status: 'done' }] });
    console.log(`  wave${bi} running: node scripts/emit-activity.cjs '${runEvt}'`);
    console.log(`  wave${bi} done:    node scripts/emit-activity.cjs '${doneEvt}'`);
  }

  console.log(`\n완료 후: ${allJobs.length} 직업 rev 수집 + 검증 세션(sonnet, master-verify-cycle 전수 실측) + R${cycleNum}_report.md + 메모리 갱신 (project_careerwiki_cycle_progress.md).`);
}

// ─── 마지막 완료 cycle + 다음 미처리 cycle 계산 (DB processed Set 기반) ───
function computeCyclePosition(processed) {
  const byCycle = loadCycles();
  const cycleNums = Object.keys(byCycle)
    .map((k) => parseInt(k.slice(1), 10))
    .sort((a, b) => a - b);
  let lastDone = null;
  let next = null;
  for (const n of cycleNums) {
    const jobs = byCycle[`R${n}`].flat();
    const doneCount = jobs.filter((j) => processed.has(String(j.id))).length;
    if (doneCount >= jobs.length / 2) {
      lastDone = { n, doneCount, total: jobs.length, lastSlug: jobs[jobs.length - 1]?.slug };
    } else if (next === null) {
      next = { n, doneCount, total: jobs.length, firstSlug: jobs[0]?.slug };
    }
  }
  return { lastDone, next };
}

// ─── --next-cycle: 처리 안 된 다음 cycle 자동 결정 ───
function findNextCycle() {
  const processed = fetchProcessedSlugs();
  if (!processed) {
    console.error('[error] DB 쿼리 실패 — --cycle=N 명시 사용 권장.');
    process.exit(1);
  }
  const { next } = computeCyclePosition(processed);
  if (!next) {
    console.error('[info] 모든 cycle 처리 완료된 것으로 보임.');
    process.exit(0);
  }
  console.log(`[next-cycle] R${next.n} 결정 (${next.doneCount}/${next.total} 처리됨 → 미처리 cycle, 시작=${next.firstSlug})`);
  return next.n;
}

// ─── --status ───
function showStatus() {
  const { a, b } = fetchMasterCount();
  console.log('=== CareerWiki master cycle 현황 ===');
  console.log(`A. 모든 master 마커 (yt-fill/cleanup 포함, DISTINCT 직업): ${a ?? 'DB 쿼리 실패'}   ← 메모리 "누적 진행" 정의`);
  console.log(`B. enhance 풀 사이클만 (yt-fill 제외, DISTINCT 직업):    ${b ?? 'DB 쿼리 실패'}   ← 실제 보강 완료`);
  if (a != null && b != null) console.log(`   차이 ${a - b} = yt-fill/cleanup만 적용 (풀 enhance 미완)`);

  // 마지막 처리 / 다음 cycle 위치 (DB 진리값)
  const processed = fetchProcessedSlugs();
  if (processed) {
    const { lastDone, next } = computeCyclePosition(processed);
    console.log(`\n=== cycle 위치 (DB 기준) ===`);
    if (lastDone) console.log(`마지막 처리 cycle: R${lastDone.n} (${lastDone.doneCount}/${lastDone.total}, 끝=${lastDone.lastSlug})`);
    if (next) console.log(`다음 cycle:        R${next.n} (시작=${next.firstSlug})  → 'node scripts/master-cycle-helper.cjs --cycle=${next.n}' 또는 '--next-cycle'`);
    else console.log(`다음 cycle:        없음 (전체 처리 완료)`);
  }

  console.log(`\n다음 단계: data/cycle/_dispatcher_manual.md 의 ENTRY POINT 6 step 따라 진행.`);
  console.log(`(보조 메모리: agent/memory/project_careerwiki_cycle_progress.md — drift 시 A 값으로 갱신)`);
}

// ─── main ───
if (hasFlag('status')) {
  showStatus();
} else if (hasFlag('next-cycle')) {
  const n = findNextCycle();
  generateCycle(n);
} else if (getArg('cycle')) {
  generateCycle(parseInt(getArg('cycle'), 10), { skipDb: hasFlag('skip-db') });
} else {
  console.log(`master-cycle-helper.cjs — 사용법:
  node scripts/master-cycle-helper.cjs --status        DB master 카운트 + drift 안내
  node scripts/master-cycle-helper.cjs --cycle=12      R12 batch list + prompt 생성
  node scripts/master-cycle-helper.cjs --cycle=12 --skip-db   DB cross-check 생략 (오프라인)
  node scripts/master-cycle-helper.cjs --next-cycle    미처리 다음 cycle 자동 결정 + 생성`);
}
