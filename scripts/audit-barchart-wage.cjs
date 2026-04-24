#!/usr/bin/env node
/**
 * audit-barchart-wage.cjs  — 바 차트 손실 전수조사 및 복원 (v2)
 *
 * 근본 원인:
 *   WORK24_JOB 원본 sal 텍스트가 렌더러의 careernetPattern/goyong24Pattern에
 *   매칭되어 바 차트를 그렸으나, 스킬이 sal을 서술형으로 교체하면서
 *   패턴 매칭이 깨지고 wage 필드도 없어 바 차트 소멸.
 *
 * 개선 사항 (v2):
 *   - 가장 최근 structured-snapshot 우선 사용 (이전 버전은 최초 snapshot 사용)
 *   - 현재 sal 텍스트에서 wage 추출 시도 (서술형 텍스트에서 중위값 파싱)
 *   - snapshot wage vs current-sal 추출 wage 불일치 시 → current-sal 기준 사용
 *   - 월급 기준 데이터(값 < 1,500) 플래그 → 사유 기록 후 스킵
 *
 * 사용법:
 *   node scripts/audit-barchart-wage.cjs --dry-run
 *   node scripts/audit-barchart-wage.cjs --execute
 */

'use strict';

const { execSync } = require('child_process');
const https = require('https');
const path = require('path');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/audit-barchart-wage.cjs --dry-run');
  console.error('       node scripts/audit-barchart-wage.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';
const PROJECT_ROOT = path.join(__dirname, '..');

// 렌더러와 동일한 패턴 (만원 단위, 띄어쓰기 없음)
const GOYONG24_RE = /하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/s;
const CAREERNET_RE = /임금\s*하위\(25%\)\s*([\d,]+)만원.*?평균\(50%\)\s*([\d,]+)만원.*?상위\(25%\)\s*([\d,]+)만원/s;

// 현재 sal 텍스트에서 중위/평균값 추출 — 여러 한국어 서술형 패턴 대응

function parseNum(s) {
  if (!s) return null;
  const n = parseInt(String(s).replace(/,/g, ''), 10);
  return Number.isFinite(n) && n > 0 ? n : null;
}

function extractMedianFromStructured(sal) {
  const m = CAREERNET_RE.exec(sal) || GOYONG24_RE.exec(sal);
  if (m) return parseNum(m[2]);
  return null;
}

function extractWageFromCurrentSal(sal) {
  if (!sal) return null;
  let m;

  // 1순위: 명시적 중위/평균(50%) 값 — "중위 50% 약 N만" / "평균(중위 50%)은 약 N만" / "중앙값(50%) 약 N만"
  m = /(?:중위|중앙값?)\s*(?:\(50%\)|50%)[^0-9]*?약?\s*([\d,]+)만/.exec(sal);
  if (m) return parseNum(m[1]);
  m = /평균\(중위[^)]*\)[^0-9]*?약?\s*([\d,]+)만/.exec(sal);
  if (m) return parseNum(m[1]);
  m = /중앙값?\(50%\)[^0-9]*?약?\s*([\d,]+)만/.exec(sal);
  if (m) return parseNum(m[1]);

  // 2순위: 중위/중앙 키워드 + 근접 숫자 — "중위(평균)는 약 N만" / "중위값은 약 N만" / "중앙값 약 N만"
  m = /(?:중위(?:값?|\([^)]*\))|중앙값?)[^0-9]{0,25}([\d,]+)만/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }

  // 3순위: "평균 연봉은 약 N만" — 단일값 (범위 아닌 경우)
  m = /평균\s*(?:연봉|임금|소득|급여)[^0-9]{0,20}?약?\s*([\d,]+)만(?!\s*원?\s*~)/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }

  // 4순위: "약 N만" 단일값
  m = /약\s*([\d,]+)만(?!\s*원?\s*~)/.exec(sal);
  if (m) { const n = parseNum(m[1]); if (n && n >= 1500) return n; }

  // 5순위: 범위 중간값 — "N~M만" 또는 "N만~M만"
  m = /([\d,]+)\s*(?:만\s*원?)?\s*[~～]\s*([\d,]+)\s*만/.exec(sal);
  if (m) {
    const lo = parseNum(m[1]), hi = parseNum(m[2]);
    if (lo && hi && lo >= 500 && hi >= 500 && lo < hi) return Math.round((lo + hi) / 2);
  }

  // 6순위: 순수 숫자
  const numOnly = sal.trim().replace(/[,\s만원]/g, '');
  if (/^\d{3,6}$/.test(numOnly)) return parseNum(numOnly);

  return null;
}

function isDailyRate(s) {
  return /일당|시급|시간당|\/일|하루\s*\d/.test(s || '');
}

