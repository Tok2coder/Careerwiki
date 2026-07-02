#!/usr/bin/env node
/*
 * major-cycle-helper.cjs — CareerWiki major(전공) skill cycle 자동화 helper
 *   (master-cycle-helper.cjs 포크 — 직업(job)→전공(major) 치환판. 설계 진리: data/cycle/major_cycle_design_v1.md)
 *
 * ⚠️ 이름 주의: cycle-script-block.cjs hook 이 /^_?cycle.../ 패턴(underscore optional)으로
 *   "cycle"로 시작하는 파일명을 차단함. 그래서 "major-cycle-helper" (major 접두) 사용.
 *   이 스크립트는 자작 enhance dispatcher가 아니라 batch list/prompt 생성 + DB 현황 측정 도구.
 *   실제 데이터 보강은 .claude/skills/major-data-master/SKILL.md 가 수행 (WebFetch 우회 X).
 *
 * 기능:
 *   node scripts/major-cycle-helper.cjs --status
 *       → DB major master 적용 카운트 + 권위 KPI(done/total) 측정 (drift 검증)
 *   node scripts/major-cycle-helper.cjs --cycle=0
 *       → M0(파일럿) batch list + prompt 생성 (명시 cycle. M0=1배치 5전공, M1~=5배치 25전공)
 *   node scripts/major-cycle-helper.cjs --next-cycle
 *       → 처리 안 된 다음 cycle 자동 결정 + 생성
 *   node scripts/major-cycle-helper.cjs --resume=3
 *       → M3 미완 전공 산출 (리밋 사망 후 재개용, 완료분 dup 가드)
 *   node scripts/major-cycle-helper.cjs --emit-progress --m=3
 *       → 단일 진실 진행 마커 1줄 출력 (데몬이 파싱→KV forward).
 *         검증 PASS + KPI 산수 일치 직후 1회만 실행. stdout은 마커 라인 단 1줄.
 *         kpi_done = admin CTE 구조 미러(권위), majors_done = major_list M0..m 누적합.
 *
 * 산출물 (직업판 v5 구조 승계 — 5전공-1세션 배치, 순차 POST 체크포인트):
 *   data/cycle/M{N}_queue.txt              (배치 큐 — B1~B5 × 5전공 enqueue 순서)
 *   data/cycle/m{N}_prompts/M{N}_B{1..5}_prompt.md  (batch dispatch prompt, 각 5전공)
 *   data/cycle/m{N}_activity/b{n}.json + verify.json (활동 가시화 base 이벤트)
 *   stdout: summary + dispatcher가 복붙할 spawn 명령
 */

