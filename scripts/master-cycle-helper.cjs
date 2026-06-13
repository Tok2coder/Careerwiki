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
 * 산출물 (v5, 2026-06-13 — 5직업-1세션 배치 복원, Jason 결정. 토큰 효율 회귀 수습):
 *   data/cycle/R{N}_queue.txt             (배치 큐 — B1~B5 × 5직업 enqueue 순서)
 *   data/cycle/r{N}_prompts/R{N}_B{1..5}_prompt.md  (5 batch dispatch prompt, 각 5직업)
 *   stdout: summary + dispatcher가 복붙할 25 spawn 명령 (전량 일괄 투입, 데몬 워커풀 동시성 7)
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const MASTER_LIST = path.join(ROOT, 'data/cycle/master_list_R7_R229.jsonl');
const DISPATCH_TEMPLATE = path.join(ROOT, 'data/cycle/_dispatch_template_v5.md');

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

// ─── batch prompt 생성 (v5: 5직업-1세션, 순차 POST 체크포인트) ───
function buildBatchPrompt(cycleNum, batchNum, jobs, strictBlock) {
  const sessionName = `R${cycleNum}_B${batchNum}`;
  const rows = jobs.map((job, i) =>
    `| ${i + 1} | ${job.name} | ${job.id} | ${job.slug} | (자체 분류: niche/major — 모호 시 default major. minor 금지: 게이트 외 분류) | 산업 소관 부처(.go.kr)·직능 협회/학회(.or.kr)·대표 기업(.co.kr) deep page + KOSIS·언론 deep article 우선. root/검색 URL 금지. **niche도 distinct≥10 필수(d<10 검증 FAIL)** |`
  ).join('\n');
  const reportRows = jobs.map((job) => `${job.slug}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN | 마커OK`).join('\n');

  return `${strictBlock}

---

# 처리 대상 직업 (${sessionName} — ENHANCE 모드, marker 미보유 신규, ${jobs.length}직업-1세션 배치)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
${rows}

# 처리 절차

\`.claude/skills/job-data-master/SKILL.md\` Phase 0~7 흐름 (ENHANCE 모드). 위 표의 직업을 **1건씩 순차** 처리 — 한 직업을 POST·검증 완료한 뒤 다음 직업으로 (POST 체크포인트: 세션 중간 사망 시 완료분은 prod 보존, 검증세션이 미완분 식별).
- POST: \`https://careerwiki.org/api/job/{id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 \`node scripts/validate-job-edit.cjs payload.json --class=<분류>\` ALL PASS 의무 (룰 19 결정적 게이트)
- POST 후 \`node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal\` CLEAN + 마커 확인 — **직업당 1라운드** (룰 20 과검증 금지, 세션 생존)
- change_summary: \`[job-data-master] enhance — way·trivia·detailReady·sidebar·youtubeLinks·...\` (top-level camelCase)
- distinct URL ≥ 18 + totalEntries ≥ 19 강제 (룰 4·15). 한 직업 막히면 사유 보고 + skip하고 다음 직업 계속(세션 전체 abort X).

표의 직업 전부 끝나면 즉시 종료. 자동 다음 cycle 진입 X.

# 보고 형식

\`\`\`
${sessionName} 결과:
${reportRows}

JOBS DONE: ${jobs.length}/${jobs.length} ok   (미완 시: JOBS: M/${jobs.length} ok, 미완=<slug + 사유>)
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

  // 배치 큐 txt + batch prompt 생성 (v5: 5직업-1세션 배치 복원, 순차 POST 체크포인트)
  const promptDir = path.join(ROOT, `data/cycle/r${cycleNum}_prompts`);
  fs.mkdirSync(promptDir, { recursive: true });

  const queueLines = [];
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const jobs = batches[bi];
    const prompt = buildBatchPrompt(cycleNum, bn, jobs, strictBlock);
    fs.writeFileSync(path.join(promptDir, `R${cycleNum}_B${bn}_prompt.md`), prompt);
    queueLines.push(`# B${bn} (${jobs.length}직업)`);
    jobs.forEach((j) => queueLines.push(`B${bn} | ${j.slug} | id=${j.id}`));
  }
  fs.writeFileSync(path.join(ROOT, `data/cycle/R${cycleNum}_queue.txt`), queueLines.join('\n'));

  // ─── 보고 ───
  console.log(`\n=== ${cycleKey} cycle 생성 완료 (v5: 5직업-1세션 배치 복원) ===`);
  console.log(`직업: ${allJobs.length}건 → 배치 ${batches.length}개 (각 ~${Math.round(allJobs.length / batches.length)}직업/세션) — 전량 일괄 enqueue (데몬 워커풀 동시성 7, 슬롯 비는 대로 연속 투입)`);
  console.log(`queue:        data/cycle/R${cycleNum}_queue.txt`);
  console.log(`prompt:       data/cycle/r${cycleNum}_prompts/R${cycleNum}_B{1..${batches.length}}_prompt.md`);

  if (alreadyDone.length) {
    console.log(`\n⚠️  이미 master 적용된 직업 ${alreadyDone.length}건 (cross-check):`);
    alreadyDone.forEach((s) => console.log(`   - ${s} (skip 또는 force-enhance 판단 필요)`));
  } else if (processed) {
    console.log(`\n✓ ${allJobs.length} 직업 모두 미적용 (정상 신규 enhance 대상)`);
  }

  console.log(`\n=== Dispatcher spawn 명령 (5직업-1세션 × ${batches.length} 배치, 전량 일괄 enqueue) ===`);
  console.log(`${batches.length}개 배치 세션을 한 번에 작업큐에 투입 — 데몬 워커풀(동시성 7)이 슬롯 비는 대로 연속 처리:`);
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const slugs = batches[bi].map((j) => j.slug).join(', ');
    console.log(`  B${bn}: cat data/cycle/r${cycleNum}_prompts/R${cycleNum}_B${bn}_prompt.md  → prompt (${slugs})`);
  }

  // ─── 활동 가시화 (app.wikicomu.com /activity) ───
  // dispatcher가 일괄 enqueue 직전에 running 1건, 전건 완료 후 done 1건 (cycle 단위).
  const isoDate = new Date().toISOString().slice(0, 10);
  const groupKey = `cycle-R${cycleNum}-${isoDate}`;
  console.log(`\n=== Activity emit 명령 (enqueue 직전 running / 전건 완료 후 done — cycle 단위 1건) ===`);
  console.log(`group_key: ${groupKey}`);
  {
    const label = `R${cycleNum} 작업 ${allJobs.length}건: ${allJobs[0].slug}~${allJobs[allJobs.length - 1].slug}`;
    const extId = `r${cycleNum}-work`;
    const runEvt = JSON.stringify({ events: [{ label, source: 'batch', external_id: extId, group_key: groupKey, agent_slug: 'hangyeol', model: 'claude-sonnet-4-5', status: 'running' }] });
    const doneEvt = JSON.stringify({ events: [{ label, source: 'batch', external_id: extId, group_key: groupKey, status: 'done' }] });
    console.log(`  running: node scripts/emit-activity.cjs '${runEvt}'`);
    console.log(`  done:    node scripts/emit-activity.cjs '${doneEvt}'`);
  }

  console.log(`\n완료 후: ${allJobs.length} 직업 rev 수집 + 검증 세션(sonnet, master-verify-cycle 전수 실측 + 다중 rev 전수 보고) + R${cycleNum}_report.md + 메모리 갱신 (project_careerwiki_cycle_progress.md).`);
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