// 렌더러가 이미 바 차트를 그릴 수 있는지 (wage 없이도)
function currentSalRendersChart(sal) {
  if (!sal) return false;
  const raw = sal.trim();
  if (CAREERNET_RE.test(raw) || GOYONG24_RE.test(raw)) return true;
  if (raw.includes('~') && (raw.match(/\d[\d,]*/g) || []).length === 2) return true;
  const numOnly = raw.replace(/[,\s만원]/g, '');
  if (/^\d{3,6}$/.test(numOnly)) { const n = parseNum(numOnly); if (n && n > 0) return true; }
  return false;
}

function fmtWage(n) {
  return n.toLocaleString('ko-KR');
}

function d1Query(sql) {
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 120000 }
  );
  return JSON.parse(out)[0].results;
}

function apiCall(method, urlPath, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + urlPath);
    const req = https.request({
      hostname: url.hostname,
      path: url.pathname,
      method,
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'X-Admin-Secret': ADMIN_SECRET,
      },
    }, (res) => {
      let buf = '';
      res.on('data', c => buf += c);
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

async function main() {
  console.log('\n=== audit-barchart-wage v2: 바 차트 손실 전수조사 ===');
  console.log('모드: ' + (DRY_RUN ? 'DRY-RUN' : 'EXECUTE'));
  console.log('실행: ' + new Date().toISOString() + '\n');

  // ── STEP 1: wage 없는 직업 전체 ──
  console.log('[Step 1] wage 없는 직업 조회...');
  const noWageJobs = d1Query(
    "SELECT id, name, slug, " +
    "json_extract(merged_profile_json,'$.overviewSalary') as merged_sal, " +
    "json_extract(user_contributed_json,'$._sources') as sources " +
    "FROM jobs " +
    "WHERE (json_extract(merged_profile_json,'$.overviewSalary.wage') IS NULL " +
    "    OR json_extract(merged_profile_json,'$.overviewSalary.wage')='null') " +
    "AND json_extract(merged_profile_json,'$.overviewSalary.sal') IS NOT NULL"
  );
  console.log('  wage 없음 + sal 있음: ' + noWageJobs.length + '개\n');

  const noWageMap = {};
  for (const r of noWageJobs) {
    let ms = null, srcs = {};
    try { ms = r.merged_sal ? JSON.parse(r.merged_sal) : null; } catch {}
    try { srcs = r.sources ? JSON.parse(r.sources) : {}; } catch {}
    noWageMap[r.id] = { name: r.name, slug: r.slug, mergedSal: ms, sources: srcs };
  }

  // ── STEP 2: page_revisions 초기 structured-snapshot 조회 (DESC 순서 → 가장 최근 우선) ──
  console.log('[Step 2] page_revisions structured-snapshot 조회...');
  const eligibleIds = Object.keys(noWageMap);
  const snapshotWage = {};  // entity_id → { wage, snap_sal }

  const BATCH = 200;
  for (let i = 0; i < eligibleIds.length; i += BATCH) {
    const batch = eligibleIds.slice(i, i + BATCH).map(id => "'" + id + "'");
    const rows = d1Query(
      "SELECT pr.entity_id, " +
      "json_extract(pr.data_snapshot,'$.overviewSalary.sal') as snap_sal " +
      "FROM page_revisions pr " +
      "WHERE pr.entity_type='job' " +
      "AND pr.entity_id IN (" + batch.join(',') + ") " +
      "AND json_type(pr.data_snapshot,'$.changedFields') IS NULL " +
      "AND json_extract(pr.data_snapshot,'$.overviewSalary.sal') LIKE '%하위(25%)%평균(50%)%상위(25%)%' " +
      "ORDER BY pr.created_at DESC"   // 가장 최근 snapshot 우선
    );
    for (const row of rows) {
      if (snapshotWage[row.entity_id]) continue; // DESC → 첫 번째 = 가장 최근
      const w = extractMedianFromStructured(row.snap_sal);
      if (w) snapshotWage[row.entity_id] = { wage: w, snap_sal: row.snap_sal };
    }
    process.stdout.write('.');
  }
  console.log();
  console.log('  structured-snapshot 후보: ' + Object.keys(snapshotWage).length + '개\n');

  // ── STEP 3: 판정 ──
  const toRestore = [];
  const skipped = [];

  for (const id of eligibleIds) {
    const job = noWageMap[id];
    const currentSal = job.mergedSal && job.mergedSal.sal;
    const snap = snapshotWage[id];

    if (!snap) continue; // structured snapshot 없는 직업은 복원 대상 아님

    // 이미 현재 sal이 바 차트를 그리면 스킵
    if (currentSalRendersChart(currentSal)) {
      skipped.push({ name: job.name, slug: job.slug, reason: '현재 sal이 이미 렌더러 패턴 매칭 (바 차트 있음)' });
      continue;
    }

    // 일당/시급 기준이면 스킵
    if (isDailyRate(currentSal)) {
      skipped.push({ name: job.name, slug: job.slug, reason: '일당/시급 기준 sal — 연봉환산 불가', sal: currentSal ? currentSal.slice(0, 60) : null });
      continue;
    }

    // 복원 wage 결정: snapshot wage vs current sal 추출값 비교
    const snapWage = snap.wage;
    const currentExtracted = extractWageFromCurrentSal(currentSal);

    let finalWage = snapWage;
    let wageSource = 'snapshot';
    let noteMsg = null;

    // 월급 기준 플래그: 1,500 미만은 월급 단위 데이터 (만원/월) 가능성 높음
    if (snapWage < 1500 && (!currentExtracted || currentExtracted < 1500)) {
      skipped.push({
        name: job.name, slug: job.slug,
        reason: '월급 기준 데이터 추정 (' + fmtWage(snapWage) + '만원) — 연봉과 단위 불일치 가능성. 수동 검토 필요',
        sal: currentSal ? currentSal.slice(0, 80) : null,
      });
      continue;
    }

    if (currentExtracted && currentExtracted >= 1500) {
      // current sal 추출값이 있으면 우선 사용 (더 최신 데이터)
      if (currentExtracted !== snapWage) {
        finalWage = currentExtracted;
        wageSource = 'current_sal';
        const match = Math.abs(snapWage - currentExtracted) / Math.max(snapWage, currentExtracted) < 0.2;
        noteMsg = 'snapshot=' + fmtWage(snapWage) + (match ? ', ' : ' vs ') + 'current_sal=' + fmtWage(currentExtracted) + (match ? ' (일치)' : ' (불일치 → current 사용)');
      } else {
        noteMsg = 'snapshot=current_sal=' + fmtWage(snapWage) + ' (완전 일치)';
      }
    }

    toRestore.push({
      id,
      name: job.name,
      slug: job.slug,
      wage: fmtWage(finalWage),
      wageNum: finalWage,
      wageSource,
      note: noteMsg,
      currentSal: currentSal ? currentSal.slice(0, 70) : null,
      mergedSalObj: job.mergedSal,
      sources: job.sources,
    });
  }

  // ── STEP 4: 결과 출력 ──
  console.log('=== 분석 결과 ===\n');

  if (skipped.length > 0) {
    console.log('⏭  스킵 (' + skipped.length + '개):');
    for (const s of skipped) {
      console.log('  ⏭  ' + s.name + ' — ' + s.reason);
    }
    console.log();
  }

  if (toRestore.length === 0) {
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ 바 차트 손실 0건 — 모든 직업 정상');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    return;
  }

  console.log('❌ 복원 대상 (' + toRestore.length + '개):\n');
  for (const r of toRestore) {
    const icon = r.wageSource === 'current_sal' ? '⚠ ' : '❌';
    console.log('  ' + icon + ' ' + r.name);
    console.log('     설정할 wage: ' + r.wage + '만원 (출처: ' + r.wageSource + ')');
    if (r.note) console.log('     메모: ' + r.note);
    console.log('     현재 sal: ' + (r.currentSal || '없음'));
    console.log('     https://careerwiki.org/job/' + encodeURIComponent(r.slug));
    console.log();
  }

  if (DRY_RUN) {
    console.log('[DRY-RUN] 실제 변경 없음. --execute로 재실행하면 복원됩니다.');
    return;
  }

  // ── STEP 5: EXECUTE ──
  console.log('[EXECUTE] API 호출로 wage 설정...\n');
  const results = [];

  for (const r of toRestore) {
    const newSal = Object.assign({}, r.mergedSalObj, { wage: r.wage });
    process.stdout.write('  ' + r.name + '... ');
    try {
      const res = await apiCall('POST', '/api/job/' + r.id + '/edit', {
        fields: { overviewSalary: newSal },
        sources: r.sources || {},
      });
      if (res.status >= 200 && res.status < 300) {
        console.log('✅ HTTP ' + res.status + ' wage=' + r.wage);
        results.push({ ...r, ok: true });
      } else {
        console.log('❌ HTTP ' + res.status + ': ' + JSON.stringify(res.body));
        results.push({ ...r, ok: false, error: res.body });
      }
    } catch (err) {
      console.log('❌ ' + err.message);
      results.push({ ...r, ok: false, error: err.message });
    }
    await new Promise(resolve => setTimeout(resolve, 600));
  }

  const ok = results.filter(r => r.ok);
  const fail = results.filter(r => !r.ok);
  console.log('\n=== 복원 결과: 성공 ' + ok.length + '개 / 실패 ' + fail.length + '개 ===\n');

  if (ok.length > 0) {
    console.log('✅ 복원 완료 목록:');
    for (const r of ok) {
      console.log('  - ' + r.name + ' wage=' + r.wage + '만원');
      console.log('    https://careerwiki.org/job/' + encodeURIComponent(r.slug));
    }
  }

  if (fail.length > 0) {
    console.log('\n❌ 실패:');
    for (const r of fail) console.log('  - ' + r.name + ': ' + JSON.stringify(r.error));
    process.exit(1);
  }
}

main().catch(err => { console.error('Fatal:', err); process.exit(1); });
