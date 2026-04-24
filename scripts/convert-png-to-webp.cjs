#!/usr/bin/env node
'use strict';

/**
 * convert-png-to-webp.cjs
 *
 * 기존 R2에 .png 로 저장된 이미지를 WebP로 변환·재업로드·DB 갱신.
 *
 * 배경:
 *   ComfyUI SaveImage 노드가 PNG만 출력해서 2,160개 직업 + 2개 전공 이미지가
 *   .png 키로 저장됨. bridge는 수정 완료(PNG→WebP 변환 추가)했으므로 이후
 *   생성되는 이미지는 전부 .webp. 기존 항목만 후처리로 일괄 변환.
 *
 * 동작:
 *   1. D1에서 image_url LIKE '%.png%' AND is_active=1 대상 목록 조회
 *   2. 각 항목:
 *      - 기존 PNG 다운로드 (https://careerwiki.org/uploads/jobs/job-{slug}.png)
 *      - sharp로 WebP 변환 (quality 85, effort 4)
 *      - POST /api/admin/image/save 로 업로드 (mimeType: image/webp)
 *        → 서버가 R2 .webp 키로 업로드 + DB image_url 갱신 + 캐시 무효화
 *      - 기존 prompt / generation_meta 보존
 *   3. R2의 orphan .png는 남아 있음 — 별도 정리 필요
 *
 * 사용법:
 *   node scripts/convert-png-to-webp.cjs [옵션]
 *
 * 옵션:
 *   --dry-run         대상 목록 + 예상 시간만 출력
 *   --test=N          N개만 처리 (검증용, 예: --test=3)
 *   --only=jobs       직업만
 *   --only=majors     전공만
 *   --concurrency=N   동시 처리 개수 (기본 5, 최대 20)
 *   --resume          체크포인트에서 재개 (기본값)
 *   --restart         체크포인트 무시하고 처음부터
 */

const fs   = require('fs');
const path = require('path');
const { execSync, spawnSync } = require('child_process');

// ─────────────────────────────────────────────────────────────────────────────
// 설정
// ─────────────────────────────────────────────────────────────────────────────

const SITE_BASE       = 'https://careerwiki.org';
const SAVE_URL        = `${SITE_BASE}/api/admin/image/save`;
const DB_NAME         = 'careerwiki-kr';
const ROOT            = path.join(__dirname, '..');
const CHECKPOINT_FILE = path.join(__dirname, '.convert-png-to-webp.json');
const LOG_FILE        = path.join(__dirname, 'convert-png-to-webp.log');

const DOWNLOAD_TIMEOUT = 30_000;
const SAVE_TIMEOUT     = 60_000;
const MAX_CONCURRENCY  = 20;

// ─────────────────────────────────────────────────────────────────────────────
// CLI 인수
// ─────────────────────────────────────────────────────────────────────────────

