#!/usr/bin/env node
'use strict';

/**
 * batch-regenerate-all-images-parallel.cjs
 *
 * 파이프라인 프리페치 프로토타입:
 *   Save(item N)  ←→  Bridge-start(item N+1 Ollama)  동시 실행
 *
 * 단일 GPU 환경에서 유일하게 유효한 병렬화:
 *   - Save = 순수 네트워크 I/O (GPU 불필요)
 *   - 다음 항목 bridge job 시작 → Ollama 즉시 기동 (GPU 사용)
 *   - 두 작업이 다른 리소스를 쓰므로 실질 overlap 가능
 *
 * 예상 절감: ~4-5초/항목 (Save 시간만큼)
 *
 * 사용법:
 *   node scripts/batch-regenerate-all-images-parallel.cjs --test=5   # 5개 벤치마크
 *   node scripts/batch-regenerate-all-images-parallel.cjs --only=majors
 *   node scripts/batch-regenerate-all-images-parallel.cjs            # 전체
 *
 * 주의: 현재 순차 배치(batch-regenerate-all-images.cjs)와 동시 실행 시
 *       ComfyUI 큐 경합 → 각각 느려짐. 순차 배치 중단 후 교체 실행 권장.
 */

const fs   = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ─────────────────────────────────────────────────────────────────────────────
// 상수
// ─────────────────────────────────────────────────────────────────────────────

const BRIDGE_BASE          = 'https://bridge.careerwiki.org';
const SERVER_SAVE_URL      = 'https://careerwiki.org/api/admin/image/save';
const HEALTH_URL           = `${BRIDGE_BASE}/api/health`;
const GENERATE_URL         = `${BRIDGE_BASE}/api/generate-image`;

const BRIDGE_START_TIMEOUT = 15_000;
const BRIDGE_POLL_INTERVAL = 1_500;
const BRIDGE_POLL_TIMEOUT  = 10_000;
const BRIDGE_TOTAL_MAX     = 300_000;
const SAVE_TIMEOUT         = 60_000;
const HEALTH_TIMEOUT       = 5_000;
const CONSECUTIVE_FAIL_MAX = 5;

const DB_NAME          = 'careerwiki-kr';
const CHECKPOINT_FILE  = path.join(__dirname, '.batch-regenerate-progress.json');
const LOG_FILE         = path.join(__dirname, 'batch-regenerate-progress.log');
const ROOT             = path.join(__dirname, '..');
const AVG_SEC_PER_ITEM = 60;

// ─────────────────────────────────────────────────────────────────────────────
// CLI
// ─────────────────────────────────────────────────────────────────────────────

function parseArgs() {
  const args = process.argv.slice(2);
  const only      = (args.find(a => a.startsWith('--only=')) || '').split('=')[1] || null;
  const testMatch = (args.find(a => a.startsWith('--test=')) || '').split('=')[1];
  return {
    testCount:   testMatch ? (parseInt(testMatch, 10) || null) : null,
    onlyJobs:    only === 'jobs',
    onlyMajors:  only === 'majors',
    restart:     args.includes('--restart'),
    benchmark:   args.includes('--benchmark'), // 순차 vs 병렬 직접 비교
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 공통 유틸
// ─────────────────────────────────────────────────────────────────────────────

function loadDevVars() {
  const candidates = [
    path.join(ROOT, 'dev.vars'), path.join(ROOT, '.dev.vars'),
    path.join(ROOT, '..', '..', '..', 'dev.vars'),
    path.join(ROOT, '..', '..', '..', '.dev.vars'),
  ];
  const p = candidates.find(c => fs.existsSync(c));
  if (!p) return {};
  const vars = {};
  for (const line of fs.readFileSync(p, 'utf8').split(/\r?\n/)) {
    const t = line.trim();
    if (!t || t.startsWith('#')) continue;
    const idx = t.indexOf('=');
    if (idx > 0) vars[t.slice(0, idx).trim()] = t.slice(idx + 1).trim();
  }
  return vars;
}

function loadCheckpoint() {
  try {
    if (fs.existsSync(CHECKPOINT_FILE))
      return JSON.parse(fs.readFileSync(CHECKPOINT_FILE, 'utf8'));
  } catch {}
  return { completed: [], failed: [], lastAt: null };
}

function saveCheckpoint(cp) {
  cp.lastAt = new Date().toISOString();
  fs.writeFileSync(CHECKPOINT_FILE, JSON.stringify(cp, null, 2), 'utf8');
}

function appendLog(line) {
  try {
    const ts = new Date().toISOString().replace('T', ' ').slice(0, 19);
    fs.appendFileSync(LOG_FILE, `[${ts}] ${line}\n`, 'utf8');
  } catch {}
}

function queryD1(sql) {
  try {
    const out = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
      { encoding: 'utf8', cwd: ROOT, stdio: ['pipe', 'pipe', 'pipe'] }
    );
    return (JSON.parse(out)?.[0]?.results) || [];
  } catch (err) {
    throw new Error(`D1 쿼리 실패: ${(err.stderr?.toString?.() || err.message || '').slice(0, 200)}`);
  }
}

function formatDuration(sec) {
  const h = Math.floor(sec / 3600), m = Math.floor((sec % 3600) / 60), s = Math.floor(sec % 60);
  if (h > 0) return `${h}시간 ${m}분 ${s}초`;
  if (m > 0) return `${m}분 ${s}초`;
  return `${s}초`;
}

function keyOf(item) { return `${item.type}-${item.id}`; }

// ─────────────────────────────────────────────────────────────────────────────
// HTTP
// ─────────────────────────────────────────────────────────────────────────────

async function fetchJSON(url, opts, timeoutMs) {
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res  = await fetch(url, { ...opts, signal: ctrl.signal });
    const text = await res.text().catch(() => '');
    let body;
    try   { body = text ? JSON.parse(text) : {}; }
    catch { body = { success: false, error: text.slice(0, 200) || `HTTP ${res.status}` }; }
    if (!res.ok)                 throw new Error(body?.error || `HTTP ${res.status}`);
    if (body?.success === false) throw new Error(body?.error || `HTTP ${res.status}`);
    return body;
  } catch (err) {
    if (err.name === 'AbortError') throw new Error(`timeout after ${timeoutMs}ms`);
    throw err;
  } finally { clearTimeout(timer); }
}