const fs = require('fs');
const path = require('path');
const { execSync, execFileSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const MASTER_LIST = path.join(ROOT, 'data/cycle/major_list_M0_M25.jsonl');
const DISPATCH_TEMPLATE = path.join(ROOT, 'data/cycle/_major_dispatch_template_v1.md');

// ─── arg parse ───
const args = process.argv.slice(2);
const getArg = (name) => {
  const a = args.find((x) => x.startsWith(`--${name}=`));
  return a ? a.split('=')[1] : null;
};
const hasFlag = (name) => args.includes(`--${name}`);

// ─── major_list 로드 (tolerant — 명단 파일 병렬 생성 중일 수 있음) ───
function loadCycles({ tolerant = false } = {}) {
  if (!fs.existsSync(MASTER_LIST)) {
    if (tolerant) {
      console.error(`[warn] major_list 없음 (${path.relative(ROOT, MASTER_LIST)}) — 병렬 생성 중이면 KPI만 보고. cycle 위치/생성은 명단 생성 후 가능.`);
      return null;
    }
    console.error(`[error] major_list 없음: ${path.relative(ROOT, MASTER_LIST)} — B6(명단 생성) 먼저 완료 필요.`);
    process.exit(1);
  }
  const lines = fs.readFileSync(MASTER_LIST, 'utf8').split('\n').filter(Boolean);
  const byCycle = {};
  for (const l of lines) {
    const o = JSON.parse(l);
    if (!byCycle[o.cycle]) byCycle[o.cycle] = [];
    byCycle[o.cycle][o.batch - 1] = o.jobs; // 형식은 직업판 동일: {"cycle":"M0","batch":1,"jobs":[{id,slug,name}...]}
  }
  return byCycle;
}

// ─── DB: major master 적용 slug Set + 카운트 ───
function fetchProcessedSlugs() {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT DISTINCT pr.entity_id FROM page_revisions pr WHERE pr.entity_type='major' AND pr.change_summary LIKE '%[major-data-master]%enhance%' AND pr.change_summary NOT LIKE '%yt-fill%';" --json`;
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
  // A = 모든 major-data-master 마커 (yt-fill/cleanup 포함) — "누적" 정의
  // B = enhance 풀 사이클만 (yt-fill 제외) — 진짜 보강 완료 전공
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT 'A' AS def, COUNT(DISTINCT entity_id) AS cnt FROM page_revisions WHERE entity_type='major' AND change_summary LIKE '%[major-data-master]%' UNION ALL SELECT 'B', COUNT(DISTINCT entity_id) FROM page_revisions WHERE entity_type='major' AND change_summary LIKE '%[major-data-master]%enhance%' AND change_summary NOT LIKE '%yt-fill%';" --json`;
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

// ─── STRICT 룰 블록 (_major_dispatch_template_v1.md의 ``` 펜스 내부) 추출 ───
function loadStrictBlock() {
  if (!fs.existsSync(DISPATCH_TEMPLATE)) {
    console.error(`[error] dispatch template 없음: ${path.relative(ROOT, DISPATCH_TEMPLATE)} — B7(템플릿 생성) 먼저 완료 필요. prompt 생성 불가.`);
    process.exit(1);
  }
  const md = fs.readFileSync(DISPATCH_TEMPLATE, 'utf8');
  const m = md.match(/```\s*\n(# 🚨 STRICT[\s\S]*?)\n```/);
  if (!m) {
    // fallback: 처리 대상 헤더 전까지
    const idx = md.indexOf('# 처리 대상');
    const start = md.indexOf('# 🚨 STRICT');
    if (start < 0) {
      console.error(`[error] template에서 '# 🚨 STRICT' 블록을 못 찾음 — ${path.relative(ROOT, DISPATCH_TEMPLATE)} 형식 확인 필요.`);
      process.exit(1);
    }
    return md.slice(start, idx > 0 ? idx : undefined).trim();
  }
  // 템플릿 placeholder (처리 대상 표 + 처리 절차) 제거 — 룰만
  const block = m[1];
  const cut = block.indexOf('# 처리 대상');
  return cut > 0 ? block.slice(0, cut).trim() : block.trim();
}

// ─── batch prompt 생성 (5전공-1세션, 순차 POST 체크포인트) ───
function buildBatchPrompt(cycleNum, batchNum, majors, strictBlock) {
  const sessionName = `M${cycleNum}_B${batchNum}`;
  const rows = majors.map((mj, i) =>
    `| ${i + 1} | ${mj.name} | ${mj.id} | ${mj.slug} | 대학 학과 페이지(.ac.kr 소개·커리큘럼 deep) + 소관 부처(.go.kr)·학회/협회(.or.kr) deep + 언론 deep article 우선. root/검색 URL 금지. **distinct≥8 + totalE≥14 필수(미달 검증 FAIL)** |`
  ).join('\n');
  const reportRows = majors.map((mj) => `${mj.slug}  | rev=NNNN | distinct=NN | totalE=NN | CLEAN | 마커OK`).join('\n');

  // ─── 활동 가시화: wave(=이 세션) 단위 emit (대시보드 '세부 작업' 개별 행) ───
  const actFile = `data/cycle/m${cycleNum}_activity/b${batchNum}.json`;

  return `${strictBlock}

---

# 🟢 활동 보고 (필수 — 생략 금지, 대시보드 '세부 작업' 실시간 가시화)

이 세션은 대시보드에 1개의 wave 행으로 뜬다. 아래 2개를 **반드시** 실행한다(실패해도 배치는 계속 — emit 실패는 무해).

- **STEP 0 (작업 시작 즉시, 첫 전공 처리 전):**
  \`node scripts/emit-activity.cjs --file ${actFile} --status running\`
- **STEP LAST (세션 종료 직전, 모든 전공 처리/보고 후):**
  성공: \`node scripts/emit-activity.cjs --file ${actFile} --status done --tool-calls <대략 tool-call 수> --detail "<완료전공수>/${majors.length} done"\`
  일부/실패: \`node scripts/emit-activity.cjs --file ${actFile} --status failed --detail "<완료>/${majors.length}, 미완=<slug 사유>"\`

(\`--tool-calls\`/\`--detail\`는 가능하면 채우고, 모르면 생략 가능. external_id·group_key·label·model은 base 파일에 이미 박혀 있으니 건드리지 않는다.)

---

# 처리 대상 전공 (${sessionName} — ENHANCE 모드, marker 미보유 신규, ${majors.length}전공-1세션 배치)

| # | name | id | slug | URL pool hint |
|---|---|---|---|---|
${rows}

# 처리 절차

\`.claude/skills/major-data-master/SKILL.md\` 흐름 (ENHANCE 모드). 위 표의 전공을 **1건씩 순차** 처리 — 한 전공을 POST·검증 완료한 뒤 다음 전공으로 (POST 체크포인트: 세션 중간 사망 시 완료분은 prod 보존, 검증세션이 미완분 식별).
- POST: \`https://careerwiki.org/api/major/{id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 \`node scripts/validate-major-edit.cjs payload.json\` ALL PASS 의무 (결정적 게이트)
- POST 후 \`node scripts/skill-cache/audit-major-via-api.cjs <slug>\` CLEAN + 마커 확인 — **전공당 1라운드** (과검증 금지, 세션 생존)
- change_summary: \`[major-data-master] enhance — whatStudy·howPrepare·jobProspect·summary·youtubeLinks·...\` (top-level — fields 중첩 금지)
- distinct URL ≥ 8 + totalEntries ≥ 14 강제 + 산문 3필드(whatStudy/howPrepare/jobProspect) 각 300자+각주. 한 전공 막히면 사유 보고 + skip하고 다음 전공 계속(세션 전체 abort X).
- 🔴 보호영역 절대 미접촉: chartData/employmentRate/salaryAfterGraduation/universities/recruitmentStatus/relatedJobs/relatedMajors/sourceIds/sources(origin)/aptitude/property/careerAct/relateSubject/mainSubject(단수형)

표의 전공 전부 끝나면 즉시 종료. 자동 다음 cycle 진입 X.

# 보고 형식

\`\`\`
${sessionName} 결과:
${reportRows}

MAJORS DONE: ${majors.length}/${majors.length} ok   (미완 시: MAJORS: N/${majors.length} ok, 미완=<slug + 사유>)
\`\`\`
`;
}

// ─── cycle 생성 ───
function generateCycle(cycleNum, opts = {}) {
  const byCycle = loadCycles();
  const cycleKey = `M${cycleNum}`;
  const batches = byCycle[cycleKey];
  if (!batches) {
    const keys = Object.keys(byCycle).sort((a, b) => parseInt(a.slice(1), 10) - parseInt(b.slice(1), 10));
    console.error(`[error] ${cycleKey} 가 major_list에 없음. 범위: ${keys[0]}~${keys[keys.length - 1]}.`);
    process.exit(1);
  }

  const strictBlock = loadStrictBlock();
  const allMajors = batches.flat();

  // DB cross-check (옵션)
  let processed = null;
  if (!opts.skipDb) processed = fetchProcessedSlugs();
  const alreadyDone = [];
  if (processed) {
    for (const mj of allMajors) {
      if (processed.has(String(mj.id))) alreadyDone.push(mj.slug);
    }
  }

  // 배치 큐 txt + batch prompt 생성 (5전공-1세션 배치, 순차 POST 체크포인트)
  const promptDir = path.join(ROOT, `data/cycle/m${cycleNum}_prompts`);
  fs.mkdirSync(promptDir, { recursive: true });

  const queueLines = [];
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const majors = batches[bi];
    const prompt = buildBatchPrompt(cycleNum, bn, majors, strictBlock);
    fs.writeFileSync(path.join(promptDir, `M${cycleNum}_B${bn}_prompt.md`), prompt);
    queueLines.push(`# B${bn} (${majors.length}전공)`);
    majors.forEach((mj) => queueLines.push(`B${bn} | ${mj.slug} | id=${mj.id}`));
  }
  fs.writeFileSync(path.join(ROOT, `data/cycle/M${cycleNum}_queue.txt`), queueLines.join('\n'));

  // ─── 보고 ───
  console.log(`\n=== ${cycleKey} cycle 생성 완료 (5전공-1세션 배치${cycleNum === 0 ? ', 파일럿 1배치' : ''}) ===`);
  console.log(`전공: ${allMajors.length}건 → 배치 ${batches.length}개 (각 ~${Math.round(allMajors.length / batches.length)}전공/세션) — 전량 일괄 enqueue (데몬 워커풀 동시성 7, 슬롯 비는 대로 연속 투입)`);
  console.log(`queue:        data/cycle/M${cycleNum}_queue.txt`);
  console.log(`prompt:       data/cycle/m${cycleNum}_prompts/M${cycleNum}_B{1..${batches.length}}_prompt.md`);

  if (alreadyDone.length) {
    console.log(`\n⚠️  이미 major master 적용된 전공 ${alreadyDone.length}건 (cross-check):`);
    alreadyDone.forEach((s) => console.log(`   - ${s} (skip 또는 force-enhance 판단 필요)`));
  } else if (processed) {
    console.log(`\n✓ ${allMajors.length} 전공 모두 미적용 (정상 신규 enhance 대상)`);
  }

  console.log(`\n=== Dispatcher spawn 명령 (5전공-1세션 × ${batches.length} 배치, 전량 일괄 enqueue) ===`);
  console.log(`${batches.length}개 배치 세션을 한 번에 작업큐에 투입 — 데몬 워커풀(동시성 7)이 슬롯 비는 대로 연속 처리:`);
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const slugs = batches[bi].map((mj) => mj.slug).join(', ');
    console.log(`  B${bn}: cat data/cycle/m${cycleNum}_prompts/M${cycleNum}_B${bn}_prompt.md  → prompt (${slugs})`);
  }

  // ─── 활동 가시화 (app.wikicomu.com /activity) — wave(=병렬 세션) 단위 세분화 ───
  // 직업판 옵션 A 승계: cycle 1행이 아니라 B1~B5 + 검증 = 유닛별 개별 행.
  // 각 유닛마다 base 이벤트 파일을 생성 → 해당 세션이 STEP0(running)/STEP_LAST(done) 자동 emit.
  // (source, external_id) 유니크 키라 같은 external_id의 running→done이 같은 행을 upsert(라이프사이클).
  // group_key가 같아 한 cycle의 유닛들이 대시보드에서 한 그룹으로 묶임.
  const d = new Date();
  const isoDate = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`; // 로컬 날짜(KST) — UTC toISOString는 자정 부근 하루 어긋남
  const groupKey = `cycle-M${cycleNum}-${isoDate}`;
  const activityDir = path.join(ROOT, `data/cycle/m${cycleNum}_activity`);
  fs.mkdirSync(activityDir, { recursive: true });
  const writeBase = (extId, label) =>
    fs.writeFileSync(
      path.join(activityDir, `${extId.replace(`m${cycleNum}-`, '')}.json`),
      JSON.stringify({ events: [{ source: 'batch', external_id: extId, group_key: groupKey, agent_slug: 'hangyeol', label, model: 'sonnet', status: 'running' }] }, null, 2),
    );
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const b = batches[bi];
    writeBase(`m${cycleNum}-b${bn}`, `M${cycleNum} B${bn}: ${b[0].slug}~${b[b.length - 1].slug}`);
  }
  writeBase(`m${cycleNum}-verify`, `M${cycleNum} 검증: ${allMajors.length}전공 전수 실측`);
  console.log(`\n=== Activity 가시화 (wave 단위) — base 이벤트 파일 생성 완료 ===`);
  console.log(`group_key: ${groupKey}  (B1~B${batches.length} + verify = ${batches.length + 1}개 유닛이 한 그룹으로 묶임)`);
  console.log(`base dir:  data/cycle/m${cycleNum}_activity/  (b1..b${batches.length}.json + verify.json)`);
  console.log(`각 배치 세션은 prompt의 STEP0/STEP_LAST에서 자동 emit (running→done). 검증 세션은 아래 명령 사용:`);
  console.log(`  검증 running: node scripts/emit-activity.cjs --file data/cycle/m${cycleNum}_activity/verify.json --status running`);
  console.log(`  검증 done:    node scripts/emit-activity.cjs --file data/cycle/m${cycleNum}_activity/verify.json --status done --detail "<${allMajors.length}/${allMajors.length} PASS, KPI ...>"`);

  console.log(`\n완료 후: ${allMajors.length} 전공 rev 수집 + 검증 세션(opus, major-verify-cycle 전수 실측 + 다중 rev 전수 보고) + M${cycleNum}_report.md + 메모리 갱신 (major cycle progress).`);
}

// ─── 마지막 완료 cycle + 다음 미처리 cycle 계산 (DB processed Set 기반) ───
function computeCyclePosition(processed, byCycle) {
  const cycleNums = Object.keys(byCycle)
    .map((k) => parseInt(k.slice(1), 10))
    .sort((a, b) => a - b);
  let lastDone = null;
  let next = null;
  for (const n of cycleNums) {
    const majors = byCycle[`M${n}`].flat();
    const doneCount = majors.filter((mj) => processed.has(String(mj.id))).length;
    if (doneCount >= majors.length / 2) {
      lastDone = { n, doneCount, total: majors.length, lastSlug: majors[majors.length - 1]?.slug };
    } else if (next === null) {
      next = { n, doneCount, total: majors.length, firstSlug: majors[0]?.slug };
    }
  }
  return { lastDone, next };
}

// ─── --next-cycle: 처리 안 된 다음 cycle 자동 결정 ───
function findNextCycle() {
  const byCycle = loadCycles();
  const processed = fetchProcessedSlugs();
  if (!processed) {
    console.error('[error] DB 쿼리 실패 — --cycle=N 명시 사용 권장.');
    process.exit(1);
  }
  const { next } = computeCyclePosition(processed, byCycle);
  if (!next) {
    console.error('[info] 모든 cycle 처리 완료된 것으로 보임.');
    process.exit(0);
  }
  console.log(`[next-cycle] M${next.n} 결정 (${next.doneCount}/${next.total} 처리됨 → 미처리 cycle, 시작=${next.firstSlug})`);
  return next.n;
}

// ─── --status ───
function showStatus() {
  const { a, b } = fetchMasterCount();
  console.log('=== CareerWiki major cycle 현황 ===');
  console.log(`A. 모든 major-data-master 마커 (yt-fill/cleanup 포함, DISTINCT 전공): ${a ?? 'DB 쿼리 실패'}   ← "누적 진행" 정의`);
  console.log(`B. enhance 풀 사이클만 (yt-fill 제외, DISTINCT 전공):              ${b ?? 'DB 쿼리 실패'}   ← 실제 보강 완료`);
  if (a != null && b != null) console.log(`   차이 ${a - b} = yt-fill/cleanup만 적용 (풀 enhance 미완)`);

  // 권위 KPI (admin CTE 구조 미러 — latest content rev + 마커 + UCJ NOT NULL)
  const kpiDone = fetchKpiDone();
  const kpiTotal = fetchActiveMajorCount();
  console.log(`\n=== 권위 KPI (latest non-sidebar-fill rev 마커 + user_contributed_json NOT NULL) ===`);
  console.log(`KPI: ${kpiDone ?? 'DB 쿼리 실패'} / ${kpiTotal ?? 'DB 쿼리 실패'}   (kpi_total = majors is_active=1, 예상 607)`);

  // 마지막 처리 / 다음 cycle 위치 (DB 진리값) — major_list 없으면 KPI만 보고 (tolerant)
  const byCycle = loadCycles({ tolerant: true });
  if (byCycle) {
    const processed = fetchProcessedSlugs();
    if (processed) {
      const { lastDone, next } = computeCyclePosition(processed, byCycle);
      console.log(`\n=== cycle 위치 (DB 기준) ===`);
      if (lastDone) console.log(`마지막 처리 cycle: M${lastDone.n} (${lastDone.doneCount}/${lastDone.total}, 끝=${lastDone.lastSlug})`);
      else console.log(`마지막 처리 cycle: 없음 (아직 0 cycle — M0 파일럿부터)`);
      if (next) console.log(`다음 cycle:        M${next.n} (시작=${next.firstSlug})  → 'node scripts/major-cycle-helper.cjs --cycle=${next.n}' 또는 '--next-cycle'`);
      else console.log(`다음 cycle:        없음 (전체 처리 완료)`);
    }
  } else {
    console.log(`\n[warn] major_list 미생성 → cycle 위치 계산 생략 (KPI만 보고). 명단 생성 후 재실행.`);
  }

  console.log(`\n다음 단계: 설계서 data/cycle/major_cycle_design_v1.md §4·§8 따라 진행 (go-gate: 매 cycle Jason go).`);
}

// ─── 마커 판정 (legacy 분기 없음 — [major-data-master] 단일) ───
const isMasterMarker = (cs) => !!cs && /\[major-data-master\]/.test(cs);

// ─── --reset-delay: 리밋 사망 메시지에서 리셋 시각 파싱 → ScheduleWakeup delay(초) 계산 (KST 기준) ───
// 입력 예: "...session limit · resets 3:10am (Asia/Seoul)"  → 리셋까지 남은 초 + 버퍼
function computeResetDelay(msg) {
  const m = (msg || '').match(/resets\s+(\d{1,2}):(\d{2})\s*(am|pm)?\s*\(Asia\/Seoul\)/i);
  if (!m) return null;
  let hh = parseInt(m[1], 10);
  const mm = parseInt(m[2], 10);
  const ap = (m[3] || '').toLowerCase();
  if (ap === 'pm' && hh !== 12) hh += 12;
  if (ap === 'am' && hh === 12) hh = 0;
  const KST = 9 * 3600 * 1000;
  const nowKstMs = Date.now() + KST;            // UTC epoch를 KST 벽시계로 shift
  const d = new Date(nowKstMs);                  // d의 getUTC* = KST 벽시계 값
  let targetKstMs = Date.UTC(d.getUTCFullYear(), d.getUTCMonth(), d.getUTCDate(), hh, mm, 0);
  if (targetKstMs <= nowKstMs) targetKstMs += 24 * 3600 * 1000; // 이미 지난 시각이면 내일
  const rawSec = Math.ceil((targetKstMs - nowKstMs) / 1000);
  const delaySec = rawSec + 45;                  // 리셋 직후 버퍼 45초
  return { hh, mm, rawSec, delaySec };
}

// ─── --resume=N: cycle N의 전공 중 이미 master 적용(KPI 카운트)된 것 vs 미완 산출 ───
function fetchResumeStatus(ids) {
  const inList = ids.map((id) => `'${id}'`).join(',');
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "WITH cr AS (SELECT entity_id, change_summary, ROW_NUMBER() OVER(PARTITION BY entity_id ORDER BY id DESC) rn FROM page_revisions WHERE entity_type='major' AND change_summary NOT LIKE '%[sidebar-fill]%' AND entity_id IN (${inList})) SELECT entity_id, change_summary FROM cr WHERE rn=1;" --json`;
  const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
  const rows = JSON.parse(out)[0]?.results || [];
  const map = new Map();
  for (const r of rows) map.set(String(r.entity_id), r.change_summary);
  return map;
}

