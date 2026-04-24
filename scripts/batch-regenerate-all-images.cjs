#!/usr/bin/env node
'use strict';

/**
 * batch-regenerate-all-images.cjs
 *
 * CareerWiki 전체 직업/전공 이미지 배치 재생성.
 * 로컬 브리지(bridge.careerwiki.org)를 통해 이미지를 생성하고
 * careerwiki.org/api/admin/image/save 로 저장한다.
 *
 * 인증: X-Admin-Secret 헤더 (세션 쿠키 불필요)
 * 비용: 로컬 브리지 사용 → Claude/Gemini API 비용 0
 *       R2 Class A 쓰기 요청 + D1 쓰기만 발생
 *
 * 사용법:
 *   node scripts/batch-regenerate-all-images.cjs [옵션]
 *
 * 옵션:
 *   --dry-run        실제 생성/저장 없이 대상 목록 + 예상 시간 출력
 *   --test=N         N개만 처리하고 멈춤 (전체 실행 전 검증용, 예: --test=3)
 *   --only=jobs      직업만 처리
 *   --only=majors    전공만 처리
 *   --resume         체크포인트에서 재개 (기본값)
 *   --restart        체크포인트 무시하고 처음부터
 *   --retry-failed   체크포인트의 failed 배열만 재시도 (현재 DB에 아직
 *                    is_active=1인 항목만 대상. 성공 시 failed에서 제거)
 */

const fs   = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// ─────────────────────────────────────────────────────────────────────────────
// 설정 상수
// ─────────────────────────────────────────────────────────────────────────────

const BRIDGE_BASE          = 'https://bridge.careerwiki.org';
const SERVER_SAVE_URL      = 'https://careerwiki.org/api/admin/image/save';
const HEALTH_URL           = `${BRIDGE_BASE}/api/health`;
const GENERATE_URL         = `${BRIDGE_BASE}/api/generate-image`;

const BRIDGE_START_TIMEOUT = 15_000;   // POST /api/generate-image 응답 대기 (ms)
const BRIDGE_POLL_INTERVAL = 1_500;    // 폴링 간격 — admin-image-controls.js와 동일
const BRIDGE_POLL_TIMEOUT  = 10_000;   // 개별 GET /api/job/{id} 타임아웃
const BRIDGE_TOTAL_MAX     = 300_000;  // 5분 전체 한도
const SAVE_TIMEOUT         = 60_000;   // 이미지 저장 타임아웃
const HEALTH_TIMEOUT       = 5_000;    // 헬스체크 타임아웃
const CONSECUTIVE_FAIL_MAX = 5;        // 연속 실패 감지 → 브리지 다운 판정

const DB_NAME              = 'careerwiki-kr';
const CHECKPOINT_FILE      = path.join(__dirname, '.batch-regenerate-progress.json');
const LOG_FILE             = path.join(__dirname, 'batch-regenerate-progress.log');
const ROOT                 = path.join(__dirname, '..');
const AVG_SEC_PER_ITEM     = 60; // 항목당 예상 평균 초 (warm 상태 기준)

// ─────────────────────────────────────────────────────────────────────────────
// CLI 인수 파싱
// ─────────────────────────────────────────────────────────────────────────────