// ─────────────────────────────────────────────────────────────────────────────
// 브리지 API — startJob / pollJob 분리
// 프리페치 핵심: startJob(N+1) → Save(N) 동시 실행 → pollJob(N+1)
// ─────────────────────────────────────────────────────────────────────────────

async function startBridgeJob(type, slug) {
  const resp = await fetchJSON(
    GENERATE_URL,
    { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ type, slug }) },
    BRIDGE_START_TIMEOUT
  );
  const jobId = resp?.jobId;
  if (!jobId) throw new Error('브리지가 jobId를 반환하지 않았습니다.');
  return { jobId, startedAt: Date.now() };
}

async function pollBridgeJob(jobId, startedAt, onProgress) {
  let lastProgress = '';
  while (Date.now() - startedAt < BRIDGE_TOTAL_MAX) {
    await new Promise(r => setTimeout(r, BRIDGE_POLL_INTERVAL));
    let st;
    try {
      st = await fetchJSON(
        `${BRIDGE_BASE}/api/job/${encodeURIComponent(jobId)}`,
        { method: 'GET' }, BRIDGE_POLL_TIMEOUT
      );
    } catch { continue; }
    if (st?.status === 'done'   && st?.result) return st.result;
    if (st?.status === 'failed')               throw new Error(st?.error || '브리지 작업 실패');
    if (onProgress && st?.progress && st.progress !== lastProgress) {
      onProgress(st.progress);
      lastProgress = st.progress;
    }
  }
  throw new Error('브리지 작업이 5분 내에 완료되지 않았습니다.');
}

// 기존 순차 방식 (벤치마크 비교용)
async function generateViaBridge(type, slug, onProgress) {
  const { jobId, startedAt } = await startBridgeJob(type, slug);
  return pollBridgeJob(jobId, startedAt, onProgress);
}

async function saveImage(type, slug, bridgeResult, adminSecret) {
  return fetchJSON(SERVER_SAVE_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': adminSecret },
    body: JSON.stringify({
      type, slug,
      imageBase64: bridgeResult.imageBase64, mimeType: bridgeResult.mimeType,
      prompt: bridgeResult.prompt, source: bridgeResult.source, loraApplied: bridgeResult.loraApplied,
    }),
  }, SAVE_TIMEOUT);
}

async function checkBridgeHealth() {
  try {
    const body = await fetchJSON(HEALTH_URL, { method: 'GET' }, HEALTH_TIMEOUT);
    return { ok: body?.success === true, body };
  } catch { return { ok: false, body: null }; }
}

// ─────────────────────────────────────────────────────────────────────────────
// 순차 처리 (벤치마크 기준선)
// ─────────────────────────────────────────────────────────────────────────────