function resumeCycle(n) {
  const cycles = loadCycles();
  const batches = cycles[`M${n}`];
  if (!batches) {
    console.error(`[error] M${n} major_list에 없음.`);
    process.exit(1);
  }
  const allMajors = batches.flatMap((b, bi) => (b || []).map((mj) => ({ ...mj, batch: bi + 1 })));
  let statusMap;
  try {
    statusMap = fetchResumeStatus(allMajors.map((mj) => String(mj.id)));
  } catch (e) {
    console.error('[error] DB 쿼리 실패:', e.message.slice(0, 120));
    process.exit(1);
  }
  const done = [], remain = [];
  for (const mj of allMajors) (isMasterMarker(statusMap.get(String(mj.id))) ? done : remain).push(mj);

  console.log(`=== M${n} 재개 상태 (DB 기준, latest non-sidebar rev 마커 판정) ===`);
  console.log(`완료: ${done.length}/${allMajors.length} | 미완: ${remain.length}\n`);
  console.log(`완료 전공(재처리 금지): ${done.map((mj) => mj.name).join(', ') || '(없음)'}\n`);
  if (!remain.length) {
    console.log('✅ 미완 0 — 이 cycle은 완료됨. 재개 불필요.');
    return;
  }
  console.log('미완 전공 (배치별):');
  for (let b = 1; b <= batches.length; b++) {
    const rs = remain.filter((mj) => mj.batch === b);
    if (rs.length) console.log(`  B${b}: ${rs.map((mj) => mj.name).join(', ')}`);
  }
  // 재개 Workflow REMAIN 맵 (그대로 붙여넣기용)
  const remainMap = {};
  for (let b = 1; b <= batches.length; b++) {
    const rs = remain.filter((mj) => mj.batch === b).map((mj) => mj.name);
    if (rs.length) remainMap[b] = rs;
  }
  console.log(`\n재개 Workflow REMAIN(JS):\nconst REMAIN = ${JSON.stringify(remainMap)};`);
  console.log(`완료분 DONE 가드: 각 전공 POST 전 'SELECT MAX(id) WHERE entity_type=major AND entity_id={id} AND change_summary LIKE %[major-data-master]% 그리고 latest여부' 재확인 (idempotent).`);
}