function parseArgs() {
  const args = process.argv.slice(2);
  const only = (args.find(a => a.startsWith('--only=')) || '').split('=')[1] || null;
  const testMatch = (args.find(a => a.startsWith('--test=')) || '').split('=')[1];
  const testCount = testMatch ? parseInt(testMatch, 10) : null;
  const concMatch = (args.find(a => a.startsWith('--concurrency=')) || '').split('=')[1];
  const concurrency = concMatch ? Math.min(parseInt(concMatch, 10) || 5, MAX_CONCURRENCY) : 5;
  return {
    dryRun: args.includes('--dry-run'),
    testCount: (testCount && testCount > 0) ? testCount : null,
    onlyJobs: only === 'jobs',
    onlyMajors: only === 'majors',
    restart: args.includes('--restart'),
    concurrency: Math.max(1, concurrency),
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// dev.vars 로드 (ADMIN_SECRET)
// ─────────────────────────────────────────────────────────────────────────────

function loadDevVars() {
  const vars = {};
  const candidates = [
    path.join(ROOT, 'dev.vars'),
    path.join(ROOT, '.dev.vars'),
    path.join(ROOT, '..', '..', '..', 'dev.vars'),
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
// 체크포인트
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
// D1 쿼리
// ─────────────────────────────────────────────────────────────────────────────

function queryD1(sql) {
  // wrangler --file은 metadata만 반환하고 SELECT 결과를 반환하지 않으므로 --command 사용.
  // execSync의 파이프를 통한 대용량 UTF-8 출력 시 libuv assertion이 발생할 수 있으므로
  // spawnSync로 stdout을 파일 디스크립터에 직접 리다이렉트한다.
  const tag = `${Date.now()}-${Math.random().toString(36).slice(2, 8)}`;
  const tmpOut = path.join(__dirname, `.d1-tmp-${tag}.json`);
  const outFd = fs.openSync(tmpOut, 'w');
  try {
    // Node 20+: .cmd/.bat 실행 시 shell:true 필수 (EINVAL 방지)
    // SQL 내 개행을 공백으로 치환하지 않으면 cmd.exe가 개행에서 명령을 끊어
    // wrangler가 stdin 종료 없이 크래시(UV assertion)하므로 반드시 단일 라인으로 전달.
    const singleLine = sql.replace(/\s+/g, ' ').trim();
    const escapedSql = singleLine.replace(/"/g, '\\"');
    const cmdStr = `npx wrangler d1 execute ${DB_NAME} --remote --json --command "${escapedSql}"`;
    if (process.env.DEBUG_D1) {
      console.error('[D1-DEBUG] cmd:', cmdStr.slice(0, 500));
    }
    const result = spawnSync(cmdStr, {
      cwd: ROOT,
      stdio: ['ignore', outFd, 'pipe'],
      shell: true,
      windowsHide: true,
    });
    if (process.env.DEBUG_D1) {
      console.error('[D1-DEBUG] status:', result.status, 'signal:', result.signal);
      console.error('[D1-DEBUG] stderr:', (result.stderr || '').toString().slice(0, 1000));
    }
    fs.closeSync(outFd);
    if (result.status !== 0) {
      const errMsg = (result.stderr?.toString('utf8') || '').slice(0, 800);
      const sigMsg = result.signal ? ` signal=${result.signal}` : '';
      const errInfo = result.error ? ` error=${result.error.message}` : '';
      throw new Error(`wrangler exit ${result.status}${sigMsg}${errInfo}: ${errMsg}`);
    }
    const raw = fs.readFileSync(tmpOut, 'utf8');
    const startIdx = Math.min(
      ...['[', '{'].map(ch => {
        const i = raw.indexOf(ch);
        return i === -1 ? Infinity : i;
      })
    );
    if (!isFinite(startIdx)) throw new Error('wrangler 출력에 JSON 시작 문자 없음');
    const parsed = JSON.parse(raw.slice(startIdx));
    return (parsed?.[0]?.results) || [];
  } catch (err) {
    try { fs.closeSync(outFd); } catch {}
    const msg = (err.stderr?.toString?.() || err.stdout?.toString?.() || err.message || '').slice(0, 400);
    throw new Error(`D1 쿼리 실패: ${msg}`);
  } finally {
    try { if (fs.existsSync(tmpOut)) fs.unlinkSync(tmpOut); } catch {}
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 로그 (UTF-8 BOM 포함)
// ─────────────────────────────────────────────────────────────────────────────

function ensureLogBom() {
  try {
    if (!fs.existsSync(LOG_FILE) || fs.statSync(LOG_FILE).size === 0) {
      fs.writeFileSync(LOG_FILE, '\uFEFF', 'utf8');
    } else {
      const head = Buffer.alloc(3);
      const fd = fs.openSync(LOG_FILE, 'r');
      fs.readSync(fd, head, 0, 3, 0);
      fs.closeSync(fd);
      if (head[0] !== 0xEF || head[1] !== 0xBB || head[2] !== 0xBF) {
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
  } catch {}
}

// ─────────────────────────────────────────────────────────────────────────────
// fetch 래퍼 (timeout + binary 지원)
// ─────────────────────────────────────────────────────────────────────────────

async function fetchBuffer(url, timeoutMs) {
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res = await fetch(url, { signal: ctrl.signal });
    if (!res.ok) throw new Error(`HTTP ${res.status} ${res.statusText}`);
    const ab = await res.arrayBuffer();
    return Buffer.from(ab);
  } catch (err) {
    if (err.name === 'AbortError') throw new Error(`timeout after ${timeoutMs}ms`);
    throw err;
  } finally {
    clearTimeout(timer);
  }
}

async function fetchJSON(url, opts, timeoutMs) {
  const ctrl = new AbortController();
  const timer = setTimeout(() => ctrl.abort(), timeoutMs);
  try {
    const res = await fetch(url, { ...opts, signal: ctrl.signal });
    const text = await res.text().catch(() => '');
    let body;
    try { body = text ? JSON.parse(text) : {}; }
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
// 변환 로직
// ─────────────────────────────────────────────────────────────────────────────

let sharp;
try {
  sharp = require('sharp');
} catch (err) {
  console.error('❌ sharp 패키지가 설치되어 있지 않습니다. `npm install sharp --save` 먼저 실행하세요.');
  process.exit(1);
}

/**
 * 단일 항목 변환
 *   item = { id, slug, type, image_url, image_prompt, meta }
 */
async function convertOne(item, adminSecret) {
  const t0 = Date.now();

  // 1. 원본 PNG URL 구성 (image_url 그대로 사용 — ?v= 쿼리 포함돼 있음)
  //    캐시 강제 갱신을 위해 ?v= 붙여 fetch
  //    slug가 한글이어서 URL 인코딩 필요 — image_url은 이미 인코딩돼 있지 않은 raw 형태이므로 수동 인코딩
  const [pathPart, queryPart] = String(item.image_url).split('?');
  // pathPart 예: /uploads/jobs/job-도금원.png
  // 한글 부분만 encodeURI로 안전하게 처리
  const encodedPath = pathPart.split('/').map(seg => encodeURIComponent(seg)).join('/').replace(/%2F/g, '/');
  const fullUrl = `${SITE_BASE}${encodedPath}${queryPart ? '?' + queryPart : ''}`;

  // 2. PNG 다운로드
  const pngBuffer = await fetchBuffer(fullUrl, DOWNLOAD_TIMEOUT);
  if (pngBuffer.length < 100) {
    throw new Error(`원본 PNG가 비어있음 (${pngBuffer.length} bytes)`);
  }
  // PNG 매직 넘버 확인
  if (!(pngBuffer[0] === 0x89 && pngBuffer[1] === 0x50 && pngBuffer[2] === 0x4E && pngBuffer[3] === 0x47)) {
    throw new Error('다운로드된 파일이 PNG가 아님');
  }

  // 3. WebP 변환
  const webpBuffer = await sharp(pngBuffer)
    .webp({ quality: 85, effort: 4 })
    .toBuffer();

  // 4. 서버에 업로드 (save 엔드포인트가 R2 + DB 동시 갱신)
  const apiType = item.type; // 'jobs' or 'majors'
  const source = {
    prompt: item.meta?.promptSource || 'unknown',
    image:  item.meta?.imageSource  || 'unknown',
  };
  const body = {
    type: apiType,
    slug: item.slug,
    imageBase64: webpBuffer.toString('base64'),
    mimeType: 'image/webp',
    prompt: item.image_prompt || '',
    source,
    loraApplied: !!item.meta?.loraApplied,
  };

  await fetchJSON(
    SAVE_URL,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': adminSecret },
      body: JSON.stringify(body),
    },
    SAVE_TIMEOUT
  );

  return {
    pngSize: pngBuffer.length,
    webpSize: webpBuffer.length,
    elapsedMs: Date.now() - t0,
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// 병렬 실행 (worker pool)
// ─────────────────────────────────────────────────────────────────────────────

async function runPool(items, concurrency, worker, onProgress) {
  let idx = 0;
  const results = [];
  async function next() {
    while (true) {
      const myIdx = idx++;
      if (myIdx >= items.length) return;
      const item = items[myIdx];
      try {
        const r = await worker(item);
        results[myIdx] = { ok: true, item, result: r };
      } catch (err) {
        results[myIdx] = { ok: false, item, error: err?.message || String(err) };
      }
      if (onProgress) onProgress(results[myIdx], myIdx);
    }
  }
  const workers = Array.from({ length: concurrency }, () => next());
  await Promise.all(workers);
  return results;
}

// ─────────────────────────────────────────────────────────────────────────────
// 유틸
// ─────────────────────────────────────────────────────────────────────────────

function formatDuration(sec) {
  const h = Math.floor(sec / 3600);
  const m = Math.floor((sec % 3600) / 60);
  const s = Math.floor(sec % 60);
  if (h > 0) return `${h}시간 ${m}분 ${s}초`;
  if (m > 0) return `${m}분 ${s}초`;
  return `${s}초`;
}

function keyOf(item) { return `${item.type}-${item.id}`; }

// ─────────────────────────────────────────────────────────────────────────────
// 메인
// ─────────────────────────────────────────────────────────────────────────────

async function main() {
  const opts = parseArgs();
  const devVars = loadDevVars();
  const adminSecret = process.env.ADMIN_SECRET || devVars.ADMIN_SECRET;

  if (!opts.dryRun && !adminSecret) {
    console.error('❌ ADMIN_SECRET이 없습니다. dev.vars 또는 환경변수(ADMIN_SECRET=...)로 설정하세요.');
    process.exit(1);
  }

  ensureLogBom();

  const modeLabel = opts.dryRun
    ? 'DRY-RUN'
    : opts.testCount
      ? `TEST-${opts.testCount}개`
      : '실제 실행 (전체)';

  console.log('═'.repeat(64));
  console.log('  CareerWiki PNG → WebP 일괄 변환');
  console.log(`  모드: ${modeLabel}`);
  console.log(`  동시 처리: ${opts.concurrency}개`);
  if (opts.onlyJobs)        console.log('  대상: 직업(jobs)만');
  else if (opts.onlyMajors) console.log('  대상: 전공(majors)만');
  else                      console.log('  대상: 직업 + 전공 전체');
  console.log('═'.repeat(64));

  // ── 1. 대상 목록 조회 ────────────────────────────────────────────────────
  const items = [];

  if (!opts.onlyMajors) {
    process.stdout.write('직업 PNG 목록 조회 중... ');
    // merged_profile_json에서 image_generation_meta 추출
    const rows = queryD1(
      `SELECT id, slug, name, image_url, image_prompt,
              json_extract(merged_profile_json, '$.image_generation_meta') AS meta_json
       FROM jobs
       WHERE image_url LIKE '%.png%' AND is_active = 1
       ORDER BY id`
    );
    for (const r of rows) {
      let meta = {};
      try { meta = r.meta_json ? JSON.parse(r.meta_json) : {}; } catch {}
      items.push({
        id: r.id, slug: r.slug, name: r.name, type: 'jobs',
        image_url: r.image_url, image_prompt: r.image_prompt, meta,
      });
    }
    console.log(`${rows.length}개`);
  }
  if (!opts.onlyJobs) {
    process.stdout.write('전공 PNG 목록 조회 중... ');
    const rows = queryD1(
      `SELECT id, slug, name, image_url, image_prompt,
              json_extract(merged_profile_json, '$.image_generation_meta') AS meta_json
       FROM majors
       WHERE image_url LIKE '%.png%' AND is_active = 1
       ORDER BY id`
    );
    for (const r of rows) {
      let meta = {};
      try { meta = r.meta_json ? JSON.parse(r.meta_json) : {}; } catch {}
      items.push({
        id: r.id, slug: r.slug, name: r.name, type: 'majors',
        image_url: r.image_url, image_prompt: r.image_prompt, meta,
      });
    }
    console.log(`${rows.length}개`);
  }

  const total = items.length;
  const jobCount = items.filter(i => i.type === 'jobs').length;
  const majorCount = items.filter(i => i.type === 'majors').length;

  // ── 2. DRY-RUN ─────────────────────────────────────────────────────────
  if (opts.dryRun) {
    const avgSecPerItem = 3; // 다운로드 1s + 변환 0.1s + 업로드 1s + 오버헤드
    const estSec = Math.ceil(total * avgSecPerItem / opts.concurrency);

    console.log('');
    console.log('┌─ DRY-RUN 결과 ──────────────────────────────────────────┐');
    console.log(`│  직업 PNG : ${String(jobCount).padStart(5)}개                            │`);
    console.log(`│  전공 PNG : ${String(majorCount).padStart(5)}개                            │`);
    console.log(`│  합계     : ${String(total).padStart(5)}개                            │`);
    console.log(`│  예상 시간: 약 ${formatDuration(estSec).padEnd(12)} (동시 ${opts.concurrency}개)        │`);
    console.log(`│  비용     : R2 Class A ${total}회 + D1 쓰기 ${total}회       │`);
    console.log('└─────────────────────────────────────────────────────────┘');
    console.log('');
    console.log('처음 10개 샘플:');
    items.slice(0, 10).forEach((item, i) => {
      const tag = item.type === 'jobs' ? 'job' : 'maj';
      console.log(`  [${String(i + 1).padStart(2)}] [${tag}] ${item.name} (${item.slug})`);
    });
    if (total > 10) console.log(`  ... 외 ${total - 10}개`);
    console.log('');
    console.log('다음 단계:');
    console.log('  1. 테스트 (3개):  node scripts/convert-png-to-webp.cjs --test=3');
    console.log('  2. 전체 실행:     node scripts/convert-png-to-webp.cjs');
    console.log('  3. 속도 조절:     node scripts/convert-png-to-webp.cjs --concurrency=10');
    return;
  }

  // ── 3. 체크포인트 / 필터 ─────────────────────────────────────────────
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
  let remaining = items.filter(item => !completedSet.has(keyOf(item)));
  const alreadyDone = total - remaining.length;

  if (opts.testCount) {
    remaining = remaining.slice(0, opts.testCount);
    console.log(`[TEST 모드] ${remaining.length}개만 처리합니다.`);
  }

  console.log(`대상: ${total}개 / 처리 예정: ${remaining.length}개 (이미 완료: ${alreadyDone}개)`);

  if (remaining.length === 0) {
    console.log('✓ 변환할 항목이 없습니다.');
    return;
  }

  appendLog(`── 배치 시작 (대상 ${remaining.length}개, 동시 ${opts.concurrency}개) ──`);

  // ── 4. 병렬 실행 ─────────────────────────────────────────────────────
  const t0 = Date.now();
  let doneCount = 0;
  let failCount = 0;
  let totalPngBytes = 0;
  let totalWebpBytes = 0;
  const BATCH_SAVE_EVERY = 20; // 체크포인트 주기

  await runPool(remaining, opts.concurrency, async (item) => {
    return await convertOne(item, adminSecret);
  }, (res, idx) => {
    const n = ++doneCount;
    const tag = res.item.type === 'jobs' ? 'job' : 'maj';
    if (res.ok) {
      totalPngBytes  += res.result.pngSize;
      totalWebpBytes += res.result.webpSize;
      const ratio = ((res.result.webpSize / res.result.pngSize) * 100).toFixed(0);
      const sec = (res.result.elapsedMs / 1000).toFixed(1);
      const line = `✓ [${tag}] ${res.item.name} (${res.item.slug}) — ${(res.result.pngSize / 1024).toFixed(0)}KB → ${(res.result.webpSize / 1024).toFixed(0)}KB (${ratio}%) ${sec}s`;
      console.log(`  [${n}/${remaining.length}] ${line}`);
      appendLog(line);
      cp.completed.push(keyOf(res.item));
    } else {
      failCount++;
      const line = `✗ [${tag}] ${res.item.slug}: ${res.error.slice(0, 100)}`;
      console.log(`  [${n}/${remaining.length}] ${line}`);
      appendLog(line);
      cp.failed.push({ type: res.item.type, slug: res.item.slug, reason: res.error });
    }
    // 주기적 체크포인트 저장
    if (n % BATCH_SAVE_EVERY === 0 || n === remaining.length) {
      saveCheckpoint(cp);
    }
  });

  saveCheckpoint(cp);

  // ── 5. 요약 ────────────────────────────────────────────────────────────
  const elapsedSec = (Date.now() - t0) / 1000;
  const savings = totalPngBytes > 0
    ? (((totalPngBytes - totalWebpBytes) / totalPngBytes) * 100).toFixed(1)
    : '0';

  console.log('');
  console.log('═'.repeat(64));
  console.log('  배치 완료');
  console.log('═'.repeat(64));
  console.log(`  성공: ${doneCount - failCount}개 / 실패: ${failCount}개`);
  console.log(`  경과: ${formatDuration(elapsedSec)}`);
  console.log(`  PNG 총량:  ${(totalPngBytes / 1024 / 1024).toFixed(1)} MB`);
  console.log(`  WebP 총량: ${(totalWebpBytes / 1024 / 1024).toFixed(1)} MB`);
  console.log(`  절감률:    ${savings}%`);
  if (failCount > 0) {
    console.log('');
    console.log('  최근 실패 5개:');
    cp.failed.slice(-5).forEach(f => {
      console.log(`    ✗ [${f.type}] ${f.slug}: ${f.reason.slice(0, 80)}`);
    });
    console.log('');
    console.log('  재시도: node scripts/convert-png-to-webp.cjs --resume');
  }
  appendLog(`── 배치 종료 (성공 ${doneCount - failCount} / 실패 ${failCount}, ${formatDuration(elapsedSec)}) ──`);
}

main().catch(err => {
  console.error('치명적 오류:', err?.message || err);
  process.exit(1);
});