async function processSequential(items, adminSecret, label = '순차') {
  const times = [];
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const t0 = Date.now();
    process.stdout.write(`  [${label}][${i + 1}/${items.length}] ${item.title} ... `);
    const bridgeResult = await generateViaBridge(item.type, item.slug);
    const t1 = Date.now();
    await saveImage(item.type, item.slug, bridgeResult, adminSecret);
    const t2 = Date.now();
    const total = (t2 - t0) / 1000;
    const genTime = (t1 - t0) / 1000;
    const saveTime = (t2 - t1) / 1000;
    times.push({ total, genTime, saveTime });
    console.log(`완료 ${total.toFixed(1)}s (생성 ${genTime.toFixed(1)}s + 저장 ${saveTime.toFixed(1)}s)`);
  }
  return times;
}

// ─────────────────────────────────────────────────────────────────────────────
// 파이프라인 처리 (프리페치)
// ─────────────────────────────────────────────────────────────────────────────
//
// 타임라인 (항목당):
//
//   ┌───────────────────────────────────────────────────────────┐
//   │ [생성N: Ollama+ComfyUI ≈38s]                              │
//   └───────────────────────────────────────────────────────────┘
//                                       ┌──────────┐
//                                       │ 저장N    │  ← 네트워크 I/O ≈4s
//                                       └──────────┘
//                                       ┌──────────────┐
//                                       │ Ollama N+1   │  ← GPU, 동시 시작 ≈6-8s
//                                       └──────────────┘
//                                                   ┌──────────────────┐
//                                                   │ ComfyUI N+1      │  ≈32-35s
//                                                   └──────────────────┘
//
// 절감: Save N과 Ollama N+1 overlap → min(4s, 7s) ≈ 4s/항목
// ─────────────────────────────────────────────────────────────────────────────

async function processPipelined(items, adminSecret, label = '파이프라인') {
  const times = [];
  let prefetch = null; // { item, jobId, startedAt }

  for (let i = 0; i < items.length; i++) {
    const item     = items[i];
    const nextItem = items[i + 1] ?? null;
    const t0       = Date.now();

    process.stdout.write(`  [${label}][${i + 1}/${items.length}] ${item.title} ... `);

    // 1. 현재 항목 bridge result 획득 (프리페치 or 신규)
    let bridgeResult;
    let genTime;
    if (prefetch && prefetch.item.slug === item.slug && prefetch.item.type === item.type) {
      // 이미 job 시작됨 → 이어서 폴링
      bridgeResult = await pollBridgeJob(prefetch.jobId, prefetch.startedAt);
      genTime = (Date.now() - prefetch.startedAt) / 1000;
      prefetch = null;
    } else {
      // 신규 시작
      const { jobId, startedAt } = await startBridgeJob(item.type, item.slug);
      bridgeResult = await pollBridgeJob(jobId, startedAt);
      genTime = (Date.now() - startedAt) / 1000;
    }

    const t1 = Date.now();

    // 2. 저장 비동기 시작 (await 하지 않음)
    const savePromise = saveImage(item.type, item.slug, bridgeResult, adminSecret);

    // 3. 다음 항목 bridge job 즉시 시작 (Ollama가 저장 I/O와 동시 실행)
    let prefetchStarted = false;
    if (nextItem) {
      try {
        const pf = await startBridgeJob(nextItem.type, nextItem.slug);
        prefetch = { item: nextItem, ...pf };
        prefetchStarted = true;
      } catch {
        prefetch = null; // 프리페치 실패 → 다음 루프에서 신규 시작
      }
    }

    // 4. 저장 완료 대기 (이 시간 동안 Ollama N+1이 GPU에서 실행 중)
    await savePromise;
    const t2 = Date.now();
    const saveTime = (t2 - t1) / 1000;
    const total    = (t2 - t0) / 1000;

    times.push({ total, genTime, saveTime, prefetchStarted });
    console.log(
      `완료 ${total.toFixed(1)}s (생성 ${genTime.toFixed(1)}s + 저장 ${saveTime.toFixed(1)}s${prefetchStarted ? ' + 프리페치↑' : ''})`
    );
  }
  return times;
}

// ─────────────────────────────────────────────────────────────────────────────
// 전체 배치 (프리페치 방식, 체크포인트 기반)
// ─────────────────────────────────────────────────────────────────────────────