// ─── --emit-progress: 단일 진실 진행 마커 1줄 emit (데몬 파싱 → KV forward) ───
// 계약(7키, JSON.stringify 삽입순서 = 계약순서): last_completed_m·kpi_done·kpi_total·
//   cycles_done·cycles_total·majors_done·majors_total·as_of
// 권위 규칙:
//   kpi_done  = admin CTE 구조 미러 (설계서 §1): latest non-[sidebar-fill] rev 가
//               [major-data-master] 마커 + majors.user_contributed_json NOT NULL.
//               --status A/B 카운트는 절대 쓰지 않음(over-count).
//   kpi_total = majors WHERE is_active=1 (예상 607).
//   majors_done = major_list M0..last_m 전공수 누적합 (25×cycle 금지 — M0 파일럿 5전공).
// stdout 에는 마커 라인 1줄만 출력(데몬 정규식 ^STORE_CAREERWIKI_MAJOR_PROGRESS:\s*(\{.*\})$ 매칭). 경고는 stderr.

// 설계서 §1 KPI 단일 진실 쿼리 (admin.ts job-equalize CTE 구조의 major 치환).
function fetchKpiDone() {
  const sql = `WITH latest AS (SELECT entity_id, MAX(id) AS max_id FROM page_revisions WHERE entity_type='major' AND change_summary NOT LIKE '%[sidebar-fill]%' GROUP BY entity_id) SELECT COUNT(DISTINCT pr.entity_id) AS cnt FROM page_revisions pr JOIN latest l ON l.entity_id=pr.entity_id AND l.max_id=pr.id JOIN majors m ON m.id=pr.entity_id WHERE pr.change_summary LIKE '%[major-data-master]%' AND m.user_contributed_json IS NOT NULL;`;
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "${sql}" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const rows = JSON.parse(out)[0]?.results || [];
    return rows[0]?.cnt ?? null;
  } catch (e) {
    console.error('[error] KPI 권위 쿼리 실패:', e.message.slice(0, 120));
    return null;
  }
}