function parseArgs() {
  const args = process.argv.slice(2);
  const only      = (args.find(a => a.startsWith('--only=')) || '').split('=')[1] || null;
  const testMatch = (args.find(a => a.startsWith('--test=')) || '').split('=')[1];
  const testCount = testMatch ? parseInt(testMatch, 10) : null;
  return {
    dryRun:      args.includes('--dry-run'),
    testCount:   (testCount && testCount > 0) ? testCount : null,
    onlyJobs:    only === 'jobs',
    onlyMajors:  only === 'majors',
    restart:     args.includes('--restart'),
    retryFailed: args.includes('--retry-failed'),
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// .dev.vars 로드 (ADMIN_SECRET 읽기용)
// ─────────────────────────────────────────────────────────────────────────────

function loadDevVars() {
  const vars = {};
  // local-image-bridge.cjs와 동일하게 'dev.vars' (점 없음) 사용.
  // worktree에서 실행 시 파일이 없을 수 있으므로 상위 디렉토리도 탐색.
  const candidates = [
    path.join(ROOT, 'dev.vars'),
    path.join(ROOT, '.dev.vars'),
    path.join(ROOT, '..', '..', '..', 'dev.vars'), // worktree → 메인 프로젝트
    path.join(ROOT, '..', '..', '..', '.dev.vars'),
  ];
  const p = candidates.find(c => fs.existsSync(c));
  if (!p) return vars;
  for (const line of fs.readFileSync(p, 'utf8').split(/\r?\n/)) {
    const t = line.trim();
    if (!t || t.startsWith('#')) continue;
    const idx = t.indexOf('=');
    if (idx > 0) vars[t.slice(0, idx).trim()] = t.slice(idx + 1).trim();
  }
  return vars;
}

// ─────────────────────────────────────────────────────────────────────────────
// 체크포인트 (중단 시 재개용)
// ─────────────────────────────────────────────────────────────────────────────

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

// ─────────────────────────────────────────────────────────────────────────────
// 프로덕션 D1 쿼리 (wrangler --remote)
// ─────────────────────────────────────────────────────────────────────────────

function queryD1(sql) {
  try {
    const stdout = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
      { encoding: 'utf8', cwd: ROOT, stdio: ['pipe', 'pipe', 'pipe'] }
    );
    const parsed = JSON.parse(stdout);
    return (parsed?.[0]?.results) || [];
  } catch (err) {
    const msg = (err.stderr?.toString?.() || err.stdout?.toString?.() || err.message || '').slice(0, 400);
    throw new Error(`D1 쿼리 실패: ${msg}`);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HTTP 래퍼 (timeout + JSON 정규화)
// ─────────────────────────────────────────────────────────────────────────────

async function fetchJSON(url, opts, timeoutMs) {
  const ctrl  = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res  = await fetch(url, { ...opts, signal: ctrl.signal });
    const text = await res.text().catch(() => '');
    let body;
    try   { body = text ? JSON.parse(text) : {}; }
    catch { body = { success: false, error: text.slice(0, 200) || `HTTP ${res.status}` }; }
    if (!res.ok)              throw new Error(body?.error || `HTTP ${res.status} ${res.statusText}`);
    if (body?.success === false) throw new Error(body?.error || `HTTP ${res.status}`);
    return body;
  } catch (err) {
    if (err.name === 'AbortError') throw new Error(`timeout after ${timeoutMs}ms`);
    throw err;
  } finally {
    clearTimeout(timer);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 브리지 헬스체크
// ─────────────────────────────────────────────────────────────────────────────

async function checkBridgeHealth() {
  try {
    const body = await fetchJSON(HEALTH_URL, { method: 'GET' }, HEALTH_TIMEOUT);
    return { ok: body?.success === true, body };
  } catch {
    return { ok: false, body: null };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 브리지 이미지 생성 (비동기 job 패턴 — admin-image-controls.js의 callBridge 동일)
// ─────────────────────────────────────────────────────────────────────────────

async function generateViaBridge(type, slug, onProgress) {
  // POST → jobId 즉시 반환 (Cloudflare 100s edge timeout 우회)
  const startResp = await fetchJSON(
    GENERATE_URL,
    { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ type, slug }) },
    BRIDGE_START_TIMEOUT
  );
  const jobId = startResp?.jobId;
  if (!jobId) throw new Error('브리지가 jobId를 반환하지 않았습니다.');

  const startedAt = Date.now();
  let lastProgress = '';
  while (Date.now() - startedAt < BRIDGE_TOTAL_MAX) {
    await new Promise(r => setTimeout(r, BRIDGE_POLL_INTERVAL));
    let st;
    try {
      st = await fetchJSON(
        `${BRIDGE_BASE}/api/job/${encodeURIComponent(jobId)}`,
        { method: 'GET' },
        BRIDGE_POLL_TIMEOUT
      );
    } catch { continue; } // 일시적 폴링 실패 → 재시도
    if (st?.status === 'done'   && st?.result) return st.result;
    if (st?.status === 'failed')               throw new Error(st?.error || '브리지 작업 실패');
    if (onProgress && st?.progress && st.progress !== lastProgress) {
      onProgress(st.progress);
      lastProgress = st.progress;
    }
  }
  throw new Error('브리지 작업이 5분 내에 완료되지 않았습니다.');
}

// ─────────────────────────────────────────────────────────────────────────────
// 이미지 저장 (R2 + D1 업데이트)
// 비용: R2 Class A 쓰기 1회 + D1 쓰기 1회 (Claude/Gemini API 비용 없음)
// ─────────────────────────────────────────────────────────────────────────────

async function saveImage(type, slug, bridgeResult, adminSecret) {
  return fetchJSON(
    SERVER_SAVE_URL,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': adminSecret },
      body: JSON.stringify({
        type,
        slug,
        imageBase64: bridgeResult.imageBase64,
        mimeType:    bridgeResult.mimeType,
        prompt:      bridgeResult.prompt,
        source:      bridgeResult.source,
        loraApplied: bridgeResult.loraApplied,
      }),
    },
    SAVE_TIMEOUT
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 유틸
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// 로그 파일 출력 (매 항목마다 한 줄 append — PowerShell tail로 실시간 확인 가능)
// ─────────────────────────────────────────────────────────────────────────────

function ensureLogBom() {
  // UTF-8 BOM을 파일 시작에 추가 — PowerShell Get-Content가 한글을 정상 표시하게 함
  try {
    if (!fs.existsSync(LOG_FILE) || fs.statSync(LOG_FILE).size === 0) {
      fs.writeFileSync(LOG_FILE, '\uFEFF', 'utf8'); // BOM
    } else {
      const head = Buffer.alloc(3);
      const fd = fs.openSync(LOG_FILE, 'r');
      fs.readSync(fd, head, 0, 3, 0);
      fs.closeSync(fd);
      if (head[0] !== 0xEF || head[1] !== 0xBB || head[2] !== 0xBF) {
        // BOM 없음 → 기존 내용 앞에 BOM 추가
        const old = fs.readFileSync(LOG_FILE);
        const bom = Buffer.from([0xEF, 0xBB, 0xBF]);
        fs.writeFileSync(LOG_FILE, Buffer.concat([bom, old]));
      }
    }
  } catch {}
}

function appendLog(line) {
  try {
    const ts = new Date().toISOString().replace('T', ' ').slice(0, 19);
    fs.appendFileSync(LOG_FILE, `[${ts}] ${line}\n`, 'utf8');
  } catch { /* 로그 실패는 무시 */ }
}

function formatDuration(totalSec) {
  const h = Math.floor(totalSec / 3600);
  const m = Math.floor((totalSec % 3600) / 60);
  const s = Math.floor(totalSec % 60);
  if (h > 0) return `${h}시간 ${m}분 ${s}초`;
  if (m > 0) return `${m}분 ${s}초`;
  return `${s}초`;
}

function keyOf(item) { return `${item.type}-${item.id}`; }

// ─────────────────────────────────────────────────────────────────────────────
// 메인
// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  const opts      = parseArgs();
  const devVars   = loadDevVars();
  const adminSecret = process.env.ADMIN_SECRET || devVars.ADMIN_SECRET;

  // wrangler D1 호출(queryD1)은 자식 프로세스로 실행되고 부모의 process.env를
  // 상속받는다. 재부팅 후처럼 환경변수가 휘발된 상태에서도 dev.vars의
  // Cloudflare 토큰으로 D1 인증이 되도록 process.env에 주입한다.
  // (env var가 이미 있으면 덮어쓰지 않음 — 사용자 세팅 우선)
  for (const key of ['CLOUDFLARE_API_TOKEN', 'CLOUDFLARE_ACCOUNT_ID']) {
    if (!process.env[key] && devVars[key]) process.env[key] = devVars[key];
  }

  if (!opts.dryRun && !adminSecret) {
    console.error('❌ ADMIN_SECRET이 없습니다. .dev.vars 또는 환경변수(ADMIN_SECRET=...)로 설정하세요.');
    process.exit(1);
  }

  if (!opts.dryRun && !process.env.CLOUDFLARE_API_TOKEN) {
    console.error('❌ CLOUDFLARE_API_TOKEN이 없습니다. dev.vars에 설정하거나 환경변수로 주입하세요.');
    process.exit(1);
  }

  ensureLogBom();

  // --retry-failed와 --restart는 상호 배타적 (의미 충돌)
  if (opts.retryFailed && opts.restart) {
    console.error('❌ --retry-failed 와 --restart 는 함께 사용할 수 없습니다.');
    process.exit(1);
  }

  const modeLabel = opts.dryRun
    ? 'DRY-RUN'
    : opts.retryFailed
      ? '실패 항목 재시도 (RETRY-FAILED)'
      : opts.testCount
        ? `TEST-${opts.testCount}개`
        : '실제 실행 (전체)';

  console.log('═'.repeat(64));
  console.log('  CareerWiki 이미지 배치 재생성');
  console.log(`  모드: ${modeLabel}`);
  if (opts.onlyJobs)        console.log('  대상: 직업(jobs)만');
  else if (opts.onlyMajors) console.log('  대상: 전공(majors)만');
  else                      console.log('  대상: 직업 + 전공 전체');
  console.log('═'.repeat(64));

  // ── 1. 대상 목록 조회 (wrangler d1 execute --remote) ──────────────────────
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

  const total      = items.length;
  const jobCount   = items.filter(i => i.type === 'jobs').length;
  const majorCount = items.filter(i => i.type === 'majors').length;

  // ── 2. DRY-RUN ─────────────────────────────────────────────────────────────
  if (opts.dryRun) {
    const estSec  = total * AVG_SEC_PER_ITEM;
    const estHour = (estSec / 3600).toFixed(1);

    console.log('');
    console.log('┌─ DRY-RUN 결과 ─────────────────────────────────────────────┐');
    console.log(`│  직업   : ${String(jobCount).padStart(5)}개                               │`);
    console.log(`│  전공   : ${String(majorCount).padStart(5)}개                               │`);
    console.log(`│  합계   : ${String(total).padStart(5)}개                               │`);
    console.log(`│  예상   : 약 ${estHour}시간 (항목당 평균 ${AVG_SEC_PER_ITEM}초, warm 기준)  │`);
    console.log(`│  비용   : R2 Class A ${total}회 + D1 쓰기 ${total}회          │`);
    console.log(`│           Claude/Gemini API 비용 없음 (로컬 브리지)         │`);
    console.log('└────────────────────────────────────────────────────────────┘');
    console.log('');
    console.log(`처음 15개 샘플:`);
    items.slice(0, 15).forEach((item, i) => {
      const tag = item.type === 'jobs' ? 'job' : 'maj';
      console.log(`  [${String(i + 1).padStart(2)}] [${tag}] ${item.title} (${item.slug})`);
    });
    if (total > 15) console.log(`  ... 외 ${total - 15}개`);

    // 브리지 헬스체크 (정보 제공용)
    console.log('');
    console.log('브리지 헬스체크...');
    const health = await checkBridgeHealth();
    if (health.ok) {
      const ollamaOk = !!health.body?.ollama?.ready;
      const comfyOk  = !!(health.body?.comfyui?.instances || []).find(i => i.ready);
      console.log(`  브리지   : ✓ 온라인`);
      console.log(`  Ollama   : ${ollamaOk ? '✓ 준비됨' : '⚡ 기동 필요 (자동 기동됨)'}`);
      console.log(`  ComfyUI  : ${comfyOk  ? '✓ 준비됨' : '⚡ 기동 필요 (첫 항목에서 ~3분 소요)'}`);
    } else {
      console.log('  브리지   : ✗ 오프라인 — 실행 전 로컬 브리지를 시작하세요.');
      console.log('    node scripts/local-image-bridge.cjs');
    }

    console.log('');
    console.log('다음 단계:');
    console.log('  1. 테스트 (3개):      node scripts/batch-regenerate-all-images.cjs --test=3');
    console.log('  2. 직업만:            node scripts/batch-regenerate-all-images.cjs --only=jobs');
    console.log('  3. 전공만:            node scripts/batch-regenerate-all-images.cjs --only=majors');
    console.log('  4. 전체:              node scripts/batch-regenerate-all-images.cjs');
    console.log('  5. 중단 후 재개:      node scripts/batch-regenerate-all-images.cjs --resume');
    console.log('  6. 처음부터:          node scripts/batch-regenerate-all-images.cjs --restart');
    console.log('  7. 실패만 재시도:     node scripts/batch-regenerate-all-images.cjs --retry-failed');
    return;
  }

  // ── 3. 실제 실행 (--test=N, --retry-failed, 또는 전체) ──────────────────

  // 체크포인트
  let cp = opts.restart
    ? { completed: [], failed: [], lastAt: null }
    : loadCheckpoint();

  if (opts.restart) {
    saveCheckpoint(cp);
    console.log('체크포인트 초기화 완료.');
  } else if (cp.completed.length > 0 || cp.failed.length > 0) {
    console.log(`체크포인트 (${cp.lastAt}): 완료 ${cp.completed.length}개 / 실패 ${cp.failed.length}개 → 재개`);
  }

  const completedSet = new Set(cp.completed.map(String));

  let remaining;
  let alreadyDone;

  if (opts.retryFailed) {
    // 체크포인트의 failed 배열 ∩ 현재 활성 items (is_active=1)
    // - failed 항목이 이미 다른 경로로 복구됐거나 is_active=0으로 바뀐 경우 자동 제외
    // - --only=jobs|majors 와 조합 시 DB 조회 단계에서 이미 필터됨
    const itemsByKey = new Map(items.map(it => [keyOf(it), it]));
    const failedKeysInDb = new Set();
    const stale = [];
    for (const f of cp.failed) {
      const key = f.key || `${f.type}-${f.id}`;
      if (itemsByKey.has(key)) failedKeysInDb.add(key);
      else stale.push(f);
    }
    remaining = [...failedKeysInDb].map(k => itemsByKey.get(k));
    alreadyDone = 0;

    console.log('');
    console.log(`[RETRY-FAILED 모드] 체크포인트 failed ${cp.failed.length}개 중 현재 활성 ${remaining.length}개 재시도`);
    if (stale.length > 0) {
      console.log(`  └ DB에 없거나 비활성(is_active=0)인 ${stale.length}개는 스킵 (완료 요약에서 체크포인트 정리 여부 결정)`);
    }
    if (remaining.length === 0) {
      console.log('  → 재시도할 활성 실패 항목 없음. 체크포인트 정리만 원하면 수동 편집 필요.');
      return;
    }
  } else {
    remaining = items.filter(item => !completedSet.has(keyOf(item)));
    alreadyDone = total - remaining.length;
  }

  // --test=N: 미완료 중 앞에서 N개만 (retry-failed와 조합 가능)
  const isTestMode = !!opts.testCount;
  if (isTestMode) {
    remaining = remaining.slice(0, opts.testCount);
    console.log(`[TEST 모드] ${remaining.length}개만 처리합니다.`);
  }

  console.log(`대상: ${total}개 / 처리 예정: ${remaining.length}개 (이미 완료: ${alreadyDone}개)`);

  // 브리지 헬스체크
  console.log('브리지 상태 확인 중...');
  const health = await checkBridgeHealth();
  if (!health.ok) {
    console.error('❌ 브리지(bridge.careerwiki.org)가 응답하지 않습니다.');
    console.error('   node scripts/local-image-bridge.cjs 로 먼저 브리지를 시작하세요.');
    process.exit(1);
  }
  const ollamaOk = !!health.body?.ollama?.ready;
  const comfyOk  = !!(health.body?.comfyui?.instances || []).find(i => i.ready);
  console.log(`  Ollama: ${ollamaOk ? '✓ 준비' : '⚡ 자동 기동 예정'}, ComfyUI: ${comfyOk ? '✓ 준비' : '⚡ 자동 기동 예정'}`);
  console.log('');

  const batchStart     = Date.now();
  let successCount     = 0;
  let failCount        = 0;
  let consecutiveFails = 0;

  appendLog(`=== 배치 시작: 대상 ${total}개 / 처리 예정 ${remaining.length}개 (이미 완료: ${alreadyDone}개) ===`);

  for (let i = 0; i < remaining.length; i++) {
    const item       = remaining[i];
    const globalIdx  = alreadyDone + i + 1;
    const itemStart  = Date.now();
    let lastProgress = '';

    process.stdout.write(`[${globalIdx}/${total}] ${item.title} (${item.type}) `);

    try {
      // 이미지 생성 (브리지 비동기 job 패턴)
      const bridgeResult = await generateViaBridge(item.type, item.slug, (progress) => {
        process.stdout.write(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) [${progress}]    `);
        lastProgress = progress;
      });

      // 저장
      process.stdout.write(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) [저장 중...]   `);
      await saveImage(item.type, item.slug, bridgeResult, adminSecret);

      const elapsed = ((Date.now() - itemStart) / 1000).toFixed(1);
      console.log(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) ✓ 완료 (${elapsed}s)          `);
      appendLog(`[${globalIdx}/${total}] ✓ ${item.title} (${item.type}, ${item.slug}) ${elapsed}s`);

      successCount++;
      consecutiveFails = 0;
      const k = keyOf(item);
      if (!completedSet.has(k)) {
        cp.completed.push(k);
        completedSet.add(k);
      }
      // retry-failed 모드: 성공 시 failed에서 제거 (중복 엔트리 전부 제거)
      if (opts.retryFailed) {
        cp.failed = cp.failed.filter(f => (f.key || `${f.type}-${f.id}`) !== k);
      }

    } catch (err) {
      const elapsed = ((Date.now() - itemStart) / 1000).toFixed(1);
      const reason  = err instanceof Error ? err.message : String(err);
      console.log(`\r[${globalIdx}/${total}] ${item.title} (${item.type}) ✗ 실패 (${elapsed}s) — ${reason}`);
      appendLog(`[${globalIdx}/${total}] ✗ ${item.title} (${item.type}, ${item.slug}) ${elapsed}s — ${reason}`);

      failCount++;
      consecutiveFails++;
      const k = keyOf(item);
      if (opts.retryFailed) {
        // 기존 failed 엔트리의 reason만 최신화 (중복 누적 방지)
        cp.failed = cp.failed.filter(f => (f.key || `${f.type}-${f.id}`) !== k);
      }
      cp.failed.push({ key: k, id: item.id, slug: item.slug, type: item.type, title: item.title, reason });
    }

    // 매 항목 후 체크포인트 저장
    saveCheckpoint(cp);

    // 연속 실패 → 브리지 다운 판정, 중단
    if (consecutiveFails >= CONSECUTIVE_FAIL_MAX) {
      const msg = `⚠️ 연속 ${CONSECUTIVE_FAIL_MAX}회 실패 — 브리지 이상. 중단.`;
      console.error(`\n${msg}`);
      console.error('   브리지 확인 후: node scripts/batch-regenerate-all-images.cjs');
      appendLog(msg);
      break;
    }
  }

  // ── 4. 완료 요약 ──────────────────────────────────────────────────────────
  const totalElapsedSec = (Date.now() - batchStart) / 1000;

  console.log('');
  console.log('═'.repeat(64));
  if (isTestMode) {
    console.log(`  TEST 완료 (${opts.testCount}개 테스트)`);
  } else {
    console.log('  배치 완료');
  }
  console.log('─'.repeat(64));
  console.log(`  이번 세션:  성공 ${successCount}개 / 실패 ${failCount}개`);
  console.log(`  누적 완료:  ${cp.completed.length}개 / ${total}개`);
  console.log(`  소요 시간:  ${formatDuration(totalElapsedSec)}`);
  if (successCount > 0) {
    console.log(`  항목 평균:  ${(totalElapsedSec / successCount).toFixed(1)}초`);
  }
  console.log('');
  console.log('  비용 (이번 세션)');
  console.log(`    Claude/Gemini API : 0원 (로컬 브리지 사용)`);
  console.log(`    R2 Class A 쓰기   : ${successCount}회`);
  console.log(`    D1 쓰기           : ${successCount}회`);

  appendLog(`=== 세션 종료: 성공 ${successCount} / 실패 ${failCount} / 누적 완료 ${cp.completed.length}/${total} / 소요 ${formatDuration(totalElapsedSec)} ===`);

  if (cp.failed.length > 0) {
    console.log('');
    console.log(`  실패 항목 (${cp.failed.length}개):`);
    cp.failed.slice(0, 20).forEach(f => {
      console.log(`    [${f.type}] ${f.slug}: ${f.reason.slice(0, 80)}`);
    });
    if (cp.failed.length > 20) console.log(`    ... 외 ${cp.failed.length - 20}개`);
    console.log('');
    console.log('  전체 재시도(미완료 + 실패): node scripts/batch-regenerate-all-images.cjs');
    console.log('  실패 항목만 재시도:         node scripts/batch-regenerate-all-images.cjs --retry-failed');
  }

  if (isTestMode && successCount > 0) {
    console.log('');
    console.log('  ▶ 테스트 성공. 전체 실행하려면:');
    console.log('    node scripts/batch-regenerate-all-images.cjs');
  }
  console.log('═'.repeat(64));
}

main().catch(err => {
  console.error('\n❌ 치명적 오류:', err?.message || err);
  process.exit(1);
});