async function runFullBatch(items, opts, adminSecret) {
  let cp = opts.restart
    ? { completed: [], failed: [], lastAt: null }
    : loadCheckpoint();

  if (opts.restart) saveCheckpoint(cp);
  else if (cp.completed.length > 0) {
    console.log(`체크포인트 재개: 완료 ${cp.completed.length}개 / 실패 ${cp.failed.length}개`);
  }

  const completedSet = new Set(cp.completed.map(String));
  let remaining = items.filter(i => !completedSet.has(keyOf(i)));
  if (opts.testCount) remaining = remaining.slice(0, opts.testCount);

  const total      = items.length;
  const alreadyDone = total - remaining.length;
  appendLog(`=== [parallel] 배치 시작: 처리 예정 ${remaining.length}개 ===`);

  const batchStart     = Date.now();
  let successCount     = 0;
  let failCount        = 0;
  let consecutiveFails = 0;
  let prefetch         = null;

  for (let i = 0; i < remaining.length; i++) {
    const item     = remaining[i];
    const nextItem = remaining[i + 1] ?? null;
    const globalIdx = alreadyDone + i + 1;
    const t0        = Date.now();

    process.stdout.write(`[${globalIdx}/${total}] ${item.title} (${item.type}) `);

    try {
      // bridge result (프리페치 or 신규)
      let bridgeResult;
      if (prefetch && prefetch.item.slug === item.slug && prefetch.item.type === item.type) {
        bridgeResult = await pollBridgeJob(prefetch.jobId, prefetch.startedAt, (p) => {
          process.stdout.write(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) [${p}]    `);
        });
        prefetch = null;
      } else {
        const { jobId, startedAt } = await startBridgeJob(item.type, item.slug);
        bridgeResult = await pollBridgeJob(jobId, startedAt, (p) => {
          process.stdout.write(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) [${p}]    `);
        });
      }

      // 저장 비동기 시작
      process.stdout.write(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) [저장 중...]   `);
      const savePromise = saveImage(item.type, item.slug, bridgeResult, adminSecret);

      // 다음 항목 프리페치 시작
      if (nextItem) {
        try {
          const pf = await startBridgeJob(nextItem.type, nextItem.slug);
          prefetch = { item: nextItem, ...pf };
        } catch { prefetch = null; }
      }

      await savePromise;

      const elapsed = ((Date.now() - t0) / 1000).toFixed(1);
      console.log(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) ✓ ${elapsed}s (↑프리페치)          `);
      appendLog(`[${globalIdx}/${total}] ✓ ${item.title} (${item.type}, ${item.slug}) ${elapsed}s [parallel]`);

      successCount++;
      consecutiveFails = 0;
      cp.completed.push(keyOf(item));

    } catch (err) {
      prefetch = null; // 실패 시 프리페치 초기화
      const elapsed = ((Date.now() - t0) / 1000).toFixed(1);
      const reason  = err instanceof Error ? err.message : String(err);
      console.log(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) ✗ ${elapsed}s — ${reason}`);
      appendLog(`[${globalIdx}/${total}] ✗ ${item.title} (${item.type}, ${item.slug}) ${elapsed}s — ${reason} [parallel]`);

      failCount++;
      consecutiveFails++;
      cp.failed.push({ key: keyOf(item), id: item.id, slug: item.slug, type: item.type, title: item.title, reason });
    }

    saveCheckpoint(cp);

    if (consecutiveFails >= CONSECUTIVE_FAIL_MAX) {
      const msg = `⚠️ 연속 ${CONSECUTIVE_FAIL_MAX}회 실패 — 브리지 이상. 중단.`;
      console.error(`\n${msg}`);
      appendLog(msg);
      break;
    }
  }

  const elapsed = (Date.now() - batchStart) / 1000;
  appendLog(`=== [parallel] 세션 종료: 성공 ${successCount} / 실패 ${failCount} / 소요 ${formatDuration(elapsed)} ===`);

  console.log('\n' + '═'.repeat(64));
  console.log(`  완료: 성공 ${successCount} / 실패 ${failCount} / 소요 ${formatDuration(elapsed)}`);
  if (successCount > 0) console.log(`  평균: ${(elapsed / successCount).toFixed(1)}초/항목`);
  console.log('═'.repeat(64));
}

// ─────────────────────────────────────────────────────────────────────────────
// 벤치마크 모드: 동일 항목 5개를 순차 vs 파이프라인으로 비교
// ─────────────────────────────────────────────────────────────────────────────

async function runBenchmark(items, adminSecret) {
  const sample = items.slice(0, 5);
  console.log(`\n벤치마크 대상 (5개):`);
  sample.forEach((it, i) => console.log(`  [${i + 1}] ${it.title} (${it.type})`));

  // 주의: 같은 항목을 두 번 처리하면 기존 이미지 덮어씀 (의도적)
  console.log('\n--- 순차 방식 ---');
  const seqTimes = await processSequential(sample, adminSecret, '순차');

  console.log('\n잠시 대기 (ComfyUI 안정화)...');
  await new Promise(r => setTimeout(r, 5000));

  console.log('\n--- 파이프라인 방식 ---');
  const parTimes = await processPipelined(sample, adminSecret, '파이프');

  // 결과 분석
  const seqAvg  = seqTimes.reduce((a, b) => a + b.total, 0) / seqTimes.length;
  const parAvg  = parTimes.reduce((a, b) => a + b.total, 0) / parTimes.length;
  const seqSave = seqTimes.reduce((a, b) => a + b.saveTime, 0) / seqTimes.length;
  const parSave = parTimes.reduce((a, b) => a + b.saveTime, 0) / parTimes.length;
  const improvement = ((seqAvg - parAvg) / seqAvg * 100);

  console.log('\n' + '═'.repeat(60));
  console.log('  벤치마크 결과');
  console.log('─'.repeat(60));
  console.log(`  순차 평균:        ${seqAvg.toFixed(1)}s/항목 (저장 ${seqSave.toFixed(1)}s)`);
  console.log(`  파이프라인 평균:  ${parAvg.toFixed(1)}s/항목 (저장 ${parSave.toFixed(1)}s)`);
  console.log(`  개선율:           ${improvement.toFixed(1)}%`);
  const REMAINING = 7_539;
  const savedHrs = (seqAvg - parAvg) * REMAINING / 3600;
  console.log(`  잔여 ${REMAINING.toLocaleString()}개 기준:`);
  console.log(`    순차: ${(seqAvg * REMAINING / 3600).toFixed(1)}h → 파이프라인: ${(parAvg * REMAINING / 3600).toFixed(1)}h`);
  console.log(`    단축: ${Math.abs(savedHrs).toFixed(1)}시간`);
  console.log('═'.repeat(60));
}

// ─────────────────────────────────────────────────────────────────────────────
// 메인
// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  const opts      = parseArgs();
  const devVars   = loadDevVars();
  const adminSecret = process.env.ADMIN_SECRET || devVars.ADMIN_SECRET;

  if (!adminSecret) {
    console.error('❌ ADMIN_SECRET 없음. .dev.vars 또는 환경변수로 설정하세요.');
    process.exit(1);
  }

  console.log('═'.repeat(64));
  console.log('  CareerWiki 이미지 배치 재생성 [파이프라인 버전]');
  console.log('  전략: Save(N) ↔ Ollama(N+1) 동시 실행으로 4-5s/항목 절감');
  if (opts.benchmark) console.log('  모드: 벤치마크 (순차 vs 파이프라인 비교)');
  else if (opts.testCount) console.log(`  모드: 테스트 ${opts.testCount}개`);
  else console.log('  모드: 전체 실행');
  console.log('═'.repeat(64));

  // 대상 목록 조회
  const items = [];
  if (!opts.onlyMajors) {
    process.stdout.write('직업 목록 조회 중... ');
    const rows = queryD1('SELECT id, slug, name FROM jobs WHERE is_active = 1 ORDER BY id');
    items.push(...rows.map(r => ({ id: r.id, slug: r.slug, title: r.name, type: 'jobs' })));
    console.log(`${rows.length}개`);
  }
  if (!opts.onlyJobs) {
    process.stdout.write('전공 목록 조회 중... ');
    const rows = queryD1('SELECT id, slug, name FROM majors WHERE is_active = 1 ORDER BY id');
    items.push(...rows.map(r => ({ id: r.id, slug: r.slug, title: r.name, type: 'majors' })));
    console.log(`${rows.length}개`);
  }

  // 브리지 헬스체크
  const health = await checkBridgeHealth();
  if (!health.ok) {
    console.error('❌ 브리지 오프라인. node scripts/local-image-bridge.cjs 먼저 실행.');
    process.exit(1);
  }
  const ollamaOk = !!health.body?.ollama?.ready;
  const comfyOk  = !!(health.body?.comfyui?.instances || []).find(i => i.ready);
  console.log(`브리지: ✓ | Ollama: ${ollamaOk ? '✓' : '⚡'} | ComfyUI: ${comfyOk ? '✓' : '⚡'}\n`);

  if (opts.benchmark) {
    await runBenchmark(items, adminSecret);
  } else {
    await runFullBatch(items, opts, adminSecret);
  }
}

main().catch(err => {
  console.error('\n❌ 치명적 오류:', err?.message || err);
  process.exit(1);
});