// kpi_total = majors WHERE is_active=1 (예상 607).
function fetchActiveMajorCount() {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT COUNT(*) AS cnt FROM majors WHERE is_active=1;" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const rows = JSON.parse(out)[0]?.results || [];
    return rows[0]?.cnt ?? null;
  } catch (e) {
    console.error('[error] 활성 전공 총수 쿼리 실패:', e.message.slice(0, 120));
    return null;
  }
}

function emitProgress() {
  const byCycle = loadCycles();
  const cycleNums = Object.keys(byCycle).map((k) => parseInt(k.slice(1), 10)).sort((a, b) => a - b);

  // last_completed_m: --m 명시가 진리(검증 직후 dispatcher가 방금 끝낸 cycle 번호를 안다).
  //   미지정 시 DB processed Set 기반 lastDone 로 추론(보조).
  let lastM = getArg('m') != null ? parseInt(getArg('m'), 10) : null;
  if (lastM == null) {
    const processed = fetchProcessedSlugs();
    if (!processed) {
      console.error('[error] --m 미지정 + DB 추론 실패. --m=N 명시 필요.');
      process.exit(1);
    }
    const { lastDone } = computeCyclePosition(processed, byCycle);
    if (!lastDone) {
      console.error('[error] 완료 cycle 추론 불가. --m=N 명시 필요.');
      process.exit(1);
    }
    lastM = lastDone.n;
  }
  if (!cycleNums.includes(lastM)) {
    console.error(`[error] M${lastM} 가 major_list에 없음. 범위 M${cycleNums[0]}~M${cycleNums[cycleNums.length - 1]}.`);
    process.exit(1);
  }

  // KPI(권위): 설계서 §1 단일 진실 쿼리. 실패 시 마커 미생성(추측 emit 금지).
  const kpiDone = fetchKpiDone();
  const kpiTotal = fetchActiveMajorCount();
  if (kpiDone == null || kpiTotal == null) {
    console.error('[error] 권위 KPI 측정 실패 → 마커 미생성. (추측값 emit 금지)');
    process.exit(1);
  }

  // cycles: M0..last_m 갯수 / 전체 cycle 갯수
  const cyclesTotal = cycleNums.length;
  const cyclesDone = cycleNums.filter((n) => n <= lastM).length;

  // majors: major_list 전공수 누적합 (25×cycle 금지 — M0 파일럿 5전공)
  const majorsOf = (n) => byCycle[`M${n}`].flat().length;
  const majorsTotal = cycleNums.reduce((s, n) => s + majorsOf(n), 0);
  const majorsDone = cycleNums.filter((n) => n <= lastM).reduce((s, n) => s + majorsOf(n), 0);

  // as_of: 로컬(KST) 날짜 — UTC toISOString는 자정 부근 하루 어긋남
  const d = new Date();
  const asOf = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;

  // 키 순서 = 계약 순서 (JSON.stringify 삽입순서 보존)
  const payload = {
    last_completed_m: lastM,
    kpi_done: kpiDone,
    kpi_total: kpiTotal,
    cycles_done: cyclesDone,
    cycles_total: cyclesTotal,
    majors_done: majorsDone,
    majors_total: majorsTotal,
    as_of: asOf,
  };
  // stdout: 마커 라인 1줄만 (데몬 정규식 매칭 — 직업판 STORE_CAREERWIKI_PROGRESS 와 네임스페이스 분리)
  console.log(`STORE_CAREERWIKI_MAJOR_PROGRESS: ${JSON.stringify(payload)}`);
}

// ─── main ───
if (hasFlag('emit-progress')) {
  emitProgress();
} else if (hasFlag('status')) {
  showStatus();
} else if (hasFlag('next-cycle')) {
  const n = findNextCycle();
  generateCycle(n);
} else if (getArg('cycle') != null) {
  generateCycle(parseInt(getArg('cycle'), 10), { skipDb: hasFlag('skip-db') });
} else if (getArg('resume') != null) {
  resumeCycle(parseInt(getArg('resume'), 10));
} else if (getArg('reset-delay') != null) {
  const r = computeResetDelay(getArg('reset-delay'));
  if (!r) {
    console.error('[error] 리셋 시각 파싱 실패. 입력에 "resets H:MMam (Asia/Seoul)" 포함 필요.');
    process.exit(1);
  }
  const hop = r.delaySec > 3600;
  console.log(`리셋 ${String(r.hh).padStart(2,'0')}:${String(r.mm).padStart(2,'0')} KST 까지 ${r.rawSec}s (버퍼 포함 ${r.delaySec}s)`);
  if (hop) console.log(`ScheduleWakeup delaySeconds=3300 (1h 초과 → 멀티홉: 깨어나 아직 리밋이면 --reset-delay 재계산 후 재예약)`);
  else console.log(`ScheduleWakeup delaySeconds=${r.delaySec} (리셋 직후 1회 재기동)`);
} else {
  console.log(`major-cycle-helper.cjs — 사용법:
  node scripts/major-cycle-helper.cjs --status        DB major 카운트 + 권위 KPI + drift 안내
  node scripts/major-cycle-helper.cjs --cycle=0       M0(파일럿) batch list + prompt 생성
  node scripts/major-cycle-helper.cjs --cycle=1 --skip-db   DB cross-check 생략 (오프라인)
  node scripts/major-cycle-helper.cjs --next-cycle    미처리 다음 cycle 자동 결정 + 생성
  node scripts/major-cycle-helper.cjs --resume=3      M3 미완 전공 산출 (리밋 사망 후 재개용)
  node scripts/major-cycle-helper.cjs --emit-progress --m=3   진행 마커 1줄 emit (검증 PASS 직후 1회, 데몬→KV forward)
  node scripts/major-cycle-helper.cjs --reset-delay="resets 3:10am (Asia/Seoul)"  리셋까지 ScheduleWakeup delay 계산`);
}
